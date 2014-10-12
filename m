From: Dun Peal <dunpealer@gmail.com>
Subject: $GIT_DIR/info/exclude fails to negate a pattern defined by core.excludesfile
Date: Sat, 11 Oct 2014 22:58:19 -0400
Message-ID: <CAD03jn4md9YJZ3fFWmvjiO2KSztc-02QpznXO3LJeiZDz8YhrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 12 05:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdAFQ-0005fY-R0
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 05:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbaJLDyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 23:54:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:47423 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbaJLDyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 23:54:52 -0400
Received: by mail-oi0-f66.google.com with SMTP id a141so4271891oig.9
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 20:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=reFStDIohfLECo9D6A6jRJotoEOeudQf7uVcDLZZl8c=;
        b=d77NZzCvlAX9EPM0gYyv4OXMIF406mCbLX55dI0ooK+h2Ul3o0hItnh+CKtOT2lkGI
         rgi34pvYWO4PXg4Wk8l+lwNVQm+JuitAGujCxbY9Lyv0ltALQMHhZZzAi6qvLPJIeVGc
         t/pcVD8iAGtsSg1vTKH64JGPjoVLgLxSv0Sv0WEsD3Qyou4jEsAPxk72wAIKacO6wNM8
         HICYky1TtVloQVbdtmL8q2HUdyFCPxBZLBtIduVAwUBAX4YIfRc7enJxGScjdiEU9QDy
         TT7snUw9Qmg/E7xOaHrgguWayTDTal1DepQwPYpGznZtR2cV2k/Npl/2RXI3VlkLieLs
         jf9w==
X-Received: by 10.202.11.72 with SMTP id 69mr12975475oil.40.1413082699086;
 Sat, 11 Oct 2014 19:58:19 -0700 (PDT)
Received: by 10.76.33.66 with HTTP; Sat, 11 Oct 2014 19:58:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have the pattern `*.out` defined in my `core.excludesfile`.
According to the documentation[1], patterns defined in
`$GIT_DIR/info/exclude` take precedence over `core.excludesfile`, so
for one particular project that needs to track some `.out` files, I
created `$GIT_DIR/info/exclude` with just one pattern: `!*.out`.

Yet for some reason, `git status` still fails to report newly created
`.out` files for that project. Am I misunderstanding the
documentation?

Thanks, D.

[1] http://jk.gs/gitignore.html
