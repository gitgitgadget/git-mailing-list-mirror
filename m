Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777483CAE84
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950297; cv=none; b=HaRef4TWa4Jk89eKSL5OHJmnGGkYgZ3u9a/ICIImAHfOqeLYyVdsssgpJWWTjTMSy7JKiJHOCsejmD16hvMAX9Z6w6vFTeOmN+55VYqg5JbUeoZGMl05ihm2Y9jT2r1aQSWCvC8wg+3/jhZaQHabVvAkUGnGt/hrgQRZMgWDd1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950297; c=relaxed/simple;
	bh=AoK1tkjb/XVt+F3aZQZ6RpqSwWbVqq785v51FaB9n2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQSxgpLV1qCjn5JaF7zENSivhdOJzGienYZEMWilbdBi9dJ6Hmv0UvC9+k0oCYowYyoQOSLan2H4NmoCHZ+jXOrxX0hvHhsA/bbwlilveWLyY6hVfWJrc2VPR/5u+4+XQ7i7GXK5EZT12ts7gl0ezopULhMDqSZkBncZx1DhMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILr+0Qvz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILr+0Qvz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49e73611928so366635e9.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790950291; x=1791555091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DIXgv36k36YGz13813HxAaJR9/pHiRcD/T/uphlQgd8=;
        b=ILr+0QvzfujNQ0wgH5+eTANl8MlyeELQWKw8RmvpnjWMIqypT8gopvLbjngyHM3hL9
         I/bvIWxPfU2jxxSk7R8LyCvPg+stkPcS0HCwnAtZNaN3N1oLNZIM2yXfYgS6f21AvFA0
         RJWYBBGeQDXwKVZIjPyY5szwsNEAa19XwobJ0VpWUkOMGYFaJxOTW+sRZ+Ci2qZLGka+
         dJdqMjOtIKrQ/2BT8sP84fU0GpMifEu/Lgw63Qxlg4cQLe00pHNiOsYAG0MZuIFN9dzF
         oMbH5CS2Op5sAq/PMXMiKfFBNqhbkwZASBvL2JCLBGuzmdlCplpf1BjbbjBv52MXT9K0
         3TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950291; x=1791555091;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DIXgv36k36YGz13813HxAaJR9/pHiRcD/T/uphlQgd8=;
        b=sAr9XFgtLdEUVbqjqYG8o2UbeN6p0SMoVURGyh4MkgCnuXa+xWuqZj1fhGXGAugR6y
         DRc35CE9GuZWvr8NCfzNUR3UWplwl2hWWApJE61XccHgrrlj+P5S+/APSfuYYiOWDWWT
         mWML2ZZMt6q2ONuaHlpXIgTDJx7X1KhFwm/fDfjQuJpPid58U+doCkW5Oz1KPMQaJEdm
         bzs0qH8QlKN+eJRenJe1GrsA57Gx7tE6lqP2Zx3H/Ds9q4i5g8dgNXo8ENrsJ8JByVBr
         v+5n3xw7xLRbrspq9+E70Jj4inAnhPDbiiaPduzPg2nXew4dSwKvuASP929xoTdSadAD
         81nA==
X-Forwarded-Encrypted: i=1; AKwUvBwCFhEP5cTmhe6apetgWlR1X5aiZspHHbIcv7mY70iDsvkEHm1bHWin0VW49W+hfs2VbNk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJE2h/n9TZ9kGa53yRVXh6+plsAfJcww+Qjfcmjq1++gWL0Zdr/
	QjWRQwK4b9+Fol/tcxqOsmJuT3JTyKjzhvnqYm5+Rz+6njxUUolj7k0GAUObffkc
X-Gm-Gg: AYBFou1tNOU1jW+p64mrc6XCLwJusPAiGmvQ5xoDmTMezVCKOABjqWqXdKZTCJr5Dld
	vfJnJWS95VFWnCiWE+BfdDDeTqxnqmN9eB1FeTnMsZW+pEdn/7tQEWRbJ5AilYE1Xe+cIyZXJlA
	Kstyqf7M/J0mTz696cTfgP/Xed4dHrcNQf/6uh2/WU9Gl9EzKoS6iNf94/uCMUN5Q0FMSeDBR59
	A8ZW0RUsMuFxlateThBmJH/tzUlFuoQ1YjhlMHINRAf9fRpOUu5/nAJWM9+J6NeA+dV1Cd0YpU+
	TZuKmLCWyzZM8rGVd0Le8DRtjv2wau+Tff4XA57aHzgArwlXGLtPCiLq8g84gxvADlRCwSaMgL6
	oIV1hz6XrrpWPhgOdBM94T0ZszkcUbgO8oxIJp17MigG17Y/9w/xd26BTVpQupHONUJGuAfzEbT
	CTNTDvS3RnW/AzJkItJPa+bfgd2QcpHAabAP3U8ItG7It5DL6Cfy75JY6DwR0G77BZ6HNXuevMD
	daDoDoFgqmQm51jj8t0UyaFgwIlkoJIp7LUvLS7HBU8/NC+Nd943Q==
