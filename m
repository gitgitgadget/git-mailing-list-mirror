Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF62F1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbdFVThL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:37:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34155 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbdFVThK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:37:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id d5so4369231pfe.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F6eqUF3/vZI1pvlFWsRSiWEPq6qQTpmbyCshBaIenWs=;
        b=uHbSFwLo1nIS9zG8ql2RtM41ttO4e+S6/a/hcd8PBbyAlIRka5/oPQJJlhF+NLMsRM
         IhiuOCNR0I94bSl2HtzIcPiYPa4+PNS8gkZfk8774JcQe496mbAmBOcZ9OdbCi00erhE
         MzUEIR1M4kD85xxKTNwNaQqgmkptpwYLVjqWMgtqlGv38/znUpbewlDFtFyAO5QhT8id
         nfMb30UEwA/Ax5+d0rEuCaMOoa7IFCeOps7Rgj24gQBYwjaCc7zBLYmZOCE25jZua7/N
         SMzDlrWFq9P+DKB/bDYOxJFvzd4pOmcIozKjsd4gDfGFBojqVz3cs+evpphdocAB1mts
         l0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F6eqUF3/vZI1pvlFWsRSiWEPq6qQTpmbyCshBaIenWs=;
        b=LEYr9Y0a0l5VXktvfv+qI7hn4INlX7QAxoI08eRoEJYaHmBAa+4Pw8BVJBNYDZgCMg
         OOvQtwMnI0qFfNomfglITYdUwHtGpPNzu9nlbCvy7xZzWGI6q4IP126t9grYZeE+JDv9
         40h2EP+J79N6h1+YOaneYUreHc5Ix/eT2/uiIqfkFeWWU9MuVs0N7ZqG4pkIAhgzpw6I
         w5UqACZn7MukyVJ/ZNXl0l93UXKANh0VL8E+COn0QkAvnlUn2mz2p8gZf6QMcB1vqHvb
         etvYKpJhydsviO9lo2psDfRX13lm/cEz1RX7r9YEyzbyfJDaqxiJbpTqAXE0Ar754ZQ4
         XjCw==
X-Gm-Message-State: AKS2vOyoxM4ZHtnXX9twk2zjErort/C88hV2vVMrYgGMJC+6k4V82/Ij
        j4sI5Uqq13k7fA==
X-Received: by 10.84.138.131 with SMTP id 3mr4806583plp.24.1498160229820;
        Thu, 22 Jun 2017 12:37:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id x88sm5956908pff.123.2017.06.22.12.37.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:37:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/5] Git::unquote_path() throw an exception on bad path
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
        <20170622102622.26147-4-phillip.wood@talktalk.net>
Date:   Thu, 22 Jun 2017 12:37:08 -0700
In-Reply-To: <20170622102622.26147-4-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Thu, 22 Jun 2017 11:26:20 +0100")
Message-ID: <xmqqh8z7ke57.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This is what the other routines in Git.pm do if there's an error.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  perl/Git.pm | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 889bf88cfcd34136e24e166fb3b72cced6debf9d..51cb3446088dd12e8fd93d47b95e29fab22a8466 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1493,8 +1493,8 @@ when not using -z
>  					$_ = $2;
>  					last;
>  				}
> -				# This is malformed -- just return it as-is for now.
> -				return $_[0];
> +				# This is malformed
> +				throw Error::Simple("Invalid quoted path $_[0]");
>  			}

Output from "git grep Error::Simple" tells me that mostly we do not
upcase the first word of the error message.  Perhaps this should
follow the convention.

It is a different matter that use of Error::Simple has been
discouraged for quite some time (e.g. *1*) and we haven't been got
around doing that.  When the clean-up happens, this code will have
to be migrated to a different mechanism together with 30+ existing
uses of it; in the scope of this series, throwing of Error::Simple 
is consistent with the remainder of Git.pm and is a good thing.

[References]

*1* https://public-inbox.org/git/1330809281-25774-1-git-send-email-jnareb@gmail.com/
