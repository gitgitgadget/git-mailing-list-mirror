Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F021F464
	for <e@80x24.org>; Fri, 27 Sep 2019 12:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfI0Mpa (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 08:45:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42003 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0Mpa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 08:45:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so1783637qkl.9
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=44aPgVnHfFmeufhycevTC5hH8EyfGXrfCRUPhbTDuu0=;
        b=BZPNNoezlvQJ3UTWhGJJ2KiL4ZOGMHyTMeMSpa6Ahtr/143UOVZWsyIbxFFUgNTFMx
         MBkr3+4fH0jy5I4eYzheGx7Wpi2XwD69u7SFbI2IJBy0ttYN1H0rz4YUnTI5Er0KmP6Q
         XUG7XTOjbQ3zIGY8TwQ9ak0kElTYYDlaQScjcxtdkb7DkT64gQO4l7Rce8bXMOFZmst8
         fUyv/l9L0pl+jQDntKYtVHpkupRS5FZDr7pGcCcP7PdTkylg2naXW1AgaunLzsVcOPyp
         g2c39eBnqa60nni2VI6kA2dD6YZct5X37i+x6mIRH7SHdEcEcepZGjZSzY6CBI1Rw1Od
         PvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=44aPgVnHfFmeufhycevTC5hH8EyfGXrfCRUPhbTDuu0=;
        b=cCG1A5it06OtkmLYm9IShcS82Z3hjmkT1bQJK19au8SI7BsSvK5Svkew0nV0il1RBQ
         n6Ll6QUN4oyD6FO2B9tzyGKPKNYBQ/ZF+VEM8DsbMnUz1SLAhd9yKe5gw6/J/GEecC8I
         zHXJh25psqwR62UTLLr7k4k1Wk6FJR/xc8ZeuYEYxsAiNR2RQSCAHQ/19HnhdAOKstWk
         YthggcuYuBEsAqUkgCEnzllTe8ctpUqdNQOMZV/5t51Gjx1x4NAGZverTQQc9uuyUMRW
         Kx0U/sNziwpKMr3W8TKKxHdVCFn1jFWuW3y1RH+KjTAxgmw5X64yo8TCYqkDaJgzYXwX
         9waQ==
X-Gm-Message-State: APjAAAXNjvsUc0/Y5puYHfd9U4M3Z0oit25z+iP2SN7EpMi8jhZ+seL8
        PCuVW3M2AMGxQocZ7HO7jTk=
X-Google-Smtp-Source: APXvYqxCF3roWMTTYfAEKJwkR/mj/t4XuHwMx10AtSkJtl+ar58wzD8a/NojPtFJ5KzIgwiQoD94wg==
X-Received: by 2002:a37:a409:: with SMTP id n9mr4154274qke.485.1569588329077;
        Fri, 27 Sep 2019 05:45:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3c25:ecbb:deb4:f177? ([2001:4898:a800:1012:ed58:ecbb:deb4:f177])
        by smtp.gmail.com with ESMTPSA id g33sm2348099qtd.12.2019.09.27.05.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 05:45:28 -0700 (PDT)
Subject: Re: [PATCH v2] commit-graph: remove a duplicate assignment
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
References: <20190927021952.364646-1-alexhenrie24@gmail.com>
 <nycvar.QRO.7.76.6.1909271418170.15067@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <adf9c41a-47af-04dd-d1ed-c181eba80dab@gmail.com>
Date:   Fri, 27 Sep 2019 08:45:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1909271418170.15067@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2019 8:21 AM, Johannes Schindelin wrote:
> Hi,
> 
> 
> On Thu, 26 Sep 2019, Alex Henrie wrote:
> 
>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> 
> Hrm, the commit message should reflect Stolee's careful consideration,
> no? An empty commit message won't be helpful e.g. when cherry-picking on
> top of a branch that already has your v1.

I agree that we need more in the commit messages here. It is
helpful to include _why_ you are doing this. Keep in mind
that your cover letter is not recorded with the commit at all.

Further, when updating a patch series, you should re-roll the
entire series as a v2 (preferably as a reply to the original
series). Keep in mind that this patch should NOT be applied
on top of your other series because then 'g' is not assigned
at all. Mechanically, it COULD apply, but it would break
in tests.

Patches 2 and 3 in your series also have feedback that would
be good to apply in your v2.

Thanks,
-Stolee
