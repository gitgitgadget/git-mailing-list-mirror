Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6401F405
	for <e@80x24.org>; Sun, 16 Dec 2018 22:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbeLPWPA (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 17:15:00 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:36923 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeLPWPA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 17:15:00 -0500
Received: by mail-pf1-f182.google.com with SMTP id y126so5363306pfb.4
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 14:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CICCQZezlXHam6kLj211WaTepXmDi3rK0HbTKEOjp3k=;
        b=Ejde048K5tKR5oy3Tm/w1GfsUTSMhacS1FyAtjKxXB0rusQpJUgJfveQxDBN+yk+3r
         mAm+zahgug9iZ149bGyYUy3HdiEPXPVit1JUpdcSM4YHNe2DVrkbt2Q4u/IDGHEqXdMq
         oqPOr8o1qu0QKl2Jzm4eEVuI6cr3uaHLtIwaF/TVEy6vuRmcyaRjwjW1dZbohgw9X+xf
         NMWnIrXZ0AoXGpkEicffkMGKvHAuLhLSHIBsNN6hDCBoobSUTqWeELMLoU9VM+vlsToq
         fR4KTid1cqMjTd4jKVhzPV+H8tz5TR8vvpehH7VLvZD97DzX9ej9bIEgjUP1fIPFTpyB
         VglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CICCQZezlXHam6kLj211WaTepXmDi3rK0HbTKEOjp3k=;
        b=nCzhUnmBRbvPv7T4bJifq2hJSH4e8GizHqSpPDSQFKt+GfgS4Fq8A8j/zxxCKu14pR
         1SgYGd3vU3jHZ7fWRqV2JkiZgsGBRxfsHFO2HPnJfWiKLjydMGj00g2yKge0BtjVBcE2
         /EI6BZMYSufIsJpRjk1VUm5brkk7g29cRFidR4hO+HSuX0P9J36uvSRolBIaFXeTz3za
         /a1YlIIPKmMX3BucbRVRivH1rmThd8VB7gNvKYzr1cbOLeGisBgThNIMyDrinA1mrKzJ
         fRjuVCirI2nJx04Xt4omdjfft7dlRsMpjo+GoyOAT6wtj1a3zOb3ANKBhqD/klRth/tc
         o+KA==
X-Gm-Message-State: AA+aEWY5XY7Fwmb4JtI0wfJJCoXiBx7thlN6FSwQbLds/uTJGdSLLOIU
        UYbWeECidNyQ4G7vrRJRxoQRpeQm
X-Google-Smtp-Source: AFSGD/VX/fZ1re7Jz06n6y6LBHGuro/P7sheebeGTQtn3ZDkgi0O/oMmnGAGciK6q1jBSgWLwrvP0g==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr9772494pgg.16.1544998499516;
        Sun, 16 Dec 2018 14:14:59 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id e65sm15703954pfc.74.2018.12.16.14.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 14:14:59 -0800 (PST)
Date:   Sun, 16 Dec 2018 14:14:57 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Farhan Khan <khanzf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: pack file object size question
Message-ID: <20181216221457.GH75890@google.com>
References: <CAFd4kYCHefqRsiFK=K7MHp=MTwOBXB5979WobEm3w1J5q1bZ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd4kYCHefqRsiFK=K7MHp=MTwOBXB5979WobEm3w1J5q1bZ0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Farhan Khan wrote:

> I am trying to write an implementation of "git index-pack" and having
> a bit of trouble with understanding the ".pack" format. Specifically,
> I am having trouble figuring out the boundary between two objects in
> the pack file.

Have you seen Documentation/technical/pack-format.txt?  If so, do you
have ideas for improving it?

Thanks,
Jonathan
