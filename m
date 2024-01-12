Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7325D74B
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3t+XJ0W"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ce04c601e5so5098369a12.2
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 00:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705047144; x=1705651944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcXOECkobylFgJaD1y4fK7VmM0FXj3LI1k5bK+0yf2Y=;
        b=J3t+XJ0W7noUACPx4jRQs4K5Jt9L3Idq7yrP1zr2LpizraUx3HZ7ZwTL/uvQYcfJhb
         eRMBCY3XUWGpBUEJzpxRtMC9dJ7crg2ddt/TMDdLRayH+J1TF82mQQrUo5LwkOUYMMIh
         eglmJLewwRgpwyyav40X9PubyOsQX4ipc9goDp2MiXipVd/8lxT7kF5QCUuez6iQ0DJr
         ZNlNs+RbMFVoXa6Ml0VXX3UBE4vstNe3FytG6ICjVTgB6oRoM9TfRI2bdmN4fUZCJ7G+
         YVACCiwDvz3JofFuGc+hwb65QzdC+gNI9rxtHDvrofGJLxgMO/MxSEte4RuHI42qt2W9
         /uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705047144; x=1705651944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcXOECkobylFgJaD1y4fK7VmM0FXj3LI1k5bK+0yf2Y=;
        b=lMfLFKbjRLX3HAFgJ2X60NeJoZ324E0yJXeuy8dkoOJSfhi3Fg4OsGpYlpWCpyEXQz
         BgkRLmCUkMpxduz4YmzzahCjD4dkLSArSJyhepM2ArQkKSnO7bkuufrCK39fxKnY0GiW
         MEjjvxI0uhv4UqLRokhmEyeVE7CwHT3pjM1O64zP80qeN+RREabZtPOp4X36hJhuYSx6
         yMeGJN4TvEcBDYMVO+1hj1iOeRD4ouHMQu6DqI29uZU/zji+TCilj9mNTNlZA/sD8eTE
         BWocVuzbD9JL229DpL1mWQqVTz/aHM/MHpoJN8Ya3hyIWdGTnr70EjPYgVv2aVMIUU2f
         Jc9A==
X-Gm-Message-State: AOJu0YxlQjMin+tfyH+HZFEbeWDfzUH21QiTsrL2PpHV6IG3psLp/5C1
	q/z32JDTEZFjW0OLBnDx9RrV5Kg0aYf77kdOVA==
X-Google-Smtp-Source: AGHT+IEDLbwT4P8+Zv2O3PZ/1ARXM6JKjvWVs8nIC0pG8delqLPz3qLvKlvxwYwDwU64etQPDF+OV+d93ig=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:85c7:0:b0:5cd:f80f:1085 with SMTP id
 u190-20020a6385c7000000b005cdf80f1085mr3112pgd.3.1705047143893; Fri, 12 Jan
 2024 00:12:23 -0800 (PST)
Date: Fri, 12 Jan 2024 00:12:22 -0800
In-Reply-To: <18b9a11d3be9d804e8d22d054ea881b8336d170c.1702562879.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <18b9a11d3be9d804e8d22d054ea881b8336d170c.1702562879.git.zhiyou.jx@alibaba-inc.com>
Message-ID: <owlyr0inhswp.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 4/4] archive: support remote archive from stateless transport
From: Linus Arver <linusa@google.com>
To: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Even though we can establish a stateless connection, we still cannot
> archive the remote repository using a stateless HTTP protocol. Try the
> following steps to make it work.

As Yoda once said, "Do or do not, there is no try". Here I think you
meant "Do".

>  1. Add support for "git-upload-archive" service in "http-backend".
>
>  2. Use the URL ".../info/refs?service=git-upload-pack" to detect the
>     protocol version, instead of use the "git-upload-archive" service.
>
>  3. "git-archive" does not expect to see protocol version and
>     capabilities when connecting to remote-helper, so do not send them
>     in "remote-curl.c" for the "git-upload-archive" service.

It would be great if you could break up this patch into 3 smaller
patches. Or 4 patches if you decide to move the new test cases into their
own patch.

> @@ -723,7 +729,8 @@ static struct service_cmd {
>  	{"GET", "/objects/pack/pack-[0-9a-f]{64}\\.idx$", get_idx_file},
>  
>  	{"POST", "/git-upload-pack$", service_rpc},
> -	{"POST", "/git-receive-pack$", service_rpc}
> +	{"POST", "/git-receive-pack$", service_rpc},
> +	{"POST", "/git-upload-archive$", service_rpc}
>  };

Style nit: it might be cleaner to put the new "git-upload-archive" just
above "git-upload-pack" because the two have a special relationship now.
