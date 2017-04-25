Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65391207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 08:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030234AbdDYI3g (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 04:29:36 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35669 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980858AbdDYI3c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 04:29:32 -0400
Received: by mail-lf0-f65.google.com with SMTP id i3so19461933lfh.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G2vCHAPunfxho1kvI94+ziaoiVenjh8kj2SgKBCGD/s=;
        b=k5XjkjpdMFjWR1DKSahi+XQhF9nk5wCF5D2jFYH4NaGIogAc4LeBdQBCbN8J3mIsGo
         eqo5jkOkpUzPS5g62pZykhLBukReLCHRw13yU8/14ZOZI8kX+943U7hwhi6Zt9+/ms/3
         dAIGgRY091JJffXGj56FBMwxjiaS3eKJnsz4o/gaDeBv6F8KPhYKvx9NYtLkv3WYXhi8
         CH7TfJ34dJuQqAC9XPFQfj3ILfdt0MgPp2B0/Lfuv4e5ZCHWsgMuoXYwDhyYHQm35MV1
         Dy0vUpKbhPmB7b1+Ei2Pl0T9kMIUL27DAuG0OQRdlamoeZawKRiYTEcvtTM6/0tZ9hRR
         t1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G2vCHAPunfxho1kvI94+ziaoiVenjh8kj2SgKBCGD/s=;
        b=fbvK3kvx3/cfDu1libv3FiA30wPmJPEx2iSF7qRqqJv4G8j2M7zfpy0Idk8NffS+Ux
         xjgUf05VwdK8jk0EpRAlBpR0A7NrSicevUAXAWMjZeobtEsZJgldAsDY+c/Rs4fr5u4B
         kNkyKyFfiMtBaOFWLxJfUQ2g4uwM15JKT+xJjS1+hdtJr8MZz8MNfYwNkDkY9V5QwBfO
         c6YD7bp172ErkxQLLstcCMzRN6lxl/xI2mgQQLrShjKxOvGFul+i8OXr+EBT/l/ZcWz/
         UwHb4haUqYlKHc5Q39F/WtHUtcnA6DM5/txYiy0Hze92GXEFOJ4iyciCoYa/9alNfWtP
         n03A==
X-Gm-Message-State: AN3rC/6JhX2hiv/2azDY4Rt1fPXDe/+MQAaXli2XK/uCdfwAcbFCjwW+
        dCAZt2kmoVYGvU10W4u1IyjacGIZNg==
X-Received: by 10.46.76.9 with SMTP id z9mr10659994lja.135.1493108971133; Tue,
 25 Apr 2017 01:29:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Tue, 25 Apr 2017 01:29:10 -0700 (PDT)
In-Reply-To: <xmqqinltuhiv.fsf@gitster.mtv.corp.google.com>
References: <20170424032347.10878-1-liambeguin@gmail.com> <20170425043742.15529-1-liambeguin@gmail.com>
 <xmqqinltuhiv.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 25 Apr 2017 01:29:10 -0700
Message-ID: <CA+P7+xrXyguugTETd_C-JXDSZ5zHUC3d_1cU4CuiaJjAqWQ=RA@mail.gmail.com>
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jhannes.Schindelin@gmx.de, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 11:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Personally I am happy with the beginning of each instruction line
> aligned, so from that point of view, this patch is a mild Meh to me,
> even though I do a fair amount of "rebase -i" myself.  But obviously
> I am not the only user of Git you need to please, so...

I would instead justify this as making it easier to change the action,
since you only need to rewrite a single letter, which at least in vim
takes "r<letter>" to change the action, vs slightly more keystrokes
such as "ct <letter" or otherwise.

Also, if you change the default commit hash length, it becomes long
enough to cover most commits and you see all commits at say 12 digits
commit hash and everything is nicely aligned.

Thanks,
Jake
