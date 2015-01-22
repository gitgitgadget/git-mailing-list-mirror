From: Michael Blume <blume.mike@gmail.com>
Subject: Git compile warnings (under mac/clang)
Date: Thu, 22 Jan 2015 11:43:29 -0800
Message-ID: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 20:43:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YENfX-0003mS-1L
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 20:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbbAVTnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 14:43:51 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34874 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbbAVTnu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 14:43:50 -0500
Received: by mail-oi0-f50.google.com with SMTP id h136so3080795oig.9
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 11:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=sUnmXwZOpR3koXsZHIvAB/indPx3gZpR2FrDF1T4Wr8=;
        b=eeCwncUI02dyVfd/ce2IFN1JkzsjzXp4TNxTbkL4w9M4fuLXdEKa+H5dahZ3IPyUH8
         DtgdhePUAyOvH5vXUZGV+ek0F/6YqpQFrW8icEDBB4DIFHq264hvBPVXmq5+L2TPM2pY
         YB+XNKbDWzNTLIJ1xubSFPPSvIEoWhZ80UBehY3b06mOB1KlaSd+nxaCYkLKDJzDaGjJ
         zQdxbTfHrh5YNgfiCvx/J6rJBHFGgUUFVVnJNXNM4X1hNeONPQDue3BrZnVXbDfitwLk
         vDATlHhn8SxHgUEpzPo4fkfXkaAmHDlxi3h1aMPJ21wQ6sM8fv+BqWBrKe84qFyKZ2mh
         shRQ==
X-Received: by 10.202.197.206 with SMTP id v197mr1937469oif.54.1421955829544;
 Thu, 22 Jan 2015 11:43:49 -0800 (PST)
Received: by 10.202.86.136 with HTTP; Thu, 22 Jan 2015 11:43:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262860>

These are probably minor, I only bring them up because Git's build is
generally so quiet that it might be worth squashing these too.

    CC fsck.o
fsck.c:110:38: warning: comparison of unsigned enum expression >= 0 is
always true [-Wtautological-compare]
        if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
                                     ~~~~~~ ^  ~
1 warning generated.
    AR libgit.a
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libgit.a(gettext.o) has no symbols
    CC builtin/remote.o
builtin/remote.c:1572:5: warning: add explicit braces to avoid
dangling else [-Wdangling-else]
                                else
                                ^
builtin/remote.c:1580:5: warning: add explicit braces to avoid
dangling else [-Wdangling-else]
                                else
                                ^
2 warnings generated.

(the warning about libgit.a(gettext.o) is probably because I'm
building with NO_GETTEXT -- I've never been able to get gettext to
work on my mac)
