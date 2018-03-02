Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7EF61F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946850AbeCBRqE (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:46:04 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35394 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946197AbeCBRqA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:46:00 -0500
Received: by mail-wr0-f193.google.com with SMTP id l43so10949348wrc.2
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 09:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LWxP6vgTRKEwXzmTjNyiAIBIZrAuSP8csSf/xHjvDAE=;
        b=Kr57HxFlYeykRRMPGKrEY67cBADcyN1QkehTobN36LppRYVkbB7j/syu5VZXNyQ77i
         ajVMUReL9o7xEpqE8wgsXOMUOn+JLd6AIn9rJgB8GnA8K5hWwTh9iPj7+vIN1dAa3ce8
         NPwYIw85j8ySZNYlnMpRp4A/57VqzbFXwKxkX9LPffO8hvaNs8jmwBFao58+3Lta2/pW
         10Ydc7+yY1vXLMPNy5L2jDkhLOaM0EeR4TLSzhlJCzytNmRAYmi2FSOpV1b5H/MGVML7
         +b5G6a9ydMRbNMOZlMWSD8YR4I1koccL/uOcAcUWzgApc4/S1KEoaXvnyh7QR13o6ckX
         DzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LWxP6vgTRKEwXzmTjNyiAIBIZrAuSP8csSf/xHjvDAE=;
        b=PaUf2wh+aA3zjEZifUgmN9jnKTLUSs67dLGpB08d0sODDOdJT7qiExIQOCLxLAe8z4
         MlE+UXRGbxep/wsQ1NQly6ASH4A2I1jras+I3COT0dKdv37H+6a0CdPNU+MmLRbNqnUv
         JJAFO4Np7Hc9y3VBqctzjwg8hlKZNt/aGN+By1L3zlZgGxY54kZTTAUVWj966XTAM2ho
         QIg0Vg6jnGZ4ZbY7ANVfV/aSGxXbuU+PUH6pDi+SYe52Wgfb+X/NIgxYTeORRpJhIrt0
         wUdi8R+RjXZgy8snyfodwJlRfGfkgykZ0mPiZGoPHDUbD0JsIwQeiNnE233Ik7zS0KsC
         /a4g==
X-Gm-Message-State: APf1xPDgZb+fDsXEzpEEFPVXZRZcWOSKclR4UV/k4t3DHoGrZQc/oGpN
        iMUiHNYywbUN1n1MOIScT0Y=
X-Google-Smtp-Source: AG47ELsIXuYvETsWYXXVChtZglSqc8Qep4JXIrTU9fwIDYze32weVSuHU4ORF23kh9iNGGRMNA6Vsg==
X-Received: by 10.223.201.11 with SMTP id m11mr6072067wrh.146.1520012759601;
        Fri, 02 Mar 2018 09:45:59 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id b66sm1375668wmg.28.2018.03.02.09.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 09:45:58 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <87606fox0b.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <143023e6-a492-ec24-aac8-821941b14b1c@gmail.com>
Date:   Fri, 2 Mar 2018 18:45:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87606fox0b.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 02/03/2018 06:40, Sergey Organov wrote:
> 
> > So... In comparison to original merge commit M, rebased merge commit 
> > M' is expected to:
> > 
> >  - Add X9, from updated "master"
> >  - Have A1 changed to A12, due to A12 commit amendment
> >  - Keep A2, rebased as A2'
> >  - Remove A3, due to dropped A3 commit
> >  - Keep amendment from original (evil) merge commit M
> >  - Miss B1' like M does B, due to original `-s ours` merge strategy
> >  - Add B2, cherry-picked as B2' into "master"
> >  - Add B3, cherry-picked as B3' into "A"
> >  - Add B4, added to "B"
> >  - Most important, provide safety mechanism to "fail loud", being 
> >    aware of non-trivial things going on, allowing to stop for user 
> >    inspection/decision
> > 
> > 
> > There, I hope I didn`t miss any expectation. And, it _seems_ to work 
> > exactly as expected :D
> 
> That's very nice, to the level of being even suspect! :-)

Heh, indeed :) I`m already thinking of some even more complex 
situations. The more use/test cases, the merrier.

Like if number of merge parents (branches) gets changed during 
interactive rebase...

> To avoid falling into euphoria though, we need to keep in mind that
> "expectations" is rather vague concept, and we likely still need to stop
> for user amendment unless we absolutely sure nothing surprising happens.
> I.e., we better require U1'==U2' test to succeed to proceed non-stop
> automatically. Besides, it will be somewhat inline with what 'rerere'
> does.

I totally agree, and I think whatever we come up with, we`ll always 
be missing some deeper context of the original merge, so U1'==U2' 
test is a must - if it fails, even if we didn`t get any conflicts and 
could otherwise proceed automatically, better stop for user sanity check.

I`m still thinking if there could be a situation where test passes, 
but result might still be suspicious (and worth inspecting), though.

Regards, Buga
