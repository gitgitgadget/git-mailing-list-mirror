Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9FB71F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeH3CgM (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:36:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34831 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbeH3CgM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:36:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so44779wmc.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 15:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=zXvzzirEw1miVx+lQFFbGY7GSDHToKL1DLmVj+cRRdM=;
        b=Mbb0kdgP5VzKhr0XVGJiI2M38ezDHPEtfnhCAQtc0WPBOP3m1QVswAtebKt2X7sgk5
         L/dKkxdGDNze4VQ08ah9Ygc2noTcuvcuoWlDTqGML2t7Mh/jdvgwH4cQSPZ70KDELUn9
         ASgwXUo2+MoiTIb9rcTNmPzpY/RfGhsbPeNkLxyPYSOies7hY8HH9a1++FsmWSDhj0pA
         pbGjxb1XL3DDmMb/+XycxxR0Njxmgg19z+nIxOGgFS6+hKU2GWKca5yJpf1+8j5+sNWP
         Vl/4fFPAdzCaR3jxSW0tHjprkEDCJd+bXhqpQ/Z3LbHYl9dMiSxqurk0n/jSns4BmglZ
         0bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=zXvzzirEw1miVx+lQFFbGY7GSDHToKL1DLmVj+cRRdM=;
        b=pBC+Vxhe5FjtgMK2KqiJZ7d1++7DV1B3dDpYzbw24G4iqEFSn4iBssIklk4DtKbldu
         bvXHnqFapBwNVfHW2R2he8yKlJ4CEyU/nSNxxSqYd1j1hfHGICiwmc1NCBPkGKC76qOy
         fbhl5IOnrqxkHrGq28FPYiMbwBv8DgQFJwjTS80XVGNEfF1iZ445VqK36T8Fho7ZBvUk
         Rm1+ahOAxzAkDeUxtd0ICCqiIVOvVbyPOT0fR1tBDMr5flXse2MHMwTBgnnaBmASF6Eb
         PJ29eevSygbPMg+2zXdKo5UQMboyk19YqB3YkziuHbogNBTCjMl4IxBqIQm41H+ZWXZ5
         AHZg==
X-Gm-Message-State: APzg51DN7GZfNUeuqyPwbZiOtGKd6ZTyH0hbaCVmC887ZYJyaJ6smEBE
        T7L+jwmZpVmFRKdSd1ttaT0XQ8fJ
X-Google-Smtp-Source: ANB0VdYykordKReMNA3mrqwIVIK8pd38gIFHvRNXEdIHOZRzwh+qEsh/C4JY4PPTWUwMaAQFYPWjOQ==
X-Received: by 2002:a1c:230f:: with SMTP id j15-v6mr31765wmj.124.1535582228170;
        Wed, 29 Aug 2018 15:37:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g126-v6sm41324wmg.5.2018.08.29.15.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 15:37:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo: support format=flowed
Date:   Wed, 29 Aug 2018 13:19:16 -0700
References: <e2f2ca18-849c-0ef4-98a5-9a1379bfcec5@web.de>
Message-ID: <xmqqo9dk94vh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Add best-effort support for patches sent using format=flowed (RFC 3676).
> Remove leading spaces ("unstuff"), remove soft line breaks (indicated
> by space + newline), but leave the signature separator (dash dash space
> newline) alone.
>
> Warn in git am when encountering a format=flowed patch, because any
> trailing spaces would most probably be lost, as the sending MUA is
> encouraged to remove them when preparing the email.

The warning is a very good idea, but I wonder if it is loud enough
when mixed with other noise (e.g. "--whitespace=warn" for a short
series, or patch titles when applying a very long series).

Lossage of trailing spaces may even be a feature (just joking), when
the project policy makes it OK to use "am --whitespace=fix".  I
usually use "am --whitespace=fix" but I used "am --whitespace=warn"
while applying this patch to preserve lines that begin with "SP SP
HT" in the sample patch.

