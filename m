Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6114E362078
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226026; cv=none; b=q3tU6apL8zKs+hCL2D7oF7CNlmwqFJt0X/H5Tn14b8Zrmq3pyl7NVmUPcQe/+A6ZYvUlZjN/zFwvsj9YlUWMpRPKHXVYPC39qF/QxY/x0xJ5AwaStq4w/gDVAtChrYYt+V8SREuwAIvk3lasQEo+bsviJ+pdENktIgVTjCprAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226026; c=relaxed/simple;
	bh=nWgtU7Ll55ivg+rsgn5/wbGF23+o4aTYUGuxpMWq19g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n92xlNw+aVqIueSAibpPyGREAzZT3iMmg0CD71oajRGthok+54WivfxscgUdS8iC7BYvClAvt3ouyxiQy1IG/Z7le6OXQ6P4xy2BAzeUPrUNLmHdkZeYWm+MaoYM64X33vvnPzUN9OOS84nROpYAsHkWK8Jz3XJGgTICpYE/3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLloJRbs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLloJRbs"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-771e4378263so2053866b3a.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 09:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226023; x=1756830823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3XOgyPWI7YDnt3UWoS+KuqcClb0gGvGQ3eWyzPOT+M=;
        b=LLloJRbsOWnDcjHPaGV0xnyFVDYI8Mm+gmase2f6BeExcl2eib8Eca/4RVUMJMnST9
         drfxPXff6vcTuU6+8IZ8kfxcUxdX0lMuFFtSSWDchoOxVcZpATlYNXeYSie7NJkA+xD1
         Z0F6BPUYcIfIjZKUC553K5AijURFWPub67YWTh67DvgIWkZjNf1muzP9rmPyw5VigmmY
         HG7fSnNZWtfsxIkRoeh1/u6bSi3dtzkINkiR4oZjQeBP0h+YTN1WS5RqHCkNkFfYPalM
         0kWefo9tEgv5aRm9ApWIPW2VQP7Emsw21bIwEpGepo0XWhmRcOe2q6RA1WMUDGYJRqIt
         Tzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226023; x=1756830823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3XOgyPWI7YDnt3UWoS+KuqcClb0gGvGQ3eWyzPOT+M=;
        b=kJsrtyVCUtl92wm3JsXKxRw1FE7PBg2nZtplBK0TsGaQygYWSGbYb95Xv3BNBhccOA
         suR7ejtrlTNJ1C4WXvN2gSbz+FNX4QmiJhsb+mfDpV3gPlHaW03DLhas+Fp8Mc73eWJx
         3Ch8nGpLFE3+u/72UgKdfe+0Q+tiOFVsD/UjvWB63PoHs0uDydhdzRMcJhwsLbtUwJgG
         4BGPIx7vn2BxSI2u3W8uQe4Uz8CIrVsIaZJerxHJwIGA7qooY7uGR9si+yzpe6iYkBR4
         X/iL7MDrrUVYEnyoO0J86xgqNIN6OjDZsIhnr54YXv+kRXsM5Xlxkgg2gIMhUSePjX1S
         bO+A==
X-Gm-Message-State: AOJu0Yxyp62rgC995b9PEyo8ICvuyExXer+kSGcOovMQVTeivq9PGLGU
	56oZBlrFCfJfxe91IDcxnBl9R5vjjbsiEbehyHydOkmgYorSFwXQ7IKT
X-Gm-Gg: ASbGncsY/+AyvQseYwWOSptZ0KVz0ny3rXi2i+MlkCfjp7P9970Prk5g9AjHO2MZw+a
	vVkf+nfcwthbWbhm/I1hNoE9LqggE4x08TAJb7yb84GjogL2r7i0dLWXU3mEoLbyqj7zpP88OZ3
	6Hj7zdY8lxkz21KyWKkBJ15Gm6+rBsHj0CoI9tJm8l/BSr9CgZvXbA9m050tI0R9jisSJgGi/pU
	Ld8Ij0AkhpkEmkQi5+WqSShqFF95leXt4SfFeGShGamPiZNZmXJasHVyBzttuv1Daql+BiSBb6/
	imXpMbmULUx7YNDtur7vGHdFDk2iimjpbqNjbtw7SZnuD35xShOBH47UZV9RlOTUhZi7y8P3Nyb
	nTIqJriPZom8aGXpNQw==
X-Google-Smtp-Source: AGHT+IHJdrbRqBMf1IniQ9Q+Gz4RpYVgFOMDNKWEIb6kQBDU85al703sfFR5zVN47/Xm2136G7kSxQ==
X-Received: by 2002:a05:6a20:7f8e:b0:243:78a:8291 with SMTP id adf61e73a8af0-24340e2d3c6mr26585471637.56.1756226023536;
        Tue, 26 Aug 2025 09:33:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-771f045b687sm4018389b3a.109.2025.08.26.09.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:33:42 -0700 (PDT)
Date: Wed, 27 Aug 2025 00:33:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] refs/reftable: add fsck check for number of tables
Message-ID: <aK3hwQbO3YwdXa3q@ArchLinux>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
 <20250819-228-reftable-introduce-consistency-checks-v1-3-8b8f6879fa9e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-3-8b8f6879fa9e@gmail.com>

On Tue, Aug 19, 2025 at 02:21:02PM +0200, Karthik Nayak wrote:
> diff --git a/reftable/fsck.c b/reftable/fsck.c
> index 22ec3c26e9..e92a630276 100644
> --- a/reftable/fsck.c
> +++ b/reftable/fsck.c
> @@ -2,6 +2,28 @@
>  #include "reftable-fsck.h"
>  #include "stack.h"
>  
> +static int reftable_fsck_valid_stack_count(struct reftable_stack *st)
> +{
> +	DIR *dir = opendir(st->reftable_dir);
> +	struct dirent *d = NULL;
> +	unsigned int count = 0;
> +
> +	if (!dir)
> +		return 0;
> +
> +	while ((d = readdir(dir))) {
> +		if (!strcmp(d->d_name, "tables.list"))
> +			continue;
> +
> +		if (d->d_type == DT_REG)
> +			count++;
> +	}
> +
> +	closedir(dir);
> +
> +	return count == st->tables_len;
> +}
> +

The above logic is clear to understand but I think we should our
internal interface in "dir-iterator.h" to implement above logic.

>  int reftable_fsck_check(struct reftable_stack *stack,
>  			reftable_fsck_report_fn report_fn,
>  			reftable_fsck_verbose_fn verbose_fn,
> @@ -44,6 +66,18 @@ int reftable_fsck_check(struct reftable_stack *stack,
>  		}
>  	}
>  
> +	verbose_fn("Checking reftable tables count", cb_data);
> +
> +	if (!reftable_fsck_valid_stack_count(stack)) {
> +		struct reftable_fsck_info info = {
> +			.error = REFTABLE_FSCK_ERROR_STACK_COUNT,
> +			.path = stack->list_file,
> +			.msg = "mismatch in number of tables"
> +		};
> +

When reading here, I somehow understand the reason why you define this
data structure in the loop. But I still think we could just define only
one `info`.

BTY, I wonder whether we should define some auxiliary functions for each
check instead of adding logic directly in `reftable_fsck_check`
function?

> +		err = report_fn(info, cb_data);
> +	}
> +
>  out:
>  	free_names(names);
>  	return err;

Thanks,
Jialuo
