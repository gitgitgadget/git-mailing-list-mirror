Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2967203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 16:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbcGYQIb (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 12:08:31 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:34997 "EHLO
	mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbcGYQIa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 12:08:30 -0400
Received: by mail-it0-f53.google.com with SMTP id u186so88553281ita.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 09:08:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=leGg4sTZD7MQZ+ApgdqyRPI1G6+ZMlZ4UMtFaBdk+FU=;
        b=G5Y0h/gLoHClfzWj5knpHwkoRmZrBJyeXmwXSdOIiIPuuLt28KqqdjSMEiiZotc7aL
         Lh7O/4JeRclniLpsx43iEBdmQssv58iVEEeThCrb2a2SLC9EZ5p9Z6SDIf2WKBt/+9+W
         pmOBzJ4f32BlM/6Tanb+AxRTuVNfTX4Ep+alH99TVcettQrbFHzC1MxSD1i4ON78rXjw
         jILyxSrA3SvzbdWMObuyo7WxUUHKvxa8m+hqB79H2VAwfbB3LrPEZ/BXYp5jzwFDMYo9
         YDFZV5ZZVBVYZDqLjljh80AGSGW6bRY5KLcyrMIfw8/l7tg4GOv7MHuhWRyHNAsl/HsT
         lRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=leGg4sTZD7MQZ+ApgdqyRPI1G6+ZMlZ4UMtFaBdk+FU=;
        b=OPbJuP3JWar70cCw5M5lU8LX2ln1Yym1nlacT5yaR4a2lELLjAAcAKU99m6YkMIR9A
         cmuHKhmDWmdztMCzuJU/FpxyDJfvpjNyZlxqbhtb97KAIxDPQpSNYPcsweLSHSfhBmhn
         tkFUheceOExOPuEUkbNpDTSo9yHUVPjlm9CxCSKGKzZi6ezZx3T1J3uHKGLKI5kPJczu
         QPWyh1uRjpeiYjcxjynD3R+kDooD9MWVSrTdVz++7byq397n7MJGKM0yq/7AmJYsu2Qp
         BxuJOP+Cgu8GuFsIv2XOMX8KSZ05JkISDaDMn41MpoJ0N8oEmSMX1Jwaa3cbQLPGGzd7
         yHug==
X-Gm-Message-State: AEkoouvP8lj0/Ph1W9/GiBQNHIa6scS/nblrD8+DyRlDiSgt7Nip1KqeVfWkv159eELxwN39XfpcNwJcORMF5w==
X-Received: by 10.36.91.134 with SMTP id g128mr21568695itb.42.1469462909041;
 Mon, 25 Jul 2016 09:08:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 25 Jul 2016 09:07:59 -0700 (PDT)
In-Reply-To: <CAPc5daVV8EkMXWeTiZN9bEXXAejmbDbT9L7SNCc4jNtXYVomLQ@mail.gmail.com>
References: <1469439068-2724-1-git-send-email-vascomalmeida@sapo.pt> <CAPc5daVV8EkMXWeTiZN9bEXXAejmbDbT9L7SNCc4jNtXYVomLQ@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 25 Jul 2016 18:07:59 +0200
Message-ID: <CACsJy8BLTdsUqN-jUXUmX+9npja9H5rO8svM18YptrxtJ7W64w@mail.gmail.com>
Subject: Re: [PATCH] t5510: become resilient to GETTEXT_POISON
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Jul 25, 2016 at 2:31 AM, Vasco Almeida <vascomalmeida@sapo.pt> wrote:
>> Replace gettext poison text with appropriate values to be able to cut
>> the right output of git fetch command for comparison.
>
> Hmm, as these tests are _all_ about human-readable output, it probably is
> sufficient to skip them using prerequiste, I would think. We do not want each
> individual test to have too intimate knowledge on how POISON strings look
> like.

Yeah these tests are about alignment,  they are probably useless
anyway after the text is poisoned (and has the same length).
-- 
Duy
