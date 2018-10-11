Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E1C1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeJLG0V (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:26:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39755 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeJLG0U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:26:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id d15-v6so9784353edq.6
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QTyOO87d1Dk5vPC3CxF7w30HxEjVBZKG1vOfLqv1pXg=;
        b=kBr5ZTg+XaxnGWZMVp9+reUb4M5fUfz+7Tkv4VFYVh+GxbrwkJRaP6FyKMdGIU0VVo
         5F0Vbkm8u6wACkVTalWtmqGwQX6hmvqUtfs/MU/9JBnn4xSulDNlKLzvQr1ecg0nah8w
         5u0OfiLN8h3/oHVc9Y6LeGDIkdJ+uE+KcgNs/ebc4ESULyeptR3aJR8N55HT/jQ0iEnS
         SN7WoJx6UzP3eJqiMJQhS+tDMnD3wL4pi9z4eLQWjozl9E9WMTycRixR+v3iDDFqKUcd
         Zz7c7aI5t5tdMYikb88i307StaXzLDpKYPHN5ZtOQnXsKhzffB+QGaekqzNkBnpdf6KO
         MiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QTyOO87d1Dk5vPC3CxF7w30HxEjVBZKG1vOfLqv1pXg=;
        b=egvGzjGbnykqjq5YszYz4hGcWzUBb5r3JE1B9+lTifW78MSoyk3hMD2PJ5gPq3CyMX
         ZVnT16tLgbs4YVBNYmcl9EKHMrNwarojwnFi1HQ84mSAoY2UmSTj25Xa3bOAjHVmJBEM
         Bjx7DcQi38RNam6esmyuLuFxKmIl6Y6Mkme862xK/4qOuq9dfYlO6PPMeoVWvIRUiPXb
         X0wyAhWDZe6aN0BT0lbn7zUNskVnkfijBg4LuxAWHQ+JGgf1xYOMHFxTZXV0fx/dhfTs
         +NmK93ZRcZQQSdaHQLye4ZI+heOwfL+sCxFPhLlUiYdqPvBelKtSY2BMltANNyuA9T5Q
         jA3w==
X-Gm-Message-State: ABuFfogStSCcnZx2deUz30wvVA6rL+/G7ePeL2ux/qUoJoDAJ4CKMBIO
        CzBkjAfNJgkXIwg78j8FTN2Yq1ck
X-Google-Smtp-Source: ACcGV61gLKT6vnREFPWzHZcPJIT9cJ+MBZFBxNzzO1ewdlr+VFgqUM1UArr5D7X+o6+VN4B6XK3b3Q==
X-Received: by 2002:a50:94d2:: with SMTP id t18-v6mr5549965eda.86.1539298614521;
        Thu, 11 Oct 2018 15:56:54 -0700 (PDT)
Received: from szeder.dev (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id i1-v6sm1385327edg.3.2018.10.11.15.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 15:56:53 -0700 (PDT)
Date:   Fri, 12 Oct 2018 00:56:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
Message-ID: <20181011225652.GD19800@szeder.dev>
References: <20181010205432.11990-1-daniels@umanovskis.se>
 <20181010205432.11990-2-daniels@umanovskis.se>
 <20181011225326.GC19800@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181011225326.GC19800@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 12:53:26AM +0200, SZEDER Gábor wrote:
> On Wed, Oct 10, 2018 at 10:54:32PM +0200, Daniels Umanovskis wrote:
> 
> [...]
> 
> > diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> > index ee6787614..e9bc3b05f 100755
> > --- a/t/t3203-branch-output.sh
> > +++ b/t/t3203-branch-output.sh
> > @@ -100,6 +100,47 @@ test_expect_success 'git branch -v pattern does not show branch summaries' '
> >  	test_must_fail git branch -v branch*
> >  '
> >  
> > +test_expect_success 'git branch `--show-current` shows current branch' '
> > +	cat >expect <<-\EOF &&
> > +	branch-two
> > +	EOF
> > +	git checkout branch-two &&
> 
> Up to this point everything talked about '--show-current' ...
> 
> > +	git branch --current >actual &&
> 
> ... but here and in all the following tests you run
> 
>   git branch --current
> 
> which then fails with "error: unknown option `current'"

Ah, OK, just noticed v3 which has already fixed this.

