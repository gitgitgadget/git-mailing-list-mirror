Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020F71F403
	for <e@80x24.org>; Tue, 12 Jun 2018 18:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeFLSQ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 14:16:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34274 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754070AbeFLSQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 14:16:27 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so14834841plq.1
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CC4fqdjnJdR0OerFlEqCqwIM/qYc+RyxgVJ1yIy8hQc=;
        b=L+ArACNI3hv4mUDXQQfDkr6MZ8c9IKGHxeYLJdAHeP4Ix2XuLcD/xOa/vPQX8Ax4EU
         r6x7ATZbfcVBGDFW/501nnOmya6dXjK1sUwDAewARvPy8ko0sLFnv44QrhDgbwLSbp7l
         pHhMTASOXzHcfVgjaCcQ/QBcZFIRQa/hftmibeJbbTB7qSzlDEBef/7QorMf09yoXdBi
         kCGCvsbP1+JFJ1QZzGo/9tI5iowGqptC5DU7Udai42sEtozY37QTp/aE9eHjbYEg/V38
         nTX/YNuD06h0EaGgX9CeehBY27+dU7sMRYGFivmYoMvH7arVdjBNJPc5/wl07JvCqYAh
         0s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CC4fqdjnJdR0OerFlEqCqwIM/qYc+RyxgVJ1yIy8hQc=;
        b=rz2cz2N09JRsqbDSwJeb/zBI9Ra29Ef54nnFtsSsRRGt/lY8CzZlE2dGFyH+IWyX2j
         aGZnb507MjNttm616BhlswgNynNntXbzXUhrsH3uSRC8v/TLn4GucWysrXgnv+gfN8wd
         jUBNGLWE2Vs2Z+rTjGZDvzz+83cQd6k0Whem1kfPNVaNInRukfV6wJ4s070o0DjtpPSN
         LJnn5r7qprsGt2JemvqxLkDSkNoln8hktH+UDr38vAkN4xG6zkN456ALtmzT+aZVVb3R
         C0tCKFLyrCMstKHvw/PNYQ4Ir9JJjccryXmvLQFaIYakv3NdeqH2snN7pe6oRofiaoR+
         iMmQ==
X-Gm-Message-State: APt69E0UG+flwL0sVxvxT3AdAV3AldqCfnUVBsY6fppcqDaq5qXPafmC
        REYg5eflmtZmLEF3WnZhXwI=
X-Google-Smtp-Source: ADUXVKJcSwt5OqSLpAHprFFmcR1Yqk8PXRX623RaCjGb/px/V/x9l7U8KjbOIhLOa7SUSakZJiUSxQ==
X-Received: by 2002:a17:902:b40f:: with SMTP id x15-v6mr1599573plr.270.1528827386445;
        Tue, 12 Jun 2018 11:16:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v5-v6sm1547993pfd.1.2018.06.12.11.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 11:16:26 -0700 (PDT)
Date:   Tue, 12 Jun 2018 11:16:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/send-pack: populate the default configs
Message-ID: <20180612181624.GB28554@aiede.svl.corp.google.com>
References: <20180612172623.165420-1-masayasuzuki@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612172623.165420-1-masayasuzuki@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Masaya Suzuki wrote:

> builtin/send-pack didn't call git_default_config, and because of this
> git push --signed didn't respect the username and email in gitconfig in
> the HTTP transport.
>
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---
>  builtin/send-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Do you have a set of commands I can run to reproduce this?  Bonus
points if they're in the form of a patch to t/, but commands I can
manually run would be fine, too.

> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -121,7 +121,7 @@ static int send_pack_config(const char *k, const char *v, void *cb)
>  			}
>  		}
>  	}
> -	return 0;
> +	return git_default_config(k, v, cb);

send-pack is not a command served by a daemon so this is less
potentially scary than the corresponding potential change to
upload-pack or receive-pack.  Some configuration this brings in:

- core.askpass: allows specifying an arbitrary command to use to
  ask for a password.  Respecting this setting should be very useful,
  even if it would be scary in a daemon.

- core.pager: allows specifying an arbitrary command to use as a
  pager, if pagination is on (but it shouldn't be on).
- core.logallrefupdates: whether to create reflogs for new refs
  (including new remote-tracking refs). Good.
- core.abbrev: what length of abbreviations to use when printing
  abbreviated object ids (good).
- core.compression, core.packedgitwindowsize, etc: pack generation
  tunables (good).
- advice.*: would allow us to make "git push" produce configurable
  advice (good!)
- etc

So it looks like a very good change.  Thanks for writing it.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
