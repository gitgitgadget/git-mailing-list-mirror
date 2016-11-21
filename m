Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 514D61FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 21:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbcKUVDo (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 16:03:44 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34369 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753565AbcKUVDn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 16:03:43 -0500
Received: by mail-qk0-f173.google.com with SMTP id q130so368494406qke.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 13:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3MTDSwc0XgGKLN7Nu7n6setimlMxzGF0SCBu1lF1psI=;
        b=YejLf30wA7B6ubzU3i3wCuJkAOyV6ZrOYskKSs74IIOG7QT46BZoAedLTwEBcxk7L0
         sh3wFlUn9RICAZLHjYoDYU2p3xFG4N/+GHzyOW4t0EfNglgpp5zTShQmjwk/XRJ67F1m
         skQQ+PPxstrd1l4UVyTu9c7A4+2SAyy2FAxojI6ugBy77FlYYnlas5qz+vX8PIda04O7
         NGgHkKTc5t231bqrnJ/FnbNS3JPTZbr9KzLhknnJsBk+HoMozRRXzggzOSDxS+14CgkN
         mcJ+RsC10rB3rxdqK7NxYuvD3xEOXllNkkRkRTkofpk1Gpi1xXudiO81HJaoJJEKT3F+
         xOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3MTDSwc0XgGKLN7Nu7n6setimlMxzGF0SCBu1lF1psI=;
        b=H5DXW0c5RaT9X4gobCsDqF+mZNBG7gXnPTND/RANhKHdorLpR+zzOiVdLanaRyik5l
         TAzDDv5nlJ1XYguOT/83zPLeajH1Zc8XcGMeNRhqW3PdDhhM2uzYKH2bWqeNGqXZZ8Vk
         uwRU2hUICPiwQ2GAmsdkd1zG8Nt05ujjvcNSvbLLkDsZMdiJ1YyvqZBGL+ENNL1qMj8l
         m+dxq1BUGTHNBcfaCZo7ZmAoIz46L+bhAmbJmWWSd7UKdIGTK2mxD8FVZGprsLMPzbtE
         grCZpTRPrgt8QsBLMMt5iSjVCLYK3a2+wwnwe1Be8D9zBfgQzKWG1WWakVquZFwhTsMn
         qgGw==
X-Gm-Message-State: AKaTC00Mk7QJF7PuvyjXNnxb9FIkzVq243cgsUey+lgt4AdUHaaWSEdMMbosdP1gzemR/d40DwwdufZkIX0NVeQt
X-Received: by 10.55.20.164 with SMTP id 36mr17415867qku.86.1479762222650;
 Mon, 21 Nov 2016 13:03:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 21 Nov 2016 13:03:42 -0800 (PST)
In-Reply-To: <xmqq8tscim31.fsf@gitster.mtv.corp.google.com>
References: <20161121204146.13665-1-sbeller@google.com> <20161121204146.13665-2-sbeller@google.com>
 <xmqq8tscim31.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Nov 2016 13:03:42 -0800
Message-ID: <CAGZ79kY=tzrsn7rS4UsRfSku_pKNNWNDc2OiTO-4-vg5h8NwWQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] submodule: use absolute path for computing relative
 path connecting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Subject: Re: [PATCH 1/3] submodule: use absolute path for computing relative path connecting
>
> connecting what?  IOW, has the subject line somehow truncated?
>
>> This addresses a similar concern as in f8eaa0ba98b (submodule--helper,
>> module_clone: always operate on absolute paths, 2016-03-31)
>>
>> When computing the relative path from one to another location, we
>> need to provide both locations as absolute paths to make sure the
>> computation of the relative path is correct.
>
> Can the effect of this change demonstrated in a new test?  There
> must be a scenario where the current behaviour is broken and this
> change fixes an incorrect computation of relative path, no?
>

I found the latest patch of this series broken without this patch.
I'll try to find existing broken code, though.
