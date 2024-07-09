Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761BB1FA3
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566338; cv=none; b=Va0T8XbIgU0TJdLkrpBOxfRe1joFsieHa8cXno5lCVaHdqOdqyamxr4sD7/s0IXshfusS/jWVSmBsArrJo1S0t32hkmA7P1fUqiCPIlRZD7xqo5ZmdeB1x8LkNTHTDIl5A+ZfUKlw2jmm9XmsFPzuMImAk+u9ToaG740irGXubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566338; c=relaxed/simple;
	bh=8ZdtUtgXvLsCiHt/mfOc7acrYgAdDYX+Axd1S9YCzCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADxNteJxpCg71R/vICJrGRMWiU9vyDWbNiQzpuMAaX4Jh5qA1k8Owe5462zI9s8bU3J6LF+8v5CLItcJogfoESlM0I4H9wfu+csz3Ty3mbSov9LPWdFDfDW5KehGcSVeMq2fGkLGzWB0n+2X57M+5w5GJp2RMe/WgAc5cPEJNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ1F2Ay+; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ1F2Ay+"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25982aa59efso2741535fac.3
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720566336; x=1721171136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jeXah0wOlAHXbcCkHdkrGL56tkOBBRJWN8LXEH/bwDE=;
        b=ZQ1F2Ay++chylQ01NjIYrX2Fv7Mt3i9svN6XCxFb2GpWo+DxwEpbE/JP/UDKpSt9uT
         mWUsQq2M2KsUVLgMRjewaVR5JyA2DmhTpzMOa8njVoqs9qfmaQfznaePOUL+aAb6Sdg4
         8g0DgfImYyubl16casyIWs5dObJmjhd670yuYYWEuuYnsPtId08Lo4eB/FBIXi6B6Dud
         87oOseOqN8MItc3P4IqtMi81h5F276VBrRxyKH/W3VUbim9FKUPCsM5rxlak5AR0LvGd
         Ria0qTtct8C9QjHVxW4OacqGymxoanVihqvukLzU35jVNFrxbbKUaM8qSLLjomrYZJy5
         Xr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720566336; x=1721171136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeXah0wOlAHXbcCkHdkrGL56tkOBBRJWN8LXEH/bwDE=;
        b=D47m8nk0e+Iv0YNRr2fA9Um3c2YLdM8ntmQWwj0nRFmOQxMMj+9s1q3h/hwixgqo40
         jK/3cEUfKXxgoMHYeda6FtFC0PgFHTTWGloQdZ4+31LrdaZDkb/HnRw2RJbvuPqA1nyw
         pjVbqUGJI8qJgIXuCUyG8U3AAL9Gzr3PE8474ssBiVymBQOducJcC6RX+N/VfA97FMjV
         9qUqhTv8HXq07PQwvyN5DBCt/FTHOu6/ubbDeWMo0DeDmFPszSSYsahjVtG9L+pdITNi
         VLYGifXU9MXlwx65U2LtE1ARjylLBB1rxR3kDxNLdHKX03/NS6rhjjpBqoCapOT6gS3e
         iAhg==
X-Gm-Message-State: AOJu0Ywb1izg21aP/IDCdorK/DeY0l02jtv31H4eupQb24ks2ya08VPZ
	u/X2GmSVPlRo/cVdP8lx4D2OehmFccE++sThaBFgIx+aj4PWsN/q
X-Google-Smtp-Source: AGHT+IEk5tXcPRUf67kFKZE7z6gIn16yuU13YA/2kqSsjg2kRIKbizKPwNwFqTNcvKF7Th/9ZdLi2Q==
X-Received: by 2002:a05:6870:c110:b0:24f:cabc:4f6b with SMTP id 586e51a60fabf-25eae764c84mr3161916fac.8.1720566336379;
        Tue, 09 Jul 2024 16:05:36 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa078407sm870708fac.27.2024.07.09.16.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 16:05:35 -0700 (PDT)
Date: Tue, 9 Jul 2024 18:05:06 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, karthik.188@gmail.com
Subject: Re: [PATCH v2 1/7] t: move reftable/merged_test.c to the unit
 testing framework
Message-ID: <f5j7warzbamijaog6ur6uovr6i7fqwadrjbevnyyocz3orjux4@wugw42cut5oi>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
 <20240709053847.4453-1-chandrapratap3519@gmail.com>
 <20240709053847.4453-2-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709053847.4453-2-chandrapratap3519@gmail.com>

On 24/07/09 10:58AM, Chandra Pratap wrote:
> reftable/merged_test.c exercises the functions defined in
> reftable/merged.{c, h}. Migrate reftable/merged_test.c to the unit
> testing framework. Migration involves refactoring the tests
> to use the unit testing framework instead of reftable's test
> framework and renaming the tests according to unit-tests' naming
> conventions.
> 
> Also, move strbuf_add_void() and noop_flush() from
> reftable/test_framework.c to the ported test. This is because
> both these functions are used in the merged tests and
> reftable/test_framework.{c, h} is not #included in the ported test.
> 
[snip]
>  
> -int merged_test_main(int argc, const char *argv[])

Since we are removing this function definition, should we also remove
`merged_test_main` from "reftable/reftable-tests.h"?

> +int cmd_main(int argc, const char *argv[])
>  {
> -	RUN_TEST(test_merged_logs);
> -	RUN_TEST(test_merged_between);
> -	RUN_TEST(test_merged);
> -	RUN_TEST(test_default_write_opts);
> -	return 0;
> +	TEST(t_default_write_opts(), "merged table with default write opts");
> +	TEST(t_merged_logs(), "merged table with multiple log updates for same ref");
> +	TEST(t_merged_refs(), "merged table with multiple updates to same ref");
> +	TEST(t_merged_single_record(), "ref ocurring in only one record can be fetched");
> +
> +	return test_done();
>  }
> -- 
> 2.45.2.404.g9eaef5822c
> 
> 
