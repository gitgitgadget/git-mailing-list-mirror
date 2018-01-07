Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB1D1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 16:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeAGQ4L (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 11:56:11 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:39032 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754177AbeAGQ4K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 11:56:10 -0500
Received: by mail-wm0-f45.google.com with SMTP id i11so10290467wmf.4
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=KH1g130ruyM5EJvsQ6/yMFcX97bI5VtdDi9PGC6GvBg=;
        b=WRwtIdsU7pGIm3n2W0eQCLewa16yi3Q68vazw73Cg7Iwu8gCcg8pfuuVJ/dhAMDh+a
         GR8UCMC5DSE6EN8bUsBwrxR3anJYrdW2oJ9CoKSMJ+3MlT4/xU+7CLxtK/I8thgmtEX/
         FUQ2UuwuoE7QnnRPpZrumWXLkip0TYUj34iPdt1fYhLwaWhttTtNewOicutT3PeTLW+d
         JZpCwCvcwZn7KWPWrVkczp8f0HysyJb7ieJVlLpFyVtKLxp4KN+5DTnK7KQme3L77+gS
         ACwSG/jIUCXb3plhyFguh50hW7SV4FMndxFq3vd/ygkl6URID+oBTxC42M+1IJj7c+/8
         nmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=KH1g130ruyM5EJvsQ6/yMFcX97bI5VtdDi9PGC6GvBg=;
        b=q2i5nCqQgPVKEm7msI0SHUFs+pxctqA6oTz3F8QoKjq2GIj1J0zR2dlFwu34k29Y7a
         DeN6G4c1K/vlJxPW78JTY2HSdZnLdtc4fVhyPSN934G2gkc/bh4uXpEW5yMAkniP1aTx
         9zMapiCyGJl4p388DWa/Ur4k1UjTALW7UqRxOiZN3ucr700PtDhQ4csrrycF6LBBJrDd
         f8Dnlk3vyqeVfL23eSnKy9AExaIQmEkh5YCvd/9/9VUfLYS8uGVFrErYLZH9fKT4V9TU
         boTa19brn6FH3/j+L3RF7loZApb3hG+1pzGHJLrUSAInDXUEmvHWucQwDZ+OcBtZ7RCP
         /Xvg==
X-Gm-Message-State: AKGB3mJaUfZGClZgNUKJNL65W9ywMR048xHylRURzWx0t6wWmm+AsKy1
        Qk+pz2eVR6XQx8EVwUPV8uf0iw==
X-Google-Smtp-Source: ACJfBotxa9uBAmtWeWe/JqUZ66pV4WfUayFYo7pbqpuhuHrjefIGxg9ZlDljyNswiSrvVeDjCoYZMA==
X-Received: by 10.80.150.35 with SMTP id y32mr13053229eda.175.1515344169493;
        Sun, 07 Jan 2018 08:56:09 -0800 (PST)
Received: from [192.168.0.104] (d8D86700B.access.telenet.be. [141.134.112.11])
        by smtp.gmail.com with ESMTPSA id 4sm5731429edf.81.2018.01.07.08.56.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 08:56:08 -0800 (PST)
Message-ID: <5A525127.5010409@gmail.com>
Date:   Sun, 07 Jan 2018 17:56:07 +0100
From:   Mark Nauwelaerts <mark.nauwelaerts@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:25.0) Gecko/20100101 Firefox/25.0 SeaMonkey/2.22
MIME-Version: 1.0
To:     git@vger.kernel.org
CC:     gitster@pobox.com
Subject: Re: [PATCH 0/2] restore fast-export full filecopy detection
References: <1514112729-31647-1-git-send-email-mark.nauwelaerts@gmail.com>
In-Reply-To: <1514112729-31647-1-git-send-email-mark.nauwelaerts@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/12/17 11:52, Mark Nauwelaerts wrote:
> From: Mark Nauwelaerts <mnauw@users.sourceforge.net>
>
> When using fast-export/fast-import to interface/bridge with another VCS
> that explicitly tracks copy/rename as metadata, fast-export's ability
> to report filecopy/filerename is quite useful (if not essential).
>
> There has been a fix in this area recently with as side-effect that
> in some scenarios a filecopy is no longer reported as such.
> These few patches provide an alternative fix for the original problem
> while still retaining previous fast-export's filecopy reporting.
>
> See patches for additional details and commit references.
Any comments or opinions on these patches?  Could they be applied and included?

Thanks,
Mark.
