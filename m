Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215AC1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 21:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfHTVjr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 17:39:47 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:32959 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbfHTVjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 17:39:47 -0400
Received: by mail-io1-f54.google.com with SMTP id z3so483500iog.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4mj68aSwuV7d18zC3LbdEMepe6GMyOpEojDWvV04Cs=;
        b=yIFVVD5mpg7xTGimpajvvEGlO8xMhpq+8RtnXZNMM85vTt3UJ/hI2DkIKFfocdq+PZ
         F5skiDI1MCjYoF+V8cu2OxyxAHHRdg3xYVCVl+gJyT+7Z5CvmsiisTp5papoXkpNFdl+
         IS2pT/PRe4M9fEdBsjL9vFLWnSDat/MxC4FrrH0cj4c9F7Fb/Zz4glohNKjPQ6E/EFQ6
         Z25YRyAplHgGn8wQdnZKXbgdcIc8tMiPRGZiwwZyPBO50mKFITy7DHaLTqHCcd5cz8WT
         q9B+3srRXfvo0T+BAlBnxJYXRL8kI5VP8Qm+PPqcJ+N48V0YPKSRW/U7uD3stNjMKSNE
         0s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4mj68aSwuV7d18zC3LbdEMepe6GMyOpEojDWvV04Cs=;
        b=MQYw/hVUviDT78/5ouMXogd8dyJXcAy9n95KCcd7ommRfdVirAdfMOX/Kwh2KJmD1N
         NVx+K0C6IyfQysICBWRkEy4j+8145C75rzgSm2QcF2eJG7J5kwTHQ/2IA8iHXv7a34sG
         3PL4fzl2lmVnKXlHKhf5Fbmi3R9mi6Ek2MWds80MAwrG/7b1QHrw3rSyUMTqCHf/zkzs
         x0Od4K60eBfX1p0Z3L8DONY05CVBleNvTU4ffBNG93RaHljGv4waZy7XGAFt4p9zmMFv
         AVEnbNRCy7QdnSPM+9HhwGZgj5mN6dCkD8yiS6RMWKzw4G+GkffjTqHd0a8Q+22pG2Tj
         GWtA==
X-Gm-Message-State: APjAAAVyYWUkmVCKq9IfwCiSgN3bPuoBtuMA3bSVwH9WgMOvbCi8+FEe
        gZHgpml/2QMHtfscJODuSyS7z8/AbOIz7sg6UpltL65rP50Bpw==
X-Google-Smtp-Source: APXvYqyLd/KU8FK0kEgsRA3uFRZYtlh1MmGlYLnPuiMNtlQX9evRQIFOVMm6D1qeYRoDi94ggOc4nzqoo9KnZEvOoe0=
X-Received: by 2002:a6b:fc02:: with SMTP id r2mr11835995ioh.15.1566337186014;
 Tue, 20 Aug 2019 14:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-GBx3FSCQTipmkNBtnwMANg5A0FXiiPc2az0NiRLRT+xg@mail.gmail.com>
 <xmqq8srowfkv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8srowfkv.fsf@gitster-ct.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 20 Aug 2019 14:39:34 -0700
Message-ID: <CAGyf7-F_89u-913P0znH_3NCzNZNarb3u_3Vpwt5-QMiFCK+Tg@mail.gmail.com>
Subject: Re: Fully peel tags via for-each-ref?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 10:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Bryan Turner <bturner@atlassian.com> writes:
>
> > Is there any way, with "git for-each-ref", to output the "fully"
> > peeled SHA of a tag's ultimate target, regardless of how many layers
> > must be traversed?
>
>
> If %(*<stuff>) does not peel fully (I do not recall what I did
> offhand), because all other things in Git (like $X~0, $X^{tree},
> etc.) fully peel the outer object until they get to what they want,
> it may even be OK to declare it a bug and "fix" the notation to
> fully peel tags.  I dunno.

%(*<stuff>) definitely doesn't fully peel.

$ git for-each-ref --format="%(refname) %(objectname) ->
%(*objectname) (%(*objecttype))" refs/tags/
refs/tags/backdated_annotated_tag
80aa5be5ecf39660f798858482254f7a2ae9110e ->
57150c54c38d6570b2fd5e6d6cfc19476de44e84 (commit)
refs/tags/retagged_signed_tag 9b4e781dea0769888fe270e06ad76675f73851b1
-> 12ebe2a58367347cd39f19f5a72f3cbec7b8f9a9 (tag)
refs/tags/signed_tag 12ebe2a58367347cd39f19f5a72f3cbec7b8f9a9 ->
0a943a29376f2336b78312d99e65da17048951db (commit)

"retagged_signed_tag" is tagging "signed_tag", and you can see that
%(*objectname) for it is "signed_tag"'s hash and %(*objecttype) is
tag.

$ git rev-parse retagged_signed_tag~0
0a943a29376f2336b78312d99e65da17048951db

I don't know that this use case is common enough for it to warrant
"fixing". I'm not even sure most would call it a "bug"; I hadn't
considered it that way, at least. I was just interested in whether
there might be an out-of-the-box approach I wasn't aware of for
getting fully peeled results.

Thanks for taking the time to answer, and to provide a bit of history!

Best regards,
Bryan Turner
