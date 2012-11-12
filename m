From: Adam Spiers <git@adamspiers.org>
Subject: splitting off shell test framework
Date: Mon, 12 Nov 2012 16:37:44 +0000
Message-ID: <CAOkDyE8KxFvM4CJhC4U=Jb95D6HQ-4qQBtKAgBMyHH15UOhvqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:38:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXx1M-00070x-Dt
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 17:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab2KLQhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 11:37:47 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:47705 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab2KLQhq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 11:37:46 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so2882016wey.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=vLGkHRz0GhXkUAM+v3bmg19O9MK67gybiHiWGBfd37k=;
        b=KWu6dCxP3TRl2DaBHR8lx6VMfO6SuGGZ9+6jImTDDwWconv6ub9tpJfLCWWJXEdfyp
         dB7xsjDP724F68lnIuPVQF9w0c1fRxdMX2EWfyxoCpPw8bdYVECDkny+Cdu2mUIudEhQ
         s9tKYJtJeb6NFYKKS4vsN+l6ULeQD09KJHGhgKxUyTgK5pzWf1GviOiZn4zQKNBdi65o
         vD2SCaV6uab2f4GQTYcIACqQj0CJE35mxM3T7z7p2P6ofzTmleRt73p67Upk2MSr50jT
         nBcY6D2rRatezEXg2LQAtGVjXGBc6TgswqXTrZhOUq+gyezDvhmUFxXFckGflOs2QB/S
         TxeQ==
Received: by 10.180.83.130 with SMTP id q2mr15854957wiy.22.1352738264557; Mon,
 12 Nov 2012 08:37:44 -0800 (PST)
Received: by 10.194.56.232 with HTTP; Mon, 12 Nov 2012 08:37:44 -0800 (PST)
X-Google-Sender-Auth: cYI5mmDNhPKynWc9Ahy6bUO6cxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209485>

Hi all,

I've been pretty impressed with git's test framework, and I'm not
aware of many other (decent) shell-based test frameworks out there.
(One that springs to mind is the one used by rvm, but last time I
looked - admittedly a while ago now - it had limitations).

Recently a situation arose where I craved the ability to test
something via shell.  I did a quick proof of concept and successfully
extracted out the non-git-specific bits of git's test framework to be
used to test something entirely unrelated to git:

    https://github.com/aspiers/shell-env/tree/master/t

As it turned out to be fairly easy, I was wondering if there would be
any interest in doing this more formally, i.e. splitting off the
framework so that it could be used and improved outside the scope of
git development?  Of course this would pose the question how git would
consume this new project without any risk of destabilisation.  I'm
guessing that simply using a git submodule would solve the problem,
but ICBW ...

Just an idea.  Interesting, or terrible? :)

Regards,
Adam
