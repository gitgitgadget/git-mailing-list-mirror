Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CAD420248
	for <e@80x24.org>; Sat, 16 Mar 2019 01:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCPBvU (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 21:51:20 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:39551 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCPBvU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 21:51:20 -0400
Received: by mail-wm1-f43.google.com with SMTP id t124so7657528wma.4
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 18:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8s1KYp4uI5J5FmtvnFTnBuvZHwnHWriDcc7XAAAyV88=;
        b=PMTHHR91q5gLZUSRhfxVvmAolDV8dcevBo9MHjN75Bn14TjNMK9f/qmaD+JcVbfEGj
         b0qZ/+jYWXLrKdP/s5eM6jmt6iXi1FHXFj1rlUowmn8FMdkGap0HMN/w9n9TZtKAElM7
         2ZAHREqEwUw2Wh6lkv10Rm6njARkWp2JD8XiWw0hOCsL3SWAqCly8Zezdchj+X0ZfYSM
         xFcmaBYfPcjMK9YzU7/32xOvmaOC1HDWMa7rrHf9ktu0Ut0t/r64akVNXES6hzpC0mUX
         Gh4fRnzmLEmwBooY1DlDsAIP7bixPxInomNn5ZClFtcIqm/xflkWh8uQ/zpjTehR1Qny
         dn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8s1KYp4uI5J5FmtvnFTnBuvZHwnHWriDcc7XAAAyV88=;
        b=bZdJ79CMsASEgsSS3ISj7TmxCdun1de6NU8P6ilOi1fT5DrHlluvkGXipwEyqR5xJC
         vpsJ9HIrus1I/FUJDl8rJj3siPIC6pzww/9tzruu7myWneifpDcGCs5WEIARzoOsyRVm
         Yy7s2HSY/xkEDxdFIE0qkG/Ln3iVHqpMaPbPmGK0A1O3Wv/JIdbGvQlCjOzIAj95GJK9
         MfFWaf0PmxOp67LBDvZnX9m/MA/ShuQ1AssmNjYXgEtu0a1eVdFgnpi9HCGpjN0pFVaU
         1jsPY8QWCmhaNI/L2WjeypSk0foJ1AR2c6GiEN6nEWQIpRrcZ1H6D64wbpEVgXl80mSX
         FsgQ==
X-Gm-Message-State: APjAAAWWn7Ex2ktGCebaJQF+7x5IlbEhvsJuHQ4o1x8iU00QO9F6lGNy
        IA2ftwE0WgIBg1jBswch5NveMLm3
X-Google-Smtp-Source: APXvYqzzH+VXd+yct/45BuKcHUlec95d6hBJIfBWhLAKEXEGMxXw9DX3Y5XSHCiMorG5u3vaurjFZQ==
X-Received: by 2002:a1c:cecd:: with SMTP id e196mr4033832wmg.31.1552701078815;
        Fri, 15 Mar 2019 18:51:18 -0700 (PDT)
Received: from szeder.dev (x4db40a84.dyn.telefonica.de. [77.180.10.132])
        by smtp.gmail.com with ESMTPSA id h137sm7055043wmg.41.2019.03.15.18.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 18:51:17 -0700 (PDT)
Date:   Sat, 16 Mar 2019 02:51:15 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: protect .git folder/files from grep/sed commands
Message-ID: <20190316015115.GB24175@szeder.dev>
References: <SYXPR01MB09574FEB4E6D6476B4F1D155DD450@SYXPR01MB0957.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SYXPR01MB09574FEB4E6D6476B4F1D155DD450@SYXPR01MB0957.ausprd01.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 16, 2019 at 01:37:39AM +0000, Dimitri Joukoff wrote:
> When performing global changes in a project/tree using a command like:
> 
> grep -r "search" | xargs -I {} sed -i '' s/search/replace/g
> 
> there exists the possibility that this command will alter data in .git
> folder.  Using GNU grep, it is possible to use --exclude '/.*"' to avoid
> the .git folder, but this flag is not available on BSD grep (i.e. MacOS).

Try 'git grep "search" | ...'

