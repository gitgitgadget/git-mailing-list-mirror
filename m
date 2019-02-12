Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34821F453
	for <e@80x24.org>; Tue, 12 Feb 2019 17:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfBLRwF (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 12:52:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53646 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfBLRwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 12:52:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so3997395wmb.3
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QePWwZpYfDzFRyx1PrMBPAiJqAKfYAV02Pz9jVrKoCI=;
        b=sx9I8ooDwc7zR7NcrvSl2OJnk81XJhHWRMr+oSD0K7/wa//VNpcxIRguir3YAJg8el
         iPAk580UmiH4X1G/GJNqfXhNNGlQsG0Jf0W6ZcmmU7WT1nErvzQX+XkYtHsm1A3FbUj8
         zvylhTVezXjTeO28fM+WsUwiMp4ZARcNL3W73WsEgqWd4HWgZs83tT4eE4OPnSs2/GcU
         SeVMque4mbSGIidshbijsCtrkwk33CX2SbCP/S19pNQ6lSfAe27RoMA3fbIKbcorTnmh
         qkq0qXdlejtwv6rnXouDQEEQkykhf4FFV7PfUe5d/Mywn3ehqH1FLew/9Bit4uKwYyWp
         +Hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QePWwZpYfDzFRyx1PrMBPAiJqAKfYAV02Pz9jVrKoCI=;
        b=qaO//9cUspApyxrTIAopnX+Hl3CeqfbV+vcUWOBX/1gM8Vw/lXkfZAqHgQlPQA8BL7
         yVGyDoxpAVi0gA3wcGClc2FUlgLXdreAytGihVKXM3Hf0JKCf79sziHlXiEmD2PDFam4
         ejnxbQgrRrdEquu6Dj6X9L9M/Cx/7Rh8Cxa8r1cBjMsCYkRmAclST9a53E8bTi/bMhzh
         4pgDbbEED8kBpkpLgpGAKBUcct7kftfs9blaEX3mp5SV8XkUzm5rEgG7JabxbHSITdh0
         RgzHfYV9hc8EwPORwCgQ0to+/O/+mKQ7Qouchc7YqYSR1/VaR7rNTnQP7sqIRGw3Iyb3
         PJ7g==
X-Gm-Message-State: AHQUAuZuD2gQgfW3CHUXs1JV4izRIZGBtuBIfjXsOZXuQVXI4OmThiVM
        2d9gu8wLIN3PfkVcz6DoO3rbO70C
X-Google-Smtp-Source: AHgI3IYOEtVNpGqLWcuGfcqHEgRuH1gOVzejm1xiWZKqPFmYs2xzCh4vHf9SWeILdrdtaUa/h7SKUQ==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr15858wme.115.1549993922902;
        Tue, 12 Feb 2019 09:52:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e67sm5612929wmg.1.2019.02.12.09.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:52:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
        <87sgwtjjbk.fsf@evledraar.gmail.com> <20190212124323.GA11677@ash>
Date:   Tue, 12 Feb 2019 09:52:01 -0800
In-Reply-To: <20190212124323.GA11677@ash> (Duy Nguyen's message of "Tue, 12
        Feb 2019 19:43:23 +0700")
Message-ID: <xmqq8sykevy6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The AIX problem is from d1dd94b308 (Do not print 'dangling' for
> cat-file in case of ambiguity - 2019-01-17). Apparently AIX compiler
> is a bit picky about enum being a strong or weak type. I like this
> compiler. The below patch should do.

That would cascade down the call graph and contaminate everything
(eh, rather, requiring that many places "int" needs to turn into
"enum get_oid_result"), no?  For starters, cache.h still says that
the function would return an "int".

> -- 8< --
> diff --git a/sha1-name.c b/sha1-name.c
> index d1cc77c124..6dda2c16df 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1820,9 +1820,11 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
>  			       prefix, &oid, &oc);
>  }
>  
> -int get_oid_with_context(struct repository *repo, const char *str,
> -			 unsigned flags, struct object_id *oid,
> -			 struct object_context *oc)
> +enum get_oid_result get_oid_with_context(struct repository *repo,
> +					 const char *str,
> +					 unsigned flags,
> +					 struct object_id *oid,
> +					 struct object_context *oc)
>  {
>  	if (flags & GET_OID_FOLLOW_SYMLINKS && flags & GET_OID_ONLY_TO_DIE)
>  		BUG("incompatible flags for get_sha1_with_context");
> -- 8< --
>
>
> [1] https://public-inbox.org/git/xmqqsgwwizf6.fsf@gitster-ct.c.googlers.com/
> --
> Duy
