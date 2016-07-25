Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AFB2203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 21:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbcGYVSJ (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 17:18:09 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34838 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbcGYVSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 17:18:06 -0400
Received: by mail-wm0-f47.google.com with SMTP id f65so150490271wmi.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 14:18:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qoZIG72rPobqfSpATCYolYxSuJJUMfofRaMufpAP6pw=;
        b=pAe23STWfqb1hf3DYBg1VqEBjcT16SOzlkynr7o+du/gnasTzOodhcDFc6KmwRPXFT
         sdO+YEfCR9sek2uB7ogNGl6pBrN3mTx6QMsqeWUEPEusZmDljeMnZJ4AO5FPBvJxJ/TW
         fzULPmMBjMZA8iX3J1zwZLW6sMs7L/2zF+hV/pU51i7C6VPOMruzrKYZf1J8PTOK98cX
         Pav+dwl83UonBErzFmu1f68eyGoKLykEND1MIEJ5g628RO3r9m4wve0ynWR8u3LWlXcG
         kmfNpRhJyZ5NwD4oFkyDr/w0xpWqjxj1Vj5guBMFLXket96erQBOSSM/adxL9LMPOgFx
         5e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qoZIG72rPobqfSpATCYolYxSuJJUMfofRaMufpAP6pw=;
        b=lRptcvsdW/e6+vTmio1ro6JTjGPpUhe3LpM08MqoqJ7+Sx2L+DbBCr7J7Kxs7qAqHZ
         cKbxtPl3nu3P0BnP97I1BiX7Sr5Bff1Ph9j1x+tGScMt5fkC/c63uGlOSfjfcw5ppqap
         wWz1+BFzuP+xw0xJZSOQM9EsW5Et43a1h2/CaHVbiIepmEAPfWfkdZC/NoG9mV1Qvysd
         ifGgqQz32jr5PezRERuav8k1fm3MfCuyq5u33w9sxddf1qNZNvnfSPU9Y4Fto7LdqrXj
         Sz64Q0jse8PqpzyVoW9HWQ5hGkU9rWOlgkpo/WclgSsP9vj7FRvKDb/Us+Os7TkHYbnC
         yjkw==
X-Gm-Message-State: AEkoouuMpfzwUFdTdx4ZEczaKLQHBmbJLLFDGqcoa1YdbI4pc0H72emvXyGVPRtyRlZxp8K/w38POHyeyqkCjA==
X-Received: by 10.194.164.9 with SMTP id ym9mr16658104wjb.78.1469481485077;
 Mon, 25 Jul 2016 14:18:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Mon, 25 Jul 2016 14:18:04 -0700 (PDT)
In-Reply-To: <CACsJy8DRmcUzG+Uj65nqmyjbohbWq1Us4c7YkNkG15fjGijfEA@mail.gmail.com>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
 <CACsJy8ApNJ+EBOVNC0GoPUaO898QRqHUZ2yQ39Qg5uGq4sHHGg@mail.gmail.com>
 <CAP8UFD20WtCPLb3VzCJnYZSreUM7Q8GOC_VBG3h1j3wjOcR=_w@mail.gmail.com> <CACsJy8DRmcUzG+Uj65nqmyjbohbWq1Us4c7YkNkG15fjGijfEA@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Mon, 25 Jul 2016 23:18:04 +0200
Message-ID: <CAP8UFD16VearVw3EMM_TzV=43qvyoo2PBDhEOFJFuBU5=Pe4Lw@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/8] Add configuration options for split-index
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 6:04 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> Hmm.. can you do the counting separately? A shared cache_entry must
> have its field "index" greater than zero. By counting the number of
> entries whose index is zero (i.e. not shared) against the total number
> of real (*) entries, you should have a decent estimate when to split.
> Then you can do exactly what "git update-index --no-split-index" and
> "git update-index --split-index" sequence does, but in write_index().
> It's easier than messing inside split-index.c. If we hit performance
> problem, then we can look into changing split-index.c

Yeah, thanks for the suggestion. I will try it.

> (*) remember that some entries may be marked CE_REMOVE, which are dead
> entries and should not be counted because they will never be written
> down on disk.
