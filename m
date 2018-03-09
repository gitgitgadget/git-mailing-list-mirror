Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FEE1FAE2
	for <e@80x24.org>; Fri,  9 Mar 2018 08:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCIIxZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 03:53:25 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40424 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeCIIxX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 03:53:23 -0500
Received: by mail-yw0-f196.google.com with SMTP id y186so877789ywf.7
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 00:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=40qwfKSdYaLsjLRRXQe93OLBGq2T7CEkleA4x/RlQ5g=;
        b=suzaO2G0+Z2J0+QdlVfukXWndDsuJ1YYkRl4neaJgcHR4XbU7I4nA91tcO5JuVNjv6
         rptn5QE9XHt71oLQnMJfB7wlbWG8Cj/ufDL0iCC9mBflzqKspHG8+TC+ohh87YBp8u7r
         47fLRNFoaOMofXxczeTvQjzwic9lsfCtc0lDaQBx1VPwypve7NzTslHiFH9kDDTYx2sh
         SYdPl/DU3aEUkopC7zvk/mgBUgSgMcVg9GfLh1wEC4wYph1HEoVHo+kY/WgbNpH26+rG
         lcLVUZr3gh1SCx9GioyB8AKmHvqYMgPUsqskuyTwW8TqlRos4vzdGZBY4+E0O8SJByk2
         pqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=40qwfKSdYaLsjLRRXQe93OLBGq2T7CEkleA4x/RlQ5g=;
        b=uMXXcoPbUgXmI1ySxls3uFC6zolN5dQQQvkC1aSZV9Ny7a/or1ZE1b/fqkqvuXz9o7
         f21Ztcfy+oa1cNpZXoqKIhF/ZeKCbccBZ7qSwUoFP3MBxbP1z2+zGzWbT0M9m4GEV155
         qVPE00NZpPfxfbBXRMsADLWUPKIxOIOQiVWR398KcN224Dd8oYAawoqgGMtNnEZkbUNO
         M1v/X0rWah5Sda7lGju9/GFFmnZdMMqx872idD2eq07TpdVtYrDe17kdLvOI9J2oZ6lT
         UhQyIjMqvpgk2V/5US1ECTEur3Us/OhFnBOqCcoSa7ZpRJ8pvNyyElu8zmXTPc2UB934
         d8xQ==
X-Gm-Message-State: AElRT7GnC9KG5CKEGG/6MhbIZ15FjOuMM08/m2uqjctuOV+3mAo6u4Au
        fQNsF9qP3+OwIj973yssuTTLEU6bWdKYE8nRlsgOzg==
X-Google-Smtp-Source: AG47ELs9HmSrBJTcQKiXt4EihMuMKnSuDBYZAxXEeFt7zWUHWI46XCL0kH5k81JD1F22lbe9VWdnlcM5V8NTaSTyR/M=
X-Received: by 10.129.73.80 with SMTP id w77mr19609964ywa.421.1520585602637;
 Fri, 09 Mar 2018 00:53:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 9 Mar 2018 00:53:22 -0800 (PST)
In-Reply-To: <20180307211140.19272-1-rcdailey@gmail.com>
References: <20180307211140.19272-1-rcdailey@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Mar 2018 00:53:22 -0800
Message-ID: <CAGZ79kZk7N4zQUS1eMFMPTuPPuo5ViOeLj5hQHV=E+A=OO+D0w@mail.gmail.com>
Subject: Re: [PATCH] Support long format for log-based submodule diff
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 7, 2018 at 1:11 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I am experimenting with a version of submodule diff (using log style)
> that prints the commits brought in from merges, while excluding the
> merge commits themselves. This is useful in cases where a merge commit's
> summary does not fully explain the changes being merged (for example,
> for longer-lived branches).
>
> I could have gone through the effort to make this more configurable, but
> before doing that level of work I wanted to get some discussion going to
> understand first if this is a useful change and second how it should be
> configured. For example, we could allow:
>
> $ git diff --submodule=long-log
>
> Or a supplementary option such as:
>
> $ git diff --submodule=log --submodule-log-detail=(long|short)
>
> I'm not sure what makes sense here. I welcome thoughts/discussion and
> will provide follow-up patches.

The case of merges is usually configured with --[no-]merges, or
--min-parents=<n>.

I would think we would want to have different settings per repository,
i.e. these settings would only apply to the superproject, however
we could keep the same names for submodules, such that we could do

    git log --min-parents=0 --submodules=--no-merges

We started an effort to have a repository object handle in most functions
some time ago, but the option parsing for the revision walking doesn't
take a repository yet, otherwise the generic revision parsing for submodules
would be easy to implement.

Thoughts on this generic approach?
Stefan

>
> Signed-off-by: Robert Dailey <rcdailey@gmail.com>
> ---
>  submodule.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index 2967704317..a0a62ad7bd 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -428,7 +428,8 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
>         init_revisions(rev, NULL);
>         setup_revisions(0, NULL, rev, NULL);
>         rev->left_right = 1;
> -       rev->first_parent_only = 1;
> +       rev->max_parents = 1;
> +       rev->first_parent_only = 0;
>         left->object.flags |= SYMMETRIC_LEFT;
>         add_pending_object(rev, &left->object, path);
>         add_pending_object(rev, &right->object, path);
> --
> 2.13.1.windows.2
>
