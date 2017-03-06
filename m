Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2883320133
	for <e@80x24.org>; Tue,  7 Mar 2017 00:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbdCGAhe (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 19:37:34 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33346 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754151AbdCGAhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 19:37:12 -0500
Received: by mail-pf0-f174.google.com with SMTP id w189so66944948pfb.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 16:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DEg9DprlsJrrPhoaDfFv2bu7bF07t9VztKucWfPZDJQ=;
        b=VLSKJwL+6NGFENg/+f5o7fuy8f/uUpp41opTx6ohPbPP0YgzjwLMT7FmnUxD8zuQsC
         e40JHzhik7o6ye0obt8cmHNXUYTn+pXEE8gQLzZ5JtOkLYPFg4ZXttdyYCCycccZV/x7
         gY6joMv4flNZcjBo7vYbjrHp3aiK/WWnUVjjUEWXBj5Muc13UJQ+F3hEl4V8F9lH32ey
         ZzHbCUg+djLMI53WhhjigrvjAhvRXycrGNMjr2nq1fluoi2OZ/hBCBmlSOycNI4+IPtO
         +BRvp/ZgxyXSpTQL6sI11/I0razdjMLVsAsBhR7I3rBmNG01gFR10B/LUngPc1hca1d+
         NMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DEg9DprlsJrrPhoaDfFv2bu7bF07t9VztKucWfPZDJQ=;
        b=mlM/mES751Q95U4mjOmzIYFKj5/CaA426SncqscXd9pb+eKX1Xrfk+syU7voCFVv5H
         djCAuKyvsz3+fPdskRgp+aRFZWfYPkUDEqeiyrWSwlU+REarBeB/t9Zt/Mncew+uLx+E
         TXrXYRwOWwa+uxpRi1k/xV9dQvYl0OQUaFEoF7Fz6b5PeTKzujsseR4aOO8l97z6S5Lz
         oKVqURsZtGfFob3dMYcMTNpYikkkBFvQ3vE2+byoEJotFytWTPbrvOIDW9dUH9XhsK/X
         mEVesVs9a/enpt/y1m1AKZzJzDaipirJakOyNvP6KbaQATlCMC7MiX6mc9ZqIBIYsgms
         CbDg==
X-Gm-Message-State: AMke39nNafkobw3mjAhqX45TueEGm6WBfVb5dZxmJKsYgLQuIAg0CzJTQGiPl6vb7+NRN7qrsn1ozdkDAVWQ8PIU
X-Received: by 10.98.112.134 with SMTP id l128mr24128670pfc.81.1488840267689;
 Mon, 06 Mar 2017 14:44:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 6 Mar 2017 14:44:27 -0800 (PST)
In-Reply-To: <20170223122346.12222-2-pclouds@gmail.com>
References: <20170223122346.12222-1-pclouds@gmail.com> <20170223122346.12222-2-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Mar 2017 14:44:27 -0800
Message-ID: <CAGZ79kboaKfzMEyDjg-m2oK8CX6B56i52ZcWhCaq87ECE9x2Dw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] config: add conditional include
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Being late to the review party here.

> +static int include_condition_is_true(const char *cond, size_t cond_len)
> +{
...
> +
> +       error(_("unrecognized include condition: %.*s"), (int)cond_len, cond);
> +       /* unknown conditionals are always false */
> +       return 0;
> +}

Thanks for putting an error message here. I was looking at what
is currently queued as origin/nd/conditional-config-include,
which doesn't have this error()  (yet / not any more?)

I'd strongly suggest to keep the error message here as that way
a user can diagnose e.g. a typo in the condition easily.

If we plan to extend this list of conditions in the future, and a user
switches between versions of git, then they may see this message
on a regular basis (whenever they use the 'old' version).

In that case it may be only a warning() instead of an error(),
but I have no strong opinion on that.

---
Reason why I am reviewing this series now:

I thought about extending the config system for submodule
usage (see debate at [1]).

My gut reaction was to have a condition for "if a superproject
exists" and then include a special config (e.g. "config.super"
in the superprojects $GIT_DIR).

However while reviewing these patches I realized
I am not interested in conditional includes, but when setting
up the submodules we know for a fact that we have a superproject,
so no conditional needed. Instead we need a special markup
of paths, i.e. we want to have an easy way to say
"$GIT_DIR of superproject". Ideas how to do that?

Thanks,
Stefan

[1] https://public-inbox.org/git/84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org/
