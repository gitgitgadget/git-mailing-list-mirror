Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5701F453
	for <e@80x24.org>; Tue,  5 Feb 2019 21:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfBEVOk (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 16:14:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37395 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBEVOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 16:14:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so4148617edb.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 13:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=89z3Kbm5H7Ir84w1ymH3Clp/ItyBpNpo02DdnZj+G1k=;
        b=IfRAAL8I3DJnFvyVAYB1Fr2jMK2eqa2BBy8n92xXROquElVhkvrU99iTDBK3t1/vS3
         u25y3pLTwOTB+LaRh5ltjuOpxaz5R/rHWYLDNEPpZplfJBZOW9MybO66VWYWaTPnarym
         1qfyJXjNEcV1zlim4qM4Fq/5HqDi9KIkCLGB+SGXZcqLKUTRFldggqcUKoIRgtYKuou4
         QXUDldHXHjOAUs84IlM3xBiRZsRkLFXptVqudZjH+HEwZGIaoyUHLd8u2qrXElbyXDWE
         4Q/5mvFqq8Wf6Ubqs3JkCP6xGqwuGXcs3Fmp5xI2U9h+BPBfLY3ZxSRvYCeNzO2dRB0Z
         MRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=89z3Kbm5H7Ir84w1ymH3Clp/ItyBpNpo02DdnZj+G1k=;
        b=rx3cRcLScSPoMBZwp4eNJEQDyQqKR902YdLi1qkj3PNBHA4kAVvQ44vPpUrERY6tIw
         MAKcXOSJN+hNlHGAfKPiywQmjOB3qfJCU+c6OHlEsnCqEa6hmQ1v+LsPZWMxsFKLOVS5
         Zc9hr6OgZ337dDHtsCedeRur2x6PQa3AtjXB6yVNk4ipuzFupRFFFeNNrZFQQ/AgxYNC
         T5w3876moh0+Q5AqkF9R+gmjIVYmFX6/TxJ2CLNVyESLFI1AorEcS5rLboXcpCqCoMRO
         Uqz78DP30SKlKg8AfDmynm5/5/buQdy6riYEqW66k1MofrG7UAtP+lR51RHFVlbNWn/r
         lxQg==
X-Gm-Message-State: AHQUAubQXj20KImWmw8wETBru00BE+G73XwQmgOk6b62Tcm2P4yvzbRU
        w9IV/WxLe8Rt4DVmyenGrPA=
X-Google-Smtp-Source: AHgI3IYCKKjywaRCWyKXSfsxZhvT76qACaYDpOyu43E5x0tZuQ9GP4Xo3wL7TX63Ys/UC1W5k6BfGw==
X-Received: by 2002:aa7:d7cf:: with SMTP id e15mr5339531eds.69.1549401278528;
        Tue, 05 Feb 2019 13:14:38 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id v14sm5018511edq.74.2019.02.05.13.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 13:14:37 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, William Hubbs <williamh@gentoo.org>,
        chutzpah@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and committer idents
References: <20190204184850.10040-1-williamh@gentoo.org> <20190205195212.25550-3-avarab@gmail.com> <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 05 Feb 2019 22:14:37 +0100
Message-ID: <87k1iekkea.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 05 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> +static int set_ident_internal(const char *var, const char *value,
>> +			    struct strbuf *sb, const int flag)
>> +{
>> +	if (!value)
>> +		return config_error_nonbool(var);
>> +	strbuf_reset(sb);
>> +	strbuf_addstr(sb, value);
>> +	author_ident_explicitly_given |=3D flag;
>> +	ident_config_given |=3D flag;
>> +	return 0;
>> +}
>> +
>> +static int set_ident(const char *var, const char *value)
>> +{
>> +	if (!strcmp(var, "author.name"))
>> +		return set_ident_internal(var, value, &git_author_name,
>> +					  IDENT_NAME_GIVEN);
>> +	else if (!strcmp(var, "author.email"))
>> +		return set_ident_internal(var, value, &git_author_email,
>> +					  IDENT_MAIL_GIVEN);
>> +	else if (!strcmp(var, "committer.name"))
>> +		return set_ident_internal(var, value, &git_committer_name,
>> +					  IDENT_NAME_GIVEN);
>> +	else if (!strcmp(var, "committer.email"))
>> +		return set_ident_internal(var, value, &git_committer_email,
>> +					  IDENT_MAIL_GIVEN);
>> +	else if (!strcmp(var, "user.name"))
>> +		return set_ident_internal(var, value, &git_default_name,
>> +					  IDENT_NAME_GIVEN);
>> +	else if (!strcmp(var, "user.email"))
>> +		return set_ident_internal(var, value, &git_default_email,
>> +					  IDENT_MAIL_GIVEN);
>> +	return 0;
>> +}
>
> In the v5 patch from William, author_ident_explicitly_given and
> committer_ident_explicitly_given were set separately depending on
> what variable was given (e.g. user.name marked both, author.name
> marked only author but not committer_ident_explicitly_given).  In
> the original before the addition of this feature with v6, giving
> user.name would have set both, as we can see below.
>
> Is this change intended?
>
> Or did you find that committer_ident_explicitly_given is no longer
> useful and the variable is not used anymore?

No, that's a mistake of mine when porting this over, but also clearly a
blindspot in our tests since they all pass with this.

I haven't dug (don't have time right now) to check what the effect of
that is. William?

>>  int git_ident_config(const char *var, const char *value, void *data)
>>  {
>>  	if (!strcmp(var, "user.useconfigonly")) {
>> @@ -480,29 +551,7 @@ int git_ident_config(const char *var, const char *v=
alue, void *data)
>>  		return 0;
>>  	}
>>
>> -	if (!strcmp(var, "user.name")) {
>> -		if (!value)
>> -			return config_error_nonbool(var);
>> -		strbuf_reset(&git_default_name);
>> -		strbuf_addstr(&git_default_name, value);
>> -		committer_ident_explicitly_given |=3D IDENT_NAME_GIVEN;
>> -		author_ident_explicitly_given |=3D IDENT_NAME_GIVEN;
>> -		ident_config_given |=3D IDENT_NAME_GIVEN;
>> -		return 0;
>> -	}
>> -
>> -	if (!strcmp(var, "user.email")) {
>> -		if (!value)
>> -			return config_error_nonbool(var);
>> -		strbuf_reset(&git_default_email);
>> -		strbuf_addstr(&git_default_email, value);
>> -		committer_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
>> -		author_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
>> -		ident_config_given |=3D IDENT_MAIL_GIVEN;
>> -		return 0;
>> -	}
>> -
>> -	return 0;
>> +	return set_ident(var, value);
>>  }
