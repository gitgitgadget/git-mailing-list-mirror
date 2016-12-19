Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322FB1FF76
	for <e@80x24.org>; Mon, 19 Dec 2016 11:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbcLSLSu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 06:18:50 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36202 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbcLSLSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 06:18:48 -0500
Received: by mail-pf0-f194.google.com with SMTP id c4so7453685pfb.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 03:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vmeiuEq+pNSxF85fxKh/5NbdUj07GvXF4VZCioKzJDw=;
        b=pAV+iFo6kcuVexsV7NP8oPSvFDwp7F1hIpSZLcctgYM7fM8Pbov3TBhIG0aWVhCB1E
         DFMvTyBI5N4nVUIVbfvkjy3iTBCKctcxmdemP+MCUeyxAWmaKS5w2xv1+InsX1FwyJIZ
         e5gSyEh1XizHHn0stVGcHnhtWwGhPhsyY2QO3g/dS3j+YJRq3s0FQUkDOpat9RksyIPu
         MQcgQ0t33KHzA56W5j3VyInEngSyHSYKjndFlQUzujZrZVxQasOR1XrFVoGFVt6tvWF2
         Q8Q5dC4HynTEsNyGK8/qnNeHSMK//e7SvvwAhqZgBgoTqDjxBuS0ANsIDDJiUGysP+i1
         VOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vmeiuEq+pNSxF85fxKh/5NbdUj07GvXF4VZCioKzJDw=;
        b=Rp7HArHeAAXj6eNuVEdNGi5EmeDzETOTZ5/XiXYQpTE8YZiNmrgxhn//mWZN4eTA0X
         vFEbJoYl+yx0RhslMytk9ugBn6Y4qy8lMk5oZ7n+RArfy30feYwvTc/6sig2nw/kY7kN
         HkY+sQ3YqpDuyaGNiPbrOJMHcBvAp0aexDpWutKkXdxQMYet0iV4MZEZ1waJdUahcDGr
         Mh9Zrat0PpVN4rLbsdRXGKr4ukbCmVQ0nQImazCF2aowtehlupfDLzZgI+TQloSZ+U6o
         oX6gH+z5RfMrUhUbOzfYFfPuSF0uoITFwR2LfGG1Mys/4H1bZIpVUqzstAGIlGanpWJ7
         iBQA==
X-Gm-Message-State: AKaTC03hj9+PCkEX5AmKEItpmWlJRM8QL0auTvw1l6MAAHEzXmpHbQ9foEXaTlrTKkuDUw==
X-Received: by 10.98.69.133 with SMTP id n5mr14694463pfi.160.1482146327737;
        Mon, 19 Dec 2016 03:18:47 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id j68sm30659888pfk.95.2016.12.19.03.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 03:18:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 19 Dec 2016 18:18:43 +0700
Date:   Mon, 19 Dec 2016 18:18:43 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 04/21] read-cache: add and then use tweak_split_index()
Message-ID: <20161219111843.GB24125@ash>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
 <20161217145547.11748-5-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161217145547.11748-5-chriscool@tuxfamily.org>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2016 at 03:55:30PM +0100, Christian Couder wrote:
> +static void tweak_split_index(struct index_state *istate)
> +{
> +	switch (git_config_get_split_index()) {
> +	case -1: /* unset: do nothing */
> +		break;
> +	case 0: /* false */
> +		remove_split_index(istate);
> +		break;
> +	case 1: /* true */
> +		add_split_index(istate);
> +		break;
> +	default: /* unknown value: do nothing */

Probably should die("BUG:") here since it looks to me like
git_config_maybe_bool() (inside git_config_get_split_index) in this
case has been updated to return more values than we can handle. And we
need to know about that so we can handle it properly.

> +		break;
> +	}
> +}
