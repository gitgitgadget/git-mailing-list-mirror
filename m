Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976232;
	b=aeb1HX0CWvvIt5EfKAKJbxQbERDYtMBCQMtSspAhmxk+Kw7TsxT7gBHeTStmrh00/3Vj
	 VPHdXpZRFahAwGgZ03HWwXqNhH02uFWLsVgn1htYtzDTzWA1aALWxrjk0Hk5JdaPpdQDQ
	 gVzh0InCK1DjHryZuG1wUvbSDgOcrV6SEXdgZXXKqMUHD4W5ztjJdtabbDNDZ7N7MBtlq
	 XKZ9tjGoWCcuz0zn5gECOrSMYCORaP+7/hqaNgpf6aqNIJU6pkzbxh2pjQuG52lkIKVXL
	 1qGnYo6sZNxeZ3k1As6o0gCS+jyBExdbSGWm7W4ntCEv5qrNW9ELQ+sw81Os7rdhTEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Wl+Z0fUh7rzm76vXOj6kXjgtPeVu5w4qnQhtV/8J4wY=;
	b=tLLBMwr4eM50qltvPsXvO+E2yNT8dXOqYZhAopyYUAKXosRZSEzQL87leQQMsZ79FWaC
	 GRf40HX+HwXTGL+ZNcxA5Eq38IVQbbZuDBsYgjk7aqyFY+rwJH/GUzuWMLS0QLa73cl35
	 GeQYxJYIUfnkhKcp0nygk6kvwqpVVDKHsf9jQ8j+t11HU4+dxJ2WHrBOZJ7gLuEwJiGlU
	 T1J1Dol4TXL6+HDrkDkn3B1W8NOah27vanvoo2RGKqfMuosg0msJQmkDgtSoQI/rka2aj
	 QtDGwjn4trUBhJ+cThViMBwABQPbn4Ziyaxr7tjqo3Q4lGGTPnyjR+7vdlcEpSCOwJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CKUuC6S5;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8432C606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8432C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CKUuC6S5
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91791ec1b83so5172246d6.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976231; x=1794581031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wl+Z0fUh7rzm76vXOj6kXjgtPeVu5w4qnQhtV/8J4wY=;
        b=CKUuC6S5PJ5jA9jcmMvGpwqdDd1mx6jxBpePyk0/dfd7gSLn1x9K3VKLau0qLTRiVE
         H8YLiP+3j4ruS24Y8PgzhU0otg+J38fSpOOxDBsAOBQtIfrtbfcBurHCfkAknW45V2gk
         lpbqt5yZ3Zw/e0tB79wocKh+UjzcIMp5LUAhckwYtNUYfmnQ2TESfFeY0nSJ4SVaWtop
         aIN6gXwFSc2OSZV776EN1zhRP3YRPrbcH7R5PoZd5zTVCHdd9ePp77PmxH+0ALg5lnmb
         8olVKKJg/5222ITijoPds1kXMHQdB3DTzuVwFkNSJvl09Grw9k8xfHsLIXjO+Mf3cREd
         2BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976231; x=1794581031;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wl+Z0fUh7rzm76vXOj6kXjgtPeVu5w4qnQhtV/8J4wY=;
        b=NPlkW0mESTPEl8g6NZQMKv71w+L0PwYrFSc/bZKylLXAeK1S/195vWR4+jdMdfw57D
         m4U+c4/VVQt9yLnPDUZ0dKK5lMoC0HQn4YXqzIR3z061G9b6CB5xh99s7Few095VwaA0
         Xgx0GzRJePG3Zl8g09L1KWq/R9wGg6BvVO6pKlSp5DeExfTkKF/5ZwfIp5PUSYqIL96T
         muFRv41A2xz2TnsFUQtFfpRC0mTf32CmtJCY/aTT5AEvfobmCfjd6UxA5iu21D8ddGu+
         sJbSL6w2zgvg8d0S6PT9W4ogp2wlCHK7ah9wq2ZV9bWPsbkzhoSmMiIbFGXpZphVMmr9
         Pu8w==
X-Forwarded-Encrypted: i=1; AKwUvByXDWJ3j0ayul8vsizWMU0gKCITmKk3zxd/jAul3DK+/Wq7NnYySreLJQUeGh+DWpFmTQI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/O743egHzij7QTj2OcymmS3qXXWuz7Jxh9gZTmgD98SKhtgoW7
	VPDWiEe9+VSHChoS+EC8R+W74+G+nAl9Da5qb8zZZQeM5hBVpuf8A3wSSb8iAg==
