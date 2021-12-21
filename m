Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4D1C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbhLUX2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbhLUX2M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:28:12 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E1DC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:28:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id k37so1257292lfv.3
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Az0B/QzDRy/9TCkh2+FTwxwBHbJvKezmmBuD/II9qDw=;
        b=ZWwbVVmYU0GX3Wo9ssqQhevX5Xn5QhZx6LQRHjibeBWyz6nitWeHg0KGb0xw38+ZgF
         wtMYiazS/JMZ0h10FUKUyH7+MgiRfwqqR9fhcDl9jaaZwDzgQwjtfqbwrD//tnILf6Uw
         mxcwMHgRGcy7fZZGvCc1MoVVhlLW7V1fU2PCXLZIvVQifKiJRk+KtwuU5fk9Nzl35xlV
         /QV2TeCiM5LxLtnuuXHrrQDGBPcVUm1+u9NT5xnVKtcYGcSPXWNTFSDY52DR+IPPhRCe
         6RfnG4msPXSsKSDk3OoOJLvDS2fHUziI+tEV0xg1L4xl9AobldrZo3tRrrRUMSBUigVi
         fqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Az0B/QzDRy/9TCkh2+FTwxwBHbJvKezmmBuD/II9qDw=;
        b=ljdDFufE3F3IWZVbb+bGEUNfDX9vgF5iWYk+LKGbuG+WgMPZOuoEiwipykCusQvmrt
         hvpuHQ5wtr2U4I6nBTpwBnvrNfqbQDbz5P4cX3g60yzKu0Jzn+/Q/e9HmQMjurfR8IEC
         wuPl0mqO6AWS0bE2pG4GR6gCpVOlpuxir6VjUt0uVd93AbQpZG8x5HeXoKjB5Aj1qNkb
         kZaNd4LZ4LgaUtDlM1FRpr0qyNgvsRwPfsAw2y1iAX9HSFMK5H1TUNCTDf7SsYsTzETv
         fKa7MebexRdGbHfQCcQ3yWr3wc8sOoAAuAibkCcExdF44jgW9Fc5rfgUGuj8pn0u3Eee
         iI9w==
X-Gm-Message-State: AOAM532s84ig6/75Y0zphmRf0ROiHiVvYucjUZ9+0USTvLkNEp+eTxv/
        mLslLnrj8pyrwwXfkucS54WL8uW9F9G6dtRi5CiH8g==
X-Google-Smtp-Source: ABdhPJyWZZMD+4MZRQl4jitdsATKSjIPKIx2edUEe89zyxCq+6PCjavor53B4FIcOlrxNh06L8DAsvboRIY0a94rhG0=
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr479650lfg.9.1640129289865;
 Tue, 21 Dec 2021 15:28:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com> <92923ca0-fbf9-e763-5735-214f3ad0cc3a@gmail.com>
In-Reply-To: <92923ca0-fbf9-e763-5735-214f3ad0cc3a@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Tue, 21 Dec 2021 20:27:58 -0300
Message-ID: <CAHd-oW6ChTb94hDOUzZZCAo5KBu5_QvD8sbpbSb2BQiWsXkMaw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Trace2 stopwatch timers and global counters
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 11:51 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/20/2021 10:01 AM, Jeff Hostetler via GitGitGadget wrote:
> >
> >  3. Rationale
> >
> > Timers and counters are an alternative to the existing "region" and "data"
> > events. The latter are intended to trace the major flow (or phases) of the
> > program and possibly capture the amount of work performed within a loop, for
> > example. The former are offered as a way to measure activity that is not
> > localized, such as the time spent in zlib or lstat, which may be called from
> > many different parts of the program.
>
> I'm excited for these API features.

Me too! This would have been very useful on some experiments I had to
run in the past.

Thanks for working on it, Jeff :)

> I also like your attention to thread contexts. I think these timers
> would be very interesting to use in parallel checkout. CC'ing Matheus
> for his thoughts on where he would want timer summaries for that
> feature.

For parallel checkout, I think it would be interesting to have timer
summaries for open/close, fstat/lstat, write, and
inflation/delta-reconstruction. Perhaps pkt-line routines too, so that
we can see how much time we spend in inter-process communication.

It would be nice to have timer information for disk reading as well
(more on that below), but I don't think it is possible since we read
the objects through mmap() and thus, we cannot easily isolate the
actual reading time from the decompression time :(

> I would probably want the per-thread summary to know if we
> are blocked on one really long thread while the others finish quickly.

That would be interesting. Parallel checkout actually uses
subprocesses, but I can see the per-thread summary being useful on
grep, for example. (Nevertheless, the use case you mentioned for the
timers -- to evaluate the work balance on parallel checkout -- seems
very interesting.)

> Within that: what are the things causing us to be slow? Is it zlib?
> Is it lstat()?

On my tests, the bottleneck on checkout heavily depended on the
underlying storage type. On HDDs, the bottleneck was object reading
(i.e. page faults on mmap()-ed files), with about 70% to 80% of the
checkout runtime.

On SSDs, reading was much faster, so CPU (i.e. inflation) became the
bottleneck, with 50% of the runtime. (Inflation only lost to reading
when checking out from *many* loose objects.)

Finally, on NFS, file creation with open(O_CREAT | O_EXCL) and fstat()
(which makes the NFS client flush previously cached writes to the
server) were the bottlenecks, with about 40% of the total runtime
each.

These numbers come from a (sequential) `git checkout .` execution on
an empty working tree of the Linux kernel (v5.12), and they were
gathered using eBPF-based profilers. For other operations, especially
ones that require many file removals or more laborious tree merging in
unpack_trees(), I suspect the bottlenecks may change.

If anyone would be interested in seeing the flamegraphs and other
plots for these profiling numbers, I have them at:
https://matheustavares.gitlab.io/annexes/parallel-checkout/profiling

And there is a bit more context at:
https://matheustavares.gitlab.io/posts/parallel-checkout
