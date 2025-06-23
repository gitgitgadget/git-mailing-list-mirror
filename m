Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E312D12F4
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709075; cv=none; b=sCf4Zgn1yGWY4ByELspVqmmjzP4q09ecDTeMtPGA9OhXf4BOTbP9jx/SWLMK1nS3SERq95NWX3Br6P7YNNCBVulyfAPgDCOkk4oGAaQ7gp6DvYggOPZ76yKI5i0wL/VD45p2r5pa4nh8j6nqtOyzSrOsPCZLv4NNXubU1cXRMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709075; c=relaxed/simple;
	bh=5vcCjQjUBuzaz6CEZAlvWVDYfkp82yJEKlmzrOlO76k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmJFQwt/93A6jJjHwAs77mvHjfZYydiO+kAuE4/P8Nx96hdB7eUvBreStVDoZ4Z2J+et8FDffDiuQTULCcvuyVfWb92iuYNkke3yVDad1pBg5On28ddcLPFB2kRRuRtNk0AvppM68aEwFkmv7Zad01rIHXG3wpZxVmtQ3Bj2QdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH9I74hH; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH9I74hH"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2e9071e3706so2733899fac.0
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750709073; x=1751313873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVzgBVflIzOrHq0xjZP/itHSuLcUkamS6znm8Xvbbxk=;
        b=jH9I74hHVStEyRt1w83nGigjs8KozVhCnwj5ii9GzybIpfbveCpXJ2UE1i2LSkqANv
         vMwk1etA6w4y0NPZtahtAwW0zT5g0kf6GUaH2qhv3FK+hnSVqU+uWPYNcbezUTgDKbus
         UvTb8Xc+ioum9XrSKulr+H57mbI/0/SDyWumWRvn4yMN7zW4oyIyo79g2Pnk5ET5Utik
         lvcgbJ+9HeYPW3BvSrbwVrTudCqNUzg5vBnEq4JeFww2KOF6wiucfo3DEHTt1+ZfzNTy
         cKdvhZQfHUVtIxeIhxdhNoqA8ETpOwIjTiPKpOsVaUPDD+Dv0X+5UtKwckK7cjVbogmQ
         GJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750709073; x=1751313873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVzgBVflIzOrHq0xjZP/itHSuLcUkamS6znm8Xvbbxk=;
        b=JiU9XMwVZF4hj9zYr6qYKShbQCGHVouPAs709HD+jLKmkjHC260E7F0FC3N0KFwOi1
         qIBVng8uqNEAvbIrFY8JQ+U7xXeeWfWPcxxSVZmVgg4w2MwxZe7G35tGmXbPgtc9Q9As
         f9GKbCvcMKzilFfJpMYhVhxFn+kcNgTRP5lQijZ317stmr3W59uPhboz39tzVRA3dRjr
         gtHY/BiKYC06SYfRxnDySUQtWLwxBiUr1leMqkHylFxoUzbFLEAWmJzxFs5DkSbV8bvx
         2wER2+sXNCyM5os7VZimcShgr6Rr5j4jjyCvxRsBBAPEeKQadL8PFew2g6xEw70XVRa6
         U1Lw==
X-Gm-Message-State: AOJu0YwkZQsZUzARDGLSPU7vBwlzZ2hrY4LgaTlb+TvhleO6/SJ0wpuu
	a+Z8SuvtDQu5mkHfdCnm4QDXW2poEXma7uqf2GXbyNRtKEzwwXHKIM0E
X-Gm-Gg: ASbGncv0vm09ZbZ6jc74WEmOF0XZalpS45d7jRBc+VeBiyHkvNLywaxDZ+ryC8Kexdg
	Nli4gZGRCm7HRSRQL5pdCP/4mjQc/o0FuyTd2nyoFQGEcU5lf7zfrmLjBwxDS+oxhz8v0ntZVWl
	l/m0glPZh4kB1915Znoc2UC7fl2cHUpwES4EkkprNN3UpFkSfccT7BmHy7dTd3jo57LjDJsTal/
	+nzeZm/P5zXNo2togXeoduaklj0Z2XZD9j/c09ygUKIk9n4lAQXHxf6QL1WP/k3w0g9ZqKotoEP
	Gh8SKfMxGtaZp93yDOPUonxEKfMw+/Z16igKT7u7EZf+AEHjEi0zbw4=
X-Google-Smtp-Source: AGHT+IHI/eZGEQp6Ma2DtHQdyThmh3bUeiUqufm8x10OGfj7aETaPEta4gIWE7P/X89OK/W9XJDbPg==
X-Received: by 2002:a05:6870:1615:b0:2eb:b6a2:8d77 with SMTP id 586e51a60fabf-2eeee586c38mr10305682fac.29.1750709073142;
        Mon, 23 Jun 2025 13:04:33 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2eead8dc454sm1739559fac.42.2025.06.23.13.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 13:04:32 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:59:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 2/5] promisor-remote: allow a server to advertise more
 fields
Message-ID: <ojee3heqvvlk3v4ftuzaulm5vu7tvmc5idvqbda2ioiuurbmdw@sevh7jtsbbad>
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250611134506.2975856-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611134506.2975856-3-christian.couder@gmail.com>

On 25/06/11 03:45PM, Christian Couder wrote:
> For now the "promisor-remote" protocol capability can only pass "name"
> and "url" information from a server to a client in the form
> "name=<remote_name>,url=<remote_url>".
> 
> Let's make it possible to pass more information by introducing a new
> "promisor.sendFields" configuration variable. This variable should
> contain a comma or space separated list of field names that will be
> looked up in the configuration of the remote on the server to find the
> values that will be passed to the client.
> 
> Only a set of predefined fields are allowed. The only fields in this
> set are "partialCloneFilter" and "token". The "partialCloneFilter"
> field specifies the filter definition used by the promisor remote,
> and the "token" field can provide an authentication credential for
> accessing it.
> 
> For example, if "promisor.sendFields" is set to "partialCloneFilter",
> and the server has the "remote.<name>.partialCloneFilter" config
> variable set to a value for a remote, then that value will be passed
> in the form "partialCloneFilter=<value>" after the "name" and "url"
> fields.
> 
> A following commit will allow the client to use the information to
> decide if it accepts the remote or not. For now the client doesn't do
> anything with the additional information it receives.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
[snip]
> +static char *fields_from_config(struct string_list *fields_list, const char *config_key)
> +{
> +	char *fields = NULL;
> +
> +	if (!git_config_get_string(config_key, &fields) && *fields) {
> +		string_list_split_in_place(fields_list, fields, ", ", -1);
> +		string_list_remove_empty_items(fields_list, 0);

Ok, in this version we now filter out empty entries from the
string_list. Previously if fields were specified with both a comma and
SP character (i.e. "partialCloneFilter, token"), an empty entry would be
parsed in the middle and lead to a warning message.

This change is good because it would be pretty natural for a user to
specify the config with both. It might be nice to leave a comment
explaining why we do this though as it may be confusing without context.

-Justin

> +		filter_string_list(fields_list, 0, is_valid_field, (void *)config_key);
> +	}
> +
> +	return fields;
> +}
> +
