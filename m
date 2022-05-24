Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F4CC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbiEXUxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiEXUxD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:53:03 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB02D737A0
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:53:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id f35so3002755qtb.11
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FaNwmbOjrjDxpzNH+gZ6n8TRd+6nY3h++uQZVRd0NOE=;
        b=n9Ppqh9+24PzHSH4BCG1ghUtggvBR9ufY404JuUIfli2fcdwEkEX2PP0BdEXqdgeSO
         +zH4m6ojt4SGoEOCvXT3lNWNnbUMGcAuidnflsv7gAaYoAacacPrhACyzbsmRKSmzEEy
         vvxbtNBnVVb4elSAJ73v4KS9sVYlkVTWwkoEvmlY97RAgzddCmcR4WvvUADCLTJ9B1iP
         hcXDFae2Hu5Qq8FaZKgnoEh3/aHEh9fVOjqtKeP8XvuoUhj5X8z2srf7CGndOovEdBkD
         PNt2qbfl/lK/8Bklm2OJN+lF7VEkScsEVP2M4q5XESJTpz6nEpiK6BgbLK1KBbc0fpBj
         ennw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FaNwmbOjrjDxpzNH+gZ6n8TRd+6nY3h++uQZVRd0NOE=;
        b=lFjkcJVcMfA3q2qgs7Xnj5DEw3eILgePxbHcr+TQods2efFKNVwuv26xK2AhTczHtc
         NyDkQqq8rjr1hbATwl1k12sgSN1BhQRVzvdHoh65yQopN0z+vCMmpX+G/UFHsm7y9Qlj
         zfe0EynJJmZuZ+HigHcgcaJtWAPUVDJxEs48k5v0yBLXFAsdHIIdLX6Rf2d9kViqocQH
         g4cnCEsyXWhbeH2yLKy1YNZUm901XWjbxvoyrFcF18dFKLK8RFg1y1r2OQ9gt5BCrTX/
         MfzmrXMFbLNNNboe0R7nsCYMbxlN71YBzwEclbJ/97xpbk7F3ogtbD378WN4/T7uGcyY
         DVBg==
X-Gm-Message-State: AOAM531oZg6sOJB+8YgqiDG1LLvhmVMzQFf/o07G6ZU+dAn4yObAW/vL
        3BfhM/YVdnp8rP7RqrxUMTY=
X-Google-Smtp-Source: ABdhPJzfseZWUXyThmyv6GkhCTn6XOLMMBaXDn/WKYClWvj+G+hstPRUK/8L6SUoU04Z+D6FEPzNfQ==
X-Received: by 2002:a05:622a:1346:b0:2f9:17ce:2f1d with SMTP id w6-20020a05622a134600b002f917ce2f1dmr18760167qtk.657.1653425581030;
        Tue, 24 May 2022 13:53:01 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id h5-20020ac81385000000b002f3b82571b1sm265500qtj.1.2022.05.24.13.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 13:53:00 -0700 (PDT)
Subject: Re: [PATCH] ci: update Cirrus-CI image to FreeBSD 13.0
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Ed Maste <emaste@freebsd.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
 <20220524192026.2373nfcrs6bsa4ce@carlos-mbp.lan>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <6a3aecf1-1c0d-f4fc-7d0e-455eb0ccc92c@gmail.com>
Date:   Tue, 24 May 2022 16:52:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220524192026.2373nfcrs6bsa4ce@carlos-mbp.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

Le 2022-05-24 à 15:20, Carlo Marcelo Arenas Belón a écrit :
> On Tue, May 24, 2022 at 12:58:23PM -0400, Philippe Blain wrote:
>> The FreeBSD CI build (on Cirrus-CI) has been failing in
>> 't9001-send-email.sh' for quite some time, with an error from the
>> runtime linker relating to the Perl installation:
>>
>>     ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Undefined symbol "strerror_l@FBSD_1.6"
>>
>> The first instance is in t9001.6 but it fails similarly in several tests
>> in this file.
> 
> I have to admit I never tried to use cirrus, but I verified locally that a
> 12.3 version wouldn't fail as well (or so I think).
> 
> did you try to use 12.3 which should be supported for a little longer?

Yes, I tested 12.3 and it also works. We could switch to that and
keep 13.0 for later.

>  
>> The FreeBSD image we use is FreeBSD 12.2, which is unsupported since
>> March 31st, 2022 [1]. Switching to a supported version, 13.0,
>> makes this error disappear [2].
> 
> I think 13.1 might be better, since with this change we are also implicitly
> making a move to say that we don't really care about the old (but still
> supported) maintenance branch, but will only look at the "latest" version
> instead.

I agree your reasoning, but 13.1 was not listed in the list of images on Cirrus-CI [1]. They 
say they support all Google Compute Engine images, but I could not find a public list
of these images ([2] seems to be it but I don't want to create an account just
to see a list!).

> 
> still (and Ed might have a stronger opinion about it than me) either version
> would be an improvement and feel free to add my Reviewed-by for what it is
> worth.

Thanks!

> 
>>     [1] https://lore.kernel.org/git/CAPUEspgdAos4KC-3AwYDd5p+u0hGk73nGocBTFFSR7VB9+M5jw@mail.gmail.com/T/#t
> 
> this might had been mangled by your mailer, but will presume is the thread
> where I replied before, and that obviously didn't stick for these round ;)
> 

I think it's actually on your side, as the archive shows this URL
on a single line [3]. And when I hit "reply all" in Thunderbird to type this
it seems to have put in back in a single line (!)

Cheers,

Philippe.


[1] https://cirrus-ci.org/guide/FreeBSD/
[2] https://console.cloud.google.com/compute/images
[3] https://lore.kernel.org/git/20220524165823.18804-1-levraiphilippeblain@gmail.com/T/#u
