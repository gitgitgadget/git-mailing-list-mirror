Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA021F770
	for <e@80x24.org>; Wed,  2 Jan 2019 16:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfABQqt (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 11:46:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42189 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbfABQqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 11:46:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so31069656wrx.9
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zD/AyCPeh7O8p6MLNQkFCwP/MIgQl7LnEbmZ+Bx4Nls=;
        b=nmxgD6IsFXmQZljvJD19tZV36en748eInpFH5o3bzDc6JjlWRUXSX/++uac8C7CIXE
         DJQ/Y+XDNOKLN3BsLheBskzrGRWTDQB+U7D4qzAXX5SSbPG0ZnDFF02TV5hfM8KMGhNA
         R0u60pXODwSfn6wH6i2elCBRVpBMzlYSc0HZlLqvsj0bm7hJ2qkt1ypDkMBf7anyOcbR
         9oG9yDlR4yjdYHkNLY9zkJ1V9IMdlTuAXplU5M8wsmtPe111dF2AKtsmV0PjPWY6LX1h
         oJ43j+OpCoeZtrl/QJaqupy+GmZcREkjMrVnrac4HliI3NeGeALZnlFeUfSxpkde3p6d
         FzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zD/AyCPeh7O8p6MLNQkFCwP/MIgQl7LnEbmZ+Bx4Nls=;
        b=Jmm1ix9e1RL4dl3mfzA7Gs5ta2AILROe75w94wlOZgFlYZFRrwcjnG7Ta1wfCxjHK5
         b4tnyTrwv/763b0P9LjWBC+BOxwNXLZOYmm7f3n9cCheW44x+4yJwiCJpKZcdH4ltl4F
         7w34fYhDH51E0LX8QIJqAc6ZNHR/NAieryy8ynHpmJ7zJh1tKPoFAw50+Q9qej6ZclHi
         2Bi5FOiGNB6WacymDeFTJYEZ/NWvVLbkmnDNM/TZECsN9cd2G7Oy+llST9yloUZAs9t9
         b6ip45NDrBdvynI+57i3R2me9q59X+6k8vMe7vLmqEZVH0sOsXeqitUKOrL8rsdqkd1U
         xCDg==
X-Gm-Message-State: AJcUukfPLniCT+1W/5TQxoqGRXXHajc3pkAATiIX+hKHV7D7EZyZ/pWp
        bKBUyB5ZdEUO6c7OZyBVZZI=
X-Google-Smtp-Source: ALg8bN5A6ptraNHO4KxSmLgI6zLuyAF4XDr0GnBDehjbifdmORkPabhOy9y2dJysKWcRvG0xNDng/g==
X-Received: by 2002:adf:9542:: with SMTP id 60mr37349197wrs.60.1546447607504;
        Wed, 02 Jan 2019 08:46:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s1sm64837348wro.9.2019.01.02.08.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 08:46:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Max Kirillov <max@max630.net>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] test-lib: check Bash version for '-x' without using shell arrays
References: <20190101231949.8184-1-szeder.dev@gmail.com>
        <a82251fa-38e1-233e-50d3-3ed4850b4e11@kdbg.org>
Date:   Wed, 02 Jan 2019 08:46:46 -0800
In-Reply-To: <a82251fa-38e1-233e-50d3-3ed4850b4e11@kdbg.org> (Johannes Sixt's
        message of "Wed, 2 Jan 2019 01:20:47 +0100")
Message-ID: <xmqqa7kjknwp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Would it perhaps be simpler to just hide the syntax behind eval? Like
>
>  		if test -z "$test_untraceable" || {
>  		     test -n "$BASH_VERSION" && eval '
> 		       test ${BASH_VERSINFO[0]} -gt 4 || {
> 			 test ${BASH_VERSINFO[0]} -eq 4 &&
> 			 test ${BASH_VERSINFO[1]} -ge 1
> 		       }
>  		     '

It indeed is somewhat easier to see that your version does exactly
the same as the original than the posted patch, but the pattern
substitutions are not all that bad, either.
