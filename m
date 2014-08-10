From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] checkpatch: Add test for commit id formatting style in
 commit log
Date: Sun, 10 Aug 2014 23:08:31 +0200
Message-ID: <CAMuHMdV1TXLmuAofwrUuT-KKUfkEYdXsM34VRrfhB6FxXfdeeg@mail.gmail.com>
References: <20140702130210.fd40d67f0819cfb5f3e9e5ca@linux-foundation.org>
	<1404331746.14624.95.camel@joe-AO725>
	<20140702131534.c613f55f79519b3862f79e40@linux-foundation.org>
	<1404338448.14741.8.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 23:08:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGaME-0004d0-0W
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 23:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbaHJVIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 17:08:35 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:58042 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaHJVId (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 17:08:33 -0400
Received: by mail-lb0-f177.google.com with SMTP id s7so5301900lbd.36
        for <multiple recipients>; Sun, 10 Aug 2014 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AYPiK5s011pmTiVGway4K3485FNdnmZX+PvAE8TEXwQ=;
        b=TD0MMxpLqKiLoLM0RprayDoaHYRYe1d9qyLCnXQAX7pjvWFSwxV5L5EFsFIYUKWlQd
         sFDBb6I/ZN3L4F1jk3FaOJ/n7E/zLfxeNyRiK8bMJdc45StGoOmFxWu+xUM3Mzzc0Bu/
         sky7qTTN1e2SxioSlgIREpGYar1cBGk+xcndzmogAHaBiik0Lp/R9u1IL56iLXqgGjdd
         Ww2UgNI0vwM3gc6og9J57ObILKZmLhgerh1DpD42SsS1QMd9aac9uZ6Ai5xxE4hj9/8t
         nKsf9nyhT+WaZozUMaABqhdQvC+54SIn7Z1CjXFPlF7pAyaFH1au4PDrlzQu/3P0eupB
         n1ZQ==
X-Received: by 10.152.29.135 with SMTP id k7mr6519251lah.14.1407704911803;
 Sun, 10 Aug 2014 14:08:31 -0700 (PDT)
Received: by 10.152.170.202 with HTTP; Sun, 10 Aug 2014 14:08:31 -0700 (PDT)
In-Reply-To: <1404338448.14741.8.camel@joe-AO725>
X-Google-Sender-Auth: K6-UyM-P0MtbwsBWKkfKhRDpi5Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255105>

Hi Joe,

On Thu, Jul 3, 2014 at 12:00 AM, Joe Perches <joe@perches.com> wrote:
> Commit logs have various forms of commit id references.
>
> Try to standardize on a 12 character long lower case
> commit id along with a description of parentheses and
> the quoted subject line
>
> ie: commit 0123456789ab ("commit description")

Now this is in mainline, checkpatch starts complaining about my "too long"
(40 chars) commit IDs in commit messages :-(

40 chars may be too long (but it's quick to copy-and-paste, as "git show"
shows that by default), but 12 sounds a bit short, as that's only 48 bits.

According to the Birthday Paradox (en.wikipedia.org/wiki/Birthday_problem),
there's a probability of 50% of a collision if you use 48 bits IDs in a
repository with ca. 16 milion (2^24) objects. A Linux kernel repository
counts ca. 4 million objects, so we're getting close...

So soon we'll get "error: short SHA1 is ambiguous".

BTW, is there actually an easy way to make "git show" show all options for
an ambiguous SHA1?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
