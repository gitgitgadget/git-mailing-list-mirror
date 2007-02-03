From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t9200 still failing...
Date: Sat, 3 Feb 2007 12:41:36 -0500
Message-ID: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com>
References: <DBACB5AE-7C40-4D44-85BB-76F30BE96E36@silverinsanity.com> <13848C22-6C0B-46F0-ABC5-1A94D0DB6B06@wf227.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Wolfgang Fischer <wf@wf227.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 18:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDOtR-0004wC-3n
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 18:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXBCRlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 12:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbXBCRlj
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 12:41:39 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:34948 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXBCRli convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Feb 2007 12:41:38 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 76BC31FFC02B;
	Sat,  3 Feb 2007 17:41:37 +0000 (UTC)
In-Reply-To: <13848C22-6C0B-46F0-ABC5-1A94D0DB6B06@wf227.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38579>


On Feb 3, 2007, at 11:17 AM, Wolfgang Fischer wrote:

> That was already discussed a lot. Any filename test on OSX with a =20
> HFS+ filesystem containing characters with a different UTF-8-NFC =20
> and UTF-8-NFD will make such a test fail. If you are using OSX, you =20
> might want to use UnicodeChecker to see the encoding difference for =20
> such characters. If you want to make such tests pass, either use =20
> characters with only one UTF-8 encoding or use a UFS partition to =20
> run such tests.

I understand why that causes git-status to continually display =20
"gitweb/test/M=E4rchen" as an untracked file, and I'm fine with that =20
(for the most part).  But I don't understand why that causes "git add =20
=C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6=
/=20
g=E5rdets=E5g=E5rdet.txt" to show a message about gitignore, especially=
 =20
when a "git add ." will pick it up just fine.  I'd argue that it's a =20
bug in git, personally, and I can't figure out why it happens.

In any case, to get the test to pass we should probably just put a "-=20
f" on the "git add", at which point it works just fine.

~~ Brian
