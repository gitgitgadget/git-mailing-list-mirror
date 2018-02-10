Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8121F576
	for <e@80x24.org>; Sat, 10 Feb 2018 09:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbeBJJ3y (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 04:29:54 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36103 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeBJJ3x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 04:29:53 -0500
Received: by mail-pl0-f67.google.com with SMTP id v3so2600572plg.3
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 01:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OehAsgOXgl+ZblbUQlRSG2ad8aTkCR4WGNsHne11Lqc=;
        b=VBX3Kx4QcQHRuhW+t9MeTNVcWwllCr3rxYbanMaefGjD1eR43fdQiptl6Kx5sbo4Rk
         8XVU44xIrHHadHJ7ULt2SxNaAepvO6Q7BTZ0nUGdOQrTAOqd4fqMcsZJNj0co7ofKmus
         CLaCJZmPxtvUsWr+kk2N9Te8BPasmepmM3ZJcKnwA0gBju4llCTmi/sNgcUmFH3HJwxg
         KGEA8K7OpSi+XNMNtPpweSEawrYY7bH197BxOTzlsMW4iAfXZXBIq785vbIFleDAYDdd
         shlOJ/Q7+kUJ3uMT4tAkyJyt01UvZRqhM62hR4z0ANR7NH1cOSgqewcd1TPYc/JAlCnK
         2u0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OehAsgOXgl+ZblbUQlRSG2ad8aTkCR4WGNsHne11Lqc=;
        b=W+guGxGtharu9ihJOymjxX4p1Rq1S5BiShJ7VLydRhKJi1DPhriJ27A+6ZKHMWlQC3
         D0c3NrPOyPDsvJqJpt/awLnYs41X+j1Jf6U1stE3bfpzgfnuf6XzK2dcUkEBMqZI4Qfb
         dcFR/meFmTEH58rM0r+6Q0JP7BXxnwUTJol0un/XBHQPqW7U7qMaPYUfFpBmIYYybD6p
         naneE8h69SPc2vY6AOA0mgfAtSHOcBB0EN6Rsky3Bzwe5OQuFS8lNqs18blR3F1W8huF
         xPFCvHRWCCKs1PAvmafYUt7hkrqg4IOcWpNgQXO4Md1uzCFfeSJ3wPKeViKtc68UuPn+
         DV5g==
X-Gm-Message-State: APf1xPClwU5tX2ULovralkJNzcMXWbD+vSqxbEPD3YcmHvB2MTTp8X69
        XdCtrzLgMKQSG2tpfzAnyxw=
X-Google-Smtp-Source: AH8x225Qxw5mFh4+f+sT6nAEUd3PWU8kpi/0YQvHj9GOR4hM+u2w0vjSO8qVRZhICI33kPLF1YSUmA==
X-Received: by 2002:a17:902:bf01:: with SMTP id bi1-v6mr5076260plb.254.1518254993005;
        Sat, 10 Feb 2018 01:29:53 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id h80sm11669094pfj.12.2018.02.10.01.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Feb 2018 01:29:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 10 Feb 2018 16:29:46 +0700
Date:   Sat, 10 Feb 2018 16:29:46 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 42/42] git-completion.bash: add
 GIT_COMPLETION_OPTIONS=all config
Message-ID: <20180210092945.GA6370@ash>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-43-pclouds@gmail.com>
 <877ermmeia.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877ermmeia.fsf@evledraar.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09, 2018 at 03:19:57PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Feb 09 2018, Nguyễn Thái Ngọc Duy jotted:
> 
> > By default, some option names (mostly --force, scripting related or for
> > internal use) are not completable for various reasons. When
> > GIT_COMPLETION_OPTIONS is set to all, all options (except hidden ones)
> > are completable.
> >
> > Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash |  6 +++++-
> >  parse-options.c                        | 11 +++++++----
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 0ddf40063b..0cfa489a8e 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -36,6 +36,10 @@
> >  #
> >  #     When set to "1", do not include "DWIM" suggestions in git-checkout
> >  #     completion (e.g., completing "foo" when "origin/foo" exists).
> > +#
> > +#   GIT_COMPLETION_OPTIONS
> > +#
> > +#     When set to "all", complete all possible options
> 
> I was going to suggest some wording like:
> 
>     When set to "all", include options considered unsafe such as --force
>     in the completion.
> 
> However per your cover letter it's not just used for that:
> 
>      10 --force
>       4 --rerere-autoupdate
>       1 --unsafe-paths
>       1 --thin
>       1 --overwrite-ignore
>       1 --open-files-in-pager
>       1 --null
>       1 --ext-grep
>       1 --exit-code
>       1 --auto
> 
> I wonder if we shouldn't just make this only about --force, I don't see
> why "git grep --o<TAB>" should only show --or but not
> --open-files-in-pager, and e.g. "git grep --<TAB>" is already verbose so
> we're not saving much by excluding those.
> 
> Then this could just become:
> 
>     GIT_COMPLETION_SHOWUNSAFEOPTIONS=1
> 
> Or other similar boolean variable, for consistency with all the "*SHOW*
> variables already in git-completion.bash.

No. You're asking for a second default. I'm not adding plenty of
GIT_COMPLETION_* variables for that. You either have all options, or
you convince people that --force should be part of the current
default.

Or you could push for a generic mechanism that allows you to customize
your own default. Something like the below patch could give you what
you want with:

    GIT_COMPLETION_OPTIONS=all
    GIT_COMPLETION_EXCLUDES=--open-files-in-pager # and some more
    . /path/to/git-completion.bash

I'm not going to make a real patch for this since people may want to
ignore --foo in one command and complete --foo in others... I'm just
not interested in trying to cover all cases.

-- 8< --
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0cfa489a8e..9ca0d80cd7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -40,6 +40,10 @@
 #   GIT_COMPLETION_OPTIONS
 #
 #     When set to "all", complete all possible options
+#
+#   GIT_COMPLETION_EXCLUDES
+#
+#     Exclude some options from the complete list
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -298,7 +302,7 @@ __gitcomp_builtin ()
 	# commands, e.g. "git remote add" becomes remote_add.
 	local cmd="$1"
 	local incl="$2"
-	local excl="$3"
+	local excl="$3 $GIT_COMPLETION_EXCLUDES"
 
 	local var=__gitcomp_builtin_"${cmd/-/_}"
 	local options
-- 8< --
