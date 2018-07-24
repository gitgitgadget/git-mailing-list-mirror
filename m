Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E55B1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbeGXT6i (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 15:58:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54388 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXT6i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 15:58:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so3551335wmb.4
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t5saW+90+LsvA1/7fUMrNVRsiWfCcJcfO2HLI8Vrlmo=;
        b=O+f43Caun3L3vPU2cg83LqA+p6RGpUNsezqmBqyNsWlC01uie6NG24AUZ24NBMiASg
         FqvjYxCMSPf061l9AAcCpvpJD9CgLrbPEZsFTe4v2JliUBEzsMTcLpY13dcE/yA7i5xS
         TewhrcwWa9dFkjPV+FT9iI1mkjka8Nk6poKevjVYm5akNRwEXatYXV16LZIoYROIraVQ
         tSShU2fXZC3bWF4Q6ZqR+o0VOipxxIh7WIuBnqtQLPgCt1rVXBUexJKctpnK0Y5PlB50
         7gDtBC2toT1C3H5WEr4IOAfmfGqtw67V6Wy+kaLJDISaOjPPZmB96WY90ac33S/dWLBU
         9p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=t5saW+90+LsvA1/7fUMrNVRsiWfCcJcfO2HLI8Vrlmo=;
        b=SjC1KVIlOFLFfnroj3c/7U1LoIHdI9DQE7A2t9kKgNij4Dqw8WOpzVvR5WOF+d2bfw
         MtTh+GP6IxdIFKzH96AM7RK9EzqVGg//++bJOUFwwVCaj06Yc+zTwoN3hJr5j0NV23LG
         A6+fq2QH8snrNs8UsEp6nvr4UMR9XCn/T7dZ+NOcBuUovsQy2/9LNV2fX3OvDSmt/hlK
         Bnk4rmCaECcXfAketHgcx9ZmGNrlKPACQ8q3CBFYvGUXQ+JSzYDXVuWL32Xv6tVMF5yx
         YOPHpmLohHHVIt0hBbEy8cSTDQiRgR5WYlO0pk7YGW5khoQvdNz0cHyYlXJqWXIT7NGI
         8t3Q==
X-Gm-Message-State: AOUpUlHQLDQytldPdMXCFJyn48bzzoHxJGLKxuK5oO61uEsIS9WgvXTv
        FHqWvpc1yf/hr+Edzy2/IfE=
X-Google-Smtp-Source: AAOMgpcH3VeuyqavlhiUj81R/Frenm6GhSti0tz+tMYHcL+FpHGMKC/8Hltbc3Xsw3j2hHkVGZOGtQ==
X-Received: by 2002:a1c:b9cf:: with SMTP id j198-v6mr2777238wmf.93.1532458247618;
        Tue, 24 Jul 2018 11:50:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m207-v6sm3153123wma.31.2018.07.24.11.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 11:50:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, peff@peff.net,
        me@ttaylorr.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] config.c: fix msvc compile error
References: <20180724153010.6693-1-git@jeffhostetler.com>
        <235ae68c-f764-ba3a-c641-ef5f99507564@drbeat.li>
        <xmqqwotkxzn0.fsf@gitster-ct.c.googlers.com>
        <8fd2fe53-ff42-5e21-a485-a38c97331b9c@drbeat.li>
Date:   Tue, 24 Jul 2018 11:50:46 -0700
In-Reply-To: <8fd2fe53-ff42-5e21-a485-a38c97331b9c@drbeat.li> (Beat Bolli's
        message of "Tue, 24 Jul 2018 20:26:50 +0200")
Message-ID: <xmqqr2jsxybd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> On 24.07.18 20:22, Junio C Hamano wrote:
>
>>> This was already fixed (differently) in
>>> <20180705183445.30901-1-dev+git@drbeat.li>.
>> 
>> Thanks for saving me from having to dig the list archive myself.
>> Yes, it is already applied to the tip of the topic that originally
>> caused the breakage.
>> 
> Just a general question:
>
> Is it OK to refer to patches on pu with the Message-ID, or would you
> prefer the commit hash? The hash changes whenever you recreate pu,
> doesn't it?

Either is fine in practice.  The commits themselves on a topic
branch that is not yet in 'next' usually stay the same once the tip
of 'pu' that contains them gets published.  Even though I often use
"git rebase -i", "git commit --amend", etc. to fix up posted patches
while turning them into commits on topic branches, I usually stop
doing so once I push out day's integration result.

Until a new version of the series is posted to replace them on the
topic branch, that is.  But at that point we are talking about new
patches with different message-ids that got turned into different
commit objects, so either commit object name or message id that
refer to older iteration would still name the same old version, and
new names would refer to the same new version.

