Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6374C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiCDANw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiCDANv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:13:51 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE2A9E37
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:13:04 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 132so6082743pga.5
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uw5O2/gb+0r8/bcTYLTV1QMAIbRox96OuyxYv2j0rKo=;
        b=a65dFbUqeIORC9bLxtQ5ivbRuIce5I5fgdZloaoepcDMJWHiaId2w8IT3T4dPspUmB
         YLt4ncCBZTTiiS2QMFvU1gVbSJtKYaNxgqBWcuunihd31vcGRSfNgMBA3JF8Fe9hqB6A
         es8ihHIk5o40gi03dgMXefTHVecyKtVuCJFTO0mY4qf/i4+hdi1+Qwhle2pmoZkGmb40
         aboaCgpqguE6KxOCAhcays1JWEizuluj4ePl8MxzMU9NnJQ/q0FRHdcAnOn5mhBgSXId
         +/lQilGvde53bCjtVveIG4pZgVgJikqE0FuCME+MsjvMUG7cSN0v5nTsoaf6WyHeLIB6
         piVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uw5O2/gb+0r8/bcTYLTV1QMAIbRox96OuyxYv2j0rKo=;
        b=ZPeyVZFMDsRyZPakCcGtB3SqF2ydsmmgAaBMTS6k4NSeCzG+NEQL9hN6rw/eENoAWf
         jIH4m/x7/ohcuau18xGPiUgozayU7rIQep+hV04czEsOL/4oG/9vXxGeTzrRgCHBho9E
         NfqSiU7GklshqV6sNVrH1yj2KrjHmHtvDjxwZGDsOLEIRf787+cxIf9nknJzhlMvnuFo
         c6dUgvMvrar01UJfJBTCvvkC6HumUUGANK2JGriTPTD7Np6VmOBWOA4UKdwrJAKeeAFo
         zljXul8ym24sB7nYTGyoeTrhqEYJeAPgYnG86VHAVKBWhYffPz9H88b4ymaNszU6P59s
         bouw==
X-Gm-Message-State: AOAM530q3HJRb58PwvwnwzIMdMxi4v3D+exD10c+iEELqCfoEmmb7Hd6
        uRIxr6PQgGqKdPWjV2vXRqX1tg2Lz7sKVA==
X-Google-Smtp-Source: ABdhPJw7ROJHAxOyiewmx9iyaeDQYY5IFB1gtrMH8FH+TxjzBFTE30crXS7wa9fckPFbVUSTbXd9kg==
X-Received: by 2002:a65:49c7:0:b0:374:4ee8:ab5e with SMTP id t7-20020a6549c7000000b003744ee8ab5emr32331473pgs.344.1646352783467;
        Thu, 03 Mar 2022 16:13:03 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:90ea:410e:eb0e:7f23])
        by smtp.gmail.com with ESMTPSA id d4-20020aa78e44000000b004f6aaa184c9sm846114pfr.71.2022.03.03.16.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:13:02 -0800 (PST)
Date:   Thu, 3 Mar 2022 16:12:57 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] contributor doc update around log messages
Message-ID: <YiFZicz69mDyFzXB@google.com>
References: <20220126234205.2923388-1-gitster@pobox.com>
 <20220127190259.2470753-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127190259.2470753-1-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 11:02:56AM -0800, Junio C Hamano wrote:
> 
> We already explain _how_ to write log messages, but did not tell
> readers why we care.  Add a few paragraphs to SubmittingPatches
> and CodingGuidelines to do so.

Bah, after I reviewed this I went and checked 'next' to see you already
merged. Sorry for the noise. :X

> 
> Junio C Hamano (3):
>   SubmittingPatches: write problem statement in the log in the present
>     tense
>   CodingGuidelines: hint why we value clearly written log messages
>   SubmittingPatches: explain why we care about log messages
> 
>  Documentation/CodingGuidelines  |  7 +++++++
>  Documentation/SubmittingPatches | 36 +++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> Range-diff against v2:
> -:  ---------- > 1:  b86a706bfd SubmittingPatches: write problem statement in the log in the present tense
> 1:  35e39deb7d ! 2:  a65df87939 CodingGuidelines: hint why we value clearly written log messages
>     @@ Documentation/CodingGuidelines: code.  For Git in general, a few rough rules are
>          go and fix it up."
>          Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
>       
>     -+ - Log messages to explain your changes are as much important as the
>     ++ - Log messages to explain your changes are as important as the
>      +   changes themselves.  Clearly written code and in-code comments
>      +   explain how the code works and what is assumed from the surrounding
>      +   context.  The log messages explain what the changes wanted to
> 2:  fb54bcfcda < -:  ---------- SubmittingPatches: explain why we care about log messages
> -:  ---------- > 3:  77d918fb98 SubmittingPatches: explain why we care about log messages
> -- 
> 2.35.0-177-g7d269f5170
> 
