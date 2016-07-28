Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2339C1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 15:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbcG1P5S (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 11:57:18 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35123 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161006AbcG1P5R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 11:57:17 -0400
Received: by mail-io0-f170.google.com with SMTP id m101so103571872ioi.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 08:57:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i4DJ6w2HjkCEr65eZOFsiwGbaGTwZ9EV45qSraAohNQ=;
        b=jYwlcVwXgj5DrqG9OUdepvWg0+InkV0U3YVQ/UTnvq9X+XiodT7eBqlA4OT9RvtMwI
         GZye7Lm17r07BuYsQguZ9iNspHUTlVLE3obUcn9fTxsEnhJg9y9wvfvJkNsFRZOf2x4S
         oGhe2oEnVgns/xjv5EE8SWqI72A08RigQdnQTZFQrEHMPO/fQ+91xIMeEysTs0WS7HTC
         lHjO4xU/UwCMGyIGTIWgbsp18J8IPHwhXuwcZXfXR6kDvn180NY1t+FHPqJYdAYbGTFZ
         0W2bnlMfpxMCO0WxHncINTjoDqaTPUPV5Zqkm4d4U7b6+oHgHPstSv2Niu9wW/rwEn2y
         QFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i4DJ6w2HjkCEr65eZOFsiwGbaGTwZ9EV45qSraAohNQ=;
        b=XlSYzqcMZ6R230ftyCbJFOv5VaO9fRAq88ThP6qEEx4IEsqGBacwc2SvQ4r2BFRPjh
         5BGJx9k/9LaIanJmo3l1yEd6ws4n0ukgkDr69DXwOWf+WZbmnv3L6RkzAytSHoMiZwgp
         qnQHLiaPOUfxchBib+W/9SPhwJ0FnDrUuSQkrembIqo0s4K+pRqc1VSwHSo1S7fIPYLo
         +XGh22hxTp1POxNnL1M3EzOSahOautZJS7G9fG2tl4ayvXckMfmHeXZgYjzxMQgGLh/k
         IrTIH03iJtCYkXYhYKxZwDHWSo2pJQCcmEh6rCTNPkDtpAdoyvhNEE2so/qteoMkHV60
         aVMQ==
X-Gm-Message-State: AEkoouvTmpTKhHOoOHJN6Cig5dsHEAiyBNyA25F/9hix6G8Y91UbaFlPf89n5UiMT8+GNYk/RRVqGsVhFR7Uas+s
X-Received: by 10.107.144.10 with SMTP id s10mr37552491iod.165.1469721436501;
 Thu, 28 Jul 2016 08:57:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 28 Jul 2016 08:57:16 -0700 (PDT)
In-Reply-To: <xmqq60rpu61h.fsf@gitster.mtv.corp.google.com>
References: <578E7A07.8080006@web.de> <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de> <20160725143706.GA4872@sandbox> <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
 <20160726094913.GA3347@book.hvoigt.net> <CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
 <20160728111636.GA7760@sandbox> <20160728125514.GA2813@sandbox> <xmqq60rpu61h.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 28 Jul 2016 08:57:16 -0700
Message-ID: <CAGZ79kYm3ERZu4LX4DavT2o=HrShr3=boExJhfGe=yitru1OOg@mail.gmail.com>
Subject: Re: [PATCH] document how to reference previous commits
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Heiko Voigt <hvoigt@hvoigt.net>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 8:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
>
>> @@ -121,6 +121,11 @@ its behaviour.  Try to make sure your explanation can be understood
>>  without external resources. Instead of giving a URL to a mailing list
>>  archive, summarize the relevant points of the discussion.
>>
>> +If you want to reference a previous commit in the history of a stable
>> +branch use the format "abbreviated sha1 (subject, date)". So for example
>> +like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
>> +noticed [...]".
>> +
>

Thanks!