X-Received: by 2002:a05:6000:4b19:b0:488:8a8d:7d15 with SMTP id ffacd0b85a97d-48b068c8c9cmr11442365f8f.28.1790950290646;
        Fri, 02 Oct 2026 07:11:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382fe9cesm6283426f8f.42.2026.10.02.07.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 07:11:30 -0700 (PDT)
Message-ID: <3509a23e-9de1-442c-a64c-bc33110f92e7@gmail.com>
Date: Fri, 2 Oct 2026 15:11:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v9 4/4] var: add broken-out identity variables
To: Andrew Pleeter <andrewpleeter@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood@dunelm.org.uk, ben.knoble@gmail.com,
 peff@peff.net, sandals@crustytoothpaste.net
References: <xmqq33va1lcg.fsf@gitster.g>
 <20260926162048.30853-5-andrewpleeter@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260926162048.30853-5-andrewpleeter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew

The implementation looks good, just one small comment on the tests.

On 26/09/2026 17:20, Andrew Pleeter wrote:
> +test_expect_success 'get author identity components' '
> +	test_tick &&
> +	echo "$GIT_AUTHOR_NAME" >expect.name &&
> +	echo "$GIT_AUTHOR_EMAIL" >expect.email &&
> +	echo "$GIT_AUTHOR_DATE" >expect.date &&
> +	git var GIT_AUTHOR_NAME >actual.name &&
> +	git var GIT_AUTHOR_EMAIL >actual.email &&
> +	git var GIT_AUTHOR_DATE >actual.date &&
> +	test_cmp expect.name actual.name &&
> +	test_cmp expect.email actual.email &&
> +	test_cmp expect.date actual.date
> +'

I think it would have been sufficient just to list all the identity 
components at once, rather than having separate tests for each one, but 
it is not worth re-rolling just for that.

Thanks

Phillip

> +test_expect_success 'get committer identity components' '
> +	test_tick &&
> +	echo "$GIT_COMMITTER_NAME" >expect.name &&
> +	echo "$GIT_COMMITTER_EMAIL" >expect.email &&
> +	echo "$GIT_COMMITTER_DATE" >expect.date &&
> +	git var GIT_COMMITTER_NAME >actual.name &&
> +	git var GIT_COMMITTER_EMAIL >actual.email &&
> +	git var GIT_COMMITTER_DATE >actual.date &&
> +	test_cmp expect.name actual.name &&
> +	test_cmp expect.email actual.email &&
> +	test_cmp expect.date actual.date
> +'
> +
> +test_expect_success !FAIL_PREREQS,!AUTOIDENT 'identity components are strict' '
> +	(
> +		sane_unset GIT_COMMITTER_NAME &&
> +		sane_unset GIT_COMMITTER_EMAIL &&
> +		test_must_fail git var GIT_COMMITTER_NAME
> +	)
> +'
> +
> +test_expect_success 'get several identity components at once' '
> +	test_tick &&
> +	cat >expect <<-EOF &&
> +	GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME
> +	GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL
> +	GIT_COMMITTER_NAME=$GIT_COMMITTER_NAME
> +	GIT_COMMITTER_EMAIL=$GIT_COMMITTER_EMAIL
> +	EOF
> +	git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git var -l lists the identity components' '
> +	git var -l >actual &&
> +	test_grep "^GIT_AUTHOR_NAME=" actual &&
> +	test_grep "^GIT_AUTHOR_EMAIL=" actual &&
> +	test_grep "^GIT_AUTHOR_DATE=" actual &&
> +	test_grep "^GIT_COMMITTER_NAME=" actual &&
> +	test_grep "^GIT_COMMITTER_EMAIL=" actual &&
> +	test_grep "^GIT_COMMITTER_DATE=" actual
> +'
> +
>   test_done

