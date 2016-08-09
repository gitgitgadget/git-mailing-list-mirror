Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDADC1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbcHIRat (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:30:49 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36780 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbcHIRas (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:30:48 -0400
Received: by mail-it0-f41.google.com with SMTP id x130so18397568ite.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 10:30:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YNrmHRtHt7pNOTBvHKAPHRcE4QAqkEkw1Om8sUm4Z0E=;
        b=fl/TXwdV9CT/yvEt1qlo7vd0HAZYs7IVBdmhA3cp4tUPQaYI2CAxMAIJlOYyf1+nQ5
         G0B/ImQpstidrIE87Wo/EezKcA+Ig9E4TYBOYyyGySaNykri4mRdWDwo7txm6nmN0xfK
         Isz5bkjolEoVBuNAcmxtFOyRnkfqC4c0nRztsrntyKGC8gIYjfNwQI1Sfn3HCfCY0QxA
         frIkU6eqj0B1LROK63ubU5z0/Tn0/teUING0JNcV14w/f4m8hFKlivOm/mjo1spKr4BL
         DOeAhzRxK1irE76qf3t5woi4lefvUq+kBzOlYRTyrWmsTwMwg4dzwqdiL5zUB/bJSIqS
         vn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YNrmHRtHt7pNOTBvHKAPHRcE4QAqkEkw1Om8sUm4Z0E=;
        b=jGZQqnS+5EeadjWQo7VIqaX8lCd/nQf2myR8SS3waSMPw/ezGvityteIYmmc2XJrcM
         6SbI6yEkUNMgIy2jsBXIhr3lBYniPRBbu60DpQ0ZWOOZQOvB/nX1cX0Pzh0lOt3xkw0e
         wZAKA24vJ2LHWVPM5RsroS3SQVmum8aKhd7LqSaDX0ER6/+gTZAkZIMFSZiOnqGdCpLC
         bUoqJthtLgaOKxahEhHZVDnVNz4GtPoj9fpxTXI1Avh/Ff0Y6grPl5tM/YT5+XOY744n
         NC1AuQy6NeJ1LAJ7+oSQDCDfc9TahbAF/uhvpl46FEMsNe5wFWBtOnibPi3UoXJZmsrh
         2SLA==
X-Gm-Message-State: AEkoouuq03jmANxYmR4mCwEINY10TjCeRrQRXNleSA19Xx/6w3icBMfxBhy+DYUO6JaFQu+JrYRj67HKTOR9X1LD
X-Received: by 10.36.228.138 with SMTP id o132mr25389218ith.49.1470763847770;
 Tue, 09 Aug 2016 10:30:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 10:30:47 -0700 (PDT)
In-Reply-To: <xmqqbn12c55e.fsf@gitster.mtv.corp.google.com>
References: <20160809040811.21408-1-sbeller@google.com> <20160809040811.21408-2-sbeller@google.com>
 <CAPig+cRnDVMBZzKOOS-fW+hNaCHhYRVLM+d_akZcB4H5iyqfKA@mail.gmail.com>
 <xmqqfuqec56x.fsf@gitster.mtv.corp.google.com> <xmqqbn12c55e.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 10:30:47 -0700
Message-ID: <CAGZ79kZgEF2FBSLQnOm=v-a+jy=6aWyPBoLC9-QU=g-aUaqj3w@mail.gmail.com>
Subject: Re: [PATCHv3 1/9] t7408: modernize style
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 8:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>

I originally thought that it may be easier to have 2 patches.
This first one is very gentle and "obviously correct" as it only changes
formatting and drops the directory changes.

The second patch goes for renaming ans subtle style issues,
combining some tests, so it is more likely to break.

After this review, I consider using just one patch and do it all
at once to not confuse the readers as otherwise I should reword
the commit message with the rationale of doing it in two patches.
