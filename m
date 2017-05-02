Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D85F207D6
	for <e@80x24.org>; Tue,  2 May 2017 00:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbdEBAaO (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 20:30:14 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36513 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbdEBAaN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 20:30:13 -0400
Received: by mail-pg0-f67.google.com with SMTP id v1so18272265pgv.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 17:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tzC1H8XBOMBBpsMl34Q/x0Xu4Hia+Or+gN9kNbdowgM=;
        b=Shki6ser9Z/XxDZRxhjWiEZsMslnYin8gjhd+yQfXd78qQeVXZhYIGv9nqXL3Kb6gg
         LllpMbw7tmM/AQEfUqMUb4Fj1h/iouyfj3jxAa8RBPTiNgPWwfnXYc17n6Hly/d9XAK0
         dRIZkCBsZbHl18RR5QZF/Ti0SGk7/MxAHs8Kwcg+PwKWnTE3NXQaR/ZLfY7O4kMfyonf
         FC9/mMMFTKzL27xyd+K3UhIQwCpYLciOVKNVP5nZ3F4cYZhXrf9QocwGm0Hu3hPLix8d
         vRUvYea6atfrw+4K9Okh7pqkYPcKojpECJvXi+2duxPzYhfb9uZQjGT9p7fbO6jkId0l
         zWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzC1H8XBOMBBpsMl34Q/x0Xu4Hia+Or+gN9kNbdowgM=;
        b=KJtHc9//Nm7GBsHM8P6LvybEDy/PPtSQYnCBQVB9trIS/8523dlEWJdXA1tdG+5pD4
         Uw93ibtFqsuF/I3/Ty6x9LxLz72scJNubVc9LDxeO1FxenA3EJGjuZ5xFf0c5FBOw3oE
         lQmX6Oivu37Wkjn1CrxOLAPeBdKHS4HWuqcQRvTxU3foFQp2aXl9D56QwGZ35jMr0UT2
         dH8XnV8/jVGhUhkmNW4jndbpxdTaMgHOUvSyhS1tQZBw1uYyXW5LFMl4hQ5Z0dwjISeE
         lJiNsQEwOHBTKoBFwGeEn9A0R+zV+kJtkAVt5JbNWwklRinBBz7CwIlO5VA/DprcfGqi
         fU6g==
X-Gm-Message-State: AN3rC/4zZrB703qRhetgiV1b8iXy/SCdaoN52LZvozVI3kZSd1k13Zr5
        2kpp8HaRHF8qgA==
X-Received: by 10.84.232.197 with SMTP id x5mr36666831plm.85.1493685012585;
        Mon, 01 May 2017 17:30:12 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:1193:d4d9:e46d:aae8])
        by smtp.gmail.com with ESMTPSA id 20sm35012789pfq.42.2017.05.01.17.30.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 17:30:11 -0700 (PDT)
Date:   Mon, 1 May 2017 17:30:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] credential doc: make multiple-helper behavior more
 prominent (Re: [PATCH] clone: handle empty config values in -c)
Message-ID: <20170502003010.GW28740@aiede.svl.corp.google.com>
References: <20170502000515.GU28740@aiede.svl.corp.google.com>
 <20170502000856.GI39135@google.com>
 <20170502002114.GV28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502002114.GV28740@aiede.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting out the reviews:

Jonathan Nieder wrote:

[...]
> configuration item to empty before giving it a new value.  This is
> already documented by the documentation is hard to find ---
                     ^^
s/by/but/

Sorry for the confusion.

[...]
> +++ b/Documentation/gitcredentials.txt
[...]
> @@ -162,6 +152,16 @@ helper::
>  	shell (so, for example, setting this to `foo --option=bar` will execute
>  	`git credential-foo --option=bar` via the shell. See the manual of
>  	specific helpers for examples of their use.
> ++
> +If there are multiple instances of the `credential.helper` configuration
> +variable, each helper will be tried in turn, and may provide a username,
> +password, or nothing. Once Git has acquired both a username and a
> +password, no more helpers will be tried.
> ++
> +If `credential.helper` is configured to the empty string, this resets
> +the helper list to empty (so you may override a helper set by a
> +lower-priority config file by configuring the empty-string helper,

It's not necessarily obvious to a new user what "lower-priority" means.

Since this text is an example, maybe it should say something like "so,
for example, you can override a helper set in /etc/gitconfig by
configuring the empty-string helper followed by whatever set of
helpers you would like in ~/.gitconfig".

That's orthogonal to this patch but it should be straightforward to
roll in if it makes sense.

Thanks,
Jonathan
