Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC72E1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 16:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdJXQNc (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 12:13:32 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:53847 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdJXQN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 12:13:29 -0400
Received: by mail-qk0-f193.google.com with SMTP id y23so26922908qkb.10
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j+y32hojn1r47Xzq0tA+kIu0YXzQvSswl1koidXFA9c=;
        b=tQinznQw8GfKl/FQtIjBBQ6v6DbQn7DiuMOpuxtSH/yfK+HJyfYgzojangwk2fiH5/
         aTlmlWpF1bevonTz/ShjrFRZvgOTN3EKZIJCunC6OMVXquujvQHU2Gj4eQ3N7XpUlB0h
         zSG0vWjHNVxgevlVBhS6si89IzpjoyVHuu4J9NUYL/Hvf15FbU1wx1gXJ7PLtlwWRvuL
         MyYa+gUCLjui25syNO1UF3XqDyZaArsHuUd/yNrCmjNgvqnfmDt0nEZcd0LmQZeMgdbe
         /rji33ePdoBtTxcVY0cQqfenhrs6pTjr4WNF+I1EdfvVUY5yCeGd1a4afzvQAGRq+Y0L
         lMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j+y32hojn1r47Xzq0tA+kIu0YXzQvSswl1koidXFA9c=;
        b=KoRHqOyzQ9dFUJMI8VsbbI9xiDojF1X5OugNVjsye1y/zuNGneZex62f3mdM4NwaKn
         D4PP8sP3ZBQd17ZI7l6nAAm+bOe9i1ce8zPO3fIxeX+ePdqUjl10EAWnpeVgMBrVFs01
         VhELuSMM9tyITmad0s2gFvHpD5eEtWKi3kNfYNl1BienIXgcaDrwqpKKSoAT3SL2a+CM
         0O5QeYytRiOSdYW0+xFAGyEdCFBOFqR3Dm+3qlF8XEnegQzeEwGgM+8ndj5vdy9WCvBa
         3R8KnfpN/3T0yVQAr9nX0IvQF4/VP2z6BydN4KnuYBCZo+nK428rNi+jSBeAjrA4h0P2
         H3ag==
X-Gm-Message-State: AMCzsaXo+yz6zLkRC4Lfx8fLSyAafq34keEXKasWyQNlHHYs5XrbTO4b
        92vVcpxhY4e1u+FKSmIMgrqhjzvdUDN89eV9igE0JMcfJos=
X-Google-Smtp-Source: ABhQp+SvSeQM55XFHjI72CHX9xH14J4mwuA0GHIgPpl3z7SNa4xv3XoPMrxNzbfedILeI25YIq/BclfCYaN5/zS+rBE=
X-Received: by 10.55.125.196 with SMTP id y187mr25922843qkc.180.1508861608517;
 Tue, 24 Oct 2017 09:13:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 24 Oct 2017 09:13:28 -0700 (PDT)
In-Reply-To: <e63c2208-900e-138a-a13c-fecf9403e0b8@samsung.com>
References: <CGME20171024151508epcas2p4d9455e93e2e19bfb118b485d4ce14922@epcas2p4.samsung.com>
 <e63c2208-900e-138a-a13c-fecf9403e0b8@samsung.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Oct 2017 09:13:28 -0700
Message-ID: <CAGZ79kZM_hVi8BeTmL5u_QK5+=1g3gcPsccEe1AJVpDLUWz_9Q@mail.gmail.com>
Subject: Re: [PATCH] path: use xmalloc in add_to_trie
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <dturner@twopensource.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 8:15 AM, Andrey Okoshkin <a.okoshkin@samsung.com> wrote:
> Add usage of xmalloc() instead of malloc() in add_to_trie() as xmalloc wraps
> and checks memory allocation result.
>
> Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
> ---
> Hello,
> I'm not sure but it looks like there is a missing check of the malloc result.
> memcpy() may crash with SIGSEGV due to the memory allocation failure.
> make_trie_node() uses xmalloc() and xcalloc() - so I believe add_to_trie()
> also should use it.

Good catch! Thanks for spotting.

Trying to find similar occurrences via git grep "= malloc" did not
yield other places that need the same fix.

Thanks,
Stefan
