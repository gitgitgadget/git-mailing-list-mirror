Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A7346AC3
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682829; cv=none; b=UBatDvN2wCfkpZG9xC6H7Ru6I7q1YfCQVV73Jh57gtVJbXYhuYpWtTdi4gv6ZcZxoqceensjR+kx7vn9SFKdb12Ny3pFNbogwT+Ab4ZNgCVMGHKll7LZUy20b4+6Skjt6p75sYJxIJSeM/y+0padkMVLNMIl+1FCiHHkXFe85fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682829; c=relaxed/simple;
	bh=BEKCRe8wkdXzf6oIWq0SThNgSksfIC3igYMzwMJ+nzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1YP+iLmVbrBsJ5XtU3acpQAi0E4+jAa27csiBaEQGwmezo/4AYHHoMyPSjV/vtLB5XdQNNKSu9uncz/Gh0snNqoZI9NwqOuHV5ygK5HtresWjuc6RXKbXRtxQoDacIdam1sPja7q7e4wACgBXuDuK5RgNKmJlhWEsDUgKJ9iA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnXgH7oK; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnXgH7oK"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45f053b7b90so119597b6e.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775682827; x=1776287627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rzU0SOU0IWqmyaEYCp56qcViXboALLniNzqVNfe3Zc=;
        b=UnXgH7oKDDKxTfBV2uHO9EmdqWKepcBl0svP3ynQVnYRasLH/dgvt2Jo/AJk1xVH7k
         o/+w1+GWhTZesSRwAAt/GSq5eZWbG6qAfjl6SIWwq1aZe4oEEmbpgxvk1yrC+dWQoJy6
         GK6VRSV/8gatHBfAOEyMxbfojLzimLpfCq7M80alYvla0ETPasoUDCUu2/wOHLxFFl88
         aPBiJQnLI5Dl46PUtUbC4azvNj/EofX2CX4g3Lem8xRobOZ/Sm+3zb+pEZfvuSWNJQWl
         JC1R2OrVrUGNY8nVqULqNJNkcehc7xFdLWlH24abihHB+ETCxkbLO1BYTz/y/EMt0VUm
         t3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775682827; x=1776287627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rzU0SOU0IWqmyaEYCp56qcViXboALLniNzqVNfe3Zc=;
        b=HDiNAX7ou/PzPXhbjeqA96jX53pldScakX6V7rv1IgpviN+eTi3LfUcAO+K8/SsQKH
         tHkGNFG1D/SI2Cju0UUBlHXqD78YLtASbT+lr85eW/iQrEdbJ0ubIAW3ugFzuvbfPgnh
         vcNPvFnZNAejmJu7DlwqPYBnsRukjp6385bAHyyT/AVaiQYvx9ubKY9CO7YXx0I8ZgNV
         P+yMBAGTPoBCle02eylo0tDLXFHJvv6myK9m3zQLSGm9ntQHg8rnMaP9uoUNfo8rWhsw
         kKfWaobtTT1qqNvDsx/wwuHvSbUG9SCgbbLFsaoWh3/G5HuA787IYJfxQbtEnmeIZ1R+
         ue+w==
X-Gm-Message-State: AOJu0Yy4q0bULVbovvV1dL/618eW4k66J6YATcrmW2S2z1/0L1OvIHRu
	MUflWuO4SZfvBqi88GV4SFKfzIixIXYHbVVaoCF4PJBFg9OHYVH5iNZQsKR6Fg==
X-Gm-Gg: AeBDiesCn7TjiYy5d9/s5gaBBV1HsiFs3SjArhLwdSo3GU36AWUdddYodLWcZvleUJ7
	i9b9raEGhwBO3Lw8gfmostJSkU8aa8hI+3avEqRf7w85CXM9geW0p/73XVppQNR3bPD/uOpc0w2
	0waBvHaXppmFZUyLqhtmFpWss4hOvdKHRIqGSw7i+lAXXQAP6cW+lW1qTRwov1a5RUMVqwGN8WO
	Q9QJF0FcoakKYl5Is/46MkJid1ldFQl19pgJLL92YN91bu5AufB3P0oNSDe0S9quhZEA+XVBfZj
	aAYY5JNGWR7Vq1PLqHZtVy2yN0R1reOM+FdkxFtDFt1/PlFMV2MfDhiAtKCCa/ouVXvZ3hXDFAz
	NKdRaaNf+DOYMfhdPmebzE611E1St9AlhqBHBUQkX2zpT1PXGDjhFowN4GQ951Fesgo5sBPPTFD
	fJWWYrUjddkGdPyZfGeF9KRnxFYoM=
X-Received: by 2002:a05:6808:8482:b0:46c:e542:cc34 with SMTP id 5614622812f47-46ef7811227mr10847914b6e.35.1775682826773;
        Wed, 08 Apr 2026 14:13:46 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46f0f4e16a9sm9985799b6e.4.2026.04.08.14.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 14:13:46 -0700 (PDT)
Date: Wed, 8 Apr 2026 16:13:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/16] odb: fix unnecessary call to `find_cached_object()`
Message-ID: <adbDpPQgvPfctxQS@denethor>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <20260403-b4-pks-odb-source-inmemory-v1-3-8b8d1abaa25e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-3-8b8d1abaa25e@pks.im>

On 26/04/03 08:01AM, Patrick Steinhardt wrote:
> diff --git a/odb.c b/odb.c
> index d321242353..21cdedc31c 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -774,8 +774,7 @@ int odb_pretend_object(struct object_database *odb,
>  	char *co_buf;
>  
>  	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
> -	if (odb_has_object(odb, oid, 0) ||
> -	    find_cached_object(odb, oid))
> +	if (odb_has_object(odb, oid, 0))

Nice, odb_has_object() does indeed already check the object cache so
that makes the explicit find_cached_object() redundant.

If a future where temporary objects could be written to the inmemory ODB
source, would there ever be a reason for odb_has_object() to
differentiate between inmemory and real objects?

-Justin
