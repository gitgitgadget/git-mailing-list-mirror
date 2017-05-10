Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1723F2018D
	for <e@80x24.org>; Wed, 10 May 2017 05:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdEJFwx (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 01:52:53 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33317 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdEJFww (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 01:52:52 -0400
Received: by mail-pf0-f172.google.com with SMTP id e193so10757548pfh.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 22:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aHyeSPNYvZ8HB8A5p7005P7SoTN8Kl3ic9uyf6EfIa4=;
        b=sHK8osMcD1EGxi/+XRK/2YhTbkTNArRhMO5nNwtmVjnLnifFP/eEQhgVLSCjkZ+JyB
         Z+tTvNR8vruyTrftMNzOJ9bO2kTSBSOSghKezaLaYTfWXPRW3lrZsCPAmROKpM/NCOu7
         zZqaaK2bOLVbAKUMpiGZq85DY7KK06faBpHSwQ+SRNUPIE6ZAKC4uirE79iwA6Gn0bXS
         a8yVLgC3t9ox+4HB9qKB9UIeKz7prMU+Bs8ayQrTAjk+C2IPbyqSspLpPHj7GiBJqWT0
         xcm3CcFAabD/wHhf0V2wVVf0IXuzJzqrFnU6w7XLHdA2BdvxwPeGgcz2IDdx146T0C8O
         kAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aHyeSPNYvZ8HB8A5p7005P7SoTN8Kl3ic9uyf6EfIa4=;
        b=Zb1cBoyIhKtTh8BMLtLVa2Uc/LWRn3sEE6T0FUU3/qYVLoNmND67IesNBJ2bBagTDl
         XfpaqXs6+lPuGBTSe98sU0VbRv+Pbn/+EetVJGXlRsaX0QsRGC1bpdDg7+JC0dpXZGP9
         M9evusLqrsPNcr57vEVBVveQSJiPivX0rUQ2g9YmOhdssNWvLnmAjhwPPaUKbQpD8JRN
         OiFa/m4JYASY43uDZMZ1wgJaPvgsikBuh5ZwH2hrl2F1WMLXyf5esq/AiYk5xBAXgu9n
         u3HBqbUII1Kv0zK77vBRYOgGC5PokKvm2z8K+TRfEXSAiqWidkD7MAFUTkKmNNZ0Prqh
         K+UQ==
X-Gm-Message-State: AODbwcAnjVfWBv9NlmdVNJyTd6r5np7j6OtQkAEWOjHIhqB8c9702Nkh
        19znC6SDR87oYjzpBQQ=
X-Received: by 10.98.112.134 with SMTP id l128mr4166752pfc.161.1494395571810;
        Tue, 09 May 2017 22:52:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id d1sm2828507pfa.56.2017.05.09.22.52.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 22:52:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/8] pathspec: change PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
References: <20170509191805.176266-1-bmwill@google.com>
        <20170509191805.176266-4-bmwill@google.com>
Date:   Wed, 10 May 2017 14:52:49 +0900
In-Reply-To: <20170509191805.176266-4-bmwill@google.com> (Brandon Williams's
        message of "Tue, 9 May 2017 12:18:00 -0700")
Message-ID: <xmqqefvxxnpq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> It's confusing to have two different 'strip submodule slash' flags which
> do subtly different things.  Both
> PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE and
> PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP will accomplish the same task of
> striping a slash from a pathspec which matches a submodule entry in the
> index.  The only difference is that
> PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE will perform additional checks
> and die if a pathspec has a leading path component which corresponds to
> a submodule.  This additional functionality should be split out into its
> own flag.
>
> To this end, rename the PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag to
> PATHSPEC_SUBMODULE_LEADING_PATH and change its behavior to only die if a
> path descends into a submodule.  In addition add the
> PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag to callers which relied on the
> old slash stripping functionality.

"PATHSPEC_SUBMODULE_LEADING_PATH" feels like an unfinished sentence
to me.  Do I understand your description correctly if I say it is
about "checking" the leading path to see if it overlaps with a
submodule path?  IOW, I am wondering if the name should have the
word CHECK somewhere in it.

