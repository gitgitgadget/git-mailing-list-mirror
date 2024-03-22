Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E258839AC5
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133329; cv=none; b=tmbLcFl06drwfW3sfSTBWRhVcqZOewh5N8G7y0ZxMcmbtz7U1OuCodOYHq/y66RZTofLPooRglj82HDei6NyRW1J4re8tG6EQx0I+U7itAWgvsCWU+tU/p350j3aJl81XFivd/IAx1ZJ76mKpuYkoiBWp1z2YQgEZel/Qip/FDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133329; c=relaxed/simple;
	bh=mo/gckyvD9+KuXYzjmk+v12OE6RVKyzn0+iIxCOTHKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4t2eJpEVOEjWV0kqAqMCsWN4iM3Xn3gSVzghRALGPh8tQy1jOHqwxc2X4eDM2TudCz7FQdx/w7fzYBN/LafzzANrnGPaOt0xRIChvmbar7GGEBu9D6y9xPeIMb6ZOZwvZewTT/HIcc+5gtX1gvb8XR+1IxndrpaqARytJIVY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQO9aX3n; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQO9aX3n"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a52c5c96feso63052eaf.3
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711133327; x=1711738127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEQTY2/BLRgae576vM4MaZIkkdidXc8ldPNz0XrBWQk=;
        b=SQO9aX3nhKSZXW7gcUE4ca89lFRtqIOtug3FzebVWv0O3sFDOB+tTr/8BaKaDp1pbp
         hd2uHPK3X3LDpVXrRUNe4uwDmmDHq/hV/ebXETHY4KIo4cbu1dkTxmi3zG1Q65RIQkdA
         MoCeWEMIsY5B62JbqTY0zX/ZnmmXU5bnTT+Cd9LRqg6B0LcoFJ4n5/LYZNgahd2pJbaz
         i7hj5ZAYav1vJ0hx/AVJwOl1a19UY4m5EZ/vcyqGsb5bBzYM2uFKr9UlfUJwBm0DZjvQ
         YqSX94OlrNyKVvmLb4v97Fbozwx1ouNo2PBV+CExGGGmAyfHd7bcINWxncoBgh0hvlda
         sb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711133327; x=1711738127;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEQTY2/BLRgae576vM4MaZIkkdidXc8ldPNz0XrBWQk=;
        b=tVskBwnOkYNsOd2U4ih3DnSLMZhKpGc8JnTYJ+mfL3Oz1/izRw9V64DQtno3q5Wjfk
         NlWdm9kA3LO64U7OTuEPKAJ25LuUWkQRhI2BiV7G7aVzeS1BZyy63x4Z543ZsZFcwj4u
         52g8Im5M2ADBgb6kCZWmM4fY8WOKO/qCR8Kk5QZq+B7l4ffXmyea48R8Z9qM+SJ5Z9Yv
         ys3aGrNuGJjbdVEbh+g6Otmy7iZ8yVe3i4EeM2nV8sqtp66qPjN90eauRklSP2qFMwFK
         m4aiBN2N2U0psJzBUT7l7fWZgJrEyqO/LdT63vGdoml9GPMDUGtdFYrKk9LqNNc7P1ZW
         5BHA==
X-Gm-Message-State: AOJu0YwhwOzSHiSbscmWZwGNs+Rr0EO8mIWt93diqGWwG/aQks+91Eno
	lySGG0846/uzerxL/JuG6bUZ3I+P0rJvllhW/xtrbFmlyb+bJlJZuh/nuwsR
X-Google-Smtp-Source: AGHT+IGjhFthTZ61PgSMOFT9wG0gvTwKkoZB3suKcLxcGeO8iNG44DCc7KqWX7tQDyjzKaMPNvr9vw==
X-Received: by 2002:a05:6820:1b13:b0:5a4:2c5e:807d with SMTP id bv19-20020a0568201b1300b005a42c5e807dmr590384oob.4.1711133326946;
        Fri, 22 Mar 2024 11:48:46 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id ch5-20020a0568200a0500b005a21ec7b19fsm152124oob.3.2024.03.22.11.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 11:48:22 -0700 (PDT)
Date: Fri, 22 Mar 2024 13:46:56 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/7] reftable/basics: improve `binsearch()` test
Message-ID: <zlj4jlfv645bxqgtjkrm3qdan3b7q4lzhxv3nqp7qagycri323@m5hhhxwuoetv>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1711109214.git.ps@pks.im>
 <7955f7983a6d8ef81a572f108b11c7afa93e34fd.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7955f7983a6d8ef81a572f108b11c7afa93e34fd.1711109214.git.ps@pks.im>

On 24/03/22 01:22PM, Patrick Steinhardt wrote:
> The `binsearch()` test is somewhat weird in that it doesn't explicitly
> spell out its expectations. Instead it does so in a rather ad-hoc way
> with some hard-to-understand computations.
> 
> Refactor the test to spell out the needle as well as expected index for
> all testcases. This refactoring highlights that the `binsearch_func()`
> is written somewhat weirdly to find the first integer smaller than the
> needle, not smaller or equal to it. Adjust the function accordingly.
> 
> While at it, rename the callback function to better convey its meaning.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/basics_test.c | 55 ++++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/reftable/basics_test.c b/reftable/basics_test.c
> index dc1c87c5df..85c4d1621c 100644
> --- a/reftable/basics_test.c
> +++ b/reftable/basics_test.c
> @@ -12,40 +12,47 @@ license that can be found in the LICENSE file or at
>  #include "test_framework.h"
>  #include "reftable-tests.h"
>  
> -struct binsearch_args {
> -	int key;
> -	int *arr;
> +struct integer_needle_lesseq {
> +	int needle;
> +	int *haystack;
>  };

This is probably just personal preference, but I think `key` and `arr`
in this case are a bit more straightforward. I do like that we rename
the args to be more specific. Do we want to also append `_args` to
denote that it is an argument set? Maybe `integer_lesseq_args`?

>  
> -static int binsearch_func(size_t i, void *void_args)
> +static int integer_needle_lesseq(size_t i, void *_args)
>  {
> -	struct binsearch_args *args = void_args;
> -
> -	return args->key < args->arr[i];
> +	struct integer_needle_lesseq *args = _args;
> +	return args->needle <= args->haystack[i];
>  }

-Justin
