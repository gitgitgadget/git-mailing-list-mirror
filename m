From: Heikki Hokkanen <hoxu@users.sf.net>
Subject: Re: [PATCH] bash prompt: add option to disable for a repository
Date: Sat, 23 Nov 2013 18:31:52 +0200
Message-ID: <CAOpY_XvN9GJw592MpbcZZ2hzUvSvTHNLebwMmQBK+N-Ez4xM_Q@mail.gmail.com>
References: <1385212703-9611-1-git-send-email-hoxu@users.sf.net>
	<5290BEE7.2070901@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Nov 23 17:31:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkG7i-0005Ou-67
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 17:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160Ab3KWQby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 11:31:54 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:63726 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517Ab3KWQbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 11:31:53 -0500
Received: by mail-bk0-f41.google.com with SMTP id v15so1245322bkz.28
        for <git@vger.kernel.org>; Sat, 23 Nov 2013 08:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=a2WDP/eF9FfUfIU0/4ptAFJuM+7TCtdiBFq4umSYLtU=;
        b=RBg+5a1ktXPFdufAnpjVJtYUGKaJ03lPrHCa+uuoIYrLAfxcna7+7TvuhvcVC+tVFw
         MS4d1+oD2o1efHg8hrW7N8FZPgwsXmDHQF76ym3SQpJ0SVIb7jy2tSSOScYXNeF4sNmT
         P7tYiAl7jHF/PnKgfbOi7jaWHDJtjd4F4Lkbwdv9GYZyYPMxqnlUtrLC5h2QuIcs9cEY
         GJ54M3KtHcAsibSnE5cUJr9VGF6LgdDXt+Qg535Oor0XgKRDi8LQmoKsWt/aTlfpi0kU
         Wn/gvodBpMykVFoh3rPtvj7UpE51nORjL86sNZl+PGw1PStOOxFgfT+hYfyrNUT1fd/h
         wJUg==
X-Received: by 10.205.36.193 with SMTP id tb1mr15035540bkb.28.1385224312472;
 Sat, 23 Nov 2013 08:31:52 -0800 (PST)
Received: by 10.205.4.6 with HTTP; Sat, 23 Nov 2013 08:31:52 -0800 (PST)
In-Reply-To: <5290BEE7.2070901@kdbg.org>
X-Google-Sender-Auth: yEsouL6_rR0nRX0ywFOPRobV6VA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238238>

On Sat, Nov 23, 2013 at 4:42 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Gah! This adds a fork+exec each time the prompt is shown. Not good,
> particularly on Windows.
>
> Since your intent is to disable the prompt in the home directory,
> wouldn't that mean that most of the time you *don't* want the prompt?
> Wouldn't you be better served with a method that *turns on* the prompt?
> For example, a shell function that sets PS1 and another one that unsets
> it? Or a wrapper that inspects a shell variable and calls __git_ps1 only
> when you want a prompt.

Actually, I do want the prompt for all other git repositories. The
problem with $HOME is that it's the default directory after logging in
or opening a terminal, so if you have git prompt sourced and your
$HOME under git, you get an unbearable delay every time you open a
terminal, or type a command, anywhere, except for a separate git
repository.

And I do believe I'm not the only one putting $HOME under git, so I
think some kind of generic solution to this problem would be nice.

If running git config on each prompt seems too expensive, do you have
any better ideas?

Regards,

-- 
Heikki Hokkanen
