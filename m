Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B97D11C83
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722030779; cv=none; b=MHVR3EEKgyT6qu1AUe2uRhw3uQ7v3H+HEo91PquJBArQvW2tNo5JYv+BIIXAuUW/+F9M82AOJg1MRsERHd2dY3o5eovOZojr7eGpSavU/tr8mUhM6DKtDsWQYyII4M4dj8yewyCJHvYmlmB08bJNzsH5cZHMizMIecxXC7HFlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722030779; c=relaxed/simple;
	bh=SqocsmPkupQvVI6saOO6odX96d+WXWkdpMNhTFz2Iwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFZcFyvLSKoMg+LlNx6eQtBxmiHJowdw/cV7vlZ6aDG3K+wISnZxpW/Lm729dGaNRo9Jjm36K6AUSXAc7qEQvul+p48U/dKQ9jzzg2OIbHaqWjJiRjvLMe0ARkz0xal5Y+1isFtnauQoardIJgR1gM4aQ/3EgSXYdIxD+aJUt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIUq9rXH; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIUq9rXH"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5d077c60aso210232eaf.1
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722030777; x=1722635577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr3Z1Wa0iZclxUB/tSAav7OQ2/pa2W8AH7CmIR3ywYA=;
        b=lIUq9rXHsDTEG1cjXGLbRuE3hbibp+sGSw8ctcptcL/o/Zx9brPgxYtlU8yvbPl3IQ
         fxWpwXttoJowsCrzcuILOo4HTTM+LzvZ7eYR91q3V3T8YnCjfFX0/hwsIfJnUcFvQWeX
         SMw85dilAyT3IcVC3DLZfb789oHL/giepdX8dau9ilz6eiAirQmvRdiJPzkPbXww/OZV
         qavA1k4C0IBMuB0f7jvOv6AIunG6z+YuEF2j74QNtsWJkCYtyeEVEbTbxeIiBAyyCj+1
         lFjgfsijyaYuAiQm/2M7AkBeRbCCty/sIx+ECokATe1qjuTlZiOnrm8Y8HjjkD6/6vsW
         pjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722030777; x=1722635577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr3Z1Wa0iZclxUB/tSAav7OQ2/pa2W8AH7CmIR3ywYA=;
        b=O8pgBK8mumlENMBX+7XbvW/fpV36/2if/fiE6SxxjVnmt/VtTfFZZDnU28HitUeZJz
         q68S1t+gOL+esHaFqXLdVgBPF6Jy+IF+XF6/0xCfyN2mD/1lwX3oPnnyGprU++BByMo/
         DCUIwyULgtc2wMRzUSNoQjMeRnCi+96iqmtUI7nyjkqzKwAlXwPNxAhEy5ffi2yFizNY
         24KBRz2/bwaxYBK3Xj744ExWGHsdAIvciuDNiTY+SG1mbCjnOsL8i5ZJh3fWJ1dQQgk5
         lsIMtiFfhHd520TXqQtw+M3T2vV8jvp4QtDhzF0qR9c00LYMRDBcCrDK2r58cG+aB047
         2TtQ==
X-Gm-Message-State: AOJu0Yw8OaMgQ0/0NdnZif4hozHwOO6i/rLR+TeshKPFCnhxl3KQj1Xc
	hRo7S+3KWfS53J9ZmrN66J37pCb8IXZNBVC0QL8vzUrYosLg8Lfn
X-Google-Smtp-Source: AGHT+IEEucCodOxm4FVkzQuwizCta7bP5h4eqZ9OP47Znu4XBIl3W9OpsYAorT8GIgO4JkDZWA+rig==
X-Received: by 2002:a05:6820:16a9:b0:5d5:bce7:677 with SMTP id 006d021491bc7-5d5d0ee0328mr947269eaf.7.1722030777025;
        Fri, 26 Jul 2024 14:52:57 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930777fd5sm920006a34.54.2024.07.26.14.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 14:52:56 -0700 (PDT)
Date: Fri, 26 Jul 2024 16:52:14 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/3] clone: remove double bundle list clear code
Message-ID: <ypkmgjgobu2tn36o7qzultltknaz35qysrfe4y4kce67uysdxk@edmxls7p36mx>
References: <20240722080705.2614195-1-toon@iotcl.com>
 <20240724144957.3033840-1-toon@iotcl.com>
 <20240724144957.3033840-2-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724144957.3033840-2-toon@iotcl.com>

