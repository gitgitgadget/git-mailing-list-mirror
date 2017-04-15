Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 353C020D09
	for <e@80x24.org>; Sat, 15 Apr 2017 11:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753472AbdDOLtL (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 07:49:11 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33123 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbdDOLtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 07:49:09 -0400
Received: by mail-pg0-f41.google.com with SMTP id x125so53149719pgb.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 04:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YVMp4GW6TpUMjAtqfdLXDoTFQEDyfkTpqYDZdu3wAWU=;
        b=D8V16PtlKK1/fEMkJzXSFb3x3JVKqyN7941T2TfF5qhMn7jcEg8iccNAUV0z3nYm75
         28I+Z1+efgQUFo/yW3khdpCGX2tMa8DE95ebe9dhCswzY2Qn90rcPzLq77ED2XJ37xBW
         +VpS2PvyTsUhfAwSSR6uGCKCTVG413n/hO046ovO9uLKIvOxsTCIuCc+80CDisSPSW+F
         L2ptmX7rLXKj4kr3zJjxt6QSZYGxKbijuOtA9DFTum8xKJBZcF5hccoWN2kYnXfHklm6
         sYBJazEsBsNU+XAuDlB/8aafYwPja664SKi52q2pr2UBaRKx4Wec/kSB9ufZrDsF32BK
         UyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YVMp4GW6TpUMjAtqfdLXDoTFQEDyfkTpqYDZdu3wAWU=;
        b=PGlMrmiipN21uHWdU726UwA99pEZGzluyv/M39IH506mc/PUzGCFwdKGww/u+vfeuN
         /9gDXR1wtLjeJlvhaOxvUdb41FFieqi+7fM1T6Q00PoZZUM9NVdag7iL2OAZ89XljN8m
         5+K9EEtL27KbonL0ouZUgV+DNEWNQ/8QBNYHXnEc5DCbPpbtJ6zuHuCYzLo2/f/mSA5k
         lYo7TW61PMb3oeklf+HNPTSDl91VHeKyprnE019JORwyztHJDMiOaNW+H74brE40SW4c
         tZov2jQC4OodXSn5JQT0CfxMyXQrxOlxpP4TAmgLA8GkepEiNDRucjagTsmeDUagL/W/
         Bo3A==
X-Gm-Message-State: AN3rC/5M1iI4b41+AhMnhPdQ7Q86qLl9BgEkKYRHW2QxnZZCAbSehl9A
        9aPQRO10kaIdAg==
X-Received: by 10.99.24.86 with SMTP id 22mr2306084pgy.238.1492256948171;
        Sat, 15 Apr 2017 04:49:08 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id a190sm8280169pgc.60.2017.04.15.04.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Apr 2017 04:49:07 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 15 Apr 2017 18:49:01 +0700
Date:   Sat, 15 Apr 2017 18:49:01 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: includeIf breaks calling dashed externals
Message-ID: <20170415114901.GA5727@ash>
References: <CAKPyHN1W175wm1doQHF71vB3PHpU2o=xtEAcZMqZtR=U_Kv0_g@mail.gmail.com>
 <20170414174337.n6qksfvugkrexnsi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170414174337.n6qksfvugkrexnsi@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 01:43:37PM -0400, Jeff King wrote:
> On Fri, Apr 14, 2017 at 07:04:23PM +0200, Bert Wesarg wrote:
> 
> > Dear Duy,
> > 
> > heaving an includeIf in a git config file breaks calling external git
> > commands, most prominently git-gui.
> > 
> > $ git --version
> > git version 2.12.2.599.gcf11a6797
> > $ git rev-parse --is-inside-work-tree
> > true
> > $ git echo
> > git: 'echo' is not a git command. See 'git --help'.
> > 
> > Did you mean this?
> >     fetch
> > $ echo '[includeIf "gitdir:does-not-exists"]path = does-not-exists'
> > >>.git/config
> > $ git rev-parse --is-inside-work-tree
> > true
> > $ git echo
> > fatal: BUG: setup_git_env called without repository
> 
> Probably this fixes it:
> 
> diff --git a/config.c b/config.c
> index b6e4a57b9..8d66bdf56 100644
> --- a/config.c
> +++ b/config.c
> @@ -213,6 +213,9 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
>  	struct strbuf pattern = STRBUF_INIT;
>  	int ret = 0, prefix;
>  
> +	if (!have_git_dir())
> +		return 0;
> +
>  	strbuf_add_absolute_path(&text, get_git_dir());
>  	strbuf_add(&pattern, cond, cond_len);
>  	prefix = prepare_include_condition_pattern(&pattern);
> 
> But it does raise a question of reading config before/after repository
> setup, since those will give different answers. I guess they do anyway
> because of $GIT_DIR/config.

This happens in execv_dased_external() -> check_pager_config() ->
read_early_config(). We probably could use the same discover_git_directory
trick to get .git dir (because we should find it). Maybe something
like this instead?

diff --git a/config.c b/config.c
index 1a4d85537b..4f540ae578 100644
--- a/config.c
+++ b/config.c
@@ -212,8 +212,14 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
 	struct strbuf text = STRBUF_INIT;
 	struct strbuf pattern = STRBUF_INIT;
 	int ret = 0, prefix;
+	struct strbuf gitdir = STRBUF_INIT;
 
-	strbuf_add_absolute_path(&text, get_git_dir());
+	if (have_git_dir())
+		strbuf_addstr(&gitdir, get_git_dir());
+	else if (!discover_git_directory(&gitdir))
+		goto done;
+
+	strbuf_add_absolute_path(&text, gitdir.buf);
 	strbuf_add(&pattern, cond, cond_len);
 	prefix = prepare_include_condition_pattern(&pattern);
 
@@ -237,6 +243,7 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
 			 icase ? WM_CASEFOLD : 0, NULL);
 
 done:
+	strbuf_release(&gitdir);
 	strbuf_release(&pattern);
 	strbuf_release(&text);
 	return ret;

--
Duy
