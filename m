Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23174203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 16:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222AbcG0Quu (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 12:50:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33446 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbcG0Qut convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 12:50:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so7338704wme.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 09:50:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3OnC5ip7dA5xwdC15NscE/eRGdq1+NuD0fj8N7BAHnk=;
        b=yHi1NI0MP3THaAWySI88hM5UFI9Nrk8mqS/rhQcoFcenNhYBR/dkwzTwnlZ8RXLwrA
         WiTBp7VlIDeIZQYM76x6eSYmzZk2XLxIA/tcMyp0ZrtWeLFxfooR0tDllrjhzNidHcWB
         1KCnQrQUUTk02/MSmJroM557/QKK7DR1vgpvZJMZxl8VVG/FK6fX2m19bLosUeGAPeJV
         RSx9bkQ6xaZ6eLcwGzMOfQyFHSnUZgo62i70XKyl5PBk0p+jcb0l6Xx/cfDI4LeiOjNI
         jCS3XmOqoAHwdr5dWTVZRmzusaIsCvzYsRq5OWta63eiwXqUeFdNzxaF9c5GV+XqfqKx
         vKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3OnC5ip7dA5xwdC15NscE/eRGdq1+NuD0fj8N7BAHnk=;
        b=ILYPMvVnnRSsX1Jd+ddfxIZna2QJlLkcMhep3cxVXvbnQFXL5BYmDT+jvdrPc16GO3
         IsxYFpQZ8DPK/oeuTOBt6yxI99/llnOJZ+t2qLSK4m9B8h3YnT6NgkS7k8ytFmKzbGxt
         /jSv2h+IrZBpnJErZtIF4q4jXDHmdQ7Myppst08lXAxgsBsWPMUoWGKgqpvOQTlMniaN
         dZ4JqGqG8B/trF7e8/LEMyigvX72op7FCRb1Skj+WRLa/06AMStbt2Z10dMPyAUgC/Jb
         FiMvSArhlKTEI/Oz6ZuJz6v8ANI8i9PrV884MhsFJNgPmQbMaMft1gMOZRK3+F1iEf5n
         czXw==
X-Gm-Message-State: AEkoous7fCnaKQIHjKg7fT9jhUbWHn7pc4xe7hTiPtzeLjxwF7Ycpeb21Agi60dLYE0Q8g==
X-Received: by 10.194.164.229 with SMTP id yt5mr28587927wjb.39.1469638242935;
        Wed, 27 Jul 2016 09:50:42 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f4sm39245324wmf.8.2016.07.27.09.50.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jul 2016 09:50:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 4/5] convert: generate large test files only once
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160727133214.GA14928@sigill.intra.peff.net>
Date:	Wed, 27 Jul 2016 18:50:40 +0200
Cc:	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	mlbright@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	pclouds@gmail.com, e@80x24.org, ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: 8BIT
Message-Id: <1D133FC4-032F-434A-882C-5931AA285CD9@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <20160727000605.49982-5-larsxschneider@gmail.com> <c3d7466b-cd3f-9f62-bc82-9f77b4f3d1a4@web.de> <20160727133214.GA14928@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 27 Jul 2016, at 15:32, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Jul 27, 2016 at 04:35:32AM +0200, Torsten Bögershausen wrote:
> 
>>> +	mkdir -p generated-test-data &&
>>> +	for i in $(test_seq 1 $T0021_LARGE_FILE_SIZE)
>>> +	do
>>> +		# Generate 1MB of empty data and 100 bytes of random characters
>>> +		printf "%1048576d" 1
>>> +		printf "$(LC_ALL=C tr -dc "A-Za-z0-9" </dev/urandom | dd bs=$((RANDOM>>8)) count=1 2>/dev/null)"
>> I'm not sure how portable /dev/urandom is.
>> The other thing, that "really random" numbers are an overkill, and
>> it may be easier to use pre-defined numbers,
> 
> Right, there are a few reasons not to use /dev/urandom:
> 
>  - it's not portable
> 
>  - if we have to generate a lot of numbers, it drains the system's
>    entropy pool, which is an unfriendly thing to do (and may also be
>    slow)
> 
>  - it makes our tests random! This sounds like a good thing, but it
>    means that if some input happens to cause failure, you are unlikely
>    to be able to reproduce it.
> 
> Instead, use test-genrandom, which is an LCG that starts at a seed. So
> you get a large amount of random-ish quickly and portably, and you get
> the same data each time.

Thank you! That's exactly what I need here :-)

- Lars