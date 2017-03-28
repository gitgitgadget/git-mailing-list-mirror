Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4031FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 15:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbdC1Pej (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 11:34:39 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35142 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbdC1Peh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 11:34:37 -0400
Received: by mail-vk0-f46.google.com with SMTP id r69so92510271vke.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RV9E5erQDatF+AfotgcHp/7uXeni1GQtuLDTfFhTUM0=;
        b=Zr6oN0TG3mQZccLaErp2wsM5OG4VHmGMKnNzJKyf75qGMoYvAaSIXMOWvwKkBrlUS0
         dp+CfaSD7NCe4eE/gvCpTqFvfL8p7/YolzBBG/e9+HLmTL1Um01dCw9qhDvzCBrDalhJ
         cS4AdiOFoOU8xJvQnl7SVfTlAzMI7kB9uimaFcYm4m/2Cnfxb657F4aohBoWlAMvsJNs
         3zHa04Li80ZyxnQQ87pm42AKTez3yYYXEE86tmQXuxuz3NdcL2MksboWEhvg9/BS0EkM
         xk8P5hDUjNXJ27l9KUZBbJkmBH4onq2NpfUSr3Ll9seT7Y8BTaPKaONGT86j0or4s7iH
         AP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RV9E5erQDatF+AfotgcHp/7uXeni1GQtuLDTfFhTUM0=;
        b=b2GqLJ7N07iuiaKnWm5m+BDX0OrJ5wm76LIrCrzOw5uoG5+bLnto0kvxhupD98lmru
         hd7v3Su76UTxN1kJjM92JvvhO1TymcthxfynE27Glt6tVnUZqPArKwxXvrxjZ5VYr4CM
         oB1VvEmS4znIfKRLihvQAM0A1I1WZDeLwEZcBmtQelWhGcQ4I4VNT/mKLfKTC3rG0y0N
         9qpiKOCGdv499w9ODMzEovjFj26z4KCqoQ5h++mQky+ud8RArEiRs/M5xys2a/Gy4KQc
         /BEmta+t0qDEXhJ074MoCuDmYIvL9IioCk0wBxJiZQv1uOjAJNuekEeCjpszaxIcA8Ag
         Ovag==
X-Gm-Message-State: AFeK/H1aAUaNfqKdfZqvUyW7UPgFMKsoz2jBTlUVvYV7/poWw95nUSevxpJ3w9tbje+AojowUivvi1mnROoaVQ==
X-Received: by 10.159.48.146 with SMTP id j18mr5935384uab.156.1490715261736;
 Tue, 28 Mar 2017 08:34:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.93.29 with HTTP; Tue, 28 Mar 2017 08:34:21 -0700 (PDT)
In-Reply-To: <20170324194237.td2nsiyuatexuxo2@sigill.intra.peff.net>
References: <20170323152924.23944-1-szeder.dev@gmail.com> <20170323152924.23944-9-szeder.dev@gmail.com>
 <20170324194237.td2nsiyuatexuxo2@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 28 Mar 2017 17:34:21 +0200
Message-ID: <CAM0VKjkMLdTzFyAdgnJsFGk4JpR-oBdnXRoeskRRSbsvT8TXcg@mail.gmail.com>
Subject: Re: [PATCHv2 08/14] completion: let 'for-each-ref' and 'ls-remote'
 filter matching refs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 8:42 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 23, 2017 at 04:29:18PM +0100, SZEDER G=C3=A1bor wrote:
>>               case "$cur_" in
>>               refs|refs/*)
>>                       format=3D"refname"
>> -                     refs=3D"${cur_%/*}"
>> +                     refs=3D("$match*" "$match*/**")
>>                       track=3D""
>
> Working on the aforementioned patch, I noticed that for-each-ref's
> matching is a little tricky due to its path semantics. So I wanted to
> double-check your patterns. :) I think these should do the right thing.

Yeah, I always thought that it's weird that globbing in for-each-ref
behaves differently from globbing in ls-remote or refspecs, but there
is nothing we can do about it now.

Anyway, this is why the tests added in this patch include e.g. both
'matching-branch' and 'matching/branch'.
