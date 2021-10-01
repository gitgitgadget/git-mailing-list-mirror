Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB84FC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B238061ABC
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354785AbhJAPFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354706AbhJAPFb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 11:05:31 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EE3C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 08:03:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d8so9206455qtd.5
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VngNkBq88q5/+hk6RWe/3Wob6lVsEAzcnH+8C8RKFhM=;
        b=iOzA6v7BJxvJs5hjy7gK2X4SCduNqhREVmK+W7hSbQ3dhmUVBlZqxc6usWo0iuDf27
         jpw0Mrp1HB3pzyxtO7ySs7IO1vszlL/W+Eq0vV4XoHLHKKPnxXJsoF/9MveAUgCVBQLU
         hsQdfLV7nVIfhfQA5lE+6hlQZn9Mf8xd9Se6uUqGOtL1+7korvb6gZTFfBFeXus3u2tY
         Nw9BsWxoIZ4dvcQLggfw3arw8cso5HNFRyxWwesfGwtA/MIR7NfsCb5dWLYrSvmmtXHt
         zdrgVUWJ07cEsM6CKjEe+yS1t3AxSXYdpMuJMz4tV9Fv4PHH3yAlDYj6+YmnMaBfCcLS
         9sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VngNkBq88q5/+hk6RWe/3Wob6lVsEAzcnH+8C8RKFhM=;
        b=qQEFxRt7pSaR6rtV98ilE6RDQ4wwPhSctgVGM4bjQQUAZRewrBpKRc2HIOnoOoVv4p
         yUl9hApIywcd2mEnNKX0cQ5QQkImdDX8gmsGk2sv/U/kPdk4nNtFv1O1SmzBmE17iD+z
         hTmi2/O1fpLnSukvdfbvYVag9Sgd99jdKJvIJ3DVG/ciW+gF6wrGf8xs8SJE3K3hqN1S
         wFWDmbHqQXinj6B1tC5ET/WXfBPYbGJqH4Ynl7CSKDixXRtfoKmJWfMCoHfUVD5QzCuD
         U+O4rNZ7sfGcGCEz8midqSGyigUdp8xQDfbfbTbEUI+xST8SLGWJO6W1oBb3UVkvqOS9
         AGgQ==
X-Gm-Message-State: AOAM5315AMLqUCHMHg7MxSB59BM0ujare9kQHiZppfaWl75HqhE1xHUY
        pXKlf0nfClsa1UsJWcgYjUmj
X-Google-Smtp-Source: ABdhPJz3GfgeqiBkXVtU5Xb8940Vvva6bVgTV8X2+XJEvyo55Eh87yRRuLxGsSGa4/kH9CnCDkpqmg==
X-Received: by 2002:a05:622a:164b:: with SMTP id y11mr13388230qtj.310.1633100625714;
        Fri, 01 Oct 2021 08:03:45 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id n11sm3650265qtk.92.2021.10.01.08.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 08:03:45 -0700 (PDT)
Message-ID: <9fe518fc-59dc-d12f-01ba-eca53777d629@github.com>
Date:   Fri, 1 Oct 2021 11:03:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH 6/7] reset: make --mixed sparse-aware
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <e7cda32efb63c63cf60513ec447418fd97ab3fa9.1633013461.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <e7cda32efb63c63cf60513ec447418fd97ab3fa9.1633013461.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye via GitGitGadget wrote:
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 0b6ff0de17d..c9b9ef4992c 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -801,14 +801,25 @@ test_expect_success 'sparse-index is not expanded' '
>  	for ref in update-deep update-folder1 update-folder2 update-deep
>  	do
>  		echo >>sparse-index/README.md &&
> +		ensure_not_expanded reset --mixed $ref
>  		ensure_not_expanded reset --hard $ref || return 1
>  	done &&
This is a bug - it's missing `&&` at the end of the line (and adding it will
cause the test to fail). The index is expanded if a mixed reset modifies an
entry outside the sparse cone, so I'll update the test in V2 to verify reset
between two refs with only in-cone files changed between them. 
