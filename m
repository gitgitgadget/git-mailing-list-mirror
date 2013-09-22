From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: suspected bug(s) in git-cvsexportcommit.perl
Date: Sun, 22 Sep 2013 23:26:23 +0200 (CEST)
Message-ID: <134834661.2525155.1379885183181.JavaMail.zimbra@dewire.com>
References: <FCEE4469EE8B234199968ECA9B0661E230EB7623@STNEEX10MB01.stone.ne.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Loyall <david.loyall@nebraska.gov>
X-From: git-owner@vger.kernel.org Sun Sep 22 23:26:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNrAp-0001FQ-3B
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 23:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313Ab3IVV0a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Sep 2013 17:26:30 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:49905 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab3IVV03 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Sep 2013 17:26:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id C2DD781986;
	Sun, 22 Sep 2013 23:26:27 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id MJH2uDfZrlYp; Sun, 22 Sep 2013 23:26:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 9B59381964;
	Sun, 22 Sep 2013 23:26:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rFZDSnQ5D16D; Sun, 22 Sep 2013 23:26:23 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 7EE87818DC;
	Sun, 22 Sep 2013 23:26:23 +0200 (CEST)
In-Reply-To: <FCEE4469EE8B234199968ECA9B0661E230EB7623@STNEEX10MB01.stone.ne.gov>
X-Originating-IP: [78.69.107.197]
X-Mailer: Zimbra 8.0.4_GA_5737 (ZimbraWebClient - FF23 (Mac)/8.0.4_GA_5737)
Thread-Topic: suspected bug(s) in git-cvsexportcommit.perl
Thread-Index: Ac60oWFMdyCnVn4fRIitg3ZlauVqcTELbiCS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235172>



----- Ursprungligt meddelande -----
> Fr=C3=A5n: "David Loyall" <david.loyall@nebraska.gov>
> Till: git@vger.kernel.org
> Skickat: onsdag, 18 sep 2013 21:00:46
> =C3=84mne: suspected bug(s) in git-cvsexportcommit.perl
>=20
> Hello.
>=20
> I don't believe that git-cvsexportcommit.perl is working properly.
>=20
> First off, invocations of "git-apply" fail on my system.=C2=A0 "git a=
pply" works.
> =C2=A0 (The aforementioned script uses the former.)

git-apply is only available from scripts invoked by the git wrapper. Sa=
me applies
to all the other git<dash>-scripts.
=20
> Second, please have a look at this output (specific strings have been
> replaced with 'foo')
>=20
> hobbes@metalbaby:~/src/foo$ git cvsexportcommit -v
> fecc8b4bb3d91d204f4eb3ebd112f6cec6004819
> Applying to CVS commit fecc8b4bb3d91d204f4eb3ebd112f6cec6004819 from =
parent
> 695a544fbdcf7e0614c35d1dab9a3eac0cc57b4c
> Checking if patch will apply
> cvs status: nothing known about `WebContent/WEB-INF/lib/commons-lang-=
2.6.jar'
> cvs status: nothing known about
> `WebContent/WEB-INF/lib/commons-configuration-1.9.jar'
> cvs status: nothing known about `JavaSource/foo/ConfigManager.java'
> cvs status: nothing known about `JavaSource/config.xml'
> Huh? Status 'Unknown' reported for unexpected file 'no file
> commons-lang-2.6.jar'
> Huh? Status 'Unknown' reported for unexpected file 'no file
> commons-configuration-1.9.jar'
> Huh? Status 'Unknown' reported for unexpected file 'no file
> ConfigManager.java'
> Huh? Status 'Unknown' reported for unexpected file 'no file config.xm=
l'
> Applying
> <stdin>:7: trailing whitespace.
> <?xml version=3D"1.0" encoding=3D"UTF-8" ?>
> <stdin>:8: trailing whitespace.
> <config>
> <stdin>:9: trailing whitespace.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 <masterthread>
> <stdin>:10: trailing whitespace.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <queuemappings>
> <stdin>:11: trailing whitespace.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <=
mapping threadtype=3D"foo"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ervice=3D"foo"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
ction=3D"foo_test" />
> error: patch failed: JavaSource/foo/QueueMapping.java:67
> error: JavaSource/foo/QueueMapping.java: patch does not apply
> Context reduced to (2/2) to apply fragment at 43
> cannot patch at /usr/lib/git-core/git-cvsexportcommit line 333.
> hobbes@metalbaby:~/src/foo$

Your CVS directory is not up to date or you are, in some other way,
trying to export something that does not match the content of your CVS
directory. Keep in mind that you cannot export any commit, it must be=20
possible to apply the changes in the commit to the CVS checkout, much
as patch(1) would.

The -u flag to cvsexportcommit will perform an update from CVS
for you, unless you want to do it manually.

> Even after I altered my copy of the script to invoke 'git apply' in t=
wo
> places, I still get the erroneous "unknown" lines.=C2=A0 My suspicion=
 is that it
> has something to do with the $basename stuff, but, who am I kidding? =
I don't
> grok perl.
>
> I haven't yet explored the error lines after "Applying".

Same explanation as for the Unknown status. It's not that the status is=
 not
known. The status is "Uknown", as in "CVS does not know about the file"=
=2E

> So, what do I want?=C2=A0 I want somebody to test git-cvsexportcommit=
=2Eperl.=C2=A0 If it
> passes tests, then I'd like help creating a test that it does fail. (=
Perhaps
> my workspace can help.  Perhaps it is as simple as the presence of a =
new
> file in a subdirectory.)

-- robin
