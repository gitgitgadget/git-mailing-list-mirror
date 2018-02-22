Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307751F576
	for <e@80x24.org>; Thu, 22 Feb 2018 06:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeBVGyz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 01:54:55 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:45908 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbeBVGyy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 01:54:54 -0500
Received: by mail-io0-f193.google.com with SMTP id m22so4876002iob.12
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 22:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1zfbH1QuSWSFIb21oSqBAaN1tM1icv8wKZSy8c7gx2s=;
        b=GJJh9RvEekTHUj5gBl2G77tEnc5IpqTBrC20LWe8QR5Fpz8dVZYuJwlPZ8NV3Bc1Vp
         ZZelwUAWZVV2ps/yFfuddan2TWzc5UK8W9RiAnYdemObwE3PmicCMXk8kb7RgTgyYa4N
         hEyKsvwqivhORTEk3k2DxhcWKDiURGcu9LEz81MyUJWZzVt/vTTYTZFremzjH02SfCO4
         wZViQNQSpHMY628ZM3VV2X06DJqbEbYG4XwctU0IkMyVKnQXfYNwmrDGtoxB/9g2wGlT
         37h2WVKf0z07fNpByTKyHqNxpD7rbZ8JO2JPU3qdwa3rW7DL4cDN+MGclVJiypYZ2hni
         Bhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1zfbH1QuSWSFIb21oSqBAaN1tM1icv8wKZSy8c7gx2s=;
        b=E42cwn72i21MZqliUM1f2AcElVXQlE/1Icd4cAAOdrzm/tGn0a6GGe0wH2/Qd1LaiE
         BfOTUqwJ8Jvj6c9w37MoQRHKOyKh+JUAmn4ZyqzHRHfAtlWNNa9Ctibmpz0CIe8KyzDa
         1ukQU/bddDg+VOotfDAHG3uK7MzjfMFiLwaysvCv5gqnlp0jJ6/T0zxPpI5+X07qvpe2
         VVU90Qc1yKsa8af0tsc2zaSETBdCBwX3EAiSdAjQMnObT/6ZiDPCirRWgrvu5qxRbqEd
         PIxzFrtl91rD9iDLgNXg176t6YLpDKUy+Zgrvw/JA+oS83QG+/zJ3T5AY9oE8bS6o8JM
         i7pg==
X-Gm-Message-State: APf1xPBL8aIUN3RKqov0yYhnkPYH5WSpVD62urbIQi4Ue/MIKfVCCkkH
        qhaoqKJ2b4ttTiwDoNFe12M=
X-Google-Smtp-Source: AG47ELs2GEmYFVADuKcZCpzbPbf8iml7z3TxdI5x3j2g9KWEMOakaAqyn7ggKh1nX7+UV/OgKZ8BSw==
X-Received: by 10.107.63.131 with SMTP id m125mr7373944ioa.211.1519282493787;
        Wed, 21 Feb 2018 22:54:53 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e81sm1042420ioa.30.2018.02.21.22.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 22:54:53 -0800 (PST)
Date:   Wed, 21 Feb 2018 22:54:50 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH 26/27] sha1_file: allow map_sha1_file to handle arbitrary
 repositories
Message-ID: <20180222065450.GH133592@aiede.svl.corp.google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-27-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-27-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  object-store.h | 3 +--
>  sha1_file.c    | 5 +++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Thanks: this is short and simple, making my life as a reviewer very
easy.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
