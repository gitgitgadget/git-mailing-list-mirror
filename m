Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363A11F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 04:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbeFAEcs (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 00:32:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52385 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeFAEcr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 00:32:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id 18-v6so427365wml.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 21:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lSEGJCOgbXxOo5Nh/lEtTi8Cp8rR1MlbQDzAdWlDid4=;
        b=D9ZMCPsIoqrMNOFI8N+DPFFklOKSShSgZ3kF2yCuST1ZHQRxyBTJGsP249+App+aHJ
         yQj7TzPKPfH/LVmLLxDsfr18ZGgU1rtiIAX6VelJE3ZV0QZ6niPKHqAagQAoa3VJR7Lp
         XMWx30JlbdDFFezGRzUh1ukqdSyAEeaL20ePH6VJBNsGiXjPu5galY93rVcJUrxdXdZh
         bIFahz2r0WMP15527ueHbSdhAxaH5g7bkeDUx8YbLpBDFehhifkuwuMk8lvufrNKJHCm
         7r0dDXPQ/JdeeVYri8vPRxtY+3UwNq4OA9pfdmO2zSkOBDi344LpERiLFuZIlXS2V1S7
         7mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lSEGJCOgbXxOo5Nh/lEtTi8Cp8rR1MlbQDzAdWlDid4=;
        b=VPHfxsOhCJEsnWa5TtCBVPvkMyq575fj2iU0sN65xhwXshFQt9RTrI4PrtlQCxpctK
         H0/OBWmAvhhpDviNddgOf0mmUQpRPNyiGJf0zAyi6q4/jHhWJksgIIYDbq3xu3XpVnel
         To2+7s5VJ4u+vvYJEIwheDjozoZ2JzK2gNC+5Gq8FuBhJA5Zak/cGD749S6CsmQ0BRH2
         6B6WgN5s9KpG41psbaoez48XC21wQwqrFkBeYUleErdjyROcQNNzfRjTYJ0Fks6wtujq
         eJhB6qN0O8AY9fBn5uYn3TmOxovt8EacpoO7OU66ozdq5grH9Okn87nm3XAvsb7DccfH
         mgxA==
X-Gm-Message-State: APt69E2pJmF9e7uaV7iUKmSJ5/cBdQjKk3Dm/FtajeRZTmidK9ud5lSr
        CwUIQ0JJCC2V10O2Ar7P9IU=
X-Google-Smtp-Source: ADUXVKJchicbiDB44yJNAn3cnZsaDHpkDqp0JVB0u7311p2fT957myKMXCgX29Y0t6bovUNDYhlhZA==
X-Received: by 2002:a1c:d391:: with SMTP id k139-v6mr1386654wmg.45.1527827566013;
        Thu, 31 May 2018 21:32:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i46-v6sm18325529wra.36.2018.05.31.21.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 21:32:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 8/9] checkout: add advice for ambiguous "checkout <branch>"
References: <20180531195252.29173-1-avarab@gmail.com>
        <87a7sg9sjz.fsf@evledraar.gmail.com>
        <20180531195252.29173-9-avarab@gmail.com>
Date:   Fri, 01 Jun 2018 13:32:44 +0900
In-Reply-To: <20180531195252.29173-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 31 May 2018 19:52:51 +0000")
Message-ID: <xmqqin7386tv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> @@ -1269,6 +1270,16 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	if (opts.patch_mode || opts.pathspec.nr) {
>  		int ret = checkout_paths(&opts, new_branch_info.name,
>  					 &dwim_remotes_matched);
> +		if (ret && dwim_remotes_matched > 1 &&
> +		    advice_checkout_ambiguous_remote_branch_name)
> +			advise(_("The argument '%s' matched more than one remote tracking branch.\n"
> +				 "We found %d remotes with a reference that matched. So we fell back\n"
> +				 "on trying to resolve the argument as a path, but failed there too!\n"
> +				 "\n"
> +				 "Perhaps you meant fully qualify the branch name? E.g. origin/<name>\n"
> +				 "instead of <name>?"),
> +			       argv[0],
> +			       dwim_remotes_matched);
>  		return ret;

Do we give "checkout -p no-such-file" the above wall of text?

Somehow checkout_paths(), which is "we were given a tree-ish and
pathspec and told to grab the matching paths out of it and stuff
them to the index and the working tree", is a wrong place to be
doing the "oh, what the caller thought was pathspec may turn out to
be a rev, so check that too for such a confused caller".  Shouldn't
the caller be doing all that (which would mean we wan't need to pass
"remotes-matched" to the function, as the helper has nothing to do
with deciding which arg is the tree-ish).

