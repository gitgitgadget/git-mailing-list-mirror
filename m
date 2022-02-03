Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADCC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 22:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355747AbiBCWRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 17:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiBCWRP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 17:17:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BF7C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 14:17:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so6570975pjy.1
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 14:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xi++EgKpuq0UJgJfKbRJxWKQGvNR6iohvq9aJ5PgOFQ=;
        b=SMXgCdnEK8w7xyymsqV8sCvx9F2lcO+sIVnBHszQIsXnSGVgx5egyGrL9KvVohSC/6
         umMHUHFZiR3CSOrA8jpxvquMlVR5MSilyZGft3/jRSAvn7BpAJSvW34ewM6XWk6HDuS+
         w6un/VBQrJlpb0k0mAsjO7+7pNO7i21PjDr1TDgiOxB5nnq8ORdknGjTeNHr66PfxZrx
         Sjofz+3JeGpZOJ3AsYSwFJRfkiDv8Dl/InhUNoqQXukApdiHPPlJfY1ePGhdu2+xDRtQ
         0YYumHGSlf+8XgRefNfokg2b05v8XCtXvq+lUjWIJTGDPfdWB5Ejehbx+zuSGMAp6GeP
         7DfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xi++EgKpuq0UJgJfKbRJxWKQGvNR6iohvq9aJ5PgOFQ=;
        b=GIaF1ggCMN8RcHdhaajV7TBWEijB5suIvYos35SWshdTtMkGFDuWFfbAUav7pNX35R
         4cqzSEEbsUjzHyGnj9b62SuMu5ws2jWtZAUQWxfW5QqU33fldCBUBkrXSuzTSiSjzLWL
         YSoocVLrpPkIh5rIu3Bfk+N6BsvQY7P2cBdDF2HfSWsU9kvxQU+lO12fXB410EFfLPAC
         2wm/H2ol+5UlP27oNJ5i4HDaWGyCix1P2MBpl+z8YYf9rXl/6MFmpElU5QUP3BL4GRyP
         SGFZmokj5eeCFFhuVXW8TaX6Z9/iZuPkrkbh43TgduZm7nXfEBecVShLnV63PgAwFrVq
         1uNg==
X-Gm-Message-State: AOAM532LVWcnJGm+z8J/LQGpxKEIigDqS8h/lQ0Y24CAJ2DrEnBKiEGX
        cnKxKT9UPp+AvBj0Arbxbfk=
X-Google-Smtp-Source: ABdhPJyNf5QmtzS1uHZVvVCHHGk1yBeUqH9RyfdDHKbtrsZed9nkPgYTcuHFtSiVE8Ofqgo8Y4WMFQ==
X-Received: by 2002:a17:90b:314b:: with SMTP id ip11mr16137835pjb.230.1643926634426;
        Thu, 03 Feb 2022 14:17:14 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:51c6:c5ef:caca:5a98? ([2601:602:9e81:12c0:51c6:c5ef:caca:5a98])
        by smtp.gmail.com with ESMTPSA id f3sm26997pfe.67.2022.02.03.14.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 14:17:13 -0800 (PST)
Message-ID: <7033ab1b-7d90-d83c-fc65-33801c6348cc@gmail.com>
Date:   Thu, 3 Feb 2022 14:17:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v5 0/3] completion: sparse-checkout updates
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
 <xmqqo83nr59i.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqqo83nr59i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/3/22 1:48 PM, Junio C Hamano wrote:
> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> This series is based on en/sparse-checkout-set.
> 
> This has been a very helpful note, but after the topic was merged to
> 'master' on Jan 3rd, it has become a tad stale.  Let me apply the
> topic directly on v2.35.0 instead.
> 
> Thanks.

Thank you for the heads up! I will remove from future versions.
