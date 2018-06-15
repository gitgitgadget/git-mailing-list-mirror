Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2331F403
	for <e@80x24.org>; Fri, 15 Jun 2018 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966392AbeFOTsz (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 15:48:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36443 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965768AbeFOTsy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 15:48:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id v131-v6so5737949wma.1
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=skNDlXINCcxg0U+4CgrKD97B8F50buSxcPhgjmqCS50=;
        b=s+Z0/NlGd6aLekw+R1lLS1snKun/8n3hxVJjBAVzhAfF/1A7uimXYQmTMD0I/Z6Mxg
         Jl+yYH416OyBFD1YqZLNbF24lrcOcc2N5eE2K2Rx1nu/QH9ogiYgRwBPdEnKidbtMRmD
         TZNy4m0qKRua4MJgonPt+FlXCKgmW8eQMNjIdchpGLGEwKGrNoSfQVvRRtdnjEdv44If
         nfL2mnfVqXXDqY/qsdRj3FRNVf8oBBgAHUvESkrAYAREV21dAGQ4WowClt/fUDw896ck
         bq7K8xoXbRuv0vH3eAZ2IjJH/r0CUQJCMX1fTkj+PNjFK+764cOte89jeduU75SdX2bf
         9+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=skNDlXINCcxg0U+4CgrKD97B8F50buSxcPhgjmqCS50=;
        b=hGLnQU4DpW0X7htrBke+yuGCBC6TwcS7C05v+F4aPCU11xJXwJQG+5JbjiTXvAuTgN
         zzYgPOHZyy5Nnm4vL4fKXUU90srRNOJOFvVwMdTXMVh8liPbbbiSda7cdErDADXrQSTi
         HbEElZ/zaiAb5Cs0+pdZKy//F26my21gNs4YBRs1XkBWMOF7uanQcbto71gHhxsQw2Ng
         C4IScSQNbSXpScSN3lKNoiBUWXwTZiCiGBFjn+gXZ4ob/t2jrSdIG6h/t4dkmXxnlWbG
         yH/HC5DPvCcGrYzNiE4ZAz+CVotKXUMt99Q6dC9CWbQqAECtQO28nSgMGuNd+OaGfU95
         Ftvw==
X-Gm-Message-State: APt69E08ru/ZVaC1qCHKwnDIbk4FAMwboVj6Asr2spmI66if00B8YM12
        yndLCK7EWd9yBxlCWEtfK6qIcxYn
X-Google-Smtp-Source: ADUXVKL/0ju9lnPOAWkf4mIzppA/BWfSMNpL3376SzABAuiFp/uP/iVKHPDw2pqSNw1LLGN8HEOKGw==
X-Received: by 2002:a1c:a54e:: with SMTP id o75-v6mr2245799wme.157.1529092133161;
        Fri, 15 Jun 2018 12:48:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q70-v6sm3075188wmd.45.2018.06.15.12.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 12:48:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "ramsay\@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 0/7] Delete unused methods in EWAH bitmap
References: <20180615143018.170686-1-dstolee@microsoft.com>
        <20180615182727.172075-1-dstolee@microsoft.com>
        <xmqq1sd7288z.fsf@gitster-ct.c.googlers.com>
        <ee8a1b8f-d14e-218c-3bdf-82908fefbec0@gmail.com>
Date:   Fri, 15 Jun 2018 12:48:52 -0700
In-Reply-To: <ee8a1b8f-d14e-218c-3bdf-82908fefbec0@gmail.com> (Derrick
        Stolee's message of "Fri, 15 Jun 2018 14:56:43 -0400")
Message-ID: <xmqqo9gbzv8b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> ewah_clear() can become file-scope static, and
>> rlwit_discharge_empty() can be eliminated.  I do not know if either
>> is worth doing, though.
>
> With Peff's patches, this is true. When I applied your diff to my
> patch alone we could not do that.

Yeah, as I organized the patches on two topics in this order:

  jk/ewah-bounds-check (build on 'maint')
    Peff's 1/3
    Peff's 4/3

  ds/ewah-cleanup (build on top of the above)
    7 patches in this series
    Peff's 2/3
    Peff's 3/3

at the end, these two changes become possible.  Again, I am not sure
if these are worth doing, so I'll leave it out of these two series,
at least for now.

This is a tangent, but I too felt that roaring paper quite a
pleasant read ;-)
