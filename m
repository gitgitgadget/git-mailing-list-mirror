Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97E8472
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714183; cv=none; b=IpJfP24wD2fiQcpefqbq1Jpl5F5VvDGSQheDDUYKYxp401XhtpYrHQtzPX35icTWFWHidCX2V+yqBwWplXxCM+4ZFkOLTqN2djBvQHXhqe9tdwYqNQfE4lsxec03g0S1d+MofMfS7Rtn2zc/Amqvf1t3SeAsIZc2ROpTYhGnnXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714183; c=relaxed/simple;
	bh=F/mQfOIhxZ93vkinzBiOFJu/4sbwZW/7gtvExOfxJXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGrpuAF9njLaCJI9Ms/dg3Zy56LnI7Y6R5GXgnxE5WYwwNex+ljbL8wQ8FFGKMzCWa6LfcgcqjGcHI7SAOCX7JEJ31hXR3GVtghKTeXTx+sxlau5AexDDpxTj8u6q/kg/VvMhOIbTqI9OpRi+Go0QDVIDCfGr3hNViytTxGmH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR3d1Jym; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR3d1Jym"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-465cfc7e33dso1620359fac.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788714181; x=1789318981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a04a9FIorE+bO1GnlAKdVlhCXOqBDHIf016nru+nwz0=;
        b=DR3d1JymNSseX9IVMyiusjUZj2T/hPWFoKar8xQUjDrrwmK/Z8Mhl6T9ZURNxha709
         zrALBT00pbxEPgMdCVwLcfgEbQ/m3+ual77n4rzAwrRJDOFu/dUC8zyShphSsgu9a3HI
         nzqZxaZIZCOnX8t3wa0eBTdL1yhm2e7jE9lFBVoRFlwbUB11jU6nijbiX9Z0T7qwPpEq
         QTQhhHPW9wE8ndAcvlAK/Kf6ri3hDpbMY1JQgB4etcEQQHzs8rQWNDLKgF+/aaQ9Hadt
         DGNLfWGUjC2yCKw/6lfWh2SGKltaPNxbc74z4m6ykk5qubhd6av+zRGTH9sdqUSUtaQ/
         96iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788714181; x=1789318981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a04a9FIorE+bO1GnlAKdVlhCXOqBDHIf016nru+nwz0=;
        b=shx0VM9mgY3QJXLoqlae1fqRiKqhpmbvGZM/+153JZ99n1hs/ndVsOQ0rwB1LKPig5
         eAFgyLO954ZJWy0Wsxon6KR03Yw7ux9xsU41vxThbWNSLQqHocQ9SgKJ/joqehfucBmU
         aAdUTYyy6xiQDUTr+GRF3I3Ce89v5f/IA5sKz2ECuTi5aZDCYCdVN5lzuEuBQLNxrjxL
         sFy/55VJLnmhcd/Y9WKlRI8c+erOunwasmFqsKCO3CJ03jm4kM1vUo9lOyeejfLe2G1m
         aj1gdLmnLfyDO4o/M3UNfuFpt8Y3u63+ywssd38vC8NFboi+OyGgxP1wcbGrPdCNeS3q
         y6uQ==
X-Gm-Message-State: AFuF++kKw9dEojkEtzIPEgFen/HayvgYAzb5sJ2StgTxCkKzuWTIEtkv
	lqEeUKuS6bei485dgRWBzrq4PNtsnLqbCfNua1ttsLejwSm2IBfzX5M6
X-Gm-Gg: AYBFou03efiL7IkuL44wYLEOoSFDIvQNb2NKCLuFSU6utDDmsPbMgDlFZgDfPpowmbF
	adIq3dR08jAd7Ozd0jYyJ4SQUuiawMrJW3z1NwEaI9zGdJuH5inreA1qniWhWlEn204yVRSFYYO
	+vg1ewqki5MFaJ3wI/W+KKlVz7yIs3zt1RncNYlBr9DoFV6pzS3TRLjqyJjmxJZBgI20FSTgtG0
	WjnftJqv4Fse3A5RbK0qBuEaOWbNlQPJtSOgMoO70CBfrMjU1wQgcjto18W2+7/QYjx71JwWI34
	cmHk/CL8Q049KygRyJsM2FauphR9bL+eFW4x7xWLYU6+1btlo66u2NjHcCEfxCe1hxPC+zT0d3z
	fz/wfO0vdWzQXnFZIuTgsidCVU5E4WW/nj25NmHXWoBbNsOA8SOyTiN/HGt7rbynLxZGUPSFrLO
	uaEHcbZ2C4mKXywtb/EBARcJnb9B7ZMsQwdrmymqdUjTj3d656qo7V8JtUfGfF2HHAmdiLPuZX9
	ZE6eKZDaQ6/vw==
X-Received: by 2002:a05:6870:968e:b0:475:e235:906 with SMTP id 586e51a60fabf-475e2350fb4mr9148027fac.36.1788714181026;
        Sun, 06 Sep 2026 10:03:01 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475543f5ac5sm8257322fac.8.2026.09.06.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:03:00 -0700 (PDT)
Date: Sun, 6 Sep 2026 12:02:57 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] odb/source: support writing alternates when
 creating the database
Message-ID: <ap2bu85Ut_bN4wkt@denethor>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
 <20260831-pks-odb-write-alternates-at-creation-time-v2-6-aecd2382ba1c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-6-aecd2382ba1c@pks.im>

On 26/08/31 12:02PM, Patrick Steinhardt wrote:
> +struct odb_create_on_disk_options {
> +	/*
> +	 * Alternates that shall be written into the newly created object
> +	 * database. Whether or not this option can be handled is specific to
> +	 * the backend.
> +	 */
> +	const struct strvec *alternates;
> +};

So ODB interface here still exposes a way to signal alternates to the
backend, but an alternative backend may not actually use alternates at
all. Out of curiousity, does this mean git-clone(1) options such as
"--shared" should only be allowed to work with the "files" backend? Or
should the expected behavior of such options just be backend specific?

-Justin
