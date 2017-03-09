Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F79202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 18:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932962AbdCISSr (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 13:18:47 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32988 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932920AbdCISSp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:18:45 -0500
Received: by mail-pf0-f170.google.com with SMTP id w189so31638149pfb.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 10:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P8BkD4uwMs8IIBDSsGf0BXwzFRLjk2RHC43WiIAVcLk=;
        b=ZbbTl4MRXi9sIujEN7m34fKsrBM7xpKsBKDSLuHP+LOlYm2h966UR4hQJ6BSAwRKvI
         nFjwd4llPoH+mfkQLxsF3IqZvWpSl9tBLURKOLRL59JhQQWK9pGDbHAZ+i6P9apHRVEY
         ACgl/h+7l+OuoTIqlJ66XpXPM55zV/Q4cWhaeEI/s6UMWcT/0QhF03zRLX0VEPFuv+wL
         c3LfX+P2h1kDIS1byiu7EU9/ZSxKD8I2Ju0pFJLEy5zLIHEcFyQXuaFbjdc5XWENRnR9
         pG07fKq0rj21sTs5yEFAi/liHoqFK357MEypotCg+gZ8vJSPvQpgcrxfjLffeZhQ1mVt
         Nd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P8BkD4uwMs8IIBDSsGf0BXwzFRLjk2RHC43WiIAVcLk=;
        b=B0aarTIZiSuzUACtt/cnfXvU1Rumx0F6IsxL2kYHNtjXfFU77URoEIfsBEzmN0PREc
         ZQgyotzwF6JUuGpHLRmGWu9kHIoSuB1iIvRUE5zyG2Id9qkeyAPnOiYXy48MBqgp1UFF
         uKF0LHmAfrsq6x1Zk6erJplMjtS2SVbOktnp1x3geLce0o+iyRpS+muGbVYp+oN191Wj
         GyHV8sk7j8gIU9HbpCFWHu7XY9WGI5dhIqNQgllbvcnVjYrKasLRUf2b427goEaKMzvW
         WVsx2VNFz+mDbydu58XgK9wEBHOMiatWOuNHcz1i2TtfkTqUfWwA6YPWS86uZd7MhJf6
         j1nQ==
X-Gm-Message-State: AMke39m0ztfB8EsJre8tpCdEfjgedhOG+fJkxQsIqzgQQhTCHsGZ0puLfxc5nJv6EH0bZlFs
X-Received: by 10.99.117.11 with SMTP id q11mr15570280pgc.9.1489083519034;
        Thu, 09 Mar 2017 10:18:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id w14sm13916530pgo.37.2017.03.09.10.18.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 10:18:38 -0800 (PST)
Date:   Thu, 9 Mar 2017 10:18:37 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Valery Tolstov <me@vtolstov.org>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
Subject: Re: [PATCH v3 2/2] submodule--helper.c: remove duplicate code
Message-ID: <20170309181837.GF153031@google.com>
References: <20170309003858.GB153031@google.com>
 <20170309012734.21541-1-me@vtolstov.org>
 <20170309012734.21541-3-me@vtolstov.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309012734.21541-3-me@vtolstov.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Valery Tolstov wrote:
> Remove code fragment from module_clone that duplicates functionality
> of connect_work_tree_and_git_dir in dir.c
> 
> Signed-off-by: Valery Tolstov <me@vtolstov.org>

Looks good.

-- 
Brandon Williams
