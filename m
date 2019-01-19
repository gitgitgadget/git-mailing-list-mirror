Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9BE1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 01:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfASBVz (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 20:21:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38360 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfASBVy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 20:21:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so17211025wrw.5
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 17:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DKun5b8D2pPsLvvBj0na2PiaKq5iCa842wT7NjtZVrM=;
        b=DNmMV+GNFBK3RrjGmqNTBC9msfSeF5BrvQrMUTPlUwId5AHG0rZUFrq1TidilVcA2F
         88C2xGTn1v5FK7EYcb0cXTi9iQHV+GiYa8JoyIJLsZrnhOGe0LbM521uwvYzzFeyaWjS
         qWWK5K8j2yOhxjGnBOtkGZA6uX1z9MUgsO2NBiIUluqVQuroTJWtL5hKEuNBlozLzc2c
         r9K1InIH6zoNK9cNLTn8fohLp+Qp+OO+gvbZoVDrbM8Hz/ztrBXGZP6/yjlirUxKxUnz
         OOJT5pcdvz7AY414+hSqaxWjnv7reAe6NTmUDPNQMjq7GmMZp9Zd9Z44lhAklprfSs8f
         zZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DKun5b8D2pPsLvvBj0na2PiaKq5iCa842wT7NjtZVrM=;
        b=X3EkiEF9oqwVeecO1TFkXLIqxyjoeHrksgqC30GAiiWPPqMnzII+riuhiYmTHA4Dtk
         ZM9HqUo8so28lAyIVTuzBQvAWez15Z0hJiiT9IXRPDyjEVM4PvT0NZP2wClznPGms3AP
         YHSyeEQ+e+WNuDd6kp9WshDiDFgIehbg57GZebtLy8Np+AQ8rBQXpD5stQyxQ3HVzGYe
         7BrJY4JFl1fbTQmSiOFyhfXGrZUNIbl69gr5bkyz/XERgfevdOOTo727vhxGB64hlCgs
         FgjUR616lVZTcWfofq2VKZajhFgnIiGFPUyvjxQhVLJdlatfah7RX3WXm6bYYRWRRPHW
         +rHg==
X-Gm-Message-State: AJcUuke7G2Vasj3LzMG69JxT8z8IJZd2/HCun7eRg6MymA2beEwGAJ8H
        rC4efeLrOXUpqaudC79Rs/s=
X-Google-Smtp-Source: ALg8bN7jHEwMQzjcuPgIV4rVBGFVnp7HBSJKUggndMs6VlFXRggU1z5Go28hGxzVXUiJZZ2ldyhwZg==
X-Received: by 2002:adf:97d1:: with SMTP id t17mr18854733wrb.283.1547860912763;
        Fri, 18 Jan 2019 17:21:52 -0800 (PST)
Received: from szeder.dev (x4dbd9ead.dyn.telefonica.de. [77.189.158.173])
        by smtp.gmail.com with ESMTPSA id z9sm78684397wrs.63.2019.01.18.17.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 17:21:52 -0800 (PST)
Date:   Sat, 19 Jan 2019 02:21:50 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 25/76] diff.c: convert --stat*
Message-ID: <20190119012150.GQ840@szeder.dev>
References: <20190117130615.18732-1-pclouds@gmail.com>
 <20190117130615.18732-26-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190117130615.18732-26-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 08:05:24PM +0700, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  diff.c | 113 ++++++++++++++++++++++++++-------------------------------
>  1 file changed, 52 insertions(+), 61 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 4398b30f47..1b01b36507 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4660,77 +4660,56 @@ int parse_long_opt(const char *opt, const char **argv,
>  	return 2;
>  }
>  
> -static int stat_opt(struct diff_options *options, const char **av)
> +static int diff_opt_stat(const struct option *opt, const char *value, int unset)
>  {
> -	const char *arg = av[0];
> -	char *end;
> +	struct diff_options *options = opt->value;
>  	int width = options->stat_width;
>  	int name_width = options->stat_name_width;
>  	int graph_width = options->stat_graph_width;
>  	int count = options->stat_count;
> -	int argcount = 1;
> +	char *end;
>  
> -	if (!skip_prefix(arg, "--stat", &arg))
> -		BUG("stat option does not begin with --stat: %s", arg);
> -	end = (char *)arg;
> +	BUG_ON_OPT_NEG(unset);
>  
> -	switch (*arg) {
> -	case '-':
> -		if (skip_prefix(arg, "-width", &arg)) {
> -			if (*arg == '=')
> -				width = strtoul(arg + 1, &end, 10);
> -			else if (!*arg && !av[1])
> -				die_want_option("--stat-width");
> -			else if (!*arg) {
> -				width = strtoul(av[1], &end, 10);
> -				argcount = 2;
> -			}
> -		} else if (skip_prefix(arg, "-name-width", &arg)) {
> -			if (*arg == '=')
> -				name_width = strtoul(arg + 1, &end, 10);
> -			else if (!*arg && !av[1])
> -				die_want_option("--stat-name-width");
> -			else if (!*arg) {
> -				name_width = strtoul(av[1], &end, 10);
> -				argcount = 2;
> -			}
> -		} else if (skip_prefix(arg, "-graph-width", &arg)) {
> -			if (*arg == '=')
> -				graph_width = strtoul(arg + 1, &end, 10);
> -			else if (!*arg && !av[1])
> -				die_want_option("--stat-graph-width");
> -			else if (!*arg) {
> -				graph_width = strtoul(av[1], &end, 10);
> -				argcount = 2;
> -			}
> -		} else if (skip_prefix(arg, "-count", &arg)) {
> -			if (*arg == '=')
> -				count = strtoul(arg + 1, &end, 10);
> -			else if (!*arg && !av[1])
> -				die_want_option("--stat-count");
> -			else if (!*arg) {
> -				count = strtoul(av[1], &end, 10);
> -				argcount = 2;
> -			}

This hunk removes the last couple of callsites of the static
die_want_option() function, and building this commit fails with:

  diff.c:107:22: error: ‘die_want_option’ defined but not used [-Werror=unused-function]
   static NORETURN void die_want_option(const char *option_name)
                        ^~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors



