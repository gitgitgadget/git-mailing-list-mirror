Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F70C433FE
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbiDAPzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356683AbiDAPqF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 11:46:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D311CCAD9
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 08:20:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m30so4777639wrb.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v7R0ARvDkaPwwvLoZUXCppi8dvFikl7IOSBRutnyuUg=;
        b=jHnGNctIgNVGVZnMMtSPeT66/17IKDZ71m/3O7tUdZKoqfwRrhpUerx+PFmiw9Iv/w
         EdEy7FDwcWsAWHVEYAz9M6T4Kbpilpm9bRFvThyULUaYFP/H0nDA0n5yJcKyiNFaVgkk
         R2xHGc661tsuNcfC7xeLbPnpDNZUfAhd9hTXNS2DcHM16Oz8yblsUEZzadCyOXAbKR+G
         O+vx6OwuTEnGKFxlF+mj8OlzyVjUC2AZS2EdQdY5r4nDM7GnN5sUwg2QQDlcL97VxmPK
         5V5+cs9zScCp2mKthKooLcpFpAXqvYY8UPK2oULQc10o4PbQNWTLtjmxoC4fz1kX9XTu
         /GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v7R0ARvDkaPwwvLoZUXCppi8dvFikl7IOSBRutnyuUg=;
        b=wJL6j/2G3++FBHQk4QpGIXW11dWe9R356Z+SQf9NhF3I4qBEXw/4vgLhhph/V7t2Nn
         Y4lHgAhnx2vGqysoXt3qSLdHAGOnEUVPsYY3yGxYUL0vbrQnu5fCDJLMkJyXvoZJ0CXn
         2/Me4lI69X9U/iacHLy5Mo2EKv9H6dl7e9us12kThYvIbIi6q+BN1Ax3pOupvuGIGQYk
         lD7Dcwbnkf2B5vKpqKID5FpBC6OEo7LM6vYxObkc+Xfszj+vyJZhLc8KKMVRc2QhCGoD
         qY0T9Ve+2q9bCJunzovKMdJ+kiIicSKj+eDylNOOdMU7jxOOLkG5CiE2i/CdnEsodqFP
         N20Q==
X-Gm-Message-State: AOAM533WD7Ssb1pxgbgEWWHdMSJv/fy+3jCsK56C4v5SiD8UH2g63k3K
        Wt0TObPJ5uCHuWhAgCBhPnE=
X-Google-Smtp-Source: ABdhPJyYBI1+zSeD4pk44+gdHZNsRR4inXNK4rEsdIW4uuNDP+NZIRUnFXDIYiMirQtntbzrQE+/2w==
X-Received: by 2002:a05:6000:15cb:b0:203:d94b:bd83 with SMTP id y11-20020a05600015cb00b00203d94bbd83mr8585565wry.113.1648826456489;
        Fri, 01 Apr 2022 08:20:56 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm2304012wrv.10.2022.04.01.08.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 08:20:56 -0700 (PDT)
Message-ID: <ffb2f216-4504-b1d7-6b59-55c09df4f5d1@gmail.com>
Date:   Fri, 1 Apr 2022 16:20:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 08/27] revision.[ch]: document and move code declared
 around "init"
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-08.27-086cec742b4-20220331T005325Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v4-08.27-086cec742b4-20220331T005325Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 31/03/2022 02:11, Ævar Arnfjörð Bjarmason wrote:
> A subsequent commit will add "REV_INFO_INIT" macro adjacent to
> repo_init_revisions(), unfortunately between the "struct rev_info"
> itself and that function we've added various miscellaneous code
> between the two over the years.
> 
> Let's move that code either lower in revision.h, giving it API docs
> while we're at it, or in cases where it wasn't public API at all move
> it into revision.c No lines of code are changed here, only moved
> around. The only changes are the addition of new API comments.

It's nice to see to see the API being documented

 >[...]
>   
> +/**
> + * Helpers to check if a "struct string_list" item matches wild
> + * wildmatch().

wild wildmatch()??

Best Wishes

Phillip