X-Gm-Gg: AYBFou0VRnuw5DdJfwJ6rb7jYjiV2T4vJtPgj1MAxa5Wz7OZtccTGPR7iJPGQ6mcstL
	O1q/+lXPecyQgpJhwbqbNZYNE4oqF/cg625WbIP8SbSUMoIw0g6GDBKbrQUuIM/GQ8WRh1bJyQq
	YvsvFJKSsbsWx5RpkkTLsier07lHL03HMiUQ0EFx6inw2gCb5kwapXoFEF0bzQ6Ly5/wG8zbCos
	YLRd7mdwJRgQQfXf6ttIekj7R14aqMvr+pm7NLAhu7WXng21KKePqlJ0I23MFe9fkhDkb9lh/i+
	z2ZmdfSg+ifXSMzurtOdovIe9cqn68FXmMWe17PRt1jRZEwDfMjkiBptgdANOF2vgB2zA5CPm7p
	i6V7/lKqB/wpLO1xUUBjtggnp0W5RHc7p0yFOTdKpCrhZ1J2F22HoxUEZPhN70Y5ofieWaRG8Zk
	SqUOFjuImcGROY3snKnmv9wDGTyUpmmTC6gtHjUlHO8aqMgiGfTrlL3S92JAQpmlDR4kJcXbWdN
	1Wfc5RteVOHtOajBhnH5QrL/K50hQHhKJq7h/NERDy2I302d7WrAvuramsx2wpBCIMMVxbZuZx9
	eQdwzXDyBEAUQh3HETEC/c5F/CAbAlQ/5GiJTSiJU86LE0cWqYAxrOAd5MmYKrwz4EuUy5OoaDg
	sxeGBYVNbHIk9c/g69BQ5CY4UuWEI3wp96/aqCO85uC2Y5rD4RCw45Nx43R23lMXAkFQplojmIv
	Y9yC/SGWtKmsTu+PZIFQKuqSlSnJDDG/F22kRF2EwUzco6x9aDi4WH
X-Received: by 2002:a05:620a:46a1:b0:944:6c7:c88 with SMTP id af79cd13be357-945f355a8f1mr398652885a.54.1793976231310;
        Fri, 06 Nov 2026 06:43:51 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5bb9bfesm156498685a.19.2026.11.06.06.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 06:43:50 -0800 (PST)
Message-ID: <85924f20-298f-401e-88f7-7fb3f949d0fe@gmail.com>
Date: Fri, 6 Nov 2026 09:43:50 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] remote: do not show credentials when
 relative_url() fails
To: Aniket Gupta <aniketgupta3001@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
 <20261105152842.566318-3-aniketgupta3001@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20261105152842.566318-3-aniketgupta3001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2026 10:28 AM, Aniket Gupta wrote:
> When relative_url() cannot resolve a URL, it names the URL in its error
> message. If the URL contains a user name and password, both end up in
> the message, and from there in terminal output and logs.
> 
> Pass the URL through transport_anonymize_url() first. Also name the
> URL that was passed in rather than what is left of it after some
> components have already been stripped off, which is what a user would
> recognize.

I'm less convinced on this factor. I understand anonymizing the URL if
we are sending it to a location that is perhaps "less trusted" (like
trace logs) but the user asked us to operate on a given URL that caused
problems, so they should know the string that caused problems.

In environments that store stdout/stderr logs, those systems already
need to be careful about such strings in the commands themselves, let
alone the output strings.

And back to the bundle-URI application: if the bundle list uses such
URIs for its child bundles, then that's not a safe mechanism for
communicating those credentials. This isn't going to protect secrets
like that from being exposed.

This is just my opinion on the necessity of this change. If we _do_
want this change, then I continued my review: the patch accomplishes
its goal.
> @@ -3078,9 +3078,12 @@ char *relative_url_gently(const char *remote_url, const char *url,
>  			url += 3;
>  			chopped = chop_last_dir(&remoteurl, is_relative);
>  			if (chopped < 0) {
> +				char *anon = transport_anonymize_url(remote_url);
> +
>  				strbuf_addf(err,
>  					    _("cannot strip one component off url '%s'"),
> -					    remoteurl);
> +					    anon);
> +				free(anon);
>  				free(remoteurl);

This code looks good, assuming taht we want to make this change.

> +test_expect_success 'relative_url() does not show credentials when it fails' '
> +	cat >expect <<-\EOF &&
> +	fatal: cannot strip one component off url '\''https://host.example/a'\''
> +	EOF
> +	test_must_fail test-tool submodule resolve-relative-url "" \
> +		"https://user:secret@host.example/a" ../../../../../../x 2>actual &&
> +	test_cmp expect actual
> +'
Thank you for including a test that demonstrates this change.

Thanks,
-Stolee

