From: Jack Nagel <jacknagel@gmail.com>
Subject: Running make in contrib/subtree does not create executable
Date: Sun, 17 Aug 2014 01:49:49 -0500
Message-ID: <CAMYxyaVrknapiF6L3Lnf5U59h7RCUY8qhYtipZp5P0k3Y1tCxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 08:50:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIuIQ-0000rf-C2
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 08:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbaHQGuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 02:50:11 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:47917 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbaHQGuK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 02:50:10 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so5430923igc.12
        for <git@vger.kernel.org>; Sat, 16 Aug 2014 23:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=AY1afXm9vfTk3PIc8T2YhdDzo1fIpfOTWdU3B1l5kis=;
        b=WdPqTDzvw8AMINaJt5+H1Bg85Z93PHNV4kP4M6rdZhCC5YgMmiLY4fKZxe/C7ErWMv
         SXshAgsBqi+Y6mJvoKoQd94YMVc97DkqDw00J82SXtgIeIquIFjs11aC3O75hhBkybuc
         lMWK9hlvUnaYuoHZogN59W5Z1KWoM+oCn5d14lnbR+sycQgNDbZ/x7cyiRxB7yA4ATqk
         xY2ZWC5wqjrdr2e7x9UzJCj9KFvys+T594B3gLC6HDd4ujczHBjNuMM1IJjuUTvXMN7s
         zT5rFFa7qVJ0cO7gArRjETqFsA1xabq2VH6LQNZz56DJ4WNiw9EkAAZ49KFgQjp8pJui
         tOXw==
X-Received: by 10.42.226.69 with SMTP id iv5mr30222162icb.43.1408258209894;
 Sat, 16 Aug 2014 23:50:09 -0700 (PDT)
Received: by 10.64.223.16 with HTTP; Sat, 16 Aug 2014 23:49:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255347>

Running "make" in contrib/subtree no longer creates the git-subtree executable:

$ git describe
v2.1.0
$ make -C contrib/subtree
/Library/Developer/CommandLineTools/usr/bin/make -C ../../ GIT-VERSION-FILE
GIT_VERSION = 2.1.0
make[1]: `GIT-VERSION-FILE' is up to date.
/Library/Developer/CommandLineTools/usr/bin/make -C ../../ GIT-VERSION-FILE
make[1]: `GIT-VERSION-FILE' is up to date.
make: `../../GIT-VERSION-FILE' is up to date.
$ ls contrib/subtree/git-subtree
ls: contrib/subtree/git-subtree: No such file or directory

The change appears to be inadvertent. I bisected it to
8e2a5ccad11bc21eb72499133bc884024e299983 ("contrib/subtree/Makefile:
use GIT-VERSION-FILE").

This was reproduced on OS X 10.9 with GNU make 3.81.

-Jack
