Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DFD1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeKNFC6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:02:58 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41426 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeKNFC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:02:58 -0500
Received: by mail-ed1-f50.google.com with SMTP id 14so2292762eds.8
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6dnQdkm65oxvZnySke9LFQivcbuIxnP14PcFOjn7B8c=;
        b=uzlBqmgoHS3MgHQmYDbGb4MmertfY3/9XkHj0oY/jS0XW8Bk1rVgVApHo1Jec3NBZp
         MCOEjGpSHA8efW/7JacsM0sQAgf65gMwhO8DnfUF8gq7i4bHyozm31yZIkeX9n3Eb8mu
         WNUXP9VHiIqJi4vArH9qVWSy1OP0WSHzc385rVUXF7T0SI/NClG2FofBUGSmPxZpwZUt
         hv+Uy7wMtBhkalcQ+xZMY0ZYFpF62b/ytdkiQf5XevophOofP7shbarr2O+4WjO08hH8
         uQQl75SHwhqCaJbO0XGne0386YiWe7i/0skYugt17my39alJhXoqD+LUtVtN9fvHup1M
         ouRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6dnQdkm65oxvZnySke9LFQivcbuIxnP14PcFOjn7B8c=;
        b=Vd0dQ3sUK/Be47ruhv9Rc8peOtGhHLVIqAAZIoKmj2FyR6XGtRS9xcmDz1N6Dxo5d5
         RtqsR0E5SG903xodY8eDhD6FjRgRvqjIhA1VtCSE/dS8PBhM289IZIrjQqOcGysJK9jU
         wmpnHimL3iLu+gggZRoSOKb/amx+hxG+t9ajkIqR8klIENw/2yxiKAHTXw0BnGW71u2h
         6AseM4kfp+roWW7zBLHYSlyfi9wjQmQ6DNYGcjBA7KJ5d4ictNcz/W8PYp2/rD/vZX/p
         SlN4rHX5rphMP5iktsxDd2+pG7zYPBdeVEEEOd0Wx4+Az56DSXRQXri/PHklD5GSm5fv
         Fwzg==
X-Gm-Message-State: AGRZ1gLsMt0KpPv+ZTg9ZGqk7gDpd+8v755Sy9NYW1Qxgw7INCznqenx
        FfjrLQbmyIHwgBJSy5TIdBUxMRy1IgU=
X-Google-Smtp-Source: AJdET5eS4s9yKw2QowH4se0zC71b5/wVJVDPGTTBEbewzJ5zAIt9NGAph7YAR6gzO4j2AtTTR2/vsQ==
X-Received: by 2002:a50:924e:: with SMTP id j14mr8517034eda.142.1542135810481;
        Tue, 13 Nov 2018 11:03:30 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id j22-v6sm6004099edh.47.2018.11.13.11.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 11:03:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2018, #04; Tue, 13)
References: <xmqq8t1xukw2.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq8t1xukw2.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 13 Nov 2018 20:03:27 +0100
Message-ID: <871s7o3im8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 13 2018, Junio C Hamano wrote:

> * ab/pack-tests-cleanup (2018-10-31) 3 commits
>   (merged to 'next' on 2018-11-03 at b4a39595bb)
>  + index-pack tests: don't leave test repo dirty at end
>  + pack-objects tests: don't leave test .git corrupt at end
>  + pack-objects test: modernize style
>
>  A couple of tests used to leave the repository in a state that is
>  deliberately corrupt, which have been corrected.

Thanks. Will send the rest soon.

> * ab/range-diff-no-patch (2018-11-12) 4 commits
>  - SQUASH???
>  - range-diff: make diff option behavior (e.g. --stat) consistent
>  - range-diff: fix regression in passing along diff options
>  - range-diff doc: add a section about output stability

Sent an update just now.

> * ab/dynamic-gettext-poison (2018-11-09) 2 commits
>  - Makefile: ease dynamic-gettext-poison transition
>  - i18n: make GETTEXT_POISON a runtime option
>
>  On hold.
>  The tip one may be controversial, but at least it would get me going.
>  cf. <xmqqpnvg8d5z.fsf@gitster-ct.c.googlers.com>

So just to clarify the state of this. I sent a v4 with the patch you're
referring to included, I don't think $(warning) instead of $(error)
there is going to bother anyone. I expect it's only very active list
members using this poisoin option to test anything anyway.

Otherwise this looks ready to merge down. All the feedback's been addressed.

I'm a bit surprised that people aren't excited about this whole "you
don't need to recompile git just to run this one special test mode", but
to me it seems like an obvious improvement, and the code cleanup in this
series makes subsequent gettext poison cleanup easier.

> * ab/push-dwim-dst (2018-10-29) 9 commits
>  - SQUASH???
>  - push doc: document the DWYM behavior pushing to unqualified <dst>
>  - push: add DWYM support for "git push refs/remotes/...:<dst>"
>  - push: test that <src> doesn't DWYM if <dst> is unqualified
>  - push: add an advice on unqualified <dst> push
>  - push: move unqualified refname error into a function
>  - push: improve the error shown on unqualified <dst> push
>  - i18n: remote.c: mark error(...) messages for translation
>  - remote.c: add braces in anticipation of a follow-up change
>
>  "git push $there $src:$dst" rejects when $dst is not a fully
>  qualified refname and not clear what the end user meant.  The
>  codepath has been taught to give a clearer error message, and also
>  guess where the push should go by taking the type of the pushed
>  object into account (e.g. a tag object would want to go under
>  refs/tags/).
>
>  The last few steps are questionable.
>  cf. <87in1lkw54.fsf@evledraar.gmail.com>

I will send out an update for this hopefully tonight. I was waiting for
the merge conflict with config.txt to clear up in next v.s. master.
