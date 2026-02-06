Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690072DC765
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397069; cv=pass; b=gw+jVd1iQK+3iWmv5b4S6g3WkcUWZUg9LSBsQ+bnwmkNFmeldj9L5uhTjP2h/APKg2+Tw+J4qynYkgbaGPBKyxwuqNuVOdz2Gy87PagbYdwsi2L7/wkvFK4pkEPxLafSp5YTAiVb65dGNmlqyx+E5TbYctHkN/s/5l4GzYflQ9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397069; c=relaxed/simple;
	bh=eZ6I3fdqvKzy4h+S7qBEi23+rgkv2ruFyzTPfr6NLpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1MdL58Xas6RPJxdnshclnNVPjbcovQwkLlXsFKdu+RMJ0ilBVu04GZ9ciS/tKWFG1nb2oJ/1BPCcwqOgZQ3E0/s0f9s2Fro0sB0x3EP7TvrqV3so51aPVVOpeVt7JQc6RWdkshWzIYWl6VaBFTdgk6GobN38NAJkF6AmZYG7qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR8YM+0R; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR8YM+0R"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so3534970a12.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 08:57:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770397068; cv=none;
        d=google.com; s=arc-20240605;
        b=jfUr83BERvpq3TlmvaXzlEh/L1pvNgpW7fG5gMlvKd4g6S5fvElumi5LTySF8sOtZ2
         unlT0FrRRMmEegJPusN6ogy7nVQR+uuaSyLF0FYaUlzYqrAlO7ufyuKT90YwBkm50l5n
         ZZBRyUitesi+LOlJkFO273MfQSOwdDHHALmzZ/SL2ZDSEE5fShWmiUS3IL4oCl2SpxO3
         2Kr1UgOwzwEzUvwLCSnXQKv9bhVoEC0WjejNhmpdMh89x3g1NmdcGeYMz7QjBUVkmsNF
         bmYvK/rmZW2ZEMFpHZiBx5dg3VZHNqQfmWL6xBdjYXS14sWirogdYNCdQ4J/IrH0YFHp
         2A0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rAJZ5g5E+seKqNcCBaoZZwfm+VuOsLDgmQ4ykWr6e6Q=;
        fh=rtE98JfZZkvlZ/cJJL/FBiVReBqq5W+nwQ5uDQmTSzQ=;
        b=jyogz3nRiXFA0n2FarMaHC8ivmFWedYfOGHWxHnBoHt9LfelA80DMtm2kWV/lLMBm+
         u1zNIA/XXQjTMY67SOwZlkW8owFjUpA1+TmhKFQ4QHmge/CeotVtp5XJNE1qZnLrm4Wh
         q5DDvwuCQyxT/JJ6f2x6ExbLKbcw4PDdoGQOM22PwyfthYR9ScSovkMj+DqcVauAznhR
         /x9R8AEGRVyxyvaBYWgE+jCnLADN0QA9GY+jo0ZAWaHmYom+gq85OkQjZ1swx8ZQ1bm/
         OLwy5+KWmlu7OMxFCzH6fTRXAe9Jw32UQB/VJINQrzOG7YGozfuW/K4BUwlvYKNof28G
         JWmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770397068; x=1771001868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rAJZ5g5E+seKqNcCBaoZZwfm+VuOsLDgmQ4ykWr6e6Q=;
        b=HR8YM+0RkEH6U5a5MCeBGGEZrZlhLdP2RxB15143vUgreg0t8h798PrvPYm97KcBWg
         Z0GgT6rcS8v9X2aIyNYvQyAMbMxFHxcRr2sNqE3/Te3MQVg7u/RwnORcqpx1cosjzeaK
         54oc0y8HWpRRyidw7AVseOcS1QNsXVoFVAoh1C8KKPr4XU0q2iF4jNUn7pzvnBjPUmhb
         b6kIDeNdN/VK0adHrPaDURGv5ATya/HNWRIJctWC/UOhs+N8uekyQTviBvUw0yV1QTyi
         uEwGnHmBj9rjb83NXojgbZIXdvXvjJisszE475FusJgrfArYkbAu5UEUc10lzCUWf0gl
         UEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770397068; x=1771001868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAJZ5g5E+seKqNcCBaoZZwfm+VuOsLDgmQ4ykWr6e6Q=;
        b=dwOLJpomZSB54HCQINH4messs6Wb6SsJMeKq6/9xH68IXQE8yAwt7HtKTaCZm0Nk9J
         WFSxivjj2fbStwZPkLgn0OARlPjzmsC03oJwlo1UJ1hnJ67zrr7Ww0FbN02s/dw4XToW
         G8cyl6Oea4ZqWazzEQKcjUyKVLbTtnuVlhxG/l/qeifhQn1O5XgNv8kQPUBn81dzfLBk
         Ryhhq8U/PUFUo/R4nQ8Ed5n0D0AQzeF9QbEm6Zh+svG+e21NfDPKVBdexKe4VnpMuofb
         7X8P7alIKp+E4D4jDL7gHqzObUiDN74TN+4DWvJiS3tkN5RvQ3cfnhdKeY1nsmwzC8di
         NsbQ==
