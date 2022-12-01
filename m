Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DA7C4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 22:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiLAWp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 17:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiLAWp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 17:45:28 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDD63121B
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 14:45:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so5206324wrm.2
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 14:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtgncV3AxDOfDmYyzuLb/09P8MsRDiu1u5QN5V+Z+XM=;
        b=GkkjRbRvagSkh2tgKRZxNZsQpQKjY0HhNumUy0t+5wOV2cZWw+ujPwSxN5gXQTYJRX
         FkWuOuvvwZObNfO3bShQ2si6bMzjMYRuqBIPusL46p5+YKpECEuLEVxprJ/JhwEA8E5J
         w9qRTkLbrsywiakPvWFIjRzEe48CjMCuN36KghVn+UkT6xl7no+91/5yA1t87dR3jmvR
         Es3lKW291nNw7eS/vFNkcV2FPIhv0QBOrTZk/ij/gfWeXQZpoF1lVppZdJWE95x1cAS7
         aa3anNoUY1/Fvv9/CEdBCZwtIQpTl4/dO17luM56zWsGSIfJpaAuKSMc79aj574vIRl4
         k0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtgncV3AxDOfDmYyzuLb/09P8MsRDiu1u5QN5V+Z+XM=;
        b=KmcPBy6CM+uTipfH6kCLJ0o8vt+XMhv08OQWJjuHm9DB6fQ6JnDWWBt2NkxpnZiJOP
         RGofDNF/DX6JOas539IzOJiYsBQj0EtsolctR4FQhnnzYe6wp4zKfAinP2Sc7/Sxasv/
         lgNGlvNUPA4z+pod/X/jafb7Hq7UDsvth/pp0+wWoOWL08sX/3Y1m5b0WOXCMu1Eh1Ct
         3FY86p/La1hhLnzQMMMqsDecSxvnO3HbEMVm8iwPwlfjpB6Fzj8bn7iR775FAgaCJIQM
         DEcvmZJyTdTYyKDZw9gW35b4lmn4IgM03ta8msxcDeX8RhH+QQ8lBfmJb7cqqOa/AOKJ
         LTXw==
X-Gm-Message-State: ANoB5pnhzntgi1EfBfCHClrHyOCjlWS5Py0kvFZzQe8kgLU2cPMZtZM2
        G1jiHQQreCEThKeF7ONcQ7ctQaFtHBM=
X-Google-Smtp-Source: AA0mqf6yr2/optUIp3mRSpkuM+slTaS1sKzZ/O28FLd4fK6LnqXA+YghL2xuxpbt57Tk5jtD/xLXaw==
X-Received: by 2002:adf:f2c2:0:b0:242:244b:3bcb with SMTP id d2-20020adff2c2000000b00242244b3bcbmr9318109wrp.655.1669934725753;
        Thu, 01 Dec 2022 14:45:25 -0800 (PST)
Received: from [192.168.2.52] (203.red-88-14-63.dynamicip.rima-tde.net. [88.14.63.203])
        by smtp.gmail.com with ESMTPSA id o37-20020a05600c512500b003cf5ec79bf9sm7760853wms.40.2022.12.01.14.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 14:45:25 -0800 (PST)
Subject: Re: What's cooking in git.git (Dec 2022, #01; Thu, 1)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr0xjs46r.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <c489ad32-1308-06c9-0c92-6e39d1f82a4b@gmail.com>
Date:   Thu, 1 Dec 2022 23:45:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqr0xjs46r.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01-dic-2022 21:23:40, Junio C Hamano wrote:                                                                                                                                                      
> * rj/branch-copy-and-rename (2022-11-17) 2 commits                                                                                                                                                
>  - branch: clear target branch configuration before copying or renaming                                                                                                                           
>  - branch: force-copy a branch to itself via @{-1} is a no-op                                                                                                                                     
>                                                                                                                                                                                                   
>  Fix a pair of bugs in 'git branch'.                                                                                                                                                              
>                                                                                                                                                                                                   
>  Waiting for review discussion to settle.                                                                                                                                                         
>  source: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>                                                                                                                                         
>                                                                                                                                                                                                   
                                                                                                                                                                                                    
We can drop the first commit (branch: clear target branch configuration                                                                                                                             
before copying or renaming) as it needs a better approach.  But we can                                                                                                                              
keep the other (branch: force-copy a branch to itself via @{-1} is a                                                                                                                                
no-op), there were no complaints about it, I think.                                                                                                                                                 
                                                                                                                                                                                                    
Un saludo.                                                                                                                                                                                          
Rubén.     
