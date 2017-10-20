Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5BF8202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 21:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753506AbdJTVvv (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 17:51:51 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:55074 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753380AbdJTVvu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 17:51:50 -0400
Received: by mail-qk0-f195.google.com with SMTP id n5so15983510qke.11
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KJQxQeks3PCoMWPX1Yf1uEjN+f0VsGoPHELLm0tm7vk=;
        b=fB+n17oc4NgVmx0ascFZczVCYgqJfgnQYaFbpG7U4s+q5QxnlHetCbGyFTPXCy3fl7
         SY0IHO31fqVrC9F6E4PzuevL70GY8mtaSkdzz4O88im1/YNBBeTaP7spu6WV9cYhZdpr
         MY9WXno0LPAowfGSXtE650nKxQfY2RfJ9J2Qah0zsnrbfAr1SuBn884xkK/k+hIRX/zm
         AybBLdaSDQE9jl/59Qy1eEHJdkQsMTeo9nkSJCWhF3HfLOpyrrDiU8DorCfHAkQ9SHSc
         HdDVJr4PPAzw/iTFoI4o3PuCwdVGMElYeTXRCs0qGTBoGjHE9jnL991i9Dde2YbEGXOL
         dKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KJQxQeks3PCoMWPX1Yf1uEjN+f0VsGoPHELLm0tm7vk=;
        b=DWLFGx+ynmqKV//zS6f7uKNnuajNsAYPxfs7Ntkpr65BoxojW+IBYyQA8fzdTQco3D
         2e+4Fhw1c1LJo5lOyDnG+QSTVt9/oTif4WN9stQSPEVuLFBPVduH6OqjbbM/75zYmtdl
         czk89H6vAnoIKRilyn28dlbK3e61girQIBt0Cp+SvEwyXHDOpg6oD8ZmPGKH4Cbz0bAJ
         q+6o5qppqyR2rz3ev43n/ZXc/v+WujGzUGQwp33IE4Y8xs76HLMdSI5msM/J1RyZHcJV
         sPuBMTbMqc/dDVbgurSz7mMLUAq7xsiIYLpUlAo+B13izUpKllexpYmLDoYb+Ubtb86H
         aKsQ==
X-Gm-Message-State: AMCzsaWOcliEMYwe+lKEF1FJfqf+BNP0eQi1+CJShSdSIH+9zyOcoSi6
        aFp8dLbNGZcrvWNywUSnzNt3VkNvfHU+b6jNSUg=
X-Google-Smtp-Source: ABhQp+QOqkS9fh3eYyW+2+D6kyHzzIq1fL2+BmF6cBBESfA66XZXpZIz5aycMX27Hwv3B9/hZW9Oekitz224Lf1op1A=
X-Received: by 10.55.109.195 with SMTP id i186mr9258200qkc.147.1508536309606;
 Fri, 20 Oct 2017 14:51:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Fri, 20 Oct 2017 14:51:49 -0700 (PDT)
In-Reply-To: <CAGZ79kaVUBuHVxaE0opXqiEwCr7MVFZHrt5ERQ0mF_deSHeOSQ@mail.gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com> <20170925082024.2691-2-kaarticsivaraam91196@gmail.com>
 <CAGZ79kaVUBuHVxaE0opXqiEwCr7MVFZHrt5ERQ0mF_deSHeOSQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Oct 2017 17:51:49 -0400
X-Google-Sender-Auth: V8UeU-ycaRxlxZParMTxrtSsIus
Message-ID: <CAPig+cS7e2i-eEJV6NcRQ-+aVmn5C7mKONxU4TLAGA7GQBX=aw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] branch: improve documentation and naming of
 certain parameters
To:     Stefan Beller <sbeller@google.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 1:20 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Documentation for a certain function was incomplete as it didn't say
> what certain parameters were used for. Further a parameter name wasn't
> very communicative.
>
> So, add missing documentation for the sake of completeness and easy
> reference. Also, rename the concerned parameter to make it's name more

s/it's/its/

> communicative.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
