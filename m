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
	by dcvr.yhbt.net (Postfix) with ESMTP id 86FED1F42D
	for <e@80x24.org>; Tue, 15 May 2018 08:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeEOIbg (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 04:31:36 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38844 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752489AbeEOIbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 04:31:35 -0400
Received: by mail-wm0-f54.google.com with SMTP id m129-v6so19799557wmb.3
        for <git@vger.kernel.org>; Tue, 15 May 2018 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=FHJDJ8Fe/YEVCgqC7GbRLry91xwpeCNrR2x0UvEVW1Y=;
        b=D8N25AZC5vALGVu9bAg87jJdDMNf4Ps3rhP8ReWiSI2q45UTHbGueH/i5uY60fY91p
         T6m6WHM5+clTeHM2Zr4rKx4r8yHFHagDO2g6JjsIfKmeS2HjOeEG6mZwvLimy/H7mdur
         ZHu9u3KXFhPfko3BHEYSxtgyqbEZ5Fd/K8HhHYxQU+wUCSQNYwPAjvW4EoSoX+Gq5+O1
         axTHlPnrmLmCis3zmuxt+8/PE+gwI4T5WxwI+vAiOsojwYh4Y9U9S1TSzzzYL9pcQt7R
         oFS7dodu47nsVLNWl28uTl/ij2bMAUUoFyXcA9A84XNMtEDe5Wu4h3o9GPr/d6L5cIIo
         B73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=FHJDJ8Fe/YEVCgqC7GbRLry91xwpeCNrR2x0UvEVW1Y=;
        b=WWGC4rhIC6vrrZSkFeL8xcatlzL9MkbqO5nLwj7O6xDhUtkNWioe7E9pYkcbxcx90y
         hDeX8y9nf+7jYjRVRimKFvIrDyMqzxkc+hvkIq28rhQmKuJvrNuZgdLzDgt0+ubiWAjp
         CcbFJ9RbiuR1epiiAJyXdNwfgllGoW1DY3ztIRCKz+TQF2bi66TMPDdkZm7lpDTRoIdu
         1efcdwuk6uloT3qq2Hp+9kwLvcDZnJZ9NcaU3ZCQOCzEMQambmbN10vMyIyiA5bLh4SX
         GXC+nRBHRBgCzELoWM5ofvuKPKYA67iN1NnfJnAWcxkeM+uzhIw3/ii8zNKztea/DqGl
         sERg==
X-Gm-Message-State: ALKqPweRD/My99fv3GpcrDKbWvj2YWO2dr+MojOJqkrFigTrQRLebug0
        2VuL0VUjkvYSuCTQr1RShtQ=
X-Google-Smtp-Source: AB8JxZoYm0qrxId77t5lNXcfY0gbefqMQrqH2MUSY+G2QIusxhBbqg3+H+lh2ShcvhfCfUN0J+vO0A==
X-Received: by 2002:a50:f4b5:: with SMTP id s50-v6mr16564232edm.262.1526373093894;
        Tue, 15 May 2018 01:31:33 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id k7-v6sm5850856edn.74.2018.05.15.01.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 01:31:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/35] remote: convert fetch refspecs to struct refspec
References: <20180514215626.164960-1-bmwill@google.com> <20180514215626.164960-15-bmwill@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180514215626.164960-15-bmwill@google.com>
Date:   Tue, 15 May 2018 10:31:32 +0200
Message-ID: <87in7p2ucb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 14 2018, Brandon Williams wrote:

>  void add_prune_tags_to_fetch_refspec(struct remote *remote)
>  {
> -	int nr = remote->fetch_refspec_nr;
> -	int bufsize = nr  + 1;
> -	int size = sizeof(struct refspec_item);
> -
> -	remote->fetch = xrealloc(remote->fetch, size  * bufsize);
> -	memcpy(&remote->fetch[nr], tag_refspec, size);
> -	add_fetch_refspec(remote, xstrdup(TAG_REFSPEC));
> +	refspec_append(&remote->fetch, TAG_REFSPEC);
>  }

Thanks for fixing the hack I needed to put in place in 97716d217c
("fetch: add a --prune-tags option and fetch.pruneTags config",
2018-02-09).

I'm not sure where it belongs in this series, but I think this makes
sense on top of the whole thing:

    diff --git a/builtin/fetch.c b/builtin/fetch.c
    index af7064dce3..9a523249f5 100644
    --- a/builtin/fetch.c
    +++ b/builtin/fetch.c
    @@ -1383,7 +1383,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru

            maybe_prune_tags = prune_tags_ok && prune_tags;
            if (maybe_prune_tags && remote_via_config)
    -               add_prune_tags_to_fetch_refspec(remote);
    +               refspec_append(&remote->fetch, TAG_REFSPEC);
    +

            if (maybe_prune_tags && (argc || !remote_via_config))
                    refspec_append(&rs, TAG_REFSPEC);
    diff --git a/remote.c b/remote.c
    index 8e6522f4d0..946b95d18d 100644
    --- a/remote.c
    +++ b/remote.c
    @@ -87,11 +87,6 @@ static void add_fetch_refspec(struct remote *remote, const char *ref)
            refspec_append(&remote->fetch, ref);
     }

    -void add_prune_tags_to_fetch_refspec(struct remote *remote)
    -{
    -       refspec_append(&remote->fetch, TAG_REFSPEC);
    -}
    -
     static void add_url(struct remote *remote, const char *url)
     {
            ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
    diff --git a/remote.h b/remote.h
    index 9014f707f0..62a6566594 100644
    --- a/remote.h
    +++ b/remote.h
    @@ -289,6 +289,4 @@ extern int parseopt_push_cas_option(const struct option *, const char *arg, int
     extern int is_empty_cas(const struct push_cas_option *);
     void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);

    -void add_prune_tags_to_fetch_refspec(struct remote *remote);
    -
     #endif

I.e. the whole reason we have this function is because of my above
commit where I had to very carefully hack around the fact that we didn't
have something which could ALLOW_GROW() the structure after it had been
created.

So I added the add_prune_tags_to_fetch_refspec() function to very
carefully do *only* that so others wouldn't be tempted to use this hack
more generally.

But now we have a nice API for it, so we can just throw away the
wrapper, and use the same API everywhere. You already did the other half
of that in your e69b54f53a ("fetch: convert fetch_one to use struct
refspec", 2018-05-11).
