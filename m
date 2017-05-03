Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A501F829
	for <e@80x24.org>; Wed,  3 May 2017 16:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdECQrt (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 12:47:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36260 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdECQrr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 12:47:47 -0400
Received: by mail-pg0-f65.google.com with SMTP id v1so29117803pgv.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BmdMwJJoBhHtoBgLOw22rhvN6Fww15lPxwmSuiXMY74=;
        b=POW81duGilu/bkK1VFNeclv5spRIb1xFYeOVic04Zrl8FhOsFb0L9JqoYF+OA+10LB
         M7m9GmHLlbF8NRpWYbT9KGprn8UrLis1Fn9vUuSxa7cS1WZ2fvxEW4h2K4bglZkLec1W
         GqE7G1dD8NRADVHlSIyaiX0KPmndISzsG2N5VSzL7IBx3BLbKQzlsU64CKrbmAmR7Z2H
         r7p7f6hEMzhkksVw9mKUpy4RHFnm9pVK/HTZ8GNKTfo8Nj3VPDua8OKw/SZM8rZRMyIR
         GjMLSzYyrnt1YGjNqX015uP0CViwGHPuZs5+OqrUXmCxvdBLnf4jSH6Vhru7vwzd3/LD
         35XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BmdMwJJoBhHtoBgLOw22rhvN6Fww15lPxwmSuiXMY74=;
        b=i161CusL//a/9/K2CKxaF4Dm88bxd+R82nrJWTFLI0C6wl2JRvqzfXYI3skA2kWKPI
         jw4Jkf1zS55hFXN+Dwdhs4jATaGGpbnovRgqUyYjwTj0BHeCy57Bx/BvhfkWnJKOrzie
         luL4l/p9vbIEuarnRDTu12v1spLOWSUpJ3jUA9kBeAsPfmC34MWPaO+NQj+okkrXcfdx
         GduuOXQiTwvMX0ihoWL5D/hlpZrnrfQY9SfjhnyF+TwGwbOZtPoKiYBz+UfSiyxjLHLZ
         gOOpongVsXKm48Vat8khpL2EoiglAZwCpQp4p63wtG/R5SeVprWGZwLXtGNUbUPypKzq
         UsFg==
X-Gm-Message-State: AN3rC/4LV6OIbxmOnZ1jtPfCW8AyBMepxwOlRy3NJrXMRWBiN7kUahKw
        RMK5btPDeprOxg==
X-Received: by 10.99.1.207 with SMTP id 198mr2177342pgb.181.1493830066714;
        Wed, 03 May 2017 09:47:46 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:8ce6:bd0b:35b6:826c])
        by smtp.gmail.com with ESMTPSA id b77sm6242968pfe.39.2017.05.03.09.47.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 09:47:46 -0700 (PDT)
Date:   Wed, 3 May 2017 09:47:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] usability: don't ask questions if no reply is
 required
Message-ID: <20170503164744.GY28740@aiede.svl.corp.google.com>
References: <20170503162931.30721-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503162931.30721-1-jn.avila@free.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jean-Noel Avila wrote:

> As described in the bug report at
>
> https://github.com/git/git-scm.com/issues/999

External issue tracker URLs have been known to change or disappear and
we try to make commit messages self-contained instead of relying on
them.  It is common to put a 'Requested-by:' footer or sentence saying
'Requested at <url> by <person>' near the bottom of a commit message
for attribution and context.  Relying on the bug report more heavily
like this example (instead of including any relevant information)
makes it harder for a reader to understand the patch easily in
one place.

In other words, instead of asking the reader to read the bug report,
please include pertinent information the reader needs to
understand the patch here so they don't have to.

> the user was disconcerted by the question asked by the program not
> requiring a reply from the user. To improve the general usability of
> the Git suite, The following rule was applied:
>
> if the sentence
>  * appears in a non-interactive session
>  * is printed last before exit
>  * is a question addressing the user ("you")
>
> the sentence is turned into affirmative and proposes the option.
>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  help.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/help.c b/help.c
> index bc6cd19cf..4658a55c6 100644
> --- a/help.c
> +++ b/help.c
> @@ -411,8 +411,8 @@ const char *help_unknown_cmd(const char *cmd)
>  
>  	if (SIMILAR_ENOUGH(best_similarity)) {
>  		fprintf_ln(stderr,
> -			   Q_("\nDid you mean this?",
> -			      "\nDid you mean one of these?",
> +			   Q_("\nThe most approaching command is",
> +			      "\nThe most approaching commands are",
>  			   n));

For what it's worth, I find the new text harder to understand than the
old text.

From the bug report:

	Now git says git: 'stahs' is not a git command. See 'git --help'.
	Did you mean this?

	stash

	Git asked if i meant git stash. and i entered yes. and git
	printed the character y infinite times.

If I'm reading that correctly, the problem is not that questions are
alarming but that Git did not cope well with the answer.  When I try
to reproduce it, I get

	$ git stahs
	WARNING: You called a Git command named 'stahs', which does not exist.
	Continuing under the assumption that you meant 'stash'
	in 5.0 seconds automatically...

which is much clearer.  After commenting out "[help] autocorrect = 50" in my
~/.config/git/config, I get

	$ git stahs
	git: 'stahs' is not a git command. See 'git --help'.

	Did you mean this?
		stash

which does seem improvable, at least for consistency with the
autocorrect case.  For example, would something like

	$ git stahs
	fatal: You called a Git command named 'stahs', which does not exist.
	hint: Did you mean 'git stash'?

work better?  And the autocorrect case could say something like

	$ git stahs
	warning: You called a Git command named 'stahs', which does not exist.
	warning: Continuing under the assumption that you meant 'stash'
	warning: in 5.0 seconds automatically...

Is contact information for the bug reporter available so we can try out
different wordings and see what works for them?

Thanks and hope that helps,
Jonathan
