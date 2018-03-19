Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BD51F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967868AbeCSRON (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:14:13 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39584 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966577AbeCSROK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:14:10 -0400
Received: by mail-wm0-f48.google.com with SMTP id f125so8803607wme.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OkfVCyNluTiygOP/4VMUh9pgLWghBtCGJVlK2G4dalY=;
        b=VmSTdCVsMs8I7HnTwMApyErhsNZS1OY2jYmvsAwLVvO6fvrlO9h2Gcvu/d5XyRc1mQ
         uQdKK+csjrWygL5TLyYObO4EP5F3Tk1Gb5+mPm2oOyunZlv785UkmvW7HP5ePad7dP73
         lzACUXbnwjKFg2VaJ3LHohtyjO7SZoqKxeV+sc7xv4ghF2C5Ym+YZ7VKjRTqaBS8FHuo
         ieYXFNKf5fKCWYwuVLWwoCh4yyVlX7JzYjNCxrQ9HltVopAZTYBPqnuqYb7h8du+/yfl
         Fv07/4J7jIiCSE9U4TB3HWAUcs5CiKGgReZDyLJi9J2X5+wcEg+4EeCfF2VL6gscxtBX
         pylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OkfVCyNluTiygOP/4VMUh9pgLWghBtCGJVlK2G4dalY=;
        b=irE10ma19SpswpzL8AICnQlWpqZ+pmdtlhuqShpEI3LjaLitqmlDhplw+LacTINpuf
         bFzH76OKlBzE8lOLEovJ4YE7mrCp7zz6fyhkDmIYXAGviYFDWI2U6LvPXqwC3wM+8rw5
         KlCfWhyJ5t88zmWoaLTh4pEE0fiPdPj3WkJOmVna6I4DPfAInLDgbNwgO/7uq4NAtUKc
         aQ11eH4nkLOuBet6prfm5kxcDX80SnRxEo85BGoNCxxirH/AIMJWVdoTzP6FAN7C5cvl
         uoeQ+PYgJxIQPHDedVYjh3cEXmKLlpmqRpB3dzWdjll8vB7LI/DF8ru8F9PMqN+1kiAj
         Xpkw==
X-Gm-Message-State: AElRT7GIDwodp0qsooSTGp6yW2LXkcMR0SKB7AS8xByCnV7usC2i83Fp
        AAzFbcSk0LGb9vWDcoHjYzM=
X-Google-Smtp-Source: AG47ELtpDAHvMbqctn89VYFNstj/qMA/ZHhlTUaVOMbq2uBBL3+SPe4ZPJX8lBrxkELKVj2O8ZgF9g==
X-Received: by 10.28.90.215 with SMTP id o206mr3441719wmb.67.1521479648621;
        Mon, 19 Mar 2018 10:14:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m190sm1069284wmb.6.2018.03.19.10.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 10:14:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
References: <20180319025046.58052-1-dnj@google.com>
        <20180319025046.58052-3-dnj@google.com>
Date:   Mon, 19 Mar 2018 10:14:07 -0700
In-Reply-To: <20180319025046.58052-3-dnj@google.com> (Dan Jacques's message of
        "Sun, 18 Mar 2018 22:50:45 -0400")
Message-ID: <xmqqbmfkvvhc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Jacques <dnj@google.com> writes:

> +# RUNTIME_PREFIX's resolution logic requires resource paths to be expressed
> +# relative to each other and share an installation path.
> +#
> +# This is a dependnecy in:

dependency?

> +# - Git's binary RUNTIME_PREFIX logic in (see "exec_cmd.c").
> +# - The runtime prefix Perl header (see
> +#   "perl/header_templates/runtime_prefix.template.pl").
> +ifdef RUNTIME_PREFIX
> +
> +ifneq ($(filter /%,$(firstword $(gitexecdir_relative))),)
> +$(error RUNTIME_PREFIX requires a relative gitexecdir, not: $(gitexecdir))
> +endif

I see Dscho is CC'ed so I won't worry about "is there a more
portable test than 'the path begins with a slash' to see if a path
is relative, or is this good enough even for Windows in the context
of this patch?".  It won't be a show-stopper issue as long as we do
not error out with false positive, though ;-).
