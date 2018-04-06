Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 473D81F404
	for <e@80x24.org>; Fri,  6 Apr 2018 15:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeDFPR1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 11:17:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:37667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751562AbeDFPRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 11:17:25 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2nfO-1eBwko4AVy-00sf0l; Fri, 06
 Apr 2018 17:17:21 +0200
Date:   Fri, 6 Apr 2018 17:17:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
Subject: Re: [PATCH v5 2/5] stash: convert apply to builtin
In-Reply-To: <20180405022810.15796-3-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1804061715020.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405022810.15796-1-joel@teichroeb.net> <20180405022810.15796-3-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lMf0l6IWOGbSeWg1zArjIIgPuz5468gLpvyd/kmpcjxKKvcoNjU
 8jMGXgIEA0iOsJV6ltTbgea2hFY6rOG6i8XuRPhHGt3Sg93d8Ymp40ItW8jqHstwwhI3AuX
 MRwHaVVkTRuc3NDyVThhTlSOrsqCRqzpH4Alu5OWx6a7rR5AB9/emlqeqTk92iDvKud68q6
 XwVDhM8lXlXn4Bkj4FKMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t3NG7TFfNXA=:0v5j21IR1xwdsOp53JuKAv
 csln5RQUq0DVBDiApHmjt4Oec00TgQdlua0IWEJsStWyoPgTOED8WyHa/e8sCtOOWDPvec4PX
 wpxTzjVhrBVqSvbXU1c5H4K08QYIhuyzMqkS03FeVKfV+WFyPYPuZv6koSsIjXbY7rkDBxCp+
 HEOdSiz2fh+wDGqmZ9+GmAFuPX/tHu8bc1kMFJZb+1zPeivnOLE5JIDrcLl5LVUKOL/E4beiv
 tIVJJJH19/H4PD7ml99/7bK/K4cwSwoOQHzB1m3vZHJvvyRyXyYEbeEJSs037sE27ORgkADNp
 lPQec0lkH3s/7ABUvh+vbirxiup/rYp6PZxbZcj6Ghkvi+o/ScI08DH15lLGBrTuzssK5aHPl
 1HA8//iC0WuDRpxsAvEWjBCVpfOyD0Qx/SmCp9jPoqh9C7O/A2z2b1mqmvCFZf4mKzgqH/NuX
 8guvq+U2XicJe8eCLdQZrZDc9xv752FWRvILnKGTCg9PNf2OGWgTeBt1RMVSOQJX/mBd1gqnE
 mUCl8RQHqgcjPGps4XIXmNMAt4DZsQnVRLokjGrQu/qhP8XGv6mMPZAw1/FIDYPgBuTMRHMeP
 1ou51euCDZ3BkdNniRHf5cQVn/tcbgkzJeUeBmtaINbzaXd2AZWYEtw4bHNFTqnrf+tgYHgZg
 lrXDHIniQD8D0RQ6G3LFvLdPNiQMz1TgFnERUFQRVYBFy/CkDIJ9JJqtB5y8AfQSsFoahqP0G
 LyvOlDuDL8oExTZpAQdJ72f3r+xFhkKHpf/OKETuS7d8vju54S9Anai2iFdYQHVjcHTz1RrNg
 RXBF3XHZROD1wvkmr35DYTBP5qPUhqlyMSXEGsIt4yOpA8dTg9HT9t7HPbjjX/91Bx2WhLr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

completely forgot to reiterate this (my reply to Christian was probably
buried in the thread):

On Wed, 4 Apr 2018, Joel Teichroeb wrote:

> +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> +{
> +	int result = 0;
> +	pid_t pid = getpid();
> +	const char *index_file;
> +
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	git_config(git_default_config, NULL);
> +
> +	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
> +		PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);
> +
> +	index_file = get_index_file();
> +	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file, (uintmax_t)pid);
> +
> +	if (argc < 1)
> +		usage_with_options(git_stash_helper_usage, options);
> +	else if (!strcmp(argv[0], "apply"))
> +		result = apply_stash(argc, argv, prefix);
> +	else {
> +		error(_("unknown subcommand: %s"), argv[0]);
> +		usage_with_options(git_stash_helper_usage, options);
> +		result = 1;
> +	}
> +
> +	return result;
> +}

The `result` variable can contain negative values, while the exit status
really should be either 0 or 1 (and the return value of
`cmd_stash__helper()` is what `run_builtin()` hands to `exit()` as exit
status). So please use

	return !!result;

here (which returns 0 if result is 0, and 1 otherwise).

Ciao,
Dscho
