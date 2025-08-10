Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD921388
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754854957; cv=none; b=Uq4cSLwOBxGQ8ayWJlZHO8POIl5tzj/eC5cMj2WZ+LXFiT9jGiovzz80/MEEolzXsT5tvIm/q9wgFafjZF1VgoeO2VXaK62n0jHK343Zs/NvoZH5o3fm/HLXIBGkJ6StiC01M437WjsXSWYZsN/g2fIZqWTbiGTmvShooVqoZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754854957; c=relaxed/simple;
	bh=Knm0f51nK5wotO6aeAT+8c3qzkTwdBPskhJUVulYANc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qUgIcT7ev9Jh655D0ys2yDKyZAR+H0FzyjV4ie93WLakzI3c9vFZ/h+doPTQ193BOx75dU8gfKsSg6CYl/CERGOqehCnjvndP6HEy2XU6NxFt479k5SKcMCbCvnnSrmhUTfYp7XZWcAfSyxSGkOABRySsyKQKJ7icFavA/+zsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1WxsV12; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1WxsV12"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so2157892f8f.2
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754854954; x=1755459754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCaFCWqXrYYC066yqQeG6cSGoeS6biGpaFnejp5ZNfo=;
        b=h1WxsV12RGkkAEStLEDWbloFNhQ+ozHpN+UdpHulSdECPSlpssXiF3qNjkSYAuoQao
         JoN//sNDEfkoZASKW/vfhozyalM891LYKqVPv6H0X3Dz4E4PxK5KhUHHmUREyEtQ2m/W
         n38bYtM2W2+wgBCfYJNHnaqjbnWQdA622n5JQP5LlLx9NLPTzNhwhkBsc76WE8m28Rkw
         HAlS9KmDYk+0qgdEFhAXrzc8A2cakzIvIIWDnOYXHX8MSJhbab8q4hfzPTEmlzvFoZ4Y
         kXIK4juTjDsFUSQgFC1ofOu7p5f6BSaU0Gqn/+poPCnpdcY9VbqbVCPxQjfJsVN1mzuX
         gKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754854954; x=1755459754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCaFCWqXrYYC066yqQeG6cSGoeS6biGpaFnejp5ZNfo=;
        b=Nnz3XECTmQcso5M3CfVpEcY6Pmihf61Jdw46qIV9idZOKiT5t/0l1WIBhv0kM+JbLh
         3Z+CpdcTpB260pSbmVCWm2xCtCxLAXALAio72kfBd2cD4lvTMGVdlIs4LML/rLLrhGqY
         BdOyNVsae4YaZEa0YlW7tUnVPrRgWEzIRLaHsqdUQbvV9aK4GiY4Po/vkVPAjjKrHInb
         2t06fTLJGHaLG9msnty33Ior1z28CuYOpWLke/q7HguupDxYxcvlYtFLbT/naArSytCJ
         JCl5fWYEtFHtdwPkYTueoHGUXW6FMpZ5cln4JKM2wVgB44uSTXy/u7X6GhMopxDAtdC0
         YiDw==
X-Forwarded-Encrypted: i=1; AJvYcCXPsVKGChQ4aQPdlAt9c5WnhURMqj5XPmWz4X+SsmdQIrvm2xkU8ZngtDC5T+6jsT6wMxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhBEpAFR/+6fWJ+8Dk24iO12bFIkZ+1Ld80Za3gx3qTfvjO7e
	qOInqO5aAE4LRfwbvGfy3IMqN0zl386Y1Qdjj34y6pc43BM3HvmHZgN2NxJvBQ==
X-Gm-Gg: ASbGnctL83ktiTx42rtas3M7O3z7oRk301MpJVK3VpWp5yKB5ZEDC66FNbXdc9NM4uZ
	vKqkMYyE5v9lvSl9PzSZt7/jn4s/9L2HJfMeXFU3jVlu7MbdTCT0udJS344f+QyMVEuRIrWMaHz
	EPqF+tG58JJHrlQcWyXDiyfDXsLMQGni7K3K+fBs5pfHu+ktsYJDMPh260UVoOfdrLMIDmVoq/8
	TrfWdu+KAN1LR+QFTq5DHQb8AlaZIMVA+0b/JxiCpjDux3UwFmrFOdY1U/rOk5xZXgDUyCmZU+8
	3A0Ori/t2eydXjzMaK6TUf9j7Zgf+eteHirQKFar84rs6/O1jfP9gomRvAWOfNsV1Spgdwqmm/I
	vq4z3TFtKR/A/eimI9pd8Da5Q60gV3pTf/o+s70qgibTbZJnffXzRLMEQ5Xyt8yBIdwtL25VuqM
	j4YqdetIEQ9Cg=
