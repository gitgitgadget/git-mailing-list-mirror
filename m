Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E6920248
	for <e@80x24.org>; Mon,  8 Apr 2019 16:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfDHQLj (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 12:11:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46243 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfDHQLi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 12:11:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so17056692wrw.13
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AjxMJ4SRmkSbMKZXCNqfz19yIEZ8YsYqn6ACyYkK0H0=;
        b=A4gNvPDb4hnUhGFMLM99J7/sx8BU8IcjOS4A+mJFtmQr5uIQK3wkTsAz9pm4IIydNM
         rYpXNhoMlk8+dGS7YpD8zwFTMpqH/9P9zmxPPrabjypWwFhmC4Z5uXaIJznenkQ2fUsr
         cKD4V/rfAiiIGZoBrOWkOpwJbqBhyVYwq/Q3IOE/06t74IKufeVuRM/97Dz1+/3H7Rn4
         C+zWGmkvJgODtqUaZiiIKuEkhxGxrJzwtQJ4AsCwst1dsB6Nb9V+x2SCsn82oQZsbc6x
         vrBff0VImCZ7dIFv5iVZksnF1BHY/1+4fR00koVFBinCo1yhL9dT4Hckj1dHTGu5vXG8
         67Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AjxMJ4SRmkSbMKZXCNqfz19yIEZ8YsYqn6ACyYkK0H0=;
        b=GUIO1mzsdWCqXYZ2aSU0DtQgTi8DKgZxUSrHxlTTYHhKM6t8ekNzV+JH5gNZVzficK
         XUWbIsO7cDz2G53/2ThQGUaGeUVtubQahtJxewG1Z27vfDfXrrRZK15P3EBOZkhznSGa
         MMg7+Y4gfdKXm5j/h+falDIoX8dgcYcsGcV3EfoUv8AcFk7g+3hfPQLTeOBVb2gdoCcG
         FJ1CH1G886py9I+ZUyeLtIIYa/kl7dq8TS7nde78VMMFFo1yNnrEBHbxcEP3NaE2XAdq
         ru9xihCfDNbJbvk++kVxZR/6OmEJrgdS3BeMuOvRrx5rI52tGQkiF6A0x2NlAACTcXCN
         wT6A==
X-Gm-Message-State: APjAAAUAndMaJ6X0sK81gHcLeHqc0K4MbI/+gLxQz6tunvKA8ch+/MVS
        IAiBE/o69Ye97WPFz440RTk=
X-Google-Smtp-Source: APXvYqzTH2Q8tvR2p9XV3Gz1znfDoVU9Ul9tgo8qJc1D1MLtYVq3PXy5CscnzeKix/i8r5oTxh5w7Q==
X-Received: by 2002:adf:f344:: with SMTP id e4mr20881481wrp.77.1554739896387;
        Mon, 08 Apr 2019 09:11:36 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id v1sm43132721wrd.47.2019.04.08.09.11.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 09:11:35 -0700 (PDT)
Date:   Mon, 8 Apr 2019 18:11:34 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Pull without fetch
Message-ID: <20190408161134.gdxmxvqitxioeibp@feanor>
References: <20190406131200.xcd7gtf7dlc567uh@doriath>
 <xmqq4l79cmb4.fsf@gitster-ct.c.googlers.com>
 <20190408145340.3rdprg3yu5shpelu@feanor>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408145340.3rdprg3yu5shpelu@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Mon, 08 Apr 2019 18:09:07 +0200
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Damien Robert, Mon 08 Apr 2019 at 16:53:40 (+0200) :
> > Others may have a better idea, but I do not immediately see any
> > solution better than inventing a new option to "git pull".

So here is a RFC patch that implements --no-fetch. (I am not sure about
the wording of the documentation, and what's the best way to test that
fetch was not called).

-- >8 --

From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date: Mon, 8 Apr 2019 17:51:51 +0200
Subject: [PATCH 1/1] pull: add --no-fetch

A common workflow is to do a fetch, review the changes, and then
integrate the changes via an explicit merge or rebase.

In the good old days `git pull` was essentially `git fetch` followed by
`git merge FETCH_HEAD` so it was easy to separate the fetching part from
the integrating part.

But nowadays there are no easy way to do the integrating part of `git
pull`. Indeed, `git pull` learnt to read the config values of
`branch.<current>.rebase` and `pull.rebase`, whose possible values are
growing. At the time of this commit, they can be 'true', 'merges',
'preserve' and 'interactive'.

To remedy this, add a new --no-fetch option to `git pull`.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/git-pull.txt |  9 +++++++++
 builtin/pull.c             |  8 ++++++--
 t/t5520-pull.sh            | 14 ++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 118d9d86f7..cec06bf6e3 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -144,6 +144,15 @@ This option is only valid when "--rebase" is used.
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
+--fetch::
+--no-fetch::
+	Perform a fetch first. This option can be used to override
+	--no-fetch.
++
+With --no-fetch don't fetch before updating the branch via a merge or a
+rebase. This can be used to review changes by doing a fetch first before
+pulling.
+
 include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
diff --git a/builtin/pull.c b/builtin/pull.c
index 33db889955..0c14701abe 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -111,6 +111,7 @@ static char *opt_gpg_sign;
 static int opt_allow_unrelated_histories;
 
 /* Options passed to git-fetch */
+static int opt_fetch = 1;
 static char *opt_all;
 static char *opt_append;
 static char *opt_upload_pack;
@@ -195,6 +196,8 @@ static struct option pull_options[] = {
 
 	/* Options passed to git-fetch */
 	OPT_GROUP(N_("Options related to fetching")),
+	OPT_BOOL(0, "fetch", &opt_fetch,
+		N_("fetch before merging / rebasing (default)")),
 	OPT_PASSTHRU(0, "all", &opt_all, NULL,
 		N_("fetch from all remotes"),
 		PARSE_OPT_NOARG),
@@ -912,8 +915,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			oidclr(&rebase_fork_point);
 	}
 
-	if (run_fetch(repo, refspecs))
-		return 1;
+	if (opt_fetch)
+		if (run_fetch(repo, refspecs))
+			return 1;
 
 	if (opt_dry_run)
 		return 0;
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index cf4cc32fd0..058c85e6a4 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -134,6 +134,20 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	test_cmp reflog.expected reflog.fuzzy
 '
 
+test_expect_success 'With --no-fetch will not fetch but still merge pending changes' '
+	git checkout -b nofetch master^ &&
+	echo modified >file &&
+	git commit -a -m modified &&
+	git checkout copy &&
+	git reset --hard HEAD^ &&
+	test "$(cat file)" = file &&
+	stat --format %Y .git/FETCH_HEAD > fetch_head_before &&
+	git pull --no-fetch . nofetch &&
+	stat --format %Y .git/FETCH_HEAD > fetch_head_after &&
+	test "$(cat file)" = modified &&
+	test_cmp fetch_head_before fetch_head_after
+'
+
 test_expect_success 'fail if wildcard spec does not match any refs' '
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
-- 
Patched on top of v2.21.0-196-g041f5ea1cf (git version 2.21.0)

