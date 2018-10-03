Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0A51F453
	for <e@80x24.org>; Wed,  3 Oct 2018 06:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJCNLP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 09:11:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36787 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCNLP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 09:11:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id d4-v6so3262846lfa.3
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xrNGV/mFvK66TRLY3rPXzghXqYJ9XUSPQ01RhZm/lxo=;
        b=bTdUTeKzyK31Li56WnxOfZB31xPyNm/T/lhRJBHmnQ7oA/Neo902W4CGxo/OxaA89i
         0XJXzkPZvEur56MWz0DQfo/LfFibOSH7JixHj9O6eIJBf5PYk16v9seLZs1w+a1WUQrl
         S71YHUhnS3G6XgQF7kWVgsYMh7hbTqhib2R38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xrNGV/mFvK66TRLY3rPXzghXqYJ9XUSPQ01RhZm/lxo=;
        b=r7YIttaymkC2w0OASWbUG+pZkKUg2iNmEm/hTrWfJ1rD/BFZ2/TEzimaJ8FUTd52mt
         YP5KRHToTmK/ahloaWjD9Pzvl9x25FUcRfWJFJesS+7j+siHR9UAVckI/cPfdgkoHxCi
         /5S1F17bFQkUMAosWd6+NUZXJpwVuQnkY1gAB8WZSkA3Kah4t3ADl5yXOPVjX8SX+VCS
         +rImDhrBrZw1eNu8bNFn+JNGe5BRhxxcfvEmEXGE5As+bC7+a+G8YSRg/XgCYS72WCN2
         QBCDIMUTVgJeOBLUGKTf8az7mkXMc+Cj58NUdLBglaBLwwzhPsd7w9wSMInljx10sVpg
         JysQ==
X-Gm-Message-State: ABuFfoiAysCBAgwNlA96vdxYVQKUQd3gzHD7PsuTtlSlucqIdP4Fjn72
        g3yk1g9ZWIVK3uQeTExgQTD4mA==
X-Google-Smtp-Source: ACcGV61MT4I/5WE/dkesQBms1HU3CABDgUI4+cS4mSsoTjab9BqH6n14YsraHPhAJyjiNOr6MmMUbA==
X-Received: by 2002:a19:d824:: with SMTP id p36-v6mr219lfg.23.1538547857053;
        Tue, 02 Oct 2018 23:24:17 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 33-v6sm93552lfu.64.2018.10.02.23.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 23:24:16 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] help: redirect to aliased commands for "git cmd
 --help"
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-1-rv@rasmusvillemoes.dk>
 <20181003021358.GA20553@sigill.intra.peff.net>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <9ab3d69a-033a-e5a0-7459-c6ba8a2ec853@rasmusvillemoes.dk>
Date:   Wed, 3 Oct 2018 08:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003021358.GA20553@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-03 04:13, Jeff King wrote:
>> +		/*
>> +		 * If we were invoked as "git help cmd", or cmd is an
>> +		 * alias for a shell command, we inform the user what
>> +		 * cmd is an alias for and do nothing else.
>> +		 */
>> +		if (!exclude_guides || alias[0] == '!') {
>> +			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
>> +			free(alias);
>> +			exit(0);
>> +		}
> 
> I'm not sure I understand why exclude_guides is relevant. We check it
> below when we know that we _don't_ have an alias. Hrm. I guess you're
> using it here as a proxy for "git foo --help" being used instead of "git
> help foo".

Exactly. Perhaps it's abusing the existing machinery, but I didn't know
how else to distinguish the two cases, and didn't feel like introducing
another way of passing on the exact same information.

> The comment probably needs to spell out that exclude_guides
> is the same as your "we were invoked as...".

Will do. That will also make the string --exclude-guides (i.e., with a
dash) appear in the comment, making it more likely to be found should
anyone change when and how --exclude-guides is implied.

> I wonder if we could change the name of that option. It is an
> undocumented, hidden option that we use internally, so it should be OK
> to do so (or we could always add another one). That might prevent
> somebody in the future from using --exclude-guides in more places and
> breaking your assumption here.

Perhaps, but I think that's better left for a separate patch, if really
necessary even with the expanded comment.

>> +		count = split_cmdline(alias, &argv);
>> +		if (count < 0)
>> +			die(_("bad alias.%s string: %s"), cmd,
>> +			    split_cmdline_strerror(count));
>> +		return alias;
> 
> So we split only to find argv[0] here. But then we don't return it. That
> works because the split is done in place, meaning we must have inserted
> a NUL in alias. That's sufficiently subtle that it might be worth
> spelling it out in a comment.

OK, I actually had precisely

+		/*
+		 * We use split_cmdline() to get the first word of the
+		 * alias, to ensure that we use the same rules as when
+		 * the alias is actually used. split_cmdline()
+		 * modifies alias in-place.
+		 */

in v1, but thought it might be overly verbose. I'll put it back in.

> We don't need to free alias here as we do above, because we're passing
> it back. We should free argv, though, I think (not its elements, just
> the array itself).

Yeah, I thought about this, and removing free(argv) was the last thing I
did before sending v1 - because we were going to leak alias anyway. I'm
happy to put it back in, along with...

> Unfortunately the caller is going to leak our returned "alias", [...] I think it may be OK to overlook
> that and just UNLEAK() it in cmd_help().

...this. Except I'd rather do the UNLEAK in check_git_cmd (the
documentation does say "only from cmd_* functions or their direct
helpers") to make it a more targeted annotation.

Thanks,
Rasmus
