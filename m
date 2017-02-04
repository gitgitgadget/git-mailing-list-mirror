Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A079D1FAFC
	for <e@80x24.org>; Sat,  4 Feb 2017 05:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753673AbdBDFCv (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 00:02:51 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33702 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753637AbdBDFCu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 00:02:50 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so2887576pfg.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 21:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fKCfjfp5MvwCwMqsvTCypaD6WqlXwWF73s62TZxaOsE=;
        b=XcW8YlYv6AaY43DTRHdrR680+R+DQ607vm3+oLV/WCNQc0vDmYZow1VgjKCExdwpNN
         cSckEu+MVJZLsn0C+PYyr2d4UrieEOrOOu/fHnFxNvElA6PE7fjx38fFBH6l75Oo3+Vp
         EfQ0guotfgPxVBSEtyQCOH/DzGWL0FBH+muWvSX6DhTuJoGU5yXWQEWhJ3BvOLbezexY
         Kncy67FsYbLRh70Ldk2hEifjatnxRkqTU5c3+JxkN26mRvOMXwYgKOBxY7TGA13iX4tw
         oeCna6iFigJzYQbmdWUXI8PyCz0fTbeJyj3rbUK7b7/rAWTFBvqtFHk1LU03LA4L+Amu
         i0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fKCfjfp5MvwCwMqsvTCypaD6WqlXwWF73s62TZxaOsE=;
        b=Sc8eghuMIoHMFRD+o3WuWmJc4/X+AjxNO+yQTOfXFNiQQW0CSIPwNaPCn2QbTXqnnf
         cAT1eQbMLmLowckuMuS0rlI6RV5eMqj/oc8kcn+KwTBey0mAtY/PamUPUAkUmZfygtGW
         duwyQUpR7hpPbVgAd+ZetSEEdRH/Ro3zdSl1TGMjP3/R0hhaA2dBvl6Mc+yvQNzDgK2V
         VLEX23WsM7sp08I3kLaxwngT/1QXAmxFb5fMoU1O9ExHYs9+kaKlsd8INKbVFoXK0NAJ
         7G3F1k9Ba1NzJJfVlf0GkzjYHC9LfZpv3YFFKRdT9IS1TCeMJ0ZOJqSxZuFpQF2FhyYi
         bzWw==
X-Gm-Message-State: AIkVDXI7fOe+lv0foZ/XxryMQgYrtGkarHhc7rEUBt7yHhTjuK4lgPTHEJ/GKNvdnNX7xg==
X-Received: by 10.99.36.7 with SMTP id k7mr705199pgk.201.1486184569668;
        Fri, 03 Feb 2017 21:02:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id c204sm70892164pfb.51.2017.02.03.21.02.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 21:02:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tag: add a config option for setting --annotate by default
References: <20170204021402.15927-1-davvid@gmail.com>
Date:   Fri, 03 Feb 2017 21:02:47 -0800
In-Reply-To: <20170204021402.15927-1-davvid@gmail.com> (David Aguilar's
        message of "Fri, 3 Feb 2017 18:14:02 -0800")
Message-ID: <xmqqlgtm8s5k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Make it easier for users to remember to annotate their tags.
> Allow setting the default value for "--annotate" via the "tag.annotate"
> configuration variable.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

I do not care too strongly about this, but I need to point out that
this will have fallout to tools and scripts.  E.g. if you have this
configured and try to create a new tag in gitk, wouldn't this part

	if {$msg != {}} {
	    exec git tag -a -m $msg $tag $id
	} else {
	    exec git tag $tag $id
	}

try to open an editor somehow to get the message even when $msg is
an empty string?  I think the same problem already exists for the
tag.forceSignAnnotated variable we already have added, though.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index af2ae4cc02..0d562b97e9 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2945,6 +2945,11 @@ submodule.alternateErrorStrategy
>  	as computed via `submodule.alternateLocation`. Possible values are
>  	`ignore`, `info`, `die`. Default is `die`.
>  
> +tag.annotate::
> +	A boolean to specify whether annotated tags should be created by
> +	default.  If `--no-annotate` is specified on the command line,
> +	it takes precedence over this option.
> +
>  tag.forceSignAnnotated::
>  	A boolean to specify whether annotated tags created should be GPG signed.
>  	If `--annotate` is specified on the command line, it takes
