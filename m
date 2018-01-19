Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125C51F576
	for <e@80x24.org>; Fri, 19 Jan 2018 09:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754991AbeASJyv (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 04:54:51 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41012 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755334AbeASJyk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 04:54:40 -0500
Received: by mail-qt0-f195.google.com with SMTP id i1so2441253qtj.8
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 01:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YCrEa1peIFmcXGYfjnpzQ3RTOiv5BhU3EaI7/Hu6y78=;
        b=mrYAdvQpA/bOB3QtuHjsyUn/92yI8JL2h2OsXcZ6GRMj/BtIb2fOpyYZXBNB9iiNUn
         D2XnhXY6hznzsBQipxseIavT9ANisxwl2FcKzcWKvNDHhTq2TqJj3q8vYPYIgXK2sAl5
         Ahucq6Mq7o1Upx5I9R4TkSQSFxf4KRE8I/dywliEpn2ulWJkExQSxLpSiTlaI8nL8c0Z
         j03T3H0mg/7OBylK5VRuC4urRIu2vGfZwVgE8xOWCAOfqSnCH/e74NTDD8ZjZEl92lnQ
         KQ/nboJtz4ssxjFBIo8hSe5ZRxZ/7aZY/oomTGzXWcRAsrbPE8cjqGhc72q8/S23DMHM
         5KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YCrEa1peIFmcXGYfjnpzQ3RTOiv5BhU3EaI7/Hu6y78=;
        b=HGJxZWxQaJfqe+540jFwL2bKxTLMmx+pXY10OASE3qdg6NrJ7FetZ3kuuhdiIu5f4q
         7IVoOCCwpiKcl00PJp0S89u0EwM3/QMrjefZSeFadQbQy2qEk9LHGANwOv6BJl9qNaoI
         grkFzts56b9ond1RVMzGIFAOh/03JoKYH6/fNhBVE/nn0tFJNCVW/7FnYAMT/9fwI+Ps
         0cJhCkNNLtJ3lJRy49plLZXKYtMBS/fB9BMShD/V08igCNk6ltdnx1wIPAlF4ZT1PI13
         rVptD2Vj/bpDVmEa0xyLq2Al1HRsVEa89JwWWkXOZ0g+09S1e66h6B9OWgY85EyBjfoq
         LYxA==
X-Gm-Message-State: AKwxytfIkQGRTGIk7p7KuJysXYkMT+g/myuTL5Dol30Smy37J0sXRuTf
        4uMWxT1kCyz9UJb+lV3MVj12ZsUjD2fXd11Cmn0=
X-Google-Smtp-Source: ACJfBoub14wccfmToTO00hX4DEEwLr2pHow1R6yMSWF7e5TeR3IBN2GVn7/VR+7qGuJJz0iNe0mWY0y1hf09QutofoU=
X-Received: by 10.55.177.135 with SMTP id a129mr28070008qkf.112.1516355679360;
 Fri, 19 Jan 2018 01:54:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 01:54:38 -0800 (PST)
In-Reply-To: <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 04:54:38 -0500
X-Google-Sender-Auth: IE1Pz_kdEJNj0ZQxlhGO2k4_Uy0
Message-ID: <CAPig+cQgNSijA-sW+AGNAHOgnJVdUGaDWjro4KVWO=vefnEPuQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 10:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> [...]
> Note: this patch only adds support for recursive merges, to keep things
> simple. Support for octopus merges will be added later in this patch
> series, support for merges using strategies other than the recursive
> merge is left for future contributions.

The above paragraph...

> The design of the `merge` command as introduced by this patch only
> supports creating new merge commits with exactly two parents, i.e. it
> adds no support for octopus merges.
>
> We will introduce support for octopus merges in a later commit.

and these two sentences say the same thing. I suppose one or the other
was meant to be dropped(?).

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -2069,6 +2077,132 @@ static int do_reset(const char *name, int len)
> +static int do_merge(struct commit *commit, const char *arg, int arg_len,
> +                   struct replay_opts *opts)
> +{
> +       [...]
> +               if (write_message(body, len, git_path_merge_msg(), 0) < 0) {
> +                       error_errno(_("Could not write '%s'"),

s/Could/could/

> +               if (write_message(p, len, git_path_merge_msg(), 0) < 0) {
> +                       error_errno(_("Could not write '%s'"),

Ditto.

> +       if (!head_commit) {
> +               rollback_lock_file(&lock);
> +               return error(_("Cannot merge without a current revision"));

s/Cannot/cannot/
