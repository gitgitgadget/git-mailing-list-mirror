Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12BA203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 17:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511AbcG0RlM (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:41:12 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33646 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196AbcG0RlK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:41:10 -0400
Received: by mail-io0-f177.google.com with SMTP id 38so77076361iol.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 10:41:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e74YdATkQMEVXLnLSLamDiZHM3GO1UER8h9jcqg3GFY=;
        b=Z+sBBfNm7UQLrn5/OUT86zj1L+HSlXBAnPlcT9DFbcpqHPIWKH4q5l9knavQfayf2j
         cxHLfh0oNnyGR32p5JMASHh7v3upzOunWgSn5hBwEsbdK1ObSh9PJ1pdC6tXz3MVUmJb
         Gj+tK48sGrM5dKPNULAgYb7+aBtFu9mvrzxhbmNdd8sOHaiThEyo9hCbHXq3aV+bGTTb
         OFAxRpDWBAsCO1+Lba4Z24rPU4MHLWzOdn4Ih6yxOdr6l7ZIsiih/SiwzfjmZEkQqHmo
         znHI13tz1/I/OtUhRNAkQNcQsj5GufusxhrlndrmzWXlcIuPPfhrDdOaRfPnu47z+edW
         tC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e74YdATkQMEVXLnLSLamDiZHM3GO1UER8h9jcqg3GFY=;
        b=ETHfbbC8NBsNqrYawsRHHBqwsU63fTUtp8Bc3dArA4d38teF04ZNg6kdFk5tkEJP4U
         BvVlFgJdsOCeZ0G4mHkggOLA+PbFlfSj6Tmuju/idN9QwgmLziP7u+Eb5V4FUV79se4d
         Yo2VMhHpS0A86VEoPOzr8mMW8wdq0NoyQ4k1KGSDFJdeklaorRZ+v4v9UZZB8B7bxqiD
         yxgcuJxwR5RbcaHrydofMSevbrqkEsGpTHC9NAv4duntn0FxtwTUK6yCtuSnqs+CX8gI
         rhgZTiR8e+1kFBeQ2dpSGZQcLtuB6+ktG21XEZf+ggSaRJPZ6k0kQ6jG0hLOpB6U5MS5
         wQBg==
X-Gm-Message-State: AEkoouuGRHy7Est3SW9hMJCMyK30WdMM0uRqeM1HeJoc03zzNMS/DMaC8OOHVV5EkJiZAkP9P51gmn+3yYz0mrDG
X-Received: by 10.107.131.38 with SMTP id f38mr35194854iod.173.1469641269170;
 Wed, 27 Jul 2016 10:41:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 27 Jul 2016 10:41:08 -0700 (PDT)
In-Reply-To: <xmqqoa5jvven.fsf@gitster.mtv.corp.google.com>
References: <20160727083406.10241-1-judge.packham@gmail.com>
 <xmqqshuvvvxb.fsf@gitster.mtv.corp.google.com> <xmqqoa5jvven.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 27 Jul 2016 10:41:08 -0700
Message-ID: <CAGZ79ka0kvr9RAkGHbgrZ7fery8436dH8Nu4bwG0t3K5FprgKA@mail.gmail.com>
Subject: Re: [PATCHv1] completion: add option '--recurse-submodules' to 'git clone'
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Chris Packham <judge.packham@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 10:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> I noticed --recurse-submodules was missing from the bash completion. This adds
>>> it. I went for '--recurse-submodules' instead of '--recursive' as I seem to
>>> recall the former being agreed upon as the better (or least ambiguous) of the
>>> two terms.
>>
>> Yup, that position is consistent with what 3446a54c (clone: fixup
>> recurse_submodules option, 2011-02-11) gave us.
>
> Silly me. The blame actually goes down to ccdd3da6 (clone: Add the
> --recurse-submodules option as alias for --recursive, 2010-11-04),
> but the conclusion is the same.
>
>> Perhaps we should think about deprecating "--recursive"?  I dunno.
>
> Anyway, I'll apply the "addition to the completion" patch.
>
> Thanks.

Thanks for this patch!

Note: if we ever decide to resurrect sb/submodule-default-path,
we run into a merge conflict. The reasoning for using
"--recurse-submodules" instead of a plain "--recurse" makes sense
as well, so that merge conflict will be resolved in favor of this patch.

Thanks,
Stefan
