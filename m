Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462621F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 00:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeJJHaM (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 03:30:12 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:40882 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeJJHaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 03:30:12 -0400
Received: by mail-yb1-f202.google.com with SMTP id h139-v6so1680584ybg.7
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 17:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hHTZelCioXNzGvc6FdZ1+Gz+0D3MRjvfzhwH4j66qcQ=;
        b=edBKjHS3rCSsOW+6EDodJyOG018LAHrx8Uv8akBHkSpTx8noQsGh1L0Z5cp2uh103R
         fHx2TI60cYt72+8l0EP49wKZ0W6DNkW4dLAeLcENgKfnC62NIX0d5QsFPWrMS0HZlDyu
         m3QCcZXEiGvw68gBEkwTuRo0wcliHJpYXKd+WGVwmcF8uI4/itD0g3eWUveCSI9CR9JF
         +UiBiseINd8IOx5nayTM5yIlckjmjfBFp5Z54LKNHCcVXjmz8c0HDm/+6BC8+Ce7s3Fd
         wIAX7YYY5B/z3J/1uSYsmSp5SaFh6/cJsiE3dUBPMhGMlZgiw6ZvzVCwvfFyjbcVukRR
         4K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hHTZelCioXNzGvc6FdZ1+Gz+0D3MRjvfzhwH4j66qcQ=;
        b=R5UBsI0GCKx7/9sUfFBD1IWMDNuuJB0bpkUZU0+I1SvIcMDLqN+YLl/gThdotu6z5J
         g+zOPfbkw+zXnNYivRUGxxAQvPjDrwc3FwGwsL/FAHGasUJz/3Xmj1vPDkXsLqLS8yjk
         ciIGbl8GqqGvOAjq0JXXuQv/8waSstCzEBlycEHOatm1oWRs2Doh+TNg+fA2O0+r+BI2
         SKNNIdwh09sT+txs8QZF+SPC+6g96LgpAT0rcEu6YNI8XTeUyj2MqTkt0S51ftF7RGL+
         93GQQQpbbwAJ5CjrKeTWz6aS8RY/epFakmc+us7/DDSP4rmRCq6/kFu23EoR7MtWTsWB
         lCAQ==
X-Gm-Message-State: ABuFfohteGnsj1QSPx3AuwPd1LIZ9Gl+OE9Nq0XQsKsOX8g+ihN9q29P
        ZsiEz4kGlNihJFYQ38ZALKwhAaGoURLmOS64jBss
X-Google-Smtp-Source: ACcGV61/WA93C9vFKdvWa3oFKbsp52BFWj5SQqofIX8lJJH8PD5KsL7AZyBLErlm/rQmG9JzsrukzDJCs9Rjdvl0+Jwf
X-Received: by 2002:a25:c04d:: with SMTP id c74-v6mr15653304ybf.33.1539130246650;
 Tue, 09 Oct 2018 17:10:46 -0700 (PDT)
Date:   Tue,  9 Oct 2018 17:10:37 -0700
In-Reply-To: <20181009183549.195316-1-sbeller@google.com>
Message-Id: <20181010001037.74709-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181009183549.195316-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH] builtin/grep.c: remote superflous submodule code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, ao2@ao2.it, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It claimed that grep would still need some explicit handling, but that is
> not the call to repo_read_gitmodules (applying this patch on top of
> ff6f1f564c4 still keep the test suite happy, specifically
> t7814-grep-recurse-submodules, which contains a test
> "grep history with moved submoules")

Firstly, spelling of "remove" and "superfluous" in the commit title.

I don't think the "grep history with moved submodules" test exercises
much. That test only tests the superproject > submodule case, but we
need a superproject > submodule > sub-submodule case, because what is
being removed is a call to repo_read_gitmodules() on a repository
("struct repository submodule") that has a superproject ("struct
repository *superproject"). In other words, we need a submodule that has
its own gitmodules.

Alternatively, it would be fine if someone could point out where the
.gitmodules file is lazily loaded when grep_submodule() is invoked. I
couldn't find it, although I wasn't looking very hard. I did look at the
invocation of repo_submodule_init() (right before the removed lines),
which indeed calls repo_read_gitmodules() indirectly through
submodule_from_path(), but that is called on the superproject, whereas
what is being removed is a call on the submodule.

> The special handling is the call to gitmodules_config_oid which was added
> already in 74ed43711f (grep: enable recurse-submodules to work on
> <tree> objects, 2016-12-16), but then was still named
> gitmodules_config_sha1.

If you're stating that gitmodules_config_oid() is where the .gitmodules
file is lazily loaded, it doesn't seem to be that way, because that
function works only on the_repository (at least on 'master' and 'next').

> This is a resend of origin/sb/grep-submodule-cleanup,
> and I think picking ff6f1f564c4 as the base for the series would
> also be appropriate.

Any particular reason why you suggest that commit (which is more than a
year old)? It seems that basing this on 'master' is fine.
