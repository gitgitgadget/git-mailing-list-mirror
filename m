Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A01020179
	for <e@80x24.org>; Mon, 20 Jun 2016 06:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbcFTGck (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 02:32:40 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36505 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbcFTGci (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 02:32:38 -0400
Received: by mail-it0-f68.google.com with SMTP id h190so5734391ith.3
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 23:32:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kzUYmKbYvj8DarhKoNPFCjJtbLix6T5E4HU5a141heo=;
        b=n9Ve4NdvRUrr7qfoZHOxdvJzlZU7nsnTF0OuJOx1CD/eSvxgqW4Bfrg8g2nBTikdnQ
         wIh+jmXC5+Ou1q0HJ0VdqBzuEUG2grJ+Lr9S4nC/2ZdMh/Lkny4QPBx8kVMY2ZpqkfpZ
         R5xdkdfqwLyMdWHWJiW8/NXa4mimrUq/fidSTGNR42/Fg0xwHMY4UFuZH0rHN5Ca0kiD
         pdX+qnZM6DpqIW5lKlF5S8OOo4vf65Ct+zqkO5pHWQfmzq06VJwQ9mAbrs9x+NlGoQlB
         wpJlcj6Pu1nvOgjOdzuDGqfmbJVnSQaKsruWaqngZlI/PRpz9r/9Cgyn3sLe56sE90ry
         UcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kzUYmKbYvj8DarhKoNPFCjJtbLix6T5E4HU5a141heo=;
        b=AlgMfIIn0vm3p3F7qvbG7DswwhVvWKSm5fGpThpze0MbRKQF9R0K/nUVGPezgg8T2Z
         spnAjo1RelyDBf3Ik2RsNj0XTbqaugGlh7Z+ZC83lZoIpwNi5WYeuaObYecy1WDArrO4
         MMosEQ9/iInnL422OGMMzFTchgUUexMiMnPbL9VjDpvBGvM75hcPthzgK7rd2Xr67rBR
         KSTuXRh2uaK+My9qYyyX0TtPobWMsxYCrGSxEmlAsVpKsGzASd9m2tzbXcZT/TRv6jBF
         64hVjaT4dsudsj/m7CtO0BHVjgKKxWkmLbQM7b18huZWzoFLYhSzTx6h5dGmqXqyGoN4
         4rHQ==
X-Gm-Message-State: ALyK8tLUCBe6zRYJTX1FPg+HyRuu5k7NPDdiMS2BHo/4xnZysKa7XO6M6uBXlISFLex24BrLTQP3zs9vcroxlg==
X-Received: by 10.36.55.15 with SMTP id r15mr14828693itr.73.1466404357731;
 Sun, 19 Jun 2016 23:32:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Sun, 19 Jun 2016 23:32:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1606200814510.22630@virtualbox>
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
 <de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de>
 <CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com> <alpine.DEB.2.20.1606200814510.22630@virtualbox>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Mon, 20 Jun 2016 02:32:37 -0400
X-Google-Sender-Auth: c4UR-2Ptg7RqDKsNyyB8bGR9Cfg
Message-ID: <CAPig+cQqworFpRvd-U9sgnyitQEzy6zAKc_091b9fzjuzsFnpA@mail.gmail.com>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 2:26 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 19 Jun 2016, Eric Sunshine wrote:
>> On Sat, Jun 18, 2016 at 6:04 AM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> >         if (output_directory) {
>> > +               rev.diffopt.use_color = 0;
>>
>> What is this change about? It doesn't seem to be related to anything
>> else in the patch.
>
> Good point, I completely forgot to mention this is the commit message.
>
> When format-patch calls the diff machinery, want_color() is used to
> determine whether to use ANSI color sequences or not. If use_color is not
> set explicitly, isatty(1) is used to determine whether or not the user
> wants color. When stdout was freopen()ed, this isatty(1) call naturally
> looked at the file descriptor that was reopened, and determined correctly
> that no color was desired.
>
> With the freopen() call gone, stdout may very well be the terminal. But we
> still do not want color because the output is intended to go to a file (at
> least if output_directory is set).

Would it make sense to do this as a separate preparatory patch, or is
it just too minor?

> So how about this commit message (I inserted the "Note: ..." paragraph)?
>
> -- snipsnap --
> format-patch: avoid freopen()
> [...]
> Note: we now have to set use_color = 0 explicitly when writing to files,
> as the auto-detection whether to colorify the output *still* looks at
> stdout (which is no longer freopen()ed, and therefore might still be
> printing to the terminal).

Thanks.
