Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="US4upZGs"
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE810D3
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 14:26:12 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-423ed5fb48eso1829701cf.3
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 14:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701296772; x=1701901572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0EYf4fjEqMMccSL0nMmZcgqOWSLRknOKS8efDIBJ0E=;
        b=US4upZGs9ACfpFPjJOavBe2fNdwlpmsNAZuvS7Zx2ywsvDYUVBB/GE96Ok7z/lzGvH
         3EIl5gDHCzCMhB9AGE/Jwc/dWgdO+GxQhjl4aYkJnbbAd13LgUgKTb2tQb+Bzo1abd4Q
         NVDOrIVGoEjGF/DKi25XX7UncXBB7gH09+JY0Gr2/ekLYrqAc8FdDhnIi9Hma0zLI42V
         hn3IAOt5tgXEmIqO88xYusGrV9z32FzFRkpaV8M7Vcmgc4rvUvNopFbd2ypCvNDbX+Ug
         jSCp+3GZl+6VNyiEbVybOPNRFA+RCNW4oltgClpTkP9UCdgmVFD+x1RaFueuoT2VmYcq
         DXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296772; x=1701901572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0EYf4fjEqMMccSL0nMmZcgqOWSLRknOKS8efDIBJ0E=;
        b=wX7FC6eMBVgxrgjAfAjZ7jFNrUkoytZyStWsUSldtL8sAQkt1Ui2WFMFVKB5zHRUFZ
         NW7jn6tK+dUto29mBsEn9z3mAPMu4Dj3OWjseDZjCXox34paUIcBDfpbe8EUHDlekTsC
         oZ6LPLaB3ZOEUnj/8oNnCZoGdeT650M8MEJJDpi5g+y20M230Abkfpa5QmfQUXZNqvbT
         UyMQH61wDOL8wuSmU/RKiRcRhiwbkcMVB5TBxIrxLpd6cQvkW8kXHBpU0wbsEofhGwP2
         80CmuDeeIOqfN+uJ2CpyuVVsJjeystmlvsUszMdq8Gn1GYjVgp+EeQc58L0YaHr2LYAH
         ZGaQ==
X-Gm-Message-State: AOJu0YyVxO56Sqh9kMjoHa5HPaysHh5T25E85cVh3y0kvv/yAybdVWny
	TY5Fw2v5zRbqUtJNAM1SlS6TuwoAJn92AjDtMMY=
X-Google-Smtp-Source: AGHT+IGd10TBfO8Pj26r8Qw2TmA2BcPua4vpvvx8uxYLQRgZK/POAvPpduonyY28i+d4re4Q5Jvq1A==
X-Received: by 2002:ac8:5789:0:b0:421:ba91:f590 with SMTP id v9-20020ac85789000000b00421ba91f590mr24820171qta.1.1701296771901;
        Wed, 29 Nov 2023 14:26:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l9-20020ac84589000000b00421c31faf05sm5963722qtn.1.2023.11.29.14.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:26:11 -0800 (PST)
Date: Wed, 29 Nov 2023 17:26:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/10] t5551: stop writing packed-refs directly
Message-ID: <ZWe6goJHliFZrOAZ@nand.local>
References: <cover.1701242407.git.ps@pks.im>
 <2ab24ea5633be6b4855567d126a184d54c624f62.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ab24ea5633be6b4855567d126a184d54c624f62.1701242407.git.ps@pks.im>

On Wed, Nov 29, 2023 at 08:25:14AM +0100, Patrick Steinhardt wrote:
> We have multiple tests in t5551 that write thousands of tags. To do so
> efficiently we generate the tags by writing the `packed-refs` file
> directly, which of course assumes that the reference database is backed
> by the files backend.
>
> Refactor the code to instead use a single `git update-ref --stdin`
> command to write the tags. While the on-disk end result is not the same
> as we now have a bunch of loose refs instead of a single packed-refs
> file, the distinction shouldn't really matter for any of the tests that
> use this helper.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t5551-http-fetch-smart.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 8a41adf1e1..e069737b80 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -359,7 +359,9 @@ create_tags () {
>
>  	# now assign tags to all the dangling commits we created above
>  	tag=$(perl -e "print \"bla\" x 30") &&
> -	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
> +	sed -e "s|^:\([^ ]*\) \(.*\)$|create refs/tags/$tag-\1 \2|" <marks >input &&
> +	git update-ref --stdin <input &&
> +	rm input

Same note here as in the previous patch, although here I think we'd
prefer to pipe from sed to git update-ref directly, rather than writing
an intermediate file which we have to clean up afterwords.

Thanks,
Taylor
