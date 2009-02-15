From: =?UTF-8?Q?Antonio_Garc=C3=ADa_Dom=C3=ADnguez?= 
	<nyoescape@gmail.com>
Subject: "add -p" + filenames with UTF-8 multibyte characters = "No changes"
Date: Sun, 15 Feb 2009 19:40:11 +0100
Message-ID: <2b8265360902151040t49711942udd4862cc9df01da5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd25dc0699a370462f9660f
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 19:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYlvx-0006HO-Dd
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 19:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbZBOSkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 13:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbZBOSkO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 13:40:14 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:57907 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbZBOSkM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 13:40:12 -0500
Received: by fg-out-1718.google.com with SMTP id 16so141108fgg.17
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=4Tu9IKkFCXTOEs3vqRDdKs9OxSlcH7cd3boIIOeesEQ=;
        b=YNNzDzCOx8k+bG1I/tL3oZOFzAF0qR2SB+7sCK+jaW8T2LxL6h7ZTT/EmCeaDcJpHB
         lhcWcomjRVdcaUCYV1C6PLxCPNS5w955AgfKxHDn64RJBjUrdd7SF/oMU53NeGSFyiDI
         NqkwKkzyYsl2sS9ccWN4UA9Wc61t2DBLYr3eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=jUwyyWJMh+xeGmjJ1h5O0G7ECmJdwGAO3ewRcd4cgUOqM85ga7TAC74bmvR3cLQOC4
         QpVYqGmi7fhC4OYQs5lGq7oHht68C8pCYBBbKPmyrNTYQaUlwbMinlxkRQhQEeuyiLJ2
         YXJKTcHUcdLZx5h4Te+RCoyjcMeHQn8Pv+QCc=
Received: by 10.86.98.18 with SMTP id v18mr960007fgb.46.1234723211417; Sun, 15 
	Feb 2009 10:40:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110030>

--000e0cd25dc0699a370462f9660f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello all,

I seem to have run into a bug in "add -p" and "add -i" when trying to
stage diff hunks in tracked files with UTF-8 multibyte characters
(such as "=C3=A1"). If I add "=C3=A1", commit, then modify it and try to ru=
n
"add -p" on it, Git reports "No changes". "add -i" doesn't do
anything, either.

I've switched to 1.6.2.rc0.90.g0753 and the problem persists. If it
helps, I've attached a small shell script with a minimal recipe for
triggering the bug.

This should incorrectly report "No changes":
./test-accents.sh

And this should work fine:
FILE=3Da ./test-accents.sh

-Antonio

--000e0cd25dc0699a370462f9660f
Content-Type: application/x-sh; name="test-accents.sh"
Content-Disposition: attachment; filename="test-accents.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr82ag0j0

IyEvYmluL3NoCgppZiBbIC16ICIkRklMRSIgXTsgdGhlbgogICBGSUxFPcOhCmZpCgpybSAtZnIg
dGVzdApta2RpciB0ZXN0CmNkIHRlc3QKZWNobyB4ID4gIiRGSUxFIgpnaXQgaW5pdApnaXQgYWRk
IC4KZ2l0IGNvbW1pdCAtbSAiaW5pdGlhbCBjb21taXQiCmVjaG8geSA+PiAiJEZJTEUiCmdpdCBh
ZGQgLXAgIiRGSUxFIgo=
--000e0cd25dc0699a370462f9660f--
