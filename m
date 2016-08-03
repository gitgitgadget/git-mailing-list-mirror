Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	URIBL_DBL_ABUSE_MALW shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7971F855
	for <e@80x24.org>; Wed,  3 Aug 2016 10:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757699AbcHCKrB (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 06:47:01 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38748 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757398AbcHCKq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 06:46:59 -0400
Received: by mail-wm0-f49.google.com with SMTP id o80so329875366wme.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 03:46:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UjOPxwh1sUMPBs8op4VS2UH/tPkd/l0gcexJbr8qpNM=;
        b=NdQ5Cv7tTZTwLLX1ZSUGrnAi+Z7RnuXfwDi7npV8FpccIU4fvYV1yMqG5valhUxulY
         TXmEOGAR8csL4UHZOQSaqAfOyEHTu8v/+RpeMLLViqbOMvO1heB3i9MavFp/yg5ZFagB
         w5Q+Cvb8iPfJc08l/oGaDgDkgUka17zgqO4gjmdiELR+Bn08TkW4SLG5KXtX2+pFvQ+1
         eR+hEjoXCsCVRh+qMD1lLC5aOUSUJWfcEygj8bLFxoDYdy9VmYDe3hPLYoEGPz4N3tOl
         sC59Oo5PGbN1wcNIxWQzgUocu0Zc5MXhtRA2B6Kn54eIXBC9xM9e5OWkcRh2D1u+tUxP
         I1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UjOPxwh1sUMPBs8op4VS2UH/tPkd/l0gcexJbr8qpNM=;
        b=Nkibgje3xszN03xxuPMV7kLfER2b5RHsnZM1ejdeluokf1vqn0pjiZ0a/q9IMEgwFv
         lRc4f82u87Fw1dyChQakDwmr8oG7P2tOwofDVT3saE9hToFr5GDP57zgRAkCDonhiaCf
         QM/BCGZRcbYPbJUZXDZApcr2kXA47ymRs9ybHJqSwOBEVb+7z+GgxEVnzCsISvc04VLe
         PJNxS4XvuHXLrZS9FQXCa+r6WLPvBtYNG2f73zlpd7BM4PCpBeJs0vQDM+j+E3H428Nt
         bqRfs8dVPLFG0iDThmUV8t1ucH5vg877k3DQWnsLLrRm8PFz0ZCNbxlurRuNVTmjDGZU
         YUkw==
X-Gm-Message-State: AEkoousYPg/Wwpsc9yCi8O2K7nwgk64C/cIUUMgNaZMFsy3SY4V4z5FPzz7tPFhD6rnErdzLWRZ31/iTpicCmQ==
X-Received: by 10.28.167.80 with SMTP id q77mr24506166wme.62.1470217635025;
 Wed, 03 Aug 2016 02:47:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Wed, 3 Aug 2016 02:47:14 -0700 (PDT)
In-Reply-To: <CAPc5daVo2o7zxTGVARoZc8AmX2WAJC1cWB4R=9sG8TH8ddKkuA@mail.gmail.com>
References: <a2b34209-2244-d498-6ed2-4f9fbf9f7ed1@ramsayjones.plus.com> <CAPc5daVo2o7zxTGVARoZc8AmX2WAJC1cWB4R=9sG8TH8ddKkuA@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 3 Aug 2016 11:47:14 +0200
Message-ID: <CAP8UFD2NFZCAF=ZWNf4YF+F2L7A4ZM0XS98o-cR_MjuLLR8pfg@mail.gmail.com>
Subject: Re: [PATCH] apply: mark some file-local symbols static
To:	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:	GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Ramsay,

On Wed, Aug 3, 2016 at 12:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Tue, Aug 2, 2016 at 3:33 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Christian,
>>
>> I had intended to ask you to squash this into your 'cc/apply-am'
>> branch, specifically commit 4d18b33a (apply: move libified code
>> from builtin/apply.c to apply.{c,h}, 30-07-2016).
>>
>> However, having read that commit a little closer, it seems that
>> you deliberately made these symbols public. The commit message
>> does not mention this issue at all, and it is not clear to me
>> why these symbols should be public.
>>
>> What am I missing?

These symbols are still used in builtin/apply.c until 9f87c22 ("apply:
refactor `git apply` option parsing") at the end of the series, for
example:

$ git checkout 4d18b33a
$ git grep -n apply_option_parse_directory builtin/apply.c
builtin/apply.c:86:                     0, apply_option_parse_directory },

> Their exports have been made obsolete by the reroll we have
> in 'pu' when "builtin/am: use apply api in run_apply()" was
> redone in a way not to duplicate the argument parsing.

Yeah.

> They should have been cleaned with 4820e13,

4820e13 (apply: make some parsing functions static again) is too early
in the series for cleaning this.
At that point the symbols are still used in builtin/apply.c.

> but I think
> Christian did not carefully review the whole series before
> sending it out and did not notice that they no longer need
> to be extern.

Yeah, I did not notice that they no longer need to be extern.
Now there are different options to fix this:

1) remove the symbols in 9f87c22 ("apply: refactor `git apply` option
parsing") at the end of the series, or
2) move 4820e13 (apply: make some parsing functions static again) at
the end of the series and make it also remove them, or:
3) add another patch to remove them after 9f87c22 ("apply: refactor
`git apply` option parsing")

My preference is to do 1). This way, or if I do 3), I would not need
to resend the first 31 patches in the series.

Thanks,
Christian.
