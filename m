Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3BE1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 13:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfJBN2j (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 09:28:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33029 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfJBN2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 09:28:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so7058001pls.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dMcMA4nQ/l5GCpYXrVGWb9L86VfDAeQzN4AEys3+3CA=;
        b=QBZv5/mFKZV7JI0+hfVVcakknjzxrMlsiGhW/TIO+P9UBfnfGmwUUTw8V8FRVaURWU
         cg7vbzqvYKw0CDOjXOrKiwazL+I1qiwJTewy3PplhzzuloqZCAsRv+uIoW5wSYVwlAXz
         RERUPVWJG/ukw6JUyj8MEJ14M7I8TBxRzmFqboNafJS5n7dIJU2xC2WFlPbFZbGa58p2
         U1/0OzyrG1Q86KXo8kkwiLDjr9RH4SlLNlo19y1e9oLTpAMKSe80q3U89oRtCGe3ymNf
         pAV80Tbo32MZJuK3qyUtvTPv/W3GLoKFEbdxtLSP/u6o2uLdeiTsAG4D8JQR4cux7DER
         DA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dMcMA4nQ/l5GCpYXrVGWb9L86VfDAeQzN4AEys3+3CA=;
        b=Xls++kTXReJLMGeDRQR/5FNxnDDLn5UFyusiAWHFzVfSaPTr3UXdaCeItJFVVX6eml
         QgfERbrwjXdQFLVSnI32bMlLMi+c/SRauLCte76Q1x/Lc9TJPP5fVGbq04TyZVsN7bRm
         p5P0BEEWP/82QlrwXcrVxcrEN7AnRz1IXuY5fsE3Gjrcy/cQn+Kp7Nd/3YTu3jYZhJYs
         i5n/kJ1kytRmvCwTOSb98aQimcyVJ2ezhdlyh5RIEiVKAQ5YuvGt/QnHyE/WawPfkCwq
         TKmSoshjhaokChnumLlIbmFvr948xFGtTpI2Yd0s9Mm+RKTxlYauoDPjOcKQtIX0ArZc
         BptA==
X-Gm-Message-State: APjAAAV/B9Yg2tlNJKdVmHODyDSrxtP+Kh/3eJ3BsfXjRoSSO7f9dCXl
        +xzcS9CHQNhx3OVyPl1vFaZq8bAMI94=
X-Google-Smtp-Source: APXvYqxykrtDWgdEmen6lstODEwOJ8NUquZb2lT9grRtLYEmscx0PcGJajpDvRd6ONh6Jg1JC/ndwA==
X-Received: by 2002:a17:902:9888:: with SMTP id s8mr3866609plp.130.1570022917760;
        Wed, 02 Oct 2019 06:28:37 -0700 (PDT)
Received: from SARKAR ([1.186.12.91])
        by smtp.gmail.com with ESMTPSA id q20sm22536358pfl.79.2019.10.02.06.28.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 06:28:37 -0700 (PDT)
Date:   Wed, 2 Oct 2019 18:58:32 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     git@vger.kernel.org
Subject: Re: git checkout with an ambiguous rev
Message-ID: <20191002132832.GD5812@SARKAR>
References: <20191002120213.GB5812@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002120213.GB5812@SARKAR>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 02, 2019 at 05:32:13PM +0530, Rohit Sarkar wrote:
> Hi,
> I was looking into writing a patch for the issue [1] where if an user has
> multiple remotes each with a remote tracking branch of the same name say
> xyz, 'git checkout xyz' fails with "error: pathspec 'xyz' did not match any
> file(s) known to git."
> 
> This can sort of be handled by setting checkout.defaultRemote so that
> the ambiguity is removed. Although when checkout.defaultRemote is not
> set or there are more than 2 remotes I think it would be helpful if git
> gives a message listing out the possible revs instead of the pathspec
> error. What do you guys think?
> 
> [1] : https://public-inbox.org/git/CACcTrKdzVCKUR8EfwhqBQR7vWzRqTLcwRJ_r-hx3VztD=xvNuQ@mail.gmail.com/

Nvm. This was already handled in https://github.com/git/git/commit/ad8d5104b42108851b082d895018655ad5f9e4f3
by Avar

Thanks,
Rohit