X-Gm-Message-State: AOJu0Yx3irRD2cjKrS4Z44acajs3enKmupaUldijQYUAX9W9T1VMqkpC
	xp6Tmahczl918462qo/3tkZg6hF9lJmzUhVPJCAwtKw4eIilF2n7MmWHIUuXj0oh7eUDqHNlUnZ
	hWyLCrNmpn8JKuNDHn+qI5oIiiq+h7u+3wpuTfEQ=
X-Gm-Gg: AZuq6aJWxCC7wPEsg/+9mBzWLYhVtck7Bj2AVQM2xBK1ZVR448hs+d63UkPkI56zr88
	Ko83LYQl/D8z/MARwULzqzKjKIvG+yT+ADm2Yw1NMhQFKGNqOegGnvz9RapFtIhNbxeNqnNjCiG
	UXO7LrhsrggJWOdcIdDXF8ByqWS4K0sy1dnPowFBYySwXeu/uQZHT42l4ePA5zs06FIl8ZdWUEF
	1AaH99OtMSgmuRrXdrwpt2l5fQbG9/TKQCHelZ/wU1ktSyEGSnA6lPnVtfScO2TTu7n74YHu27w
	T7sk0w==
X-Received: by 2002:a17:907:9707:b0:b87:2d79:61c with SMTP id
 a640c23a62f3a-b8edf174632mr182187766b.8.1770397067478; Fri, 06 Feb 2026
 08:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205080853.2034-1-kumarayushjha123@gmail.com>
In-Reply-To: <20260205080853.2034-1-kumarayushjha123@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Fri, 6 Feb 2026 22:27:25 +0530
X-Gm-Features: AZwV_Qi7WExh5mdQrdFQea1xFSKYzk2qRE3gPcEhn1B6aaqXfgZOZWMcD1wlCZ8
Message-ID: <CA+J6zkRtjxa2BUoa9SMXVET7w4O6=b8iYMLPPpb4REROPGGQNA@mail.gmail.com>
Subject: Re: [GSoC PATCH] doc: fix typo in tree-walk.h comment
To: Ayush Jha <kumarayushjha123@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Feb 2026 at 13:39, Ayush Jha <kumarayushjha123@gmail.com> wrote:
>
> Fix a duplicated word in a comment describing the return value.
>
> No code or behavior change.
>
> Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
> ---
>  tree-walk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tree-walk.h b/tree-walk.h
> index 29a55328bd..9646c47ac5 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -177,7 +177,7 @@ struct traverse_info {
>
>  /**
>   * Walk trees starting with "tree_oid" to find the entry for "name", and
> - * return the the object name and the mode of the found entry via the
> + * return the object name and the mode of the found entry via the
>   * "oid" and "mode" parameters.  Return 0 if the entry is found, and -1
>   * otherwise.
>   */
> --
> 2.53.0.windows.1

Nit: The subject line should preferably use 'tree-walk.h: ' instead of 'doc: '
since it is a change to the `tree-walk.h` file and not 'Documentation'.

Other than that, the change looks good to me. Thanks for your interest
in contributing to Git!

Thanks,
Chandra.
