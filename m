Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76781F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeKNE10 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:27:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35335 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKNE1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:27:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15-v6so12450645wmt.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zVEw6nNyL7x15kyV4YwO1Xab/R1Z/ZrzhD5fjSynuBU=;
        b=JnNu6xNQsnA4w2JkWoB+38cIK7LAzzq757smEoB/kjNQNbhqMZx5zqZsS1ryulWIun
         Js9xU7xvLTwP7N0Ne+TyWjSZA+BAZ4kN0zvyAQ4CynBGDHZFBlq+6xYS9XEymaXpoPNc
         pj3eH8Jggc47+mP4nLFrrVDEzcEuLQgNIS40jYgzFV6kvfWhWovKi/xFhMKZHvcnoRSB
         CjJd2NFbaWAS71ekP2SnfOPo+mgGRuV0yS1UhHW6l78O2UaV7p9j1n+JfIjf4gQD/KuL
         oJuekHaAa7oIuGmyqRADWxHRzdfOuKVyYEDSMDT00DhlDRhdVXKh+dFdNopOWEJC3nOn
         7FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zVEw6nNyL7x15kyV4YwO1Xab/R1Z/ZrzhD5fjSynuBU=;
        b=CbmkqUeZOMhtoOe/7HcjgnDdZ/rw4jB9OvtK6GqJdYpGbHUB3HjgcvkBEkwvCBWXvF
         NwU69balZKfev065aUMSJClTGQB4//pjr/9H3OHkWFZZK3KBvhOc9IZczp1BXPwJ2EAW
         4iJPp8NR1rmKQp1h6LvelrUt1t6ZOyZs6qOIUK4FPy8rW16Ehop3geMR6mrpj6LUlqjU
         Z69co4quuAS/3SJfvAz7rf6sRJQX52wxTVBu9Qxf/GbZ/1H901qyVCl6Oz6fqyEDVfPj
         T+2g9WK7I9QOJe4/xaPwBESh534XqRAPIO7CArwA3eR0YGVE4V6808VfW6IVd7DNd7Hr
         6Gxg==
X-Gm-Message-State: AGRZ1gL1ttZTAldsP5Nltv9n/ke2ZvlZtywrCfuU1wtAdB6LslsGxzfi
        dgI0XEHUbJlHJNiNcoD2qLQ=
X-Google-Smtp-Source: AJdET5eWI7qB04IKkyy/MLkLWRwwMpIRqQyHO09zw6kKib6tPiceMOZx37duVc8EATq0i/EWJstGgQ==
X-Received: by 2002:a1c:ac05:: with SMTP id v5-v6mr4162696wme.144.1542133687333;
        Tue, 13 Nov 2018 10:28:07 -0800 (PST)
Received: from szeder.dev (x4db2a36c.dyn.telefonica.de. [77.178.163.108])
        by smtp.gmail.com with ESMTPSA id b67-v6sm10378942wmh.11.2018.11.13.10.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:28:06 -0800 (PST)
Date:   Tue, 13 Nov 2018 19:28:02 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
Message-ID: <20181113182802.GG30222@szeder.dev>
References: <cover.1539305180.git.steadmon@google.com>
 <cover.1542059029.git.steadmon@google.com>
 <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 01:49:05PM -0800, steadmon@google.com wrote:

> diff --git a/protocol.c b/protocol.c
> index 5e636785d1..54d2ab991b 100644
> --- a/protocol.c
> +++ b/protocol.c

> +void get_client_protocol_version_advertisement(struct strbuf *advert)
> +{
> +	int tmp_nr = nr_allowed_versions;
> +	enum protocol_version *tmp_allowed_versions, config_version;
> +	strbuf_reset(advert);
> +
> +	have_advertised_versions_already = 1;
> +
> +	config_version = get_protocol_version_config();
> +	if (config_version == protocol_v0) {
> +		strbuf_addstr(advert, "version=0");
> +		return;
> +	}
> +
> +	if (tmp_nr > 0) {
> +		ALLOC_ARRAY(tmp_allowed_versions, tmp_nr);
> +		copy_array(tmp_allowed_versions, allowed_versions, tmp_nr,
> +			   sizeof(enum protocol_version));
> +	} else {
> +		ALLOC_ARRAY(tmp_allowed_versions, 1);
> +		tmp_nr = 1;
> +		tmp_allowed_versions[0] = config_version;
> +	}
> +
> +	if (tmp_allowed_versions[0] != config_version)
> +		for (int i = 1; i < nr_allowed_versions; i++)

We don't do C99 yet, thus the declaration of a loop variable like this
is not allowed and triggers compiler errors.

> +			if (tmp_allowed_versions[i] == config_version) {
> +				enum protocol_version swap =
> +					tmp_allowed_versions[0];
> +				tmp_allowed_versions[0] =
> +					tmp_allowed_versions[i];
> +				tmp_allowed_versions[i] = swap;
> +			}
> +
> +	strbuf_addf(advert, "version=%s",
> +		    format_protocol_version(tmp_allowed_versions[0]));
> +	for (int i = 1; i < tmp_nr; i++)

Likewise.

> +		strbuf_addf(advert, ":version=%s",
> +			    format_protocol_version(tmp_allowed_versions[i]));
> +}
