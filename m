Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287231F461
	for <e@80x24.org>; Sat, 31 Aug 2019 13:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfHaNRx (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Aug 2019 09:17:53 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:37854 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfHaNRx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Aug 2019 09:17:53 -0400
Received: by mail-ed1-f47.google.com with SMTP id f22so11173641edt.4
        for <git@vger.kernel.org>; Sat, 31 Aug 2019 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3AcImjhgr8bxmyC0Bl9HzvaMa5ipaJ7uFHMJsyaqOAE=;
        b=YVAYny7vvUMXgg3wzjgH79kMCpvvsrnGl/bEp50mNTOb228WYp83IDqfjr5n/YUD7j
         YjqI7UAkwxhyEX339DKN+LETzOqscNg+MG9SMJcUIa1pwRkJTJoerqaLOr4lz40UTMPv
         W7IQVRbRtOS0K+RVxdM/RdbA468kTXaMIbD76rETlO+teZdyIvG18Q13XPOXbaxbg5O3
         FEDJ3/2Cy6kfS0aByuIvjEmdFhb70v2FH0uj+erAVoaxbU27Vbf1wfOk/1BkFL43dyO3
         VsqkjGqTaoHUrYOjLeqT4Ss39+bWhQiVrEUcs4drJnvnHahZeAn/R1ugQDNt2SK0LqbL
         30Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3AcImjhgr8bxmyC0Bl9HzvaMa5ipaJ7uFHMJsyaqOAE=;
        b=JnB91Ex2aVMBkpUFNGRR/KE/QyFgOIf/Av08KEvcjhvTKxouUyXHo0i/VY7Ty/KcvO
         680kER2+ec/WOOqWSYgInUFawv+ZZpDLoq7Pz7Z0kUrKCYld15Zc7C+7kBYUVC+gmtkE
         icj2gUlVB6Yt0QsvPnQFAIqJ18GbDexxkNlFHCti0AXQCpEZBtEUrOzdUKRSwJFzFFlT
         nv8LMBur+lLtpmOdVO62yBnUWro0xMtHYz71jo5cQlD+muo/B9D71Cadt9hiJTprberJ
         3l/o5QhhdroFsXjYtDOEadP9UDe7Q2+BVL+L3yCeOWS7RLxhKQ96PfeSZot352tsXGhv
         zVWA==
X-Gm-Message-State: APjAAAXGYvJa3MwDKKpP6SIfg4pwgZ36jpcVCoSVym8s5AGeJP20O6Zi
        fjbVO0sJ4d58Xfe5D9LRyq7zr/52sKt86A==
X-Google-Smtp-Source: APXvYqyYkzZEgFBGrV9X7vDEDB/H/q75F9CswaK3EJQlmml0oeEhB8dNooEiKLearEpMQIVl5kSqmg==
X-Received: by 2002:aa7:c6ca:: with SMTP id b10mr13887283eds.233.1567257471040;
        Sat, 31 Aug 2019 06:17:51 -0700 (PDT)
Received: from instance-1.europe-west6-a.c.vaulted-journal-250706.internal (169.120.65.34.bc.googleusercontent.com. [34.65.120.169])
        by smtp.gmail.com with ESMTPSA id g3sm1180372ejj.69.2019.08.31.06.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Aug 2019 06:17:50 -0700 (PDT)
Date:   Sat, 31 Aug 2019 13:17:48 +0000
From:   Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190831131748.GA13001@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828145640.GC14432@sigill.intra.peff.net>
 <20190826191455.GA25695@sigill.intra.peff.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 03:14:55PM -0400, Jeff King wrote:
> We'd still want to keep the low-level removal of "<>\n", since those are
> syntactically significant to Git (i.e., if they sneak in you end up with
> a broken commit object).

Would it work to change `strbuf_addstr_without_crud()` such that instead of
removing crud from the beginning and *then* crud from the end, it removes crud
as long as it's palindromic? Then the function proceeds to remove "<>\n" from
the string as before.

That would implement the following _mappings_:

'Foo bar' => Foo bar
Micheal Jr. => Micheal Jr.
Mr. McDonalds => Mr. McDonalds
"John Baz" => John Baz
"JJ\x0a" => JJ

What do you think?
