Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09BD120A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbdBAX1o (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:27:44 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36016 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbdBAX1M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:27:12 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so35492739pgf.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 15:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MMKqw82+7bQ8zDFvQaJkqtrB5/dFEydSXpkQbIv0aYE=;
        b=Y11O10sRIx7Wc3cl64+jOu7vXFL81T6JrBU1E/nQd6G3ibRCmVeaEBg7yH4qOz2b9S
         Qql4D1MLk/cVmyawQi2jQV51n0tUV+Zo4LEFEsG8x3/4SQ5gIUhrueVfhgxNmd/f1dIN
         glSDuj5AV9wF9rvAAKZT8UVKj0CAMGB8r5CjtIIQ8Xx/KggqMn6Z3LjFkFr7BswYp3nk
         hX68YJgkFsJvgZsuQiibJLMehEbagu5tiQya1ssT+MrPIthwNRaU72H2cjWe8zlc6Pox
         31B4oU7dLYCKGl9qXH3x9oprO8BPDjj5G2AmuWAwRJqu7InT94VHxus56+sR7/1QnCPl
         Cspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MMKqw82+7bQ8zDFvQaJkqtrB5/dFEydSXpkQbIv0aYE=;
        b=Vz8gAMG9Hwqq0EVVLByG5EcY7s6qDGLMcSBR10fmbLhM5ykRFDsxaYGvYQGrYGoTNR
         KQhGeixMn9n4YmtZYdKSK9GqcspjuvTvV6U8QwVsknbiOzpFqaXUn8xnnj5MnWdHkVI6
         U2tUj7hDFPpXT5i4Kxh1b+m/PiT47oI1R1vlfBWnVRSenOEZFbwDTuwzZTNVD+Vufs7o
         cPbD6N/SSH8C42EEU1Ba5cD7JC0d7S5TvoXRbGKeN2uEYh3edTYPyjox81mbsYxNxuAO
         ioF4PZE9a87mb8YzMzs/Pnbnf6MlZWDGZMIy0OCLXZgXqlcNzQjZtg03UjXq16lwJqv6
         gDVQ==
X-Gm-Message-State: AIkVDXJD8ka6yawdm/Si+TgZd2Q0oV99kOAJOSfKToaQt7GCEiKdhqQGhM4u/Yv33Ak45g==
X-Received: by 10.99.229.17 with SMTP id r17mr6895181pgh.81.1485991631850;
        Wed, 01 Feb 2017 15:27:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id d128sm52393490pfg.56.2017.02.01.15.27.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 15:27:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     cornelius.weig@tngtech.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: add note about ignoring --no-create-reflog
References: <20170201220727.18070-1-cornelius.weig@tngtech.com>
        <xmqq4m0do86p.fsf@gitster.mtv.corp.google.com>
        <20170201223520.b4er3av67ev5m3ls@sigill.intra.peff.net>
        <xmqqmve5mrpe.fsf@gitster.mtv.corp.google.com>
        <20170201231939.hxhhujpzyb2cqq7a@sigill.intra.peff.net>
Date:   Wed, 01 Feb 2017 15:27:09 -0800
In-Reply-To: <20170201231939.hxhhujpzyb2cqq7a@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 2 Feb 2017 00:19:39 +0100")
Message-ID: <xmqqefzhmr02.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Should this perhaps say "currently" or "this may change in the future",
> so that people (including those who might want to fix it later) know
> that it's a limitation and not intentional?

Good point.

> I'd also probably say it a little shorter, like:
>
>   The negated form `--no-create-reflog` only overrides an earlier
>   `--create-reflog`, but currently does not negate the setting of
>   `core.logallrefupdates`.
>
> I guess that really isn't much shorter (I wondered if you could cut out
> the "overrides --create-reflog" part, since that is the normal and
> expected behavior, but I had trouble wording it to do so).

I had the same trouble wording.  Another thing I noticed was that I
deliberately left it vague what "default" this does not override,
because it appears to me that those who do not set logallrefupdates
will get the compiled-in default and that is also not overriden.

IOW, "does not negate the setting of core.logallrefupdates" will
open us to reports "I do not have the configuration set, but I still
get reflog even when --no-create-reflog is given".

   The negated form `--no-create-reflog` currently does not negate
   the default; it overrides an earlier `--create-reflog`, though.

perhaps?
