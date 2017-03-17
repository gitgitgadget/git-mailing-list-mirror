Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844B020951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdCQRXD (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:23:03 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35976 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdCQRXB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:23:01 -0400
Received: by mail-pg0-f52.google.com with SMTP id g2so46061211pge.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GozL0oZWzKdr/mJaKMR2WAsVOadH0Z5KbWwqwTZ0aWU=;
        b=IN9KZTLyIx/Lr0HaHRLpulq7SabWx0aGCm/vxzkv0DRxtg902HUphtd6rWor1q5bEO
         tofgvpQqdbsTq1KQzAERjXtcqb1ndqWpgCOh7zLe92TnsVVP5Oczrwp0TzZeCxhthaj+
         6gEi7VNVRMo/TBKOfB3RXRp6qJdNZaF+/4hBwUASwxs/B9Y6Z0vxPQdqJqVMZ315osKa
         6X46qAf2yO8vYYRgF5DS/psAX5xgasAEqpKynhO7Bunlixg+bf2eIW3jv6u6sQ/T0HUQ
         xroPfvpr1j3G0O8L0OleFnnzji+fGA3GbfyIpiEdhdEkVVGoIb758gEcm9zhtIA308HV
         cIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GozL0oZWzKdr/mJaKMR2WAsVOadH0Z5KbWwqwTZ0aWU=;
        b=gkQhqwho6iUG4EwxGTfwjG9Y9AO/nFOmuqaNTzYIh+dzb1p7+GzUTv4TE90QvayQOF
         Fzox3RFNpvNn3NtCqx/mhwZEgNmVDE1/OP8ynA9fer9uEsf5OikN6zCX7XGdoab2uaXI
         /8fDhOt1TH/BQOztuNIlkOOuW/CdK/Xm0FWgzWyBzQkgOhLbj5k6piWPUsj3GR/vFGfL
         rEGJo15/ge2ODG4rlCXAiZ3bnC6gB62wUWEPg28+dDCKBMGjPAezx0k07ViPiguwwXWb
         0uG9DD30y1czFDoHvIb1gm6LahfE9WEam9DeuHDYBFjegrjNILHfWWBUBwLQXpaOTAsD
         45cQ==
X-Gm-Message-State: AFeK/H3I74OZFRXnsf3H37S7GkQV/SS+9eSpl/rezfdnwXXrHxhEFJpisuvxSEs+nN+lmHLmcdyt/oY3mDHbet14
X-Received: by 10.84.239.8 with SMTP id w8mr21480344plk.73.1489771377574; Fri,
 17 Mar 2017 10:22:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 17 Mar 2017 10:22:57 -0700 (PDT)
In-Reply-To: <20170316222952.53801-10-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com> <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-10-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Mar 2017 10:22:57 -0700
Message-ID: <CAGZ79kbUC+R1bB64N=wQZrjxdTfA5OzC-i9sU0ymHtKgRVPu=w@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] submodule--helper init: set submodule.<name>.active
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
> When initializing a submodule set the submodule.<name>.active config to
> true if the module hasn't already been configured to be active by some
> other means (e.g. a pathspec set in submodule.active).
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/submodule--helper.c |  7 +++++++
>  t/t7400-submodule-basic.sh  | 11 +++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index e95738b42..a574596cb 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -361,6 +361,13 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>                 die(_("No url found for submodule path '%s' in .gitmodules"),
>                         displaypath);
>
> +       /* Set active flag for the submodule being initialized */
> +       if (!is_submodule_initialized(path)) {
> +               strbuf_reset(&sb);
> +               strbuf_addf(&sb, "submodule.%s.active", sub->name);

In case a reroll is needed, you could mark this location with

    /*
     * NEEDSWORK: in a multi-working-tree world we need to set
     * this per-worktree here.
     */
