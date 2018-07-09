Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B871F62D
	for <e@80x24.org>; Mon,  9 Jul 2018 04:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750952AbeGIEb6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 00:31:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38275 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeGIEb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 00:31:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id a5-v6so12818164edt.5
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 21:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfUywhdLi7GfIrLeaG6FVD/gmk+MgVPvjXM8SenJ1Kg=;
        b=ZbTYf90F6NH/ZozUupMDU0v7pd2mD+FcYtoTkcDmKL1dq7NwRvK1eF0K1YOF0t8sHV
         KeNv5YNGXFOHRAdTjOARkxenjt2WplwbSuYPWkeCs6RKqSGEegahlQOvb4YIrlIOdPb4
         sdDLdEz4rApgX27WAs+jZ1Oz3fHTwaZPVaPHiTTnalLcmpH47+QI/5wYCKGxDwL+rbHo
         r2EgpArS6++UKcekJuyrfc3UhNi0ZaTse3FY9NziiRZPyadBDxafZr4DFRlW0UkqYZvf
         52cbUQrv6P5ggQSy8lOdEPNnxhOr3dmV1h80inMFZMVLj1dW9Sm3OmV+f9W/Wv4+/SNF
         atXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfUywhdLi7GfIrLeaG6FVD/gmk+MgVPvjXM8SenJ1Kg=;
        b=jhSLFUyseINGIqELU7zvIPrs2aK9dz6HumtquxPw+VAerhbHBqJ2pa8vXeJWaR7Wzc
         NGys9qvqQCbMHHtlogbwMNeTZlkcywTw7p6uQ/FdYFu3/aqH00M6ozB4kquiehVRtQnW
         xOG/SVq3KUm8cUmSFVMwMTsi50JzKV8vR/jZF0x9T2MFqCrzJawl2+zD0Pdm3yVsXp8A
         AUzftV/eSpPFfxPofmhaHciVzqVwPQQ7AKexI2YG8HSSCq6ryfJGDExbJC1RgjoXL6oW
         +Li+qUEslVM0kAqWGxh8hSugV2INRszec8tk/brbNPlvWcANZptgNHZhVKECDpGYdF2k
         82hQ==
X-Gm-Message-State: APt69E2UqE40aT0v//Ro+XYHVpUqdkZTUagyEYCHOR/RaMhj5epM5sSW
        LOkyefkf2VWSCnYIWe0bgPsI1G5mS9y9x/GuZ+8=
X-Google-Smtp-Source: AAOMgpfEMi+9Z6lo5Sca86rKxjs7q7++sWqpP9lxzyWVF3Rw24TkbZX9/ohX7YsXn2H+QofJo+HXHUIMB+ah+cAbv7k=
X-Received: by 2002:a50:8b25:: with SMTP id l34-v6mr353780edl.265.1531110716153;
 Sun, 08 Jul 2018 21:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <20180708233638.520172-2-sandals@crustytoothpaste.net> <CA+P7+xq900ikNR3uBEo28rjrTh5iYJm-R8jcAjhq-7G2jh3iVA@mail.gmail.com>
 <CAPig+cRznUKdriPhHMt5ocb_pXbByY5a40A8ZOiqF=_0hm7avw@mail.gmail.com>
In-Reply-To: <CAPig+cRznUKdriPhHMt5ocb_pXbByY5a40A8ZOiqF=_0hm7avw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 8 Jul 2018 21:31:42 -0700
Message-ID: <CA+P7+xoMSWfV1ZqokGDvoZVRP65puiiwhTKHbuaiUPS2suA3oQ@mail.gmail.com>
Subject: Re: [PATCH 01/17] cache: update object ID functions for the_hash_algo
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 8, 2018 at 9:05 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Jul 8, 2018 at 10:38 PM Jacob Keller <jacob.keller@gmail.com> wrote:
> > On Sun, Jul 8, 2018 at 4:39 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > >  static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
> > >  {
> > > -       return hashcmp(oid1->hash, oid2->hash);
> > > +       return memcmp(oid1->hash, oid2->hash, the_hash_algo->rawsz);
> > >  }
> >
> > Just curious, what's the reasoning for not using the hashcmp anymore?
>
> hashcmp() is specific to SHA-1 (for instance, it hardocdes
> GIT_SHA1_RAWSZ). oidcmp() is meant as the hash-agnostic replacement
> for hashcmp(), so it doesn't make sense to continue implementing
> oidcmp() in terms of hashcmp() (the latter of which will eventually be
> retired, presumably).

Fair. I just saw that hashcmp was also updated to use the_hash_algo,
but if we're going to drop it eventually, then there's zero reason to
keep implementing oidcmp in terms of it, so... makes sense to me!

Thanks,
Jake
