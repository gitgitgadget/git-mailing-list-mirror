Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A9320958
	for <e@80x24.org>; Wed, 29 Mar 2017 18:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbdC2Ssi (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 14:48:38 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32979 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbdC2Ssg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 14:48:36 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so3941867pgf.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=StPinz83E2XIAialG0/oGHyA1cgi0Rr0JVQLDI9bWkI=;
        b=VWAGdbc/u8ivfVcH6GQPA57OuVQyoDrnAc6VPsx05Zt5TuP9pqAQFKifDOZgFBXCrJ
         whRJOSIw54zoRnRphCZO5irqnIlsf7Au8ykzNUzSpqm56UfDGKz+xbiVYVCcve0pI6VM
         V7zmL3yl9zqhZQR1qQOlJo236QO/Cffr34i8XQWnozQvyH9k74adYC88M0fVna1lKHOq
         jZEfjRyI2wBoObRJnyf70tHnTHRz5W4R+dde27ybK0c3eHW+7rIFxXVAGZcx3lkUvW3F
         j92bZe/F+AEZO2FWFOU/2hBIemzHVCnGa8F4ShCD0M+W1n32np8n/GijkVxZKH6DKWDt
         PtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=StPinz83E2XIAialG0/oGHyA1cgi0Rr0JVQLDI9bWkI=;
        b=lkGQAgIIDoU67j+l58JD5DdRjptlgBYhDqgd0eSHg/LohoIUvXIWT5xOpuQQ7EqTu9
         YT++IWxtE7yUPLaw6vjlZdOnMX7s6vFlnTQlqoXtjPqaoGEEleyRuZXbQracC0YrinyR
         str98/U38Y8+b9nr4iAWuAzh6cDsbKN6q+dV8Y7VH6RjSfSxjxzn5GL2tb8uemA99ijA
         8MTHc+O7XeeP1pbhzVPzE+i/Rt7TrMfXFyrcZE2zpUBuZvnp+XUYqYIXxcUuLXMWYOu0
         JlSgT0SfC1VKHQy54mCKP3N3gKDCB1faNYbiRWpjh5ZCvjb7VPIs2QCD10HFYHAONwkK
         u34Q==
X-Gm-Message-State: AFeK/H15S/gpfJkjON3EZN6sidw10Hbk4KqflYj6SGvRWbib8rFw7Q21YP0kZQA7vt/Emw==
X-Received: by 10.99.94.71 with SMTP id s68mr1969988pgb.181.1490813315486;
        Wed, 29 Mar 2017 11:48:35 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:1cae:64a4:6d7e:ad6f])
        by smtp.gmail.com with ESMTPSA id c19sm14934972pfd.85.2017.03.29.11.48.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 11:48:34 -0700 (PDT)
Date:   Wed, 29 Mar 2017 11:48:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] unpack-trees.c: align submodule error message to the
 other error messages
Message-ID: <20170329184833.GX31294@aiede.mtv.corp.google.com>
References: <20170329183743.27506-1-sbeller@google.com>
 <20170329183743.27506-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170329183743.27506-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> As the place holder in the error message is for multiple submodules,
> we don't want to encapsulate the string place holder in single quotes.

Makes sense.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  unpack-trees.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8333da2cc9..9f386cc174 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -167,7 +167,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>  	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
>  		_("The following working tree files would be removed by sparse checkout update:\n%s");
>  	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
> -		_("Submodule '%s' cannot checkout new HEAD");
> +		_("The following submodules cannot checkout a new HEAD:\n%s");

Nitpicking about wording: unless the user has adopted a strongly
object-oriented point of view, it is Git that cannot checkout a new
HEAD, not the submodule.

How about:

		_("Cannot update submodule:\n%s")

That's vague, but if I understand correctly the way this error gets
used is equally vague --- i.e., a clearer message would involve
finer-grained error codes.

Thanks,
Jonathan
