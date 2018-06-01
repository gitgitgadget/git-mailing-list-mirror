Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7641F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 02:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbeFACOx (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 22:14:53 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55508 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeFACOt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 22:14:49 -0400
Received: by mail-wm0-f45.google.com with SMTP id a8-v6so46742wmg.5
        for <git@vger.kernel.org>; Thu, 31 May 2018 19:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Kjsk/8WgmfApGq+O9evNUR3XtsRGqwRXwbE0nVoEdOM=;
        b=oLkpmNbLFJ8xxygXq9fs6eziWclxBIWeAEmlm/RVxM8EW9miIreUZe3g3LIvXr0RQ4
         EFm2sdT7a1dLZvzg5QsjxDcuzxF1Ri4Iw0xxI/j0p1ZSslchaH3Po5Q189M/wFP1jdPM
         VVSe7hV2AFRfROy405fmEo4GwquCAOgblRDmtiWwFQom7Q2rGjG0rTL2CGi6IjFAAMP4
         FAe7irz1cEdvGBsqkiV9sudkMB7wKubolhzdzkqcoYtv/3qmscl8xHvLbEc/lFAvZW2Y
         ZUMQXLhPbcZg3nXuWVqLwxq8MwAZ5Nu9ebjWa6I+1aIQXAGfwMSQAhavJt7wzetTIB7Q
         RO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Kjsk/8WgmfApGq+O9evNUR3XtsRGqwRXwbE0nVoEdOM=;
        b=W50IETu604Sjynt5hVD+j/Bvina055gPC1PgoSt0mm2CZJh1JTHutVVgblFDl7BVVU
         z6oW0bcsQNEE1hfhRFkuIghG4MbFDnXTX7ml7pKDVW8PVQyPTujwFljneM6QKA9wTd/R
         LyZ7K+KEmVpv3Zlje6d7vfEwDP82AcqDUHPLlZTKQisxK5xu2MQDPrmxPhOhotA9OXN3
         4J1G4bmlwdE0WIOmaTqP7ZjIokPBRs+VIHaFSvfkyH6uDu0QMzsdr46F/zIX7TjtW5u3
         0Sb7SIb4/7n7z7rmMvj6ospiLX+994x+7PTLA7sqWYSHzy19tCSCShXt0pmSjC8cWi8A
         ipDA==
X-Gm-Message-State: APt69E2uue8zsNfU6U19Eh07jXK70WB1mVv386S+C2jD4hD7uiG28bn2
        Xx8/2G+2rU/RIsFPkCTUC5qAS1Eo
X-Google-Smtp-Source: ADUXVKKhpr9TexSygTz6o6hUve//b+XIIfrzaAatElt3VfJVTA1XhCSHKF/dXlOSSjZnDkjYweKoEQ==
X-Received: by 2002:a1c:96c1:: with SMTP id y184-v6mr1268068wmd.156.1527819288148;
        Thu, 31 May 2018 19:14:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 141-v6sm937134wmf.35.2018.05.31.19.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 19:14:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/9] checkout.[ch]: move struct declaration into *.h
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
        <20180531195252.29173-4-avarab@gmail.com>
        <20180531214546.GC26159@hank.intra.tgummerer.com>
Date:   Fri, 01 Jun 2018 11:14:47 +0900
In-Reply-To: <20180531214546.GC26159@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Thu, 31 May 2018 22:45:46 +0100")
Message-ID: <xmqqpo1b9rs8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> We seem to have plenty of structs defined in '.c' files, if they are
> only needed there.  Its use also seems to be single purpose for the
> callback data, so I'm a bit puzzled how having this in a header file
> instead of the .c file would be helpful?
>
> I feel like having only the "public" part in the header file also
> helps developers that are just looking for documentation of the
> functions they are looking at, by having less things to go through,
> that they wouldn't necessarily care about.

Yup, sounds like a sensible criterion to choose between <*.h> and
<*.c>.
