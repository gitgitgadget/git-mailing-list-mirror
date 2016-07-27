Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2DD203EA
	for <e@80x24.org>; Wed, 27 Jul 2016 04:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020AbcG0EUx (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 00:20:53 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35670 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbcG0EUv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 00:20:51 -0400
Received: by mail-yw0-f195.google.com with SMTP id r9so3042055ywg.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 21:20:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AgZJdoqlpti9Chn2iqqZOTjEn+57cWArjFeswql01H0=;
        b=vm6fyG0p6kbs3rWZfc88QYnPVdAPjfHEbOe5USUpQ4XUnT1TIJgFGLue3iQZneoUdf
         T+XpmHuR6N/USR4Ls7FjBaP+5Vc3OuUoe1Qzp2eLZsviGIQcSaX0HdbfxvHLd4t1cMjE
         e9NfBMrvZ2iR5pIn4+DHjDIVCSIoGGJ+pisru/+yuQv28wSMD/PSpMQXxtFQz86NL0Ag
         oNr+xmu2KEoeP4gIcAxALcnsihWtD7COk2vlPhs1H3FT42yyHpWN4IV/c/+YeV5K1C6S
         b8SQbonE8ZFFDp2osu4kcAfYN0s4rC8PctXHV6cl22ARdbGHscinqKGbNRVS19IVcF1q
         ECBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AgZJdoqlpti9Chn2iqqZOTjEn+57cWArjFeswql01H0=;
        b=dN3SxkwgqVy6KiWVgBpvxkcSuKEQSQxo+3wpU8Myi5FRtb63h60lIas14Q8egZ5dor
         PesPfomT03sgXUbGHIK3D5MQkE2ERB3qzuo58b36HewpPavuzkQXt17ewNh2fxgMu/WB
         Wbta3ys3uDfGLsjBfzuYeSKfnTEjyyzxeeb3Z1vwMTfqhOrKQG4bxor93IW0T9PFLKCW
         TDfJYl+s3po6jDlz2ZSfCCAm5UfkH4hmu/CtaLlIzh1SNNcBCtj1ljJYKTTQbygV0iAb
         iXWW1g9d2ZDCVxoCnjhRputF147stjT8yXlmFGlicaVBh5tD5VXhCvBGcVHBRt5BLNAC
         ztPg==
X-Gm-Message-State: AEkoouvGNZsedpDJB/stfyD15RHoMLskPaiv0kf5oDMLRea6dJRhQFwoxdtSSgqFUyUasWt8QbHemqg2R+zVbg==
X-Received: by 10.129.76.79 with SMTP id z76mr22899180ywa.33.1469593250324;
 Tue, 26 Jul 2016 21:20:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Tue, 26 Jul 2016 21:20:49 -0700 (PDT)
In-Reply-To: <xmqqmvl41f0x.fsf@gitster.mtv.corp.google.com>
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
 <010201560a4782ce-8d6545f1-2454-492b-a2c6-6e0f2ac824d4-000000@eu-west-1.amazonses.com>
 <7a408f75-74d9-7e59-35d6-3a931414a7f9@web.de> <CAFZEwPOH+V+Nfq1KoOBBdVgeFD7YCG5c1PJrUHB50O1DkMg39Q@mail.gmail.com>
 <xmqqh9bd7j6k.fsf@gitster.mtv.corp.google.com> <f6657922-555e-affa-8904-678bc7ee3f71@web.de>
 <xmqqmvl41f0x.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Wed, 27 Jul 2016 09:50:49 +0530
Message-ID: <CAFZEwPP=AL6V+AitmVD6qnt7FvUJiX1wqrn5C2UjEKxAnnumew@mail.gmail.com>
Subject: Re: [PATCH v10 12/12] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Tue, Jul 26, 2016 at 11:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
>
>> On 07/25/2016 06:53 PM, Junio C Hamano wrote:
>>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>>
>>>>>> >>> +enum terms_defined {
>>>>>> >>> +       TERM_BAD = 1,
>>>>>> >>> +       TERM_GOOD = 2,
>>>>>> >>> +       TERM_NEW = 4,
>>>>>> >>> +       TERM_OLD = 8
>>>>>> >>> +};
>>>>>> >>> +
>>>>> >> ...
>> Is there any risk that a more generic term like "TERM_BAD" may collide
>> with some other definition some day ?
>>
>> Would it make sense to call it GIT_BISECT_TERM_BAD, GBS_TERM_BAD,
>> BIS_TERM_BAD or something more unique ?
>
> I am not sure if the scope of these symbols would ever escape
> outside bisect-helper.c (and builtin/bisect.c eventually when we
> retire git-bisect.sh), but BISECT_TERM_{GOOD,BAD,OLD,NEW} would not
> be too bad.

I agree that it wouldn't be too bad. This can be considered as low
hanging fruit and picked up after the completion of the project as
after the whole conversion, some re-ordering of code would need to be
done. For eg. there is read_bisect_terms() is in bisect.c while
get_terms() is in builtin/bisect--helper.c but they both do the same
stuff except the later one uses strbuf and a lot more important stuff.
Maybe after the whole conversion, the above enum (or #define bitmap)
should also be moved to bisect.h and be used consistently in bisect.c
too.

Regards,
Pranit Bauva
