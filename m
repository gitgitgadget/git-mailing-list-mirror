Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C93A20193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758815AbcHDQHN (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:07:13 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33752 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758799AbcHDQHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:07:11 -0400
Received: by mail-yw0-f193.google.com with SMTP id z8so20657457ywa.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 09:07:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eMtZOWsx/cMGTBtVe7VjZ6o52jEvNyEwDDOZhy1i5I4=;
        b=xWht1D51hY3YIV3eOFn/EeMP26BQLPixbRNNZbu1g4/QDDSQq4d3lhWKZfW3VmCZJn
         DWPihNtiHZpGcCQowEPEoq9T4E7jwCBpQE7FOKhwJZHOpgfh7ymZPlOe67IONrC72LJE
         Rg70ttbfgiLn/tb+T3DbR92Ds7BC5SS2lPk0uGFq4d8Yt8lMH2uZPJbXsTAwoVakmmGY
         uNYo9X5sdnPwwfDev+tlATsRwtpHz4QV1HTKfpAkNM3Hw1XIOg/gVjD5vzGsxEy+waCD
         5sPcQD+EehYyQi/lcgRBusLsGERoa3If1+jx3hdlHbrAEA9XDN+vLBCkTQqU/HUTxZUq
         TH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eMtZOWsx/cMGTBtVe7VjZ6o52jEvNyEwDDOZhy1i5I4=;
        b=N90oXbbuIDGJLvuO0rnfEYlHC+CTXY5xPqhUESCooLauGEnJbUivq4TXZSsykT3ecd
         F16sUQMP52bvLQEWJIaZM2ol/En8+/jSQDEVwbUqPRjXiI3hqILtcuQ4wWEFIt5hTjey
         Bsxr+E5jNMTtEZE3kLMif1KVeiuD3szRYMcMnf0/BxlN3WJDuZQhhzib3NUaS0ceA8xJ
         nkc/t2fKQfhORqmZnvQ9jzhtSdXqLg9FHY5d3y+JoFBQ/qM1kJSleNSZDKFgquC5+BT3
         tnvuXApUUyWOq4BVIcEKpvlrXynsKGIQZr/mjjLyS5/qOk9Y0K8YhmVs1wvVYa1FIzGn
         swYA==
X-Gm-Message-State: AEkoousOe1DEYn0tH/UGaVswFM74tm3TqoWoYimJ1urH8wSrdQRhOClSgarLNqULBx68MJtt+CLlwSFNhkRwAQ==
X-Received: by 10.129.154.76 with SMTP id r73mr59728590ywg.164.1470326830539;
 Thu, 04 Aug 2016 09:07:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Thu, 4 Aug 2016 09:07:10 -0700 (PDT)
In-Reply-To: <xmqqr3a45yi7.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423ce6-5b11201e-736d-413f-be12-7fed613ae484-000000@eu-west-1.amazonses.com>
 <xmqqy44fdpxd.fsf@gitster.mtv.corp.google.com> <CAFZEwPNFohRLCS4piB1t0LO-=keucwzRKZ2Jyhhf234tnWnVGg@mail.gmail.com>
 <xmqqr3a45yi7.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 21:37:10 +0530
Message-ID: <CAFZEwPMdOawVT6W6Ko=xkMLu4PcWkd0s_GiJA-T5uu-oY2m23g@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 04/13] bisect--helper: `bisect_clean_state` shell
 function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Thu, Aug 4, 2016 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>>> Also you do not seem to check the error from the function to smudge
>>> the "result" you are returning from this function.
>>
>> Yes I should combine the results from every removal.
>>
>>> Isn't unlink_or_warn() more correct helper to use here?
>>
>> The shell code uses rm -f which is silent and it removes only if
>> present.
>
> Isn't that what unlink_or_warn() do?  Call unlink() and happily
> return if unlink() succeeds or errors with ENOENT (i.e. path didn't
> exist in the first place), but otherwise reports an error (imagine:
> EPERM).

Umm, I am confused. I tried "rm -f" with a non-existing file and it
does not show any warning or error.

Regards,
Pranit Bauva
