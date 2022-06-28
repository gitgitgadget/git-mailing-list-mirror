Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD53C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 15:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347783AbiF1PTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 11:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346610AbiF1PT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 11:19:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13125326F5
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 08:19:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so26446091ejc.10
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xH5MprAAvp78kgX3KWkywlGpiEBoOnNn9GcVFjRPPkQ=;
        b=M0yFeWjwRJbkbHrcintmEufs9eB4lwQP4/E8I0zqe0z5pytUUQefMfrhfX1phUN1Dh
         RJ5k7L1pJj4jpan7Pcy5iye1RO8JTE/Ig+GNlQnDGQqmX/PGT18+ZuKETzc527WJnnpy
         WZ6wGynfzaTnUDWDdzxBNb8sIcFssNPm1mj3W3yAdGr1OWFgtNAQJuPLotY5NAj14E/A
         ER+lRv0n41YZQHzZYLLDTQLFcIyKBBi/ROWtsad+gqqr1SMb9wggD4WpULucerhSpGB1
         Y6Rd83zQRL1yf9HI39w9OXWIXyfifyDg/oco9kPCr75LGP7jEahfBaKsIn/0t56Gt6l+
         97sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xH5MprAAvp78kgX3KWkywlGpiEBoOnNn9GcVFjRPPkQ=;
        b=P/zMuaSpgWMMGry/mbmIvknIs6OCjC5rhEsfCIAX10GyfaMXNTUYQZnsLZ0zGKaTcr
         QoyNR5sssO6VdO6VOqC+8FjMBP1uVchq3Gpa4cm9eCBnNcY7v994WWwOIZSIbeC1PXJ8
         R/ra7ew/0+5HbgKhU/S9lY5GDYMYUNJB04EksO8ZJNI8MfvTOpMB60Nh/XO7q3HpzpJ3
         hARnF3l4HvD9/f4L17IewXl1xZT58OOAt/xImhj1u5WPfddg7vwXgxKgaE6IlwL0cNrb
         xGNJJ7JOJGvWawR+qKkW2yTmTrSVn8PCRiJ2W9xDg2eG6xLCyR02H/iB+hqqJImt3Hym
         3RIQ==
X-Gm-Message-State: AJIora8pCj+5fqk/95GtXVqpbJEraYL1+d8FtM6GVv7a0pNGPYcx8/kr
        1mUg1yWDeW9n3P8/vfdB0CgNqJgZaM8=
X-Google-Smtp-Source: AGRyM1sKoGzrJGPbUpHdYOQqv+A2CVoiIk7ih337fnFfWGFhdZHuFFPYsMOS4SOzkXqYP2PN/oBgOw==
X-Received: by 2002:a17:906:9c82:b0:6e1:2c94:1616 with SMTP id fj2-20020a1709069c8200b006e12c941616mr18559807ejc.64.1656429567580;
        Tue, 28 Jun 2022 08:19:27 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id t12-20020a50d70c000000b0043590660f16sm9870515edi.35.2022.06.28.08.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:19:27 -0700 (PDT)
Message-ID: <a556feaa-5f72-7c83-7156-fe91f18fc24a@gmail.com>
Date:   Tue, 28 Jun 2022 16:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] ls-files: introduce "--format" option
Content-Language: en-GB-large
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
 <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing

This looks good, I don't have much to add beyond the comments others 
have left.

On 26/06/2022 16:29, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com> 
> +FIELD NAMES
> +-----------
> +Various values from structured fields can be used to interpolate
> +into the resulting output. For each outputting line, the following
> +names can be used:
> +
> +objectmode::
> +	The mode of the file which is recorded in the index.
> +objectname::
> +	The name of the file which is recorded in the index.
> +stage::
> +	The stage of the file which is recorded in the index.
> +eolinfo:index::
> +	The <eolinfo> of the file which is recorded in the index.
> +eolinfo:worktree::
> +	The <eolinfo> of the file which is recorded in the working tree.
> +eolattr::
> +	The <eolattr> of the file which is recorded in the index.
> +path::
> +	The pathname of the file which is recorded in the index.

I think starting with this shorter list of field names is a good idea, 
we can always add more fields later if there is a demand for %(flags) etc.

> +test_expect_success 'git ls-files --format with --debug' '
> +	git ls-files --debug >expect &&
> +	git ls-files --format="%(path)" --debug >actual &&
> +	test_cmp expect actual
> +'

What's the motivation for being able to combine --format with --debug?

Best Wishes

Phillip
