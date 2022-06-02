Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0BFC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 13:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiFBNPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiFBNPv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 09:15:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF6147800
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 06:15:49 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b4so4723606iog.11
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p6hMnAZXa+vY+RbWxdqkIXbyt/50wmjD4Fq4mQaAoxo=;
        b=cthl0HHOzYWGc/C+VrF87TRIW1BAj7Ipw+g5U40pFv9qxYUtHtGZOzR4s06uHYm48d
         Irh+7V6/WqUcO4px4suN9XYgTpABy3u/uO1V0/xxk/sKNWtyiUFjZemwIzhOpEWmKlYn
         3xKpOtQfZHHfCujj1wlL6NbNPG+ygox+9tJe2OZVtLdLQtxJIk/kWM8igJ6BxI+QjpvF
         PJJAPoy5Xvp0FHwFt3+ll0u7CJDJH+pPsToZl8l55YdNAiD9JiLBnmGBu4lNfe+j1wzq
         sTVI8sCVhQIABJcah36MmZLu4ox9uGoGZ69JirwvX7UIHDn1WJYk4YfTtz5L5ZLI+4x9
         o41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p6hMnAZXa+vY+RbWxdqkIXbyt/50wmjD4Fq4mQaAoxo=;
        b=reCh15UobjJzeP+nPpf2P4MRZTXRc0X3Km7F+0SnutX/Ka0R6/H/E3LpC43/VL0RmO
         4miymKwF/Y57rJ7qDoFzSldoAo7bkA2iU3Tzcx5U4q6kgoI8wErKwmaprsm+g+TP/rv0
         +p7PsL6niPNjRel1/39MrTHWxdp2QH3oGmOFQRg4zcP9Me0VYN2pAMmT1lZDfB7bUNFr
         obktfujRaijR1eXXd+GI9oyQiD0Y9WEMq0O2cqUhdiKDg0l//CtPTGKaOxQAVFufoaXZ
         FhEJTNxceU+CQrnrDK5uQO4sxA2BxeyCc1LWyaN0o0dsa7MiqJTgrrqocJvtgAurn5qq
         KpQg==
X-Gm-Message-State: AOAM533qvlyzMXyuXKIkpServsMhTazsLmv9D7aqmhyP8rllCSS5jpyU
        M+szIumvCweAisZOKbNY4tJC
X-Google-Smtp-Source: ABdhPJxSKDKIjiCtFL6LFTOWAiB7DfUfk3I/zqA4ulBaFwpxXE+dPJdfhve9w6iSCZGh7REfGaYdLA==
X-Received: by 2002:a05:6638:3487:b0:32e:eac1:d4e7 with SMTP id t7-20020a056638348700b0032eeac1d4e7mr3188781jal.6.1654175748702;
        Thu, 02 Jun 2022 06:15:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id d18-20020a056e020bf200b002cde6e352d4sm1369738ilu.30.2022.06.02.06.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 06:15:45 -0700 (PDT)
Message-ID: <c9f11902-31aa-6b69-f4fc-06ed66887de1@github.com>
Date:   Thu, 2 Jun 2022 09:15:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/5] config: include "-c" in protected config
Content-Language: en-US
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
 <66a0a208176094415d7b0ae1f686bdd1638b8a8a.1653685761.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <66a0a208176094415d7b0ae1f686bdd1638b8a8a.1653685761.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2022 5:09 PM, Glen Choo via GitGitGadget wrote:
  
> +int git_configset_add_parameters(struct config_set *cs)
> +{
> +	return git_config_from_parameters(config_set_callback, cs);
> +}
> +

This one-line method could be inlined into the read_protected_config()
method:

> @@ -2628,6 +2633,7 @@ static void read_protected_config(void)
>  	git_configset_add_file(the_repository->protected_config, system_config);
>  	git_configset_add_file(the_repository->protected_config, xdg_config);
>  	git_configset_add_file(the_repository->protected_config, user_config);
> +	git_configset_add_parameters(the_repository->protected_config);
	git_config_from_parameters(config_set_callback, the_repository->protected_config);

...would be the way to inline it.

> +/**
> + * Parses command line options and environment variables, and adds the
> + * variable-value pairs to the `config_set`. Returns 0 on success, or -1
> + * if there is an error in parsing. The caller decides whether to free
> + * the incomplete configset or continue using it when the function
> + * returns -1.
> + */
> +int git_configset_add_parameters(struct config_set *cs);

You do make it public here. I wonder if we can think of other consumers
of this method that justify the addition to the API.

But this is also a nitpick. I don't feel strongly one way or another. The
code definitely works as-is.

Thanks,
-Stolee
