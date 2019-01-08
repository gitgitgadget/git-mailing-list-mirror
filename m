Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92BCE1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfAHVW7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:22:59 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:37567 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfAHVW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:22:59 -0500
Received: by mail-ed1-f53.google.com with SMTP id h15so5604614edb.4
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9IkOVuLjaLKHtxB3+yu50q4rjF0OoF3UNQ/YDRPpZQE=;
        b=CwZm54T5gvyoEALunazGNDl+VerYNVttN0H3g+gLRAfBNsj7GOSwTLE4RFrCM5l/5V
         W4quKlb22Y2tWr3LQwA3zXA/Vbrq5REJBxqazqqFPq937U6cPeGwcNxzO7eQ/ismniSE
         XxAxwKKL9lNU3aOpcvGa8JOcI2j4LL3V9YPIpkcVDGg16LVC5iKYW0I0ZPrViik/g608
         NXgg+43hmO8ogSnjfmw844ABaSvaL2524xI0fl2y5BsNMJQzqZVrs5uz9hspMYuYNdHn
         bgbk3vRiuRbI9Ox8dVvdc1jeMZtEHFkQEb1FTQxkaTOZVHpm326Zge4s6b03HSQPwIjx
         PPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9IkOVuLjaLKHtxB3+yu50q4rjF0OoF3UNQ/YDRPpZQE=;
        b=YG4zgAdCYVpetvcJW6TF4/KtL5LIqa29rut1hqSMY605Ld/PFhQCIKkAtYb/2G1PUc
         ap5EmhP6NvGHDBsv+6bs3PE8xIuJXgGU73rj/NuX3bNa1+/lUYXRTUFr7K99zOqZ8iXx
         a2yd0TKMSyugygwnVDz1QB9TI3cQnn7U1TpD6SD7VFjQu2fiOkAsPr0IkB0l+ZEVWrik
         kW1UtHL5ruWo/52aUlXeiTo/VU2t2/y3qLqPfM8rWFcSl61xBk+38yu3/+EUinG33v+P
         k9yC4P4rk7Z6/f9gSJMcvcZhEwRyi90I+fnY+Y7OsxxWgSkFAYF2FuRBkZFX935bA3ML
         taKg==
X-Gm-Message-State: AJcUukfExJ3lFKl9RfP7Hi0yOioeZ0DYYBYP+0gjlpY8OmV8/hkNvkl9
        kXoT3zfvYiLLBKd1RNYfEktLXLXSnazrihDN5W0=
X-Google-Smtp-Source: ALg8bN5IVEN1E90K1JRtWulfOzVjqtfZ/rR7IUEswdoybKNHbeJu6jpcMckdposxkkCtbSKkuxNk0ulXtPMsrueJLjM=
X-Received: by 2002:aa7:c594:: with SMTP id g20mr3426600edq.79.1546982577384;
 Tue, 08 Jan 2019 13:22:57 -0800 (PST)
MIME-Version: 1.0
References: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com>
 <87va2zavu1.fsf@igel.home> <CA+h-BnvN7+ETU-vFxAGDvs0gvXUjAAhMkvTPUxoRTt2Gb4b2ow@mail.gmail.com>
In-Reply-To: <CA+h-BnvN7+ETU-vFxAGDvs0gvXUjAAhMkvTPUxoRTt2Gb4b2ow@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Jan 2019 13:22:45 -0800
Message-ID: <CA+P7+xq++4W32JT9WcasXn=Oj9W-U1eteFgpLZn8GVqeO0foog@mail.gmail.com>
Subject: Re: git rebase: retain original head?
To:     Markus Wiederkehr <markus.wiederkehr@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 8, 2019 at 12:47 PM Markus Wiederkehr
<markus.wiederkehr@gmail.com> wrote:
>
> On Tue, Jan 8, 2019 at 6:43 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> >
> > On Jan 08 2019, Markus Wiederkehr <markus.wiederkehr@gmail.com> wrote:
> >
> > > Would it be possible to retain this information?
> >
> > You could use the reflog of the current branch, where it is the second
> > entry.
>
> It is not, depending on what happens in the rebase it could be any
> entry. That's why I always have to search for the right one, which is
> tedious.
>
> Example:
>
> $ git rebase -i root-tag
> ... (apply one fixup)
> $ git reflog
> 906caf1c (HEAD -> master) HEAD@{0}: rebase -i (finish): returning to
> refs/heads/master
> 4906caf1c (HEAD -> master) HEAD@{1}: rebase -i (pick): qux
> 85dab37b4 HEAD@{2}: rebase -i (pick): baz
> 7de7420d2 HEAD@{3}: rebase -i (fixup): bar
> 9bc0461c0 HEAD@{4}: rebase -i (start): checkout root-tag
> a150b73ca HEAD@{5}: commit: foo
>
> Here I have to use HEAD@{5}.
>

He meant using:

$ git reflog master

which only shows changes directly to the master ref, not to HEAD.
During a git rebase operations don't modify the master ref until after
the rebase finishes. This, of course, assumes you're on a branch.

If so, you should even be able to use master@{1} and be safe in
assuming it always refers to what the branch was before the rebase
started.

Thanks,
Jake
