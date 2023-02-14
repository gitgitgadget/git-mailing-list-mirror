Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334B0C6379F
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 22:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjBNWNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBNWNF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 17:13:05 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686532943D
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:13:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e1so6416188pgg.9
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TuKC9dCuAsqh20pUtDWE0uplAfeRZzs3sGYDIM0Pe8=;
        b=cx77bNqv/BrXy5XzVd2N0GQRwl4Tnw0pkkERdl0o7M/9YNsockbwyOF6xUKaWOb7vM
         OhRxKAq8JiaD+bOK4yOThFZelMW0iFrrzZUVFsYat1fDyyMm6qBUA5HGbfNDswK6VQP2
         FYxaQ0tSSwOxhlKOYi9cVouDNX/54y5sZ87MMVm2GYgRvF7OXlDHnZsVogTxtdlpR7vK
         yo0mbjNzPQATaKrFJ7GANKTARykykK8PokKA2GVn8pvX88UxjphXmRUeYM69+4oP9sXM
         +zHCX4ClhDGX2QbXfFXiwJtUztFwU1mIGk4QHIbLA8RWbz00f7IYFS8PLaqRcq6dNX69
         1WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8TuKC9dCuAsqh20pUtDWE0uplAfeRZzs3sGYDIM0Pe8=;
        b=Wd5lyEuVU47WWsGMFMNpfM1s+ZeWsA3DkYDkasNifFaRSEX5iqxrIP3Eofx3CHyObo
         X3NNygX2PdtBrnBaFMylmEzDmtKoTGJFKxaimzsJwsQVf0WjRZiPEO1wu0tYGh7sJk01
         fEEurUryQJvrl6lwAbxFXSgC8w25Y5DU9KAxr3DRdGNaYVb4JHYxgTJ3L+x5I5Ef0L2+
         dbg+yizoBIpJrMF+wi6VVRdZ3DA31eaUA8krttK81wjr+isyW8XxY9bGINJ3d7r9yqhg
         PQXlnxYsL/2YHWIgFL1U0TJjkHNHRSgH9xeaGj98g/gGojhi1yTJqOgA0I/EJsiD4KLX
         qXKw==
X-Gm-Message-State: AO0yUKVxAsHr8gyVB5/58SezrOdfWS/BEcsbuF4Olk3DHGlBVM6xST+R
        fyURwbHzQces4eC1RKBXLGA=
X-Google-Smtp-Source: AK7set9F1UBD0v9zTRap9pJhO3uM3Q7oNkkrzM+Kf4AP/6c5Gc6f0zc9grw6dE6O3dYKr9cPuEokog==
X-Received: by 2002:aa7:953c:0:b0:5a8:acca:d5ce with SMTP id c28-20020aa7953c000000b005a8accad5cemr2727654pfp.28.1676412783775;
        Tue, 14 Feb 2023 14:13:03 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x7-20020aa79187000000b0059072daa002sm10279115pfa.192.2023.02.14.14.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:13:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/*: fix error message usage typo
References: <20230214032534.507628-1-cheskaqiqi@gmail.com>
        <20230214215403.1450903-1-cheskaqiqi@gmail.com>
Date:   Tue, 14 Feb 2023 14:13:03 -0800
In-Reply-To: <20230214215403.1450903-1-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Tue, 14 Feb 2023 16:54:03 -0500")
Message-ID: <xmqqa61f521c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

>  builtin/merge-base.c        |  6 +++---
>  	if (get_oid(arg, &revkey))
> -		die("Not a valid object name %s", arg);
> +		die("not a valid object name %s", arg);
>  	r = lookup_commit_reference(the_repository, &revkey);
>  	if (!r)
> -		die("Not a valid commit name %s", arg);
> +		die("not a valid commit name %s", arg);

You picked a rather unfortunate one.

    $ git grep -E -e 'Not a valid (object|commit) name ' '*.c'
    bisect.c:		die(_("Not a valid commit name %s"), oid_to_hex(oid));
    builtin/cat-file.c:		die("Not a valid object name %s", obj_name);
    builtin/cat-file.c:			die("Not a valid object name %s", obj_name);
    builtin/describe.c:		die(_("Not a valid object name %s"), arg);
    builtin/ls-tree.c:		die("Not a valid object name %s", argv[0]);
    builtin/merge-base.c:		die("Not a valid object name %s", arg);
    builtin/merge-base.c:		die("Not a valid commit name %s", arg);
    builtin/read-tree.c:			die("Not a valid object name %s", arg);
    builtin/unpack-file.c:		die("Not a valid object name %s", argv[1]);

Updating only one file would mean you leave two variants each for
the same message, making the messages less consistent and adding
more strings for translators to translate.  If we were to do this,
it probably makes sense to fix these (or just "valid object name"
ones) as a single group in a patch (with updates to tests that
expect the old spelling).

    Subject: [PATCH] errors: downcase "Not a valid object name"

    There are many instances of "Not a valid object name %s" given
    to die(), which should start with lowercase "not a valid ...".
    Fix them.

or something, which would touch the grep hits we see above, plus
some tests in these files

    $ git grep -l -e 'Not a valid object name ' t/
    t/t1006-cat-file.sh
    t/t8007-cat-file-textconv.sh

that seem to expect "Not a valid object name", starting in capital.
