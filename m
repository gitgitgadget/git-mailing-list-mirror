Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF2820D11
	for <e@80x24.org>; Fri,  2 Jun 2017 01:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdFBB0g (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 21:26:36 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34425 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFBB0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 21:26:35 -0400
Received: by mail-pf0-f177.google.com with SMTP id 9so42040542pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 18:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s+xgzcp7JQTJAhhAfzinP+dcmyPihfBR1wRP9HRTVG4=;
        b=TlEBg1EzOUsngSQnKuWcLJhLUOlfDh6l/RNG3xNhXXIZ65Vswp+CQHIg36cl7+NNgo
         tcpOm4gRvIRJwX6MOFqEtqG/XFewJGKs3EwyXl/nRAG3JATDWNqEMV5U90jTtIBiqCXr
         B/hOc7XeFdnD2TDxEQA2LCHHogyaGK0ecjrcePHmu1EQ6rlaxWwE0wS37qf9dH8oy1c2
         R5A4INQS95FxA9aPVJtGHG1GufKyxdG9KU5DLri5Lsd43zw6cb/eNjXRtT7a7d6Y5EyG
         P2AZ8L8URRdJt8FzvKzDxuBp++SCjUKiPs5NurbMPx1fh2DA9gOly4QRfnTZaVN3Bm6r
         rvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s+xgzcp7JQTJAhhAfzinP+dcmyPihfBR1wRP9HRTVG4=;
        b=dWk7jfy//PpFDtqJUYren4SjVbgJJZ5NubETxE6P7ubvbPGwqRB8H5X87gvhxrU2oP
         H+Jk1Cxpu9mfMywdzcBP+ch1jsTZb6QdFCRgECXKebdvf/go9+rthsgO5bZqVqr6SwPY
         0gjb3YYe7Xbc4BqAhXlrAeMTSQmtVRQmByWKKJiVS+Gf7PM7nnz1T1RSOneX3qMYRnGA
         3FzOFuiEnztGFMJqsfViXZfMwSsYwvxrVhGeU96Zq8NPQH2MyQJ/xDZ6HA1rJwus0sbr
         MOJs79v7oiyLsrwKrpaAXkdAoc1dvyHiOJyzb1Kou9y9gDywNDlzUEI5MsP9NW+5vzOb
         hUig==
X-Gm-Message-State: AODbwcAKf89ezYvEvDJ40QwITIFuYtngKG2DgWxGnKbKlbcZWy2ghKjy
        9hr7jWT7klQbmQ==
X-Received: by 10.84.217.70 with SMTP id e6mr13047077plj.130.1496366794966;
        Thu, 01 Jun 2017 18:26:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id v64sm38203629pfk.86.2017.06.01.18.26.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 18:26:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 28/33] builtin/diff-tree: cleanup references to sha1
References: <20170530173109.54904-1-bmwill@google.com>
        <20170530173109.54904-29-bmwill@google.com>
Date:   Fri, 02 Jun 2017 10:26:33 +0900
In-Reply-To: <20170530173109.54904-29-bmwill@google.com> (Brandon Williams's
        message of "Tue, 30 May 2017 10:31:04 -0700")
Message-ID: <xmqqd1an2n92.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> @@ -132,15 +131,14 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>  	 * reverse the order of the objects if the second one
>  	 * is marked UNINTERESTING.
>  	 */
> -	nr_sha1 = opt->pending.nr;
> -	switch (nr_sha1) {
> +	switch (opt->pending.nr) {

Unrelated to the topic of this patch, but I notice that the comment
whose tail shows in the pre-context of this hunk is incorrect.

  We expect "a..b" to expand to "^a b" but it is perfectly possible
  for revision range parser to produce "b ^a", which means the same
  thing.  We we get the latter, i.e. the second one is marked
  UNINTERESTING, we recover the original "a..b" by swapping the
  order.

is probably what we wanted to say.  These days, I suspect that we
may be able to do a lot better by using rev_cmdline_info thing,
which did not exist when this code was written.

