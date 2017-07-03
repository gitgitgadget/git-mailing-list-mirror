Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D564201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 22:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbdGCWP7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 18:15:59 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36800 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbdGCWP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 18:15:58 -0400
Received: by mail-wm0-f51.google.com with SMTP id 62so180224695wmw.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 15:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fVihVX62aZdyFMqm8hU2uuatGSWCaZjzcW+U73gl8/I=;
        b=oDQSj+ZAVaXFIE9+RHqYQHIRzyv27571e4UBUt4tpL7Kz7h65nye1zrHbqh2LqSz5d
         BEtrOXRkcvs6Yup8TNcwfD232eV7teKdAa0qLOl+mAAHuXO0etvZ7143Zvpg9VSgpmaj
         8GSSHcYA1A8myuyoysKGbGvO2whfJBQneQY0NzgRJqoRbPkp6opzBrMoWbHPf4q82a6M
         K/wkx+djpCVI1t0Bhs23pWYJAK4TLZKLc82RwLO/39TQyppJ0ml+Z2FUvaSHTiMWVVhv
         /Nr8+AbN81gtqDqlYGZnH4LT7qn78ADBgOHsZwLaLVHiNu+a2LeFm9HM520GmSKeso2r
         xa1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fVihVX62aZdyFMqm8hU2uuatGSWCaZjzcW+U73gl8/I=;
        b=mrx8Wb78cwBBZ6O9dV+aztsV1dWsrxUULi4/Hpo4CBoMjp0bZMLGJjP2ypdK5naexr
         XyYp7n80XYE90pxXd/zE/7Q4LbAu8LQn98dVq1Uz578+Mh7mkmaLg/VPLL+qPWm51GT7
         w1Otw+jKCy9ubXh6l8zEoZh1hLKe24WoCEShgf+ezaswmkKvhVlBQn/Xi8tnjyXlDaxW
         +nKP9ENMnLKiZBEKQIq/hfKu7K2ZROTTNnEJLSobrHGViFVeY0dt3VHmDrsOTiOzcUSk
         qFI5IRGl7pm4DFJnlw6sEx3Huze3C2ud4aZeg8DGRiaV0KTmzj1aNE4gHLgzD1n9FuZj
         QHCg==
X-Gm-Message-State: AIVw113WhBeuty0MTOqVbMlf6DZWEFcCvCoDDj0btrkrosppeBFkMXui
        t3Lgeibe5MhWPCxmXCw=
X-Received: by 10.28.55.201 with SMTP id e192mr15549947wma.75.1499120157392;
        Mon, 03 Jul 2017 15:15:57 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id v102sm4557589wrc.53.2017.07.03.15.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2017 15:15:56 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dS9dL-0005kY-Gf; Tue, 04 Jul 2017 00:15:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Francesco Mazzoli <f@mazzo.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
References: <1499116727-757-1-git-send-email-f@mazzo.li>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <1499116727-757-1-git-send-email-f@mazzo.li>
Date:   Tue, 04 Jul 2017 00:15:55 +0200
Message-ID: <87y3s5b204.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 03 2017, Francesco Mazzoli jotted:

A couple of things I didn't notice at first:

>  	git_config(git_push_config, &flags);
> +	if (push_always_force_with_lease) {
> +		cas.use_tracking_for_rest = 1;
> +	}

This should go in git_push_config.

> +	if (!strcmp(var, "push.alwaysforcewithlease")) {
> +		push_always_force_with_lease = git_config_bool(var, value);
> +		return 0;
> +	}

[As you noted on IRC] --force-with-lease takes args, but yours
doesn't. Arguably this makes no sense whatsoever to have in the config,
but something worth pointing out in the commit message.

We could make the config accept args, you'd call
parse_push_cas_option(), but should we? I don't know.

Should this also apply to send-pack's --force-with-lease? Under the same
option name or send-pack.forceWithLease? I also don't know...
