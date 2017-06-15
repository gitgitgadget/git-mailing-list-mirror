Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 248E820401
	for <e@80x24.org>; Thu, 15 Jun 2017 17:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbdFOROD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 13:14:03 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35531 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdFOROC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 13:14:02 -0400
Received: by mail-io0-f196.google.com with SMTP id f79so2349125ioi.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PFFZDMX27dNFz4LRutOjwU+YAXLV1mvBUx0mzRM3cRs=;
        b=CxmhfEvAaTQn8LB0EwEDeDz15Rygu73qWWnMNh4K9EedVFSOCObLLJYW+qlxu/Trvq
         cQ/Hvo0D904V+90GHm6fD7dK3VAoU2GAHepin1b+s7SbPm5bAKwoWKa+vmwx5zszLb+0
         VUYx4dWHsvt0s4ETCBMqHM3gH89x5QyCy4XoYSU/kgMETBNk30eik6wdh8UC+XSkvpNP
         I1PNQw+VpULrI7Ze2o5NBxR7ZitiquQ2l6waTrU64hsQK8UZc4QljUcvJ7EB75eP82Qa
         atnYM66l9wVtI81qNiwuvgtvgiipMCvUipWoYgGJ6+f2cwgK75vfOxQ88MYB0LREWiPF
         Scnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PFFZDMX27dNFz4LRutOjwU+YAXLV1mvBUx0mzRM3cRs=;
        b=bvsTeu0xS1JZLfipI7BuvAKl77XPqDYDBl0BWSJyfTxeUmaMglOWVhF893DKoAwXbB
         VXcBnJtQnNsJ8hBg2R0ihulpCy3rW9ETd5ZWYnMzxxG6F4E1Y0VkeaaZuS3i8JPEZiKo
         hTgXmQk5wERsVqc6bmFejGfNu4yYltL/pZIuNwYBHfHOpsIlT5yZcb/OQdi/0V04tO7x
         WEAdFWaTF/AfucX0mG/BOY+uuusupwv2n7UDydFEndehr/mPvl/sEHzpEpQ1wO0ykb6k
         F6dM9/NCAR/jhNnrgecJZMUkFckzz/RyO8xz36V+BPhc6IOsE5MnbZJY4/nlHRo/R8qA
         hqBQ==
X-Gm-Message-State: AKS2vOx2TipU0/ISc7+OOsmmF9QGsT0aZjSNmAt/DD5RNEKvGN0HbY+N
        cSwAFbRkzjN1TpcVsLEvryEUw1tY1Nt6
X-Received: by 10.107.178.130 with SMTP id b124mr6134805iof.50.1497546841990;
 Thu, 15 Jun 2017 10:14:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Thu, 15 Jun 2017 10:13:41 -0700 (PDT)
In-Reply-To: <xmqqfuf12o46.fsf@gitster.mtv.corp.google.com>
References: <20170609085346.19974-1-avarab@gmail.com> <20170609220420.4910-2-avarab@gmail.com>
 <20170609222738.GF21733@aiede.mtv.corp.google.com> <20170609233701.GA7195@whir>
 <xmqq60g462nd.fsf@gitster.mtv.corp.google.com> <20170610032143.GA7880@starla>
 <20170610072506.embaavscstmjnv6v@sigill.intra.peff.net> <xmqqfuf12o46.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 15 Jun 2017 19:13:41 +0200
Message-ID: <CACBZZX7S9A=mPSgqtmVyZbLdR3GVH+ux3tGN1QXBMEzbg8Ffog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] git-compat-util: add a FREEZ() wrapper around
 free(ptr); ptr = NULL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 6:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Sat, Jun 10, 2017 at 03:21:43AM +0000, Eric Wong wrote:
>>
>>> > So make Jonathan's freez_impl a public API and rename it to
>>> > free_and_null(), perhaps?
>>>
>>> Perhaps...  I think it needs to take "void *" to avoid warnings:
>>>
>>>      static inline void free_and_null(void *ptrptr)
>>>      {
>>>              void **tmp =3D ptrptr;
>>>
>>>              free(*tmp);
>>>              *tmp =3D NULL;
>>>      }
>>
>> That unfortunately makes it very easy to get it wrong in the callers.
>> Both:
>>
>>   free_and_null(&p);
>>
>> and
>>
>>   free_and_null(p);
>>
>> would be accepted by the compiler, but one of them causes undefined
>> behavior.
>>
>> Unfortunately using "void **" in the declaration doesn't work, because
>> C's implicit casting rules don't apply to pointer-to-pointer types.
>
> All true.
>
> I still think the macro FREEZ() is too confusing a name to live;
> perhaps we can take =C3=86var's patch with s/FREEZ/FREE_AND_NULL/ and be
> done with it?  By spelling it in all caps, readers will know that
> there is something special going on in that macro, and Eric's
> "forcing the readers to type & in front to let them be aware that
> the ptr variable is being manipulated" may become less necessary.

I'll change it to FREE_AND_NULL and submit my patch as-is, my reading
of the rest of this thread is that making it a function instead of a
macro would be interesting, but has its own caveats that are likely
better considered as part of its own series, whereas this just changes
existing code to its macro-expanded functional equivalent.
