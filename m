Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 895C11FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 17:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbcKZRvQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 12:51:16 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33897 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbcKZRvP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 12:51:15 -0500
Received: by mail-io0-f196.google.com with SMTP id r94so14985366ioe.1
        for <git@vger.kernel.org>; Sat, 26 Nov 2016 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/7Cs1ll5eP0FHXVIcmAdthao1J1wcp97/bW5e1f1Ck=;
        b=Z9NPAManXlH1pufPNLqO/umExGzDIrTdFqiZEey4rYPgWoxRs5hNPtG0u/Sp8xC8Nc
         nDyEP6xxSh6pu3Zw+OMG01SEx+CLKlTR4vCt27NZMwag4nWYr3nFzkZEJwe5A40wgKls
         Hux/ZRhqdhgIe5teNBo8tmfkc1aApOSNQll6xm7aeOzAgqCdvWi7HpvZWKA5E+YN7fRL
         Dr1vn/7ixW88c9D74nWe4bulcz6svcS3kr7vrpSskeiq1rNCLU7YccR0Fydt6vWuuSSa
         S04EMlVFvTYGJGQBew+NZRESykXnLL38DTyzRZIjgrrC2ebqCFMGiT3r8InPTXlsdatf
         nt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/7Cs1ll5eP0FHXVIcmAdthao1J1wcp97/bW5e1f1Ck=;
        b=Q5t70N75e2pHa0TCbC/ACcwnFpIYr9Ej3/FswUEBUggiN+4u9HrP/RPr9EZehBwxxp
         srVpsdaWWQIqr8GsgJ5uzBWK9OyHDJ7NXlX8PVIgTyTbvPlPWsSMhyY90AfGNDBSm62X
         Dl6bxhGzgOoXek1LMEt8jhWECY0YeRdrPQE6cOT9V/dlxMhMPevndtejfbMin1yBfm1h
         N4G6BOcPBjHe/EKjvQKs4a/rk6Lkkwkn4J3AZKwXdIKHOpkg1PP2YkgaJ22nF1Ndjha9
         X0OWuKRp1SeY97UJZwv/7UoHJSscNWMWMXAlCsNrSKrKFKPmLnHASVkilw8SaSju4rmi
         NBOg==
X-Gm-Message-State: AKaTC00VjAIoUXniVpm+XvIYGk9ROlgkBo9pmxF8JaPQn5xATWhERw2UINEZEwc58GBh7Q==
X-Received: by 10.107.12.158 with SMTP id 30mr12082543iom.87.1480182674180;
        Sat, 26 Nov 2016 09:51:14 -0800 (PST)
Received: from maggy.simpson.net (50-80-55-235.client.mchsi.com. [50.80.55.235])
        by smtp.googlemail.com with ESMTPSA id i196sm6340442itf.8.2016.11.26.09.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Nov 2016 09:51:13 -0800 (PST)
Message-ID: <1480182671.3830.38.camel@gmail.com>
Subject: Re: git-daemon regression: 650c449250d7 common-main: call
 git_extract_argv0_path()
From:   Mike Galbraith <umgwanakikbuti@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Sat, 26 Nov 2016 18:51:11 +0100
In-Reply-To: <20161126170933.6tge6j5etuchqy33@sigill.intra.peff.net>
References: <1480169028.3830.24.camel@gmail.com>
         <20161126170933.6tge6j5etuchqy33@sigill.intra.peff.net>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.16.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2016-11-26 at 12:09 -0500, Jeff King wrote:
> On Sat, Nov 26, 2016 at 03:03:48PM +0100, Mike Galbraith wrote:
> 
> > git-daemon went broke on me post v2.9.3 due to binaries being installed
> > in /usr/lib/git, which is not in PATH.  Reverting 650c449250d7 fixes it
> > up, as does ln -s /usr/lib/git/git-daemon /usr/bin/git-daemon 'course,
> > but thought I should report it, since it used to work without that.
> 
> Generally /usr/lib/git _should_ be in your PATH, as it is added by the
> git wrapper when you run "git daemon".
> 
> The only behavior difference caused by 650c449250d7 is that we replace
> argv[0] with the output of git_extract_argv0_path(argv[0]), which will
> give the basename, not a full path. So presumably you are running:
> 
>   /usr/lib/git/git-daemon
> 
> directly. I'm not sure that's even supposed to work these days, and it
> was not just a happy accident that it did.

Ah.  I'm using suse's rpm glue to package my modified source, and its
startup script still calls it directly, so wants some modernization.

> On the other hand, I am sympathetic that something used to work and now
> doesn't. It probably wouldn't be that hard to work around it.
> 
> The reason for the behavior change is that one of the cmd_main()
> functions was relying on the basename side-effect of the
> extract_argv0_path function, so 650c449250d7 just feeds the munged
> argv[0] to all of the programs. The cleanest fix would probably be
> something like:

That did fix it up, thanks.  I'll try twiddling the script instead.

> diff --git a/common-main.c b/common-main.c
> index 44a29e8b1..c654f9555 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -33,7 +33,7 @@ int main(int argc, const char **argv)
>  
>  > 	> git_setup_gettext();
>  
> -> 	> argv[0] = git_extract_argv0_path(argv[0]);
> +> 	> git_extract_argv0_path(argv[0]);
>  
>  > 	> restore_sigpipe_to_default();
>  
> diff --git a/git.c b/git.c
> index bd66a2e0a..05986680c 100644
> --- a/git.c
> +++ b/git.c
> @@ -730,6 +730,11 @@ int cmd_main(int argc, const char **argv)
>  > 	> cmd = argv[0];
>  > 	> if (!cmd)
>  > 	> 	> cmd = "git-help";
> +> 	> else {
> +> 	> 	> const char *base = find_last_dir_sep(cmd);
> +> 	> 	> if (base)
> +> 	> 	> 	> cmd = base + 1;
> +> 	> }
>  
>  > 	> trace_command_performance(argv);
>  > 	> trace_stdin();
> 
> -Peff
