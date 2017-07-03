Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF8F201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 21:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbdGCVr5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 17:47:57 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36911 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdGCVr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 17:47:56 -0400
Received: by mail-wm0-f52.google.com with SMTP id i127so120502996wma.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=pWA/vJTilP9FybGGICmSnd0llwKK6Qj52JrUMwjPq88=;
        b=eQLgt5zymkZvxunj2uIenqdJwjhq4gF8d5L94cvsDYe3bq5Mg2QM9pmZUKVfs2ylz1
         jtkZS7csvyAXUDJAUgIH7JbyZyxfwhtmmima0YjF/WoQ4gfvBCSO9RK3HXhJADqwQ7ij
         KfMAoy0Y+awetoS4uehRtkYhikbWOjt7HbJ0YFpA+Qe/1Dx1JLFnyPzx4/ad7omsMCJj
         u2hpR4pfBCEo4fntT5yqkWrsJ7Zm5sVC8oxm89iieMRw/2rWoiprx9LbZz5lvUZ1P9hy
         Hayj8ld7reB5zZKd64Rab+HB5cRZpfEM/6q3SzJ9ENFZvOYtxJJ6GwNlsZts6arq2RGp
         eFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=pWA/vJTilP9FybGGICmSnd0llwKK6Qj52JrUMwjPq88=;
        b=p2Wr1Nb8f9lFHBcmkVj2TVOUdB6CaOQ35m8V6IgGaEmBlnTe3WTHuRAKa11tyBc+UD
         BveXPZ1vtNkhFOLeCkdslnip132v+Nqs5XP4/0BgvmnzdIs/YZeNuPbW8fjS+mPRQS7Y
         xO9tmvHHHBWZEAy9uyOOoprD6Bsg9jqiKA0q0HCtw2dC3YspKaBNvhzYmaxuQuI6kOYr
         EMPrdd4wiU+3pr+ZbdjS6OUahf1wdMojj99ezZQ5H06oagkjlTXeGgt5nM/VveEQ3iVx
         qf9vgWjud/fvlt34c8arYcrRaJ5ZbLLfwZOoeOgcLyGCMmOlNRrwogoZhd3nxr9M0d6w
         F4Uw==
X-Gm-Message-State: AIVw110u7yDnSk17MQhi9ExhRZPTyA3wk6Y/4Nfkq9LQEFqDVm7odWWL
        GpnOQjWV0WNshw==
X-Received: by 10.28.214.213 with SMTP id n204mr235031wmg.114.1499118474085;
        Mon, 03 Jul 2017 14:47:54 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id q137sm8548256wmd.32.2017.07.03.14.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2017 14:47:52 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dS9C1-0005PV-PE; Mon, 03 Jul 2017 23:47:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Francesco Mazzoli <f@mazzo.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
References: <1499116727-757-1-git-send-email-f@mazzo.li>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <1499116727-757-1-git-send-email-f@mazzo.li>
Date:   Mon, 03 Jul 2017 23:47:41 +0200
Message-ID: <871spxchvm.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 03 2017, Francesco Mazzoli jotted:

> The flag can be overridden with `--no-force-with-lease`, or by
> passing the config via the command line.

Thanks for hacking on this. A couple of things:

* Most things (but not all) that configure `git whatevs --some-option`
  are configurable via whatevs.someOption, I think this should follow
  that convention. I.e. be push.forceWithLease not
  push.alwaysForceWithLease.

  See my
  https://public-inbox.org/git/20170324231013.23346-1-avarab@gmail.com/
  patch series for something that went through many of these cases
  (although I see I didn't send it all to list). Anyway, something like
  8/10 of our config variables for switches follow that
  convention. Let's use it for new config.

* It makes sense to also document this the git-push manpage. See
  e.g. how we document --follow-tags:

      Push all the refs that [...] This can also be specified with
      configuration variable push.followTags. For more information, see
      push.followTags in git-config(1).

   You should add something like that to --force-with-lease.

> +push.alwaysforcewithlease::
> +	When true, `--force-with-lease` is the default behavior when
> +	using `push --force`. Explicit invocations of `--force-with-lease`
> +	or `--no-force-with-lease` if present, take precedence.

Semantically this makes sense, and is exactly how most of these switch
config variables work (and would be how it worked once refactored with
my CLI arg config patch).
