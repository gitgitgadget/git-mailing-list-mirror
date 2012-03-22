From: Jeremy Ramer <jdramer@gmail.com>
Subject: Currently checked out branch is not bold in gitk when using ssh X-forwarding
Date: Thu, 22 Mar 2012 15:10:47 -0600
Message-ID: <CALykgB0LCjDsMYSB1jAxBmPxsf-f6XDDFv+1nmtvCLP65ex5vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 22:10:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SApHa-0003Jo-6r
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 22:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758356Ab2CVVKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 17:10:50 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43993 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab2CVVKt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 17:10:49 -0400
Received: by bkcik5 with SMTP id ik5so2103918bkc.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=X4TFsF7QdQypspIOM5j6kZYsJwx1ubE0PzN1fvuor6c=;
        b=kcc6jq1uGA58JW/xcDWXkZBKCNOqSv6F7/4sWRAEIb5VyQA+FykBEWbLdNmTy8AcLI
         QnX1vUtUQ8yKW6fbE+cd1hINg3W3j4xKE/OlqdKxGG/+tXebnl0F7np/HsEZDs63a8RF
         dz080QHCqBVBAZxOEQNNJF7YQ/M7sA0MyNElTMKMrkjpi63QALONYdjI2hHPsygE6Rm2
         fgDyYWCmyidtmU2/y9UjWEmbRkoAmwiT37UYDMQEYyC4w2ufu58xk2jP4sc1HAyFNHne
         7iEF/eEuNOveNzKYPEvP6yACoMxu/re38KjT7iKHrxAdJ4bJlSl4jt8YTuvBS0LTagUa
         dzbw==
Received: by 10.204.130.151 with SMTP id t23mr3727422bks.27.1332450647864;
 Thu, 22 Mar 2012 14:10:47 -0700 (PDT)
Received: by 10.204.36.135 with HTTP; Thu, 22 Mar 2012 14:10:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193720>

I'm running into a rather arcane issue and I am hoping someone here
might be familiar with it. Here's the scenario:
I have a build server that has git 1.7.0.4. If I use a local X-window
system and start gitk the currently checked out branch is displayed in
bold font as normal. If I remotely log in using an older Fedora 11 box
(ssh -X buildserver) when I start gitk the currently checked out
branch is displayed in bold font as normal. However, when I log in
from my newer Ubuntu 11.11 laptop (ssh -X buildserver) and start gitk
the currently checked out branch is not displayed in bold font. In
fact, all the fonts are a little ugly, though it is the lack of bold
that is the hardest to work with.
My theory is it has something to do with Tcl/Tk/Wish.  On the build
server and the old Fedora box /usr/bin/wish -> /usr/bin/wish8.4 , but
on my Ubuntu laptop /usr/bin/wish -> /usr/bin/wish8.5.  I've tried
installing tk8.4 and changing the symlink on the laptop but it doesn't
help.  Anyone have any experience with this?

Thanks!
Jeremy
