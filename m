Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF431F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758401AbcHCUwH (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:52:07 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35125 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758386AbcHCUwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:52:05 -0400
Received: by mail-yw0-f170.google.com with SMTP id j12so238609148ywb.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:52:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E6eYZ/znDFzZwG4uiUByFrMm/6bJsgp4QT+YCwOAg9M=;
        b=a66R14+32R8P7SlyTY+9lls/1JRDs/YKMEIIF7U0h+kyMXd0zwLgzNudBzBTSKbzDN
         o/NG55on3CHhp39CMhjHcjTyfatAmdccOZ1ngQXHQTHnc67hzXOTkWil7CAaMNU/ARLX
         DZX0oNxYIFYB8vWZZUkxXeIprpvTeyEW9XfxxiN9rbY44czvNuhvXlVZiLDk9brRnoBg
         6pTjeCqh53G8XE9O1GAwxDfZvKHwPOLNLsRwty5WGFpSNlY2u8Olk0OU/wAuciEO/mFO
         vBE+62sLmHiVKCotmRyg3vkcD3L/Gf2kHFwZa/S62SG5Ac+1rTmeYDxJbB4Lofaorvv4
         TtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E6eYZ/znDFzZwG4uiUByFrMm/6bJsgp4QT+YCwOAg9M=;
        b=hG47lutmWK/EINLKjdQ1GgsTtwdQgIutsKGclW6bZnqkeYDzDKMk8r0ATUtqFACjBU
         +VEQAsDoVofwBe4VxbJZOYjFaKO2DCG5xUhpAzKSN34A3pxTXF7/ulGoi8DLZq1iWtKE
         LwrmAsRRxcm4iKWm75pHBaHUZ1/yX7IFF/Kd0YvFedMM6yFLd+TbCOgJU1md6SKMdCZI
         7nD1Fc60Rnc7mVx67LcnSl+kPbZIHtP3HWkIT35TogK5NTc/RUCJhGmZ6pfHcO1uArp1
         xb4viMr5Hw1DHggecxKJsNBIogTXad9jbTgJjXw24HUuAux09DuAaN250sD8UsOs4Idy
         cUQw==
X-Gm-Message-State: AEkoouskdXZWt6d20OFEc1Ra/jUH+z7Pzbr5laIYJl8yheYmIoKureYCcmyM0aa/8LCQhFL+3molt0YYf2Xgcg==
X-Received: by 10.13.193.135 with SMTP id c129mr53793426ywd.302.1470257523806;
 Wed, 03 Aug 2016 13:52:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 3 Aug 2016 13:52:03 -0700 (PDT)
In-Reply-To: <xmqqpopqbysv.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423cf7-078bef36-54e8-4200-9097-17d95d4f3c40-000000@eu-west-1.amazonses.com>
 <xmqqmvkudiju.fsf@gitster.mtv.corp.google.com> <xmqqpopqbysv.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 02:22:03 +0530
Message-ID: <CAFZEwPMLUCjafW44zdwYS4T-0F9ejgRSW8cN70TsUj26aeEWPA@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 09/13] bisect--helper: `bisect_write` shell
 function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Wed, Aug 3, 2016 at 3:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>
>>> Reimplement the `bisect_write` shell function in C and add a
>>> `bisect-write` subcommand to `git bisect--helper` to call it from
>>> git-bisect.sh
>>
>> Up to around this step we've seen these patches well enough and I
>> think with another reroll or two, they are in good enough shape to
>> be split out and frozen for 'next'.  We may not be there quite yet,
>> but I think we are getting pretty close.
>>
>> Thanks.
>
> By the way, this series applied as a whole seems to break t6030.

This is only because of argument handling problem. I seemed to have
mentioned it in patch 13/13 and also gave the output of the tests.

Regards,
Pranit Bauva