X-Google-Smtp-Source: AGHT+IG4dcspd2GRJlcsyyWiodn24N4i5ncKQUBCnHuO83PqdjmJGPmUGzXQULlPJ3llebUidmKFCw==
X-Received: by 2002:a05:6000:144f:b0:3b7:8984:5134 with SMTP id ffacd0b85a97d-3b900940321mr7096653f8f.16.1754854953556;
        Sun, 10 Aug 2025 12:42:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm37957527f8f.47.2025.08.10.12.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 12:42:33 -0700 (PDT)
Message-ID: <01674640-21f5-44f8-8208-d6b6d88b09c5@gmail.com>
Date: Sun, 10 Aug 2025 20:42:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] t7005: use modern test style
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250810160323.49372-2-ben.knoble+github@gmail.com>
Content-Language: en-US
In-Reply-To: <20250810160323.49372-2-ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

Thanks for cleaning up these tests

On 10/08/2025 17:03, D. Ben Knoble wrote:
> 
>   TERM=dumb
>   export TERM
>   test_expect_success 'dumb should error out when falling back on vi' '
> -
>   	if git commit --amend

Instead of this "if" we should be using test_must_fail here

>   	then
>   		echo "Oops?"
> @@ -56,13 +51,13 @@
>   '
>   
>   test_expect_success 'dumb should prefer EDITOR to VISUAL' '
> -
>   	EDITOR=./e-EDITOR.sh &&
>   	VISUAL=./e-VISUAL.sh &&
>   	export EDITOR VISUAL &&
>   	git commit --amend &&
> -	test "$(git show -s --format=%s)" = "Edited by EDITOR"
> -
> +	echo "Edited by EDITOR" >expect &&
> +	git show -s --format=%s >actual &&
> +	test_cmp expect actual

This is a faithful conversion of the original but I'd be tempted to use 
test_commit_message instead as I think we really should be checking the 
whole message rather than just the subject line in all these tests.

	test_commit_message HEAD -m "Edited by EDITOR"

The whitespace cleanups all look good to me

Thanks

Phillip

>   '
>   
>   TERM=vt100
> @@ -83,8 +78,8 @@
>   	esac
>   	test_expect_success "Using $i" '
>   		git --exec-path=. commit --amend &&
> -		git show -s --pretty=oneline |
> -		sed -e "s/^[0-9a-f]* //" >actual &&
> +		git show -s --pretty=oneline >show &&
> +		<show sed -e "s/^[0-9a-f]* //" >actual &&
>   		test_cmp expect actual
>   	'
>   done
> @@ -105,8 +100,8 @@
>   	esac
>   	test_expect_success "Using $i (override)" '
>   		git --exec-path=. commit --amend &&
> -		git show -s --pretty=oneline |
> -		sed -e "s/^[0-9a-f]* //" >actual &&
> +		git show -s --pretty=oneline >show &&
> +		<show sed -e "s/^[0-9a-f]* //" >actual &&
>   		test_cmp expect actual
>   	'
>   done
> @@ -115,17 +110,18 @@
>   	echo "echo space >\"\$1\"" >"e space.sh" &&
>   	chmod a+x "e space.sh" &&
>   	GIT_EDITOR="./e\ space.sh" git commit --amend &&
> -	test space = "$(git show -s --pretty=format:%s)"
> -
> +	echo space >expect &&
> +	git show -s --pretty=tformat:%s >actual &&
> +	test_cmp expect actual
>   '
>   
>   unset GIT_EDITOR
>   test_expect_success 'core.editor with a space' '
> -
>   	git config core.editor \"./e\ space.sh\" &&
>   	git commit --amend &&
> -	test space = "$(git show -s --pretty=format:%s)"
> -
> +	echo space >expect &&
> +	git show -s --pretty=tformat:%s >actual &&
> +	test_cmp expect actual
>   '
>   
>   test_done

