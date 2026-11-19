Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082780;
	b=FybNbwBi5xfwKzOVE7BXoADJTC3pxIyTNC6dWL6reTAFpyN2B+EdfzDRT9yTIYIJXGs+
	 50Q1bWQoxiKpKUk4R9dSUDM9fVCDFQfb71o9cLLzGBkW8kC7h72qYBpWqpYKcplctuiy3
	 hiAgfqFOguCwKGkVe25kNbTv2vlpUZJKWGm3Y9qDyEscRqScuZ3RTUo0Pxe8iZAaSf1o0
	 6Q69x6QD372qmYv1Tpn2WBOeI8Hs9Msp1lap7Vvm8Subsb5iOci/cxycsHx/pYMfD26b2
	 ZAluh+QP6cqzdWRSlB6flUc/IJpine4ZKnlbP30f4krNrnj98TBdf2CV7ShA8WGqFvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/b3zE6cwrZVIfg3dwieXXdtOE4QFmc7f6DT15g+lROk=;
	b=H5NTytNxK5XK5hvK9UU6XTRD3EedBOkQ4oIxrv85o4dytjjUkNuWhrUpH/QVKRRZOZoa
	 TIYbuLsAvPv0Lzrst/M68jnWhDdvLAWgaF1+V0dXMqXPpurDAKkJW58F1qvzD/YJni2M7
	 lJt9Nlzuwwrn3NwDy6osagQaXtAKAJr7tIy7veOUPjk+URYtNr5KDL2ea2T+5hbGa58/S
	 47iFRJOZEXBDCvVjKnmI1kpFz4d4f3K8baQRmS8wjDX7kMdW/H81vqSjnVEkUJNnOVxDS
	 XJP88LU7zuRblLoXVubfWmv7uzmxh2P5x7i4yGznswh4Qw7+/W9qOh6ZmpcfosuaUQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOD081tn;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B48606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 10:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B48606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOD081tn
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so1467568a91.2
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 02:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082780; x=1795687580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/b3zE6cwrZVIfg3dwieXXdtOE4QFmc7f6DT15g+lROk=;
        b=gOD081tn0CcXEwRDKmApCJqRq48EYbHABftq5NJ6aWSTwhqRK4kTlMxAaRrrrKCP0s
         X0Jzv47jENfoiZOCjoKwGEJt9Xo1Q3KXnIKLPb0Yco1gAiK2sTLoahFNDzTMRF3W8+65
         sJZfnggFmmgSeIFAUlCOs/+8D/Syk/HZWNw4WfaN/vn/EV29ot87/tHsEkV69oxOEx3L
         5YrhruQF/qbUKy7ugqpwT6+wqhMQ7pu+/gOggY/ShNywDWeXzs3r8KdVakSqZHPCdU0C
         X5bGHKwXbhQ4gRcFXfSWKric2zmjk73Oqe4DmQBG3UgLui03YhLghlguFkACB5pkXimt
         QsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082780; x=1795687580;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/b3zE6cwrZVIfg3dwieXXdtOE4QFmc7f6DT15g+lROk=;
        b=ndHSRJ92syTgZPwDv/xqeKaExf0NBfjDmk0hw2jcvPP/XF+okPBpEtBK/uAYpVIHB6
         TBYQU37ZyKgo7Nf3wMlZJ8WgJ9wF9SXrYaDXhK8nvJUG0KIevNd7bGxiUugCsvHdBT9s
         RtoSHmmW6lTeENepC5lPyqyjeTuocb1Y05meOSGl9jS4Z2S2hlXyAAzMu57pw7RcfeUy
         QTT77I9IKCXWqQEj2WTfq4xKZMJojm89eAEu2/m0DYTg7GvAuHEYOryFSs1jc+rZzP64
         D/Evk4MtI+YrlihPNGvshduQwhewobzx6wyOvwfRHjOwdxQDyUjeqeLZ35T1sc8mAADG
         OzGg==
X-Forwarded-Encrypted: i=1; AL+hErHgHwdduAoKi4QcRPhUCpvV/EMB7v2fPY1k+fV7+bxsUBGFdNL+lT4GuptTsRih2NV2mBE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MeFLpJUrpimjmWzh0Ym7ziAmrnq8wKQDgl3csd+cFD42CgZWY
	fpKWNkeo3RLSDuSF+1/b53fy0ITSadTdpzAWLgdENtLFEOZ6yQ75PN2f
