From: "Loyall, David" <david.loyall@nebraska.gov>
Subject: suspected bug(s) in git-cvsexportcommit.perl
Date: Wed, 18 Sep 2013 19:00:46 +0000
Message-ID: <FCEE4469EE8B234199968ECA9B0661E230EB7623@STNEEX10MB01.stone.ne.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 18 21:00:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMMzb-0003r1-Va
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 21:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab3IRTAs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Sep 2013 15:00:48 -0400
Received: from mx01.ne.gov ([164.119.247.101]:30551 "EHLO mx01.ne.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab3IRTAr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Sep 2013 15:00:47 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvIEAIv3OVIKFNNv/2dsb2JhbABahBHBLIEybQeCJwWBCwEqViYBBBvBfo82g1aBAAOJAKQTgio
X-IPAS-Result: AvIEAIv3OVIKFNNv/2dsb2JhbABahBHBLIEybQeCJwWBCwEqViYBBBvBfo82g1aBAAOJAKQTgio
X-IronPort-AV: E=Sophos;i="4.90,930,1371099600"; 
   d="scan'208";a="10402301"
Received: from stneex103.stone.ne.gov ([10.20.211.111])
  by mxout01.ne.gov with ESMTP; 18 Sep 2013 14:00:47 -0500
Received: from STNEEX10MB01.stone.ne.gov ([fe80::582b:5914:1397:c3e]) by
 STNEEX103.stone.ne.gov ([::1]) with mapi id 14.02.0347.000; Wed, 18 Sep 2013
 14:00:46 -0500
Thread-Topic: suspected bug(s) in git-cvsexportcommit.perl
Thread-Index: Ac60oWFMdyCnVn4fRIitg3ZlauVqcQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.158]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234983>

Hello.

I don't believe that git-cvsexportcommit.perl is working properly.

=46irst off, invocations of "git-apply" fail on my system.=A0 "git appl=
y" works.=A0 (The aforementioned script uses the former.)

Second, please have a look at this output (specific strings have been r=
eplaced with 'foo')

hobbes@metalbaby:~/src/foo$ git cvsexportcommit -v fecc8b4bb3d91d204f4e=
b3ebd112f6cec6004819
Applying to CVS commit fecc8b4bb3d91d204f4eb3ebd112f6cec6004819 from pa=
rent 695a544fbdcf7e0614c35d1dab9a3eac0cc57b4c
Checking if patch will apply
cvs status: nothing known about `WebContent/WEB-INF/lib/commons-lang-2.=
6.jar'
cvs status: nothing known about `WebContent/WEB-INF/lib/commons-configu=
ration-1.9.jar'
cvs status: nothing known about `JavaSource/foo/ConfigManager.java'
cvs status: nothing known about `JavaSource/config.xml'
Huh? Status 'Unknown' reported for unexpected file 'no file commons-lan=
g-2.6.jar'
Huh? Status 'Unknown' reported for unexpected file 'no file commons-con=
figuration-1.9.jar'
Huh? Status 'Unknown' reported for unexpected file 'no file ConfigManag=
er.java'
Huh? Status 'Unknown' reported for unexpected file 'no file config.xml'
Applying
<stdin>:7: trailing whitespace.
<?xml version=3D"1.0" encoding=3D"UTF-8" ?>
<stdin>:8: trailing whitespace.
<config>
<stdin>:9: trailing whitespace.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <masterthread>
<stdin>:10: trailing whitespace.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 <queuemappings>
<stdin>:11: trailing whitespace.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <=
mapping threadtype=3D"foo" service=3D"foo" action=3D"foo_test" />
error: patch failed: JavaSource/foo/QueueMapping.java:67
error: JavaSource/foo/QueueMapping.java: patch does not apply
Context reduced to (2/2) to apply fragment at 43
cannot patch at /usr/lib/git-core/git-cvsexportcommit line 333.
hobbes@metalbaby:~/src/foo$=20

Even after I altered my copy of the script to invoke 'git apply' in two=
 places, I still get the erroneous "unknown" lines.=A0 My suspicion is =
that it has something to do with the $basename stuff, but, who am I kid=
ding? I don't grok perl.

I haven't yet explored the error lines after "Applying".

So, what do I want?=A0 I want somebody to test git-cvsexportcommit.perl=
=2E=A0 If it passes tests, then I'd like help creating a test that it d=
oes fail. (Perhaps my workspace can help.  Perhaps it is as simple as t=
he presence of a new file in a subdirectory.)

Cheers, thanks,
--Dave
