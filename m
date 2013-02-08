From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: inotify to minimize stat() calls
Date: Sat, 9 Feb 2013 02:40:28 +0530
Message-ID: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:11:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3vE9-00025v-RB
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 22:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947153Ab3BHVKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 16:10:53 -0500
Received: from mail-ia0-f170.google.com ([209.85.210.170]:39977 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947150Ab3BHVKw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 16:10:52 -0500
Received: by mail-ia0-f170.google.com with SMTP id k20so4805588iak.29
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 13:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=bEjNb8uJlxei2YGnEcF5Tbe6QCbxlNxlRkDYc7gk2To=;
        b=bdPwbgHSCUQQ9ybony2AoBanUYCjvxcOpXjwBvajN7bBWVpUF6lr6jZ1CjxWHxghrV
         tacWeuq5zvImWK9+UrjwIhXplibXuZox/KBHvKKJw3+SdgSdhv5Eqr7VUu2SIR0Cy4vK
         +urwKEjc26G2MuY5cXBaICAgp7mK2tCsnT+vGNmyl4yLzWDD4jtx0rDH++jwb5lqbxj0
         8uyWHFc8o6xffTZuPqkTwOE0UhWnqcSy03YXxz6pAI0zlMMx2X50droKI7FDhbM9y23g
         vb6NrCrXEA5QtndaNC/HkHW8IIxfPcZDxDOb+huh1gFVChvot1sScimdlmRZXJC049nj
         XrZw==
X-Received: by 10.50.189.163 with SMTP id gj3mr5406671igc.14.1360357851171;
 Fri, 08 Feb 2013 13:10:51 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Fri, 8 Feb 2013 13:10:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215820>

Hi,

For large repositories, many simple git commands like `git status`
take a while to respond.  I understand that this is because of large
number of stat() calls to figure out which files were changed.  I
overheard that Mercurial wants to solve this problem using itnotify,
but the idea bothers me because it's not portable.  Will Git ever
consider using inotify on Linux?  What is the downside?

Ram
