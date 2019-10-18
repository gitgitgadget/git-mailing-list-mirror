Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DCA51F4C1
	for <e@80x24.org>; Fri, 18 Oct 2019 01:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfJRByv (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 21:54:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37559 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407134AbfJRByu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 21:54:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so3892168qkd.4
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 18:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3auhKvuKP51CazAFw/ZQ6kZs7gPKtasQpSNKpkuAgas=;
        b=aHvukMC+I42J0tLrfVVGW4aXbe5FW8pSPHw72Ppxd9LwjKYhIjpREkZ3QkKj+7bkFd
         gyxo/xKRnfQKKSWJqyFVq8Uzd0yMTLVpWuGV32lRhDX0HkxhpV+KmdBcA5dsXcgZYGON
         os0PdWT4ngsHYsWxRVdw2SjREt+q3UEpxPr70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3auhKvuKP51CazAFw/ZQ6kZs7gPKtasQpSNKpkuAgas=;
        b=QOamsQShGlKV/+InS1SygrqdZOO1BH+EgJKYd/nOSfaruEDWKXULAhMLe3o5z5dNT7
         yyYBaYx6wmCoRa7xCYBfO13xkor25EPXET4BgP5UT2/RtHNM8FduXV+S7/GeEvuTPoQj
         8Lt4faRwLIZDllgTFmEFrGQeb9yGTn/6IV0DfxtCzvLXI9whouMS4N9I1pYsMOlfh475
         fUOHQp5LA+5+P5QVyhmmM9lSVPpi00Jrq9YSyTV9gnATeacUvZBWpTEV+Jvr1F3in6+X
         xgP/hUyVU0FbqhRGmC6P+Pi4xqVVRT/A+PmTiA3gPAWXM9jZWISN84sTuwPdyTSdaGhB
         nGJQ==
X-Gm-Message-State: APjAAAVYiyEOwXNKUAUkiKzD+KSwfTU9VElSsEfJS5X0bBsbgW+hxf/t
        XR7aNCx0LyTdsCnRbdxHZaml8g==
X-Google-Smtp-Source: APXvYqwLLb+h/QZFXCl09cOrHAXP/i2RNRv109OUAZ3gs48s7CJtS8nEhvvJZ7GrtrHTMXpbYxXqAA==
X-Received: by 2002:ae9:ea17:: with SMTP id f23mr6238401qkg.49.1571363689689;
        Thu, 17 Oct 2019 18:54:49 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id v4sm2212270qkj.28.2019.10.17.18.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 18:54:49 -0700 (PDT)
Date:   Thu, 17 Oct 2019 21:54:47 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Greg KH <greg@kroah.com>
Cc:     Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018015447.GB6446@chatter.i7.local>
Mail-Followup-To: Greg KH <greg@kroah.com>,
        Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        Vegard Nossum <vegard.nossum@oracle.com>, workflows@vger.kernel.org,
        Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <20191017204343.GA1132188@kroah.com>
 <20191017204532.GA6446@chatter.i7.local>
 <20191018013029.GA1167832@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191018013029.GA1167832@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 06:30:29PM -0700, Greg KH wrote:
>> It could only possibly work if nobody ever adds their own 
>> "Signed-Off-By" or
>> any other bylines. I expect this is a deal-breaker for most maintainers.
>
>Yeah it is :(
>
>But, if we could just have the signature on the code change, not the
>changelog text, that would help with that issue.

We totally should, and I even mused on how we would do that here:
https://public-inbox.org/git/20190910121324.GA6867@pure.paranoia.local/

However, since git's PGP signatures are made for the content in the 
actual commit record (tree hash, parent, author, commit message, etc), 
the only way we could preserve them between the email and the git tree 
is if we never modify any of that data. The SOB and other trailers would 
have to only be applied to the merge commit, or migrate into commit 
notes.

-K
