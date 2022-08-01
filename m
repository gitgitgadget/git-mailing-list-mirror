Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3854FC19F2A
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 14:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiHAOBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 10:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiHAOBF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 10:01:05 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032899589
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 07:01:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v28so8371696qkg.13
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 07:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=N948ImOZwm3SQeCcAozTdftsqSVoyVah4seeU02/pD0=;
        b=UBNV9gGxgXJDsAfFgAdlgLQ7GjIY67OOLrAmK8PEsGk/Gz7ovp680TtpKFSUjw3mUg
         CIYHHMUMbblEgSvSrhFBrDQHjtfEjHiTYn+0tfHKRQp4NU98ABQ6cw1snm/IFRDVwgxJ
         WMus18se2ikf6So5Q4CnJWhrWMFtMv8ypAhcaFdIAzqG9/1fYuhn/YXng9eD7xtWNNz2
         nyxonJ8PFOTg9BocF0/4WxdxtcM0r1LqUbf4CoxywOATT64/u2ro0tThI7PU3aH7UKpk
         LpLV0/KFRNFYVtfhRVMkGCpZBecEFn7kD+2qgKJBAS3JlaAcRN51/QFYfsIVv1FJcrf2
         d3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N948ImOZwm3SQeCcAozTdftsqSVoyVah4seeU02/pD0=;
        b=bo/y/aqOmVBkryNpDYRa5RX4OUKd0KWknhjWlKjRFXF29oCVd9+fkUE0CiN3nrhCOE
         PzKMZbv1aJqWtUKS8Gm8nnclXok0ChkOtlGNhuEtrtvhS/mHVGv8Zftf6/ColKwnsAH3
         e2hkupFh6xLBBeeSr/x/BWltPdXmm8pK06WGZzV8Qqe1MutJJ8xDmceOYLpOFshdck6g
         nB8y9R1NRP1H7axXR7k3VK4FM3uOJAim1/5CVhA6HlEUyKTN94MFyDiJtvhsS75PhydI
         pCVWDlacKfVN0UwOGYEzFeYm9o6XOifFOE9fvWodSWAu0fHZ29TBfUk0X2ts5pjxV80G
         mlHA==
X-Gm-Message-State: AJIora/Mp2SVLPdTCyO5jmUa+cbIZ5G+823PkgZe6rYmSFmgxKWZL9Zs
        dhU+gs2XXiapUNFf89R1LpkM
X-Google-Smtp-Source: AGRyM1sCAfIq4w9mEHHgf4+VElknxrM8govRsXmYu81zq+j5DE2ms/FYv+34Ct9nDsL0hZS4Tzb7mQ==
X-Received: by 2002:a37:917:0:b0:6b5:b9a4:bdda with SMTP id 23-20020a370917000000b006b5b9a4bddamr11347392qkj.36.1659362462533;
        Mon, 01 Aug 2022 07:01:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8ca1:1a2:b034:1f7e? ([2600:1700:e72:80a0:8ca1:1a2:b034:1f7e])
        by smtp.gmail.com with ESMTPSA id s8-20020ac85cc8000000b0031ebb1f8918sm7495814qta.76.2022.08.01.07.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 07:01:02 -0700 (PDT)
Message-ID: <3ca12cea-aabf-05e8-2502-9cd4e82deb41@github.com>
Date:   Mon, 1 Aug 2022 10:00:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/5] Bundle URIs II: git clone --bundle-uri
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
 <YuG4ICBFNbLPR9Iv@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YuG4ICBFNbLPR9Iv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/27/2022 6:11 PM, Josh Steadmon wrote:

> Looks good to me, with just one small fix and a couple of optional
> nitpicks. Thaks for the series!
> 
> Reviewed-by: Josh Steadmon <steadmon@google.com>

Thanks for the review!

-Stolee
