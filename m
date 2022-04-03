Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9783CC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 20:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350702AbiDCUHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiDCUHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 16:07:16 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090513A198
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 13:05:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id w141so6174632qkb.6
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=l3JZD6UnsiHAyhSjrBlpqfL3a4xWQuupucq62rngXHg=;
        b=GRTL/Rxt/Ko2BlU80xZJpxCrBrt7C/w3YenYPk7iroVuCKE57mf2DtQuB5bcdV7s9Q
         H+q+n/F8E8e+u4Tx8HZj/hYsmzmytsUHsBVbA6QIfr0pJ1xTn5/2Zr/ZomnKjbekOg++
         gUssDlgGt5MIgNyCG5+kUOABXJ7ETXyGjJIpvP2h+uiC5/Dyq4ihMO0yMKHnTHwLeBlD
         LcEbFqhb4lMtAe34ix3UhUVpk/VSMzNbL2BlKK4+VxJ7zsGcl+WnCjgzOOqpnS7j/+Oh
         zc4Zeb+jPaDVNGpfhZxB9yGprCzATKCxVUaCbC18XmPo11U7S2Kmwz78V/+Y53sE9LDQ
         VBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l3JZD6UnsiHAyhSjrBlpqfL3a4xWQuupucq62rngXHg=;
        b=sVD2Rl81PNZ+qBDyqr9GPa6WnlcceE83sC1sy4wwmgRnVV8ZKtiz626cgwgTrQM+UP
         WKOFyYsVzW++voHbRmj4jz7aMgEosphr30OB1oNzzK83JYLRYIvHz5Rubm254qCVt4/E
         zoUg89oTxedxTDWx8SuOSery7A2RbtIjD+TmYUhzteKMZ58id27Q0jiZ4XI0VAOINh+L
         VcOdEU72SZ8bgIIMV8YtVteOwemFvuYApAOAfOrL3rGX0CUm7TORGDXCCvORqtZLT6V/
         MrI5SyggEgXU5QvFjRz0OA7YS/Xc5vVoPqrBCBWLLesn4i+kutpytG/7oK31eDRxbrMd
         e2YA==
X-Gm-Message-State: AOAM530Ve96eyXQ9Hxgj5Vk88DZgDoq5//nouAAegV3JUXlw6PB5/lfH
        DUQxLZpLeimKkruUOifLOQFMofXnL1M=
X-Google-Smtp-Source: ABdhPJxDitGnMuYijfBhcDtPYKr0sP/dAmWKUKqeXcxiwQabwe9eoUChQKDfzWrPskvla7coIThjlA==
X-Received: by 2002:a05:620a:2484:b0:680:9f76:aa7a with SMTP id i4-20020a05620a248400b006809f76aa7amr12465270qkn.672.1649016320140;
        Sun, 03 Apr 2022 13:05:20 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id 84-20020a370957000000b0067e4c1c8889sm5050869qkj.80.2022.04.03.13.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 13:05:19 -0700 (PDT)
Subject: Re: What's cooking in git.git (Mar 2022, #07; Wed, 30)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fernando Ramos <greenfoo@u92.eu>
References: <xmqqee2i50h9.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a5c703ed-9a75-b9e5-0103-a89741abb58f@gmail.com>
Date:   Sun, 3 Apr 2022 16:05:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqee2i50h9.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-03-30 à 22:17, Junio C Hamano a écrit :
 
> * fr/vimdiff-layout (2022-03-30) 4 commits
>  - mergetools: add description to all diff/merge tools
>  - vimdiff: add tool documentation
>  - vimdiff: integrate layout tests in the unit tests framework ('t' folder)
>  - vimdiff: new implementation with layout support
> 
>  Reimplement "vimdiff[123]" mergetool drivers with a more generic
>  layout mechanism.
> 
>  Will merge to 'next'?
>  source: <20220330191909.294610-1-greenfoo@u92.eu>

I reviewed the documentation part of v9 which you reference here
and I think it's ready to go, apart from a small typo which I
just pointed out in <d01710e1-8a42-e4d1-5034-f6796372587e@gmail.com>.
I'll let you judge if you want to fix that yourself :) 

Cheers,
Philippe.

