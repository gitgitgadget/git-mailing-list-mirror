Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9F11F42D
	for <e@80x24.org>; Tue, 15 May 2018 08:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeEOIjZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 04:39:25 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40126 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeEOIjX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 04:39:23 -0400
Received: by mail-wm0-f52.google.com with SMTP id j5-v6so19920228wme.5
        for <git@vger.kernel.org>; Tue, 15 May 2018 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+HuA7TXP4pgrOuC/dk/c3EcfTAvHZPaLFvkWrc7Lw0M=;
        b=KqPI/91n2aHMg19ndxLNnlL5Qd3K63vIv+Imc88ip1GK9ge71sex/cJRrsJM6mBmSN
         DjcxXlJ4Nl1U2nr0ApVKAhsQ8t4nQ2HaIKr8RkjhB5Y1OFL5jc69dtn8AsUp0u2IbWvG
         472bF05+iRJKLE+xkTw5uIo13HNpz7+PEn0KyRyhzJUHYVwsDB7AKKsopUzRImXnaVBi
         g20I/6XtQDy/S9QjnM0TEFFh6oBtI7JRrFSnryS2fUIxQJulBgNAtNtezoAwSf4T4Ljr
         A4Ix984UaXNPoddEGvvWS4CFzr768KwjmNbpt+lesAyDyM9I6tuzCBcpqDX7NAd51J0o
         iFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+HuA7TXP4pgrOuC/dk/c3EcfTAvHZPaLFvkWrc7Lw0M=;
        b=A0IOTywTKa5RcMbf8UfgoSTfEZXYaxx8RILR+mznPVqJF1Ks+MsQgOvshqHP7Ru/jM
         2kCWv4+t8QYiQypPvJI7Z5tViVkc6Cv7V259V1mPaRD+ObW7dFnrrufzAvK+w32HQTBF
         Pw+bQagI2DQmChxC4XGz+xY3Yb1g7++kvHb7cuQId+bHfmoP8aFJwKWt0WC/yw/QYBph
         h6zxRZRiGlvuYGhYdHFbRAvgJ1dWzso1q6fX/Vc4oguIZEdx0H3sGI0pOQPrztTnG7sh
         +C/W+I+zX/BKwiH2vklXWtB1RjzftLWNS5V6FRLhNe0K8PwBHMm1MdyuVQwy9xDXZI/C
         5IaA==
X-Gm-Message-State: ALKqPwe14ipFEEah+rpb09LCMNjNOQhs3eG4zONY5z2g1/S4PrNyCGXj
        ifRmyFFfz0DnOxCf1yb/MdzShNf3
X-Google-Smtp-Source: AB8JxZoDwfPBI7A/NJwknCT0ceIVHQAltx+eh3ijHhnX7+OtVCHdqjoxsV7mZpCde2uSzh/uM7K0DQ==
X-Received: by 2002:a50:c252:: with SMTP id t18-v6mr16659655edf.135.1526373562024;
        Tue, 15 May 2018 01:39:22 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id c15-v6sm5760207edr.78.2018.05.15.01.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 01:39:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/35] refactoring refspecs
References: <20180514215626.164960-1-bmwill@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180514215626.164960-1-bmwill@google.com>
Date:   Tue, 15 May 2018 10:39:20 +0200
Message-ID: <87h8n92tzb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 14 2018, Brandon Williams wrote:

> When working on protocol v2 I noticed that working with refspecs was a
> little difficult because of the various api's that existed.  Some
> functions expected an array of "const char *" while others expected an
> array of "struct refspec".  In all cases a length parameter needed to be
> passed as a parameter as well.  This makes working with refspecs a
> little challenging because of the different expectations different parts
> of the code base have.
>
> This series refactors how refspecs are handled through out the code base
> by renaming the existing struct refspec to refspec_item and introducing
> a new 'struct refspec' which is a container of refspec_items, much like
> how a pathspec contains pathspec_items.  This simplifies many callers
> and makes handling pathspecs a bit easier.

