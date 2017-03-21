Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654BC2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 15:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757757AbdCUPwd (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 11:52:33 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34103 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757741AbdCUPwa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 11:52:30 -0400
Received: by mail-wr0-f196.google.com with SMTP id u48so23082569wrc.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=tMUTO8Tbm+2dOnM2jhP4cWDDa5yhzfCnPdHjDjo2yq4=;
        b=czKBBxvImFj/wdWwRrjKGs9f0KS1TlHG8IgdtjFt+YPie6t8ttvoZp611+4dKkJecb
         7iS/E6a84gemz2qsEBVEV65p5y2jO4CPzt1snv+VwEFgEcXmohKC/exigrW1G82lcu7i
         dFgVLDoRSxfiWyQu4M9d/3iT9fT6Xr1nxJm+47d26HNMOsjuwt0X09rAsuMBr63c670V
         qwJatQe+5fPKthWt6zPaVLvZ516Cy8sUV/m9nXWoK9kGurTvjE+BI/gkoT8tE6Y15+r1
         aFFZoxGyGifSfV/8feozZR4XvNfkEKGyYLzLJzk1CabptcpfCyq3zN6sXlTaTt1oQzXo
         Bk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=tMUTO8Tbm+2dOnM2jhP4cWDDa5yhzfCnPdHjDjo2yq4=;
        b=GUIuzavX5PTNLNvB8id5rNejEGVnyBGgrMbCrKuhFVfCTYRxvgCin7niEbIlxlfV6k
         DUVhYVIPReJ5qnFdwtftUFnstWem+kc4YtYCzesLV9MCBWa7kpDDZclY/uef1Vy2eUOm
         /hhOrTp2svzNY3dmr3er45/kFEsf+H9oPSM0m1/RObK4C3auOPl+41uRaSnMx3fmnBHd
         fO+73bSz97SWvrvQsMabISCLEguP0NbdetoID9UW11QQIHIaTCHGtqCBdP1748pElX9x
         aip/o7gPDAf1ifRdDvHBeva7GsTVl9Zd3GTyl98jWe+l6IwLQsi/T9m4yia8GiM8NGub
         pLjg==
X-Gm-Message-State: AFeK/H2XLXcoERnOyUDJEKCTm/J+cr4EQ1hUPZgX4XfsIR95JB/Ue2/8vXHNTcoCGRJA6g==
X-Received: by 10.223.136.4 with SMTP id d4mr31295074wrd.44.1490111548304;
        Tue, 21 Mar 2017 08:52:28 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id i133sm18247503wmg.26.2017.03.21.08.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 08:52:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] doc/SubmittingPatches: show how to get a CLI commit summary
Date:   Tue, 21 Mar 2017 16:51:53 +0100
Message-Id: <20170321155153.20753-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.0.460.g848adbf9b
In-Reply-To: <20170321142154.16993-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Amend the section which describes how to get a commit summary to show
> how do to that with "git show", currently the documentation only shows
> how to do that with gitk.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/SubmittingPatches | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 9ef624ce38..d8c88153c1 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -134,8 +134,17 @@ with the subject enclosed in a pair of double-quotes, like this:
>      noticed that ...
>  
>  The "Copy commit summary" command of gitk can be used to obtain this
> -format.
> +format, or this invocation of "git show":
>  
> +    git show -s --date=short --pretty='format:%h ("%s", %ad)' <commit>
> +
> +To turn that into a handy alias:
> +
> +    git config --global alias.git-commit-summary "show -s --date=short --pretty='format:%h (\"%s\", %ad)'"
> +
> +And then to get the commit summary:
> +
> +    git git-commit-summary <commit>

- 'tformat:' is a better fit than 'format:' in this case, because it
  adds a trailing newline.

- I actually have a pretty format alias exactly for this purpose:

    pretty.commitref=tformat:%h (%s, %as)

  and a shorter 'git log -1 --pretty=commitref <commit>' does the
  trick.  Perhaps it would be worth to provide this as a builtin
  pretty format.
  (Of course this relies on '%as' being interpreted as short author
  date to make the format work on its own, without the additional
  '--date=short'.  Alas, git doesn't support this, see [1].
  If only there were a pretty format specifier for suppressing diff
  output, then the '-s' could go away as well.)

- I find that the two subsequent 'git's in 'git git-<whatever>' look
  strange.  However, to make this point moot right away:

- I don't think SubmittingPatches is the right place to show how to
  create and use a command alias.


[1] - http://public-inbox.org/git/1444235305-8718-1-git-send-email-szeder@ira.uka.de/T/#u

