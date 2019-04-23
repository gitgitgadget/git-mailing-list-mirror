Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC231F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 03:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfDWDpU (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 23:45:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44370 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDWDpU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 23:45:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so9319013wrs.11
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 20:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g0I8AEeAgGpGK4+QZvDPn+qnEkN/lDGQjNPWVLYJiMM=;
        b=QkY89Vo+jrMt45DDr33nauREwvfTOmNfCzVHBb5+H8hW7SvvBlmB52BJ29EH+QgAqp
         kkDULSYusVHaum39IJbbjK+qoX66HOo/7gYDPra5t7Hc0q7+kroRY3HP+iJTt3lmTSnk
         yu14YAv/DZS4etUrRsExjUemIYnPilXEEygdPPVPSP8xl994xXCksp+rWBkWD6pbDgbJ
         qlhpXkWToZueCgjjROJGTVMehawQugbhCv5eP/+6nLkDQmlgd6kj/ENxIH8vkugC7w8b
         +p043SemKedMkbk60MfrbSg6O/wfWbK/31As2QWt1OJHGOXNgrfs78BZEhVRPmIpOSVx
         H1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g0I8AEeAgGpGK4+QZvDPn+qnEkN/lDGQjNPWVLYJiMM=;
        b=AfQeSNzPdP5rC+sUE3OFDH9wk/psweRiP/rGll/fdR8wENNV2EV/tgYDODI2UAOOHf
         I5PrOxc3vx1SYKX8Ss5LlhOJSMWGan+BT2+Gz4LQaK3tx4rAZYjMQKidQwQhIaixAxrO
         K3JPrSotRQ4BMAXvQKhOM4I8xlLLFG7Gw31h3q3yKkrGXt3ZpVbIaHlp2Mf0FkkHwraM
         7vLX8d7rjoToAP+vTyph+kYs2ATm2TGE+/NKiXyk6Yo4ahg3dSh+EG6OdwGx3yssejsc
         JbPz7BXG8iSq4bGj5qSHY1fvEW4iu/khe5WFpiJWmvgjtrHIX3xQV0GQ1k/RgpfTRryw
         nWBQ==
X-Gm-Message-State: APjAAAXIomIEPPEaBwPokhaOPnBfRcRPhasMk3QgIiypy4VliIWpPm4u
        SqF0ysr3cQqAaRXZoSiwsNI=
X-Google-Smtp-Source: APXvYqwwEjpEvFSI6NLU5fwjsvX8mtzUKU2Uh0CopY09cakl4YW19hYwS3lDtPC1BmXt3Gn8WGNmRw==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr5681731wrn.175.1555991118257;
        Mon, 22 Apr 2019 20:45:18 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id e7sm4519371wrp.19.2019.04.22.20.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 20:45:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Shawn Landden <shawn@git.icu>, git@vger.kernel.org
Subject: Re: allow a differn't diff.context config for git format-patch
References: <CA+49okrda1=dV=rN23oFg7LQmRp+idkDDDxFQ9R5jhGJFHKpEg@mail.gmail.com>
        <20190423030648.GA6344@sigill.intra.peff.net>
Date:   Tue, 23 Apr 2019 12:45:17 +0900
In-Reply-To: <20190423030648.GA6344@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Apr 2019 23:06:49 -0400")
Message-ID: <xmqqftq95qr6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... I don't think it would be
> too big a problem for format-patch to learn some options to configure
> its diffs. We already have some options in format.* for various things.

I am not sure; diff.context is rather special in that the variable
behind it belongs to the diff layer and is set via diff_config that
is called by diff_ui_config that in turn is called by log_config
which is called by format_config.

If we want to say "format.context" trumps "diff.config", then a new
internal variable to receive the value of the variable must be
invented and after the config gets read, cmd_format_patch() needs to
do something silly like this:

                git_config(git_format_config, NULL);
        +	if (format_context != -1)
        +		diff_default_context = format_context;
                repo_init_revisions(the_repository, &rev, prefix);

committing layering violation by exposing diff_default_context
variable.