This looks really good to me. The API you're replacing is one of the
worst I've had a chance to encounter in git.git (as noted in my
https://public-inbox.org/git/87in7p2ucb.fsf@evledraar.gmail.com/ but
maybe I haven't looked widely enough), and now it's really nice.

> I have some follow on work which I'll build on top of this series, but
> since this was already getting a bit lengthy at 35 patches I'll save
> that for another time.

In addition to my other suggestions for stuff to put on top, which I see
now you may have just had in your local tree but didn't submit, I think
this makes sense:

    diff --git a/remote.c b/remote.c
    index 946b95d18d..cb97e662e8 100644
    --- a/remote.c
    +++ b/remote.c
    @@ -77,16 +77,6 @@ static const char *alias_url(const char *url, struct rewrites *r)
     	return xstrfmt("%s%s", r->rewrite[longest_i]->base, url + longest->len);
     }

    -static void add_push_refspec(struct remote *remote, const char *ref)
    -{
    -	refspec_append(&remote->push, ref);
    -}
    -
    -static void add_fetch_refspec(struct remote *remote, const char *ref)
    -{
    -	refspec_append(&remote->fetch, ref);
    -}
    -
     static void add_url(struct remote *remote, const char *url)
     {
     	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
    @@ -261,9 +251,9 @@ static void read_remotes_file(struct remote *remote)
     		if (skip_prefix(buf.buf, "URL:", &v))
     			add_url_alias(remote, xstrdup(skip_spaces(v)));
     		else if (skip_prefix(buf.buf, "Push:", &v))
    -			add_push_refspec(remote, xstrdup(skip_spaces(v)));
    +			refspec_append(&remote->push, xstrdup(skip_spaces(v)));
     		else if (skip_prefix(buf.buf, "Pull:", &v))
    -			add_fetch_refspec(remote, xstrdup(skip_spaces(v)));
    +			refspec_append(&remote->fetch, xstrdup(skip_spaces(v)));
     	}
     	strbuf_release(&buf);
     	fclose(f);
    @@ -302,14 +292,14 @@ static void read_branches_file(struct remote *remote)
     		frag = "master";

     	add_url_alias(remote, strbuf_detach(&buf, NULL));
    -	add_fetch_refspec(remote, xstrfmt("refs/heads/%s:refs/heads/%s",
    -					  frag, remote->name));
    +	refspec_append(&remote->fetch, xstrfmt("refs/heads/%s:refs/heads/%s",
    +					       frag, remote->name));

     	/*
     	 * Cogito compatible push: push current HEAD to remote #branch
     	 * (master if missing)
     	 */
    -	add_push_refspec(remote, xstrfmt("HEAD:refs/heads/%s", frag));
    +	refspec_append(&remote->push, xstrfmt("HEAD:refs/heads/%s", frag));
     	remote->fetch_tags = 1; /* always auto-follow */
     }

    @@ -395,12 +385,12 @@ static int handle_config(const char *key, const char *value, void *cb)
     		const char *v;
     		if (git_config_string(&v, key, value))
     			return -1;
    -		add_push_refspec(remote, v);
    +		refspec_append(&remote->push, v);
     	} else if (!strcmp(subkey, "fetch")) {
     		const char *v;
     		if (git_config_string(&v, key, value))
     			return -1;
    -		add_fetch_refspec(remote, v);
    +		refspec_append(&remote->fetch, v);
     	} else if (!strcmp(subkey, "receivepack")) {
     		const char *v;
     		if (git_config_string(&v, key, value))

I.e. the reason we have add_{push,fetch}_refspec() in the first place is
because without your series it's tricky to add new ones, but now it's
trivial, so let's not leave behind wrapper static functions whose sole
purpose is to just call another exported API as-is.

I've pushed all the patches I quoted inline in this review at
avar-bwill/refspec in github.com/avar/git, consider them all signed-off,
and depending on whether you agree/disagree etc. please squash
them/adapt them/drop them however you see fit.
