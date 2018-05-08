Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35660200B9
	for <e@80x24.org>; Tue,  8 May 2018 05:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbeEHFOw (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 01:14:52 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:44748 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeEHFOv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 01:14:51 -0400
Received: by mail-wr0-f180.google.com with SMTP id y15-v6so19134332wrg.11
        for <git@vger.kernel.org>; Mon, 07 May 2018 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WUFyVGIdnxj8nPNiPaZlWBb06AMjRTMO5c52pOsJ1Jw=;
        b=j7i+cgvl3UTVIF0Ue0vAZ4KTV7u1mBVNlm2z2BTeMuJYQXM3xZNIqt/Dc9CWkspto7
         8TjDKhJy4Ce68a2qvvnsrK9t8BI/PWSrl1efyU5EvNWhAgys/woPhwPwT01iWYvCMgNw
         vQLmioSO5pwk4ruiT7vEGPrcUCByTfzQxsXu7LRRIuIEsSIvycJBadwHmyiV4WUhoGRz
         2RIt7RQi4LGdVy2Qcwo8/LaqqZ2ASo60+UFCz9Bg7fth5YhDk5mLHW1Bu9d+Mwxzk1U6
         +/Op15y4m8bNSdJv1a6aEZHvj2wnFmlgij6ufVsSGsi4VzbljxgJtLMEcxN4h+wD478u
         WnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WUFyVGIdnxj8nPNiPaZlWBb06AMjRTMO5c52pOsJ1Jw=;
        b=m8gtmMJYNUu8JX+w4diWBJeTnOH/XhkMuOca9q1W45wk13S9MlhtPgE1isnDrfF8Bb
         ONjNWAleBRMpfwCJrI8lA5yZcK1OEHR9Gerb+vSPfNOwLxs5gHkNzK8hyyX4AnOkN2tT
         xX7QdyhIUm9EnGnu9jSja1LZIH9z1KNwSIwpvFbNVqQLsZx7pBtAXOuqm6p02IKiNGDk
         Nqd5efn+dlwqyVdkU8Lhbbs/bQwblFJG2uonE/BDCsDDu2GkNXFMW8pwfn9q3NtqJATK
         wpF+b1JyacqWMJMwNy9Xxf5bBDwlaLf4TTnwpA7tmEZYxqrorScbJL1N1H3NFdLtV4Ax
         xQTg==
X-Gm-Message-State: ALQs6tBz+W1EQtFte6tXgU18i89p/gksZisjGndwy7WIf/yT+qpM3gvV
        d2GnC6wq06mqkqIv/wTCBCA=
X-Google-Smtp-Source: AB8JxZoyRwe9+vuSnNXgKySHggSrRaqbM4ALiin6aKZVHXtaQ9IOeJPq9IevE/UkrcWRSBISkfQiLA==
X-Received: by 2002:adf:ac81:: with SMTP id o1-v6mr30445174wrc.220.1525756489608;
        Mon, 07 May 2018 22:14:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d83sm14607522wmh.16.2018.05.07.22.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 22:14:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] push doc: correct lies about how push refspecs work
References: <20180429202100.32353-1-avarab@gmail.com>
        <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
        <20180429202100.32353-6-avarab@gmail.com>
Date:   Tue, 08 May 2018 14:14:48 +0900
In-Reply-To: <20180429202100.32353-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 29 Apr 2018 20:20:57 +0000")
Message-ID: <xmqqzi1alodz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>  +
>  The <src> is often the name of the branch you would want to push, but
> -it can be any arbitrary "SHA-1 expression", such as `master~4` or
> -`HEAD` (see linkgit:gitrevisions[7]).
> +it can be any arbitrary "SHA-1 expression" referring to a branch, such
> +as `master~4` or `HEAD` (see linkgit:gitrevisions[7]). It can also
> +refer to tag objects, trees or blobs if the <dst> is outside of
> +`refs/heads/*`.

I think the addition of "referring to a branch" here is an opposite
of an improvement.  The fact <src> can name any object (if outside
the refs/heads/) or any commit (otherwise) is stressed with the
added "It can also ...", which is great, but neither "master~4" nor
"HEAD" refer to a branch (they refer to a commit in terms relative
to a branch and a (psuedo)ref, respectively).  And a "SHA-1 expression"
that uses branch tips as a starting point (e.g. master~4 is "start
at the tip of master and go backwards by 4 steps) is *not* special
here.  You can spell your <src> side as "v2.17.0^0" for example, and
it does not refer to any branch.

> @@ -74,12 +76,24 @@ without any `<refspec>` on the command line.  Otherwise, missing
>  `:<dst>` means to update the same ref as the `<src>`.
>  +
>  The object referenced by <src> is used to update the <dst> reference
> -on the remote side.  By default this is only allowed if <dst> is not
> -a tag (annotated or lightweight), and then only if it can fast-forward
> -<dst>.  By having the optional leading `+`, you can tell Git to update
> -the <dst> ref even if it is not allowed by default (e.g., it is not a
> -fast-forward.)  This does *not* attempt to merge <src> into <dst>.  See
> -EXAMPLES below for details.
> +on the remote side. Whether this is allowed depends on what where in

s/what where/where/, I think.

> +`refs/*` the <dst> reference lives. The `refs/heads/*` namespace will
> +only accept commit objects, and then only they can be
> +fast-forwarded. ...

Nicely clarified.  Excellent.

> +.... The `refs/tags/*` namespace will accept any kind of
> +object, but there commit objects are known as lightweight tags, and
> +any changes to them and others types of objects will be
> +rejected. ...

with s/, but there commit objects are known as lightweght tags/ the
sentence does not change any meaning?  An early part of the paragraph
made readers anticipate that they hear rules for what can go where,
and "refs/tags/ ref that point at a commit is called lightweight tag",
while it is not an incorrect statement per-se, does not belong to
these "rules".  Unless the discussing of the rules immediately
follows involves (or becomes easier to read if we use the term)
"lightweight tags", it probably is better to drop it.

> +... Finally and most confusingly, it's possible to push any type
> +of object to any namespace outside of `refs/{tags,heads}/*`, but these
> +will be treated as branches, even in the case where a tag object is
> +pushed.

I sense a confused writer, not a confusing behaviour being described
here.  If refs/poo/* is "treated as branches", because of what you
earlier said, you shouldn't be able to push a tag object in the
first place.

If refs/poo/* is meant to be lawless land where anything goes, then
saying "will be treated as branches" does not help readers.

> +... That tag object will be overwritten by another tag object (or
> +commit!) without `--force` if the new tag happens to point to a commit
> +that's a fast-forward of the commit it replaces.

If I pretend that I didn't see the "treated as branches", I fully
agree with the above description and refs/poo/* being a world
governed by random rules, and I do not think I'd be too opposed to
change it to "anything goes".  I do not think I'd be too opposed to
change it to "nothing is allowed unless forced", either, though.

> +By having the optional leading `+`, you can tell Git to update the
> +<dst> ref even if it is not allowed by its respective namespace
> +clobbering rules (e.g., it is not a fast-forward. in the case of
> +`refs/heads/*` updates) This does *not* attempt to merge <src> into
> +<dst>.  See EXAMPLES below for details.

Excellent.  

s/leading `+`/& to a refspec (or using "--force" command line option)/

Thanks.