On 24/07/24 04:49PM, Toon Claes wrote:
> The bundle list transport->bundles is filled by
> transport_get_remote_bundle_uri(). Only when the list is not used, it is
> cleared right away by calling clear_bundle_list().
> 
> This looks like we leak memory allocated for the list when
> transport->bundles *is* used. But in fact, transport->bundles is cleaned
> up in transport_disconnect() near the end of cmd_clone().

The `transport->bundles` is setup and initialized by `transport_get()`
and populated by `transport_get_remote_bundle_uri()`. In its current
form, we clean up `transport->bundles` if it is empty immediately after
checking the remote for bundles. This is redundant though because the
cleanup already occurs as part of `transport_disconnect()`.

Since `transport_disconnect()` is already responsible for freeing other
parts of `transport`, it makes sense to let it be the one to handle it.

> 
> Remove the double clean up of transport->bundles, and depend solely on
> transport_disconnect() to take care of it.
> 
> Also add a test case that hits this code, but due to other leaks we
> cannot mark it as leak-free.
> 
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  builtin/clone.c             |  3 ---
>  t/t5558-clone-bundle-uri.sh | 28 +++++++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index af6017d41a..aa507395a0 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1419,9 +1419,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			else if (fetch_bundle_list(the_repository,
>  						   transport->bundles))
>  				warning(_("failed to fetch advertised bundles"));
> -		} else {
> -			clear_bundle_list(transport->bundles);
> -			FREE_AND_NULL(transport->bundles);
>  		}
>  	}
> 
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index cd05321e17..2d6e690fbe 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
> 
> -test_description='test fetching bundles with --bundle-uri'
> +test_description='test clone with use of bundle-uri'

I assume this description was changed because the test pertains to
clones and not fetches. Might be worth mentioning in the commit message.

> 
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-bundle.sh
> @@ -438,6 +438,32 @@ test_expect_success 'negotiation: bundle list with all wanted commits' '
>  	test_grep ! "clone> want " trace-packet.txt
>  '
> 
> +test_expect_success 'bundles advertised by the server' '
> +	test_when_finished rm -f trace*.txt &&
> +	git clone clone-from clone-advertiser &&
> +	git -C clone-advertiser config uploadpack.advertiseBundleURIs true &&
> +	git -C clone-advertiser config bundle.version 1 &&
> +	git -C clone-advertiser config bundle.mode all &&
> +	git -C clone-advertiser config bundle.bundle-1.uri "file://$(pwd)/clone-from/bundle-1.bundle" &&
> +	git -C clone-advertiser config bundle.bundle-2.uri "file://$(pwd)/clone-from/bundle-2.bundle" &&
> +	git -C clone-advertiser config bundle.bundle-3.uri "file://$(pwd)/clone-from/bundle-3.bundle" &&
> +	git -C clone-advertiser config bundle.bundle-4.uri "file://$(pwd)/clone-from/bundle-4.bundle" &&
> +
> +	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
> +	git -c transfer.bundleURI=true clone clone-advertiser clone-advertised &&
> +	git -C clone-advertised for-each-ref --format="%(refname)" >refs &&
> +	grep "refs/bundles/" refs >actual &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/base
> +	refs/bundles/left
> +	refs/bundles/merge
> +	refs/bundles/right
> +	EOF
> +	test_cmp expect actual &&
> +	# We already have all needed commits so no "want" needed.
> +	test_grep ! "clone> want " trace-packet.txt
> +'
> +

Looks like this test is validating that a clone is retrieving bundles
from a remote repository advertising said bundles. We to do so by
checking for the `refs/bundles/*` references which should only exist if
the advertised bundles were fetched. This makes sense to me.

From the commit message though, I thought the added test might have
something to do with the changes to when `transport->bundles` was freed.
I wonder if it would be a good idea to expland on this further in the
commit message. Or since the added test is somewhat unrelated to this
patch, maybe it should be a separate patch?

-Justin

>  #########################################################################
>  # HTTP tests begin here
> 
> --
> 2.45.2
> 