X-Gm-Gg: AZFdTZdeeAqFtQYcs+TEOqnjn2hLm964Cb1alHdbV3AvrZiSDmnv3rJGFxioDcDKSpZ
	6oMm3wGJ4NasM+tzyWjrECmokGXf1ShHqBXKRsx2nN1lfj32fdb33POs/XxCXMDGmQD0TBfhdOy
	OmFbaOrZHhi0Wf5ZgHyju1MbqZPibZRVRTfSbJZQ3wodN0ELqTyz0cYytoihookhVTI7mAYH6iA
	z2fcTzmoZ1zZq/h3F5W4PBllfNHO5FHIik/P+IT1HLXjlEmaEOJzc0AgjlUby6E6PA2nF6QRSsc
	xQ/fHJ+GDGvCJZcgJwtYmXMHZmmrOQYiFZ7U52ekfUqSL9mWHFjgXAAj5wfW1LJJ5bYO5bj10i/
	lVMBSV/gza8dMxN1bgzWJRgUS2BDLLgJa8h5QhG6DrVYbnuwqTNdZKi1NeLyIP7rG+1X61AZ3CW
	aTj5yjPZ59rY+EWNRp2RG29dDl9xlN7mZu4wt9LXDKG/sI+8sZ8z43nRSBQ05qR96pVZ8uATnx+
	kEJwIiSSCFNIN+gYSKnCJqWVyBAoM2PCWZZAmX4ssc0v6b12vN1GluwV0hZHUEEvZKgoBLG3lQ0
	YavBd+fOzQU5a8ZW5QuAWbXGx2Otsn3rZcpxPopb
X-Received: by 2002:a17:90b:52:b0:3b3:ba43:54c3 with SMTP id 98e67ed59e1d1-3b3d07c61d4mr4820380a91.33.1795082779738;
        Thu, 19 Nov 2026 02:06:19 -0800 (PST)
Received: from [192.168.0.11] ([106.51.27.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b401f4d058sm1225190a91.0.2026.11.19.02.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 02:06:19 -0800 (PST)
Message-ID: <953176e8-e475-4a99-b2d3-725fd346c19e@gmail.com>
Date: Thu, 19 Nov 2026 15:36:16 +0530
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
Subject: Re: [PATCH v2 01/20] t9300: move 'fastimport.unpackLimit' to the
 required test
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
 <20261112-kn-fast-import-tests-1-v2-1-b8c3a0ab27e8@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-1-b8c3a0ab27e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 23:04, Karthik Nayak wrote:
> The 'empty stream succeeds' test sets 'fastimport.unpackLimit' to '0',
> so that the following imports write packs for the 'verify pack' tests
> to check. The test itself doesn't need it. A following commit makes it
> run in its own repository, where the setting would no longer reach the
> tests after it.
> 
> Move the configuration to 'A: create pack from stdin', the first test
> which needs it. The configuration must persist for the 'verify pack'
> tests of the following series, so set it with 'git config' and not with
> 'test_config'.
>

This makes me wonder if there is another patch later in this series to 
turn the 'git config fastimport.unpackLimit' into one that uses 
test_config instead to make the tests more self contained. Or may be it 
is planned in the follow-up the cover letter mentions.

I'll see about it. In any case, I think it may be worth a noting in the 
commit message your thoughts about a change that turns the 'git config' 
into a test_config one.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   t/t9300-fast-import.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 15f511fb6b..4cffe43a71 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -38,7 +38,6 @@ echo "$@"'
>   ###
>   
>   test_expect_success 'empty stream succeeds' '
> -	git config fastimport.unpackLimit 0 &&
>   	git fast-import </dev/null
>   '
>   
> @@ -47,6 +46,7 @@ test_expect_success 'truncated stream complains' '
>   '
>   
>   test_expect_success 'A: create pack from stdin' '
> +	git config fastimport.unpackLimit 0 &&
>   	test_tick &&
>   	cat >input <<-INPUT_END &&
>   	blob
> 

Change itself looks good to me.

-- 
Sivaraam

