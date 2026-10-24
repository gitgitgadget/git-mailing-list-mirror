Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792870999;
	b=DjXwRAXTuitChR7q++wTvLkZ0Vfu+POvhV8VjAVZLuvS57A1DZ6iOVP1mUEP0YhJt3vI
	 A3dGeL/tBziUs+YA2LKi9d05WLPkhwCFPXABuAZBineeqe3wLGo5iO2eVKFjVrheVY8oC
	 OC99/d5ZM6Lqxy3TvRRAsef8pnrUYrz11abcojL4jJzMpsIKVo9S+ttMstSKsbiSC9Pkn
	 42oqEQXytGMiwY8V9Fgr2j97X2bHrbvx6dq/44I3Oz/8gwRKUaHQuEhpHWvFPzm//3URA
	 x82zob49t1sGciJiFwpzMTGK6K4LqtjEU+zw2AiOHRH69XZnPUs/tLVWiSYMdrp38cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792870999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=sHaf/2Qx0hghtq0wtT8ShjWK9TnU2WfCdXP+cQBK9XM=;
	b=tLja+p5jbxFsDNojC+OFDRjYhb/VoasGzOYgjS7s6OwUVr6y8hkFVsmjZfehD+PVcUnW
	 D7oRULaSQWsOMhqF3MHsbr9yuI/W5BGCIAm6iIrcWyFtYqiEl4RdNUrYYXrNs+JRvU/Qz
	 ngSZWf8HXPQd/AWBwIsJcB5EqnhK3wvoDPbvhlt07vfCNnNNJ6JUoKD9Dw827rgJE4EtJ
	 5Wm3JGmnAOSF+2B4O0T03vhJxXyS6uq4XeL3UhPx2QPI7aqZq0fcbTOYItANndDBn9Gx5
	 XAm8t798yVAOjcMAR2il8cxCFVZR2TvYwUFgkjWqadGJBQ8lfmeXBY899xdsaWcuL9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=etaR9VZw;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B750606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 19:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B750606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=etaR9VZw
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1195694f8f.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792870997; x=1793475797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sHaf/2Qx0hghtq0wtT8ShjWK9TnU2WfCdXP+cQBK9XM=;
        b=etaR9VZwtDCQRcQBBdb1yI/hCccebWs98nWO1L6jZxyt2PgD5G589mIPwuNznhX+NU
         REj5tLDbA0OomdIENRS9ELdyZPOnz81g+00V4rvroLmYc0PjXe2KQ4kmckAtByGJobyP
         OAIe0sAn+aFyyMrMXbCyGroqddghJat7EGgmI/y3pTVUF9scXHu/idzlZpros7aBVU4h
         jsnOjr2X4gcGlXxHlXgriKp/q3CKzurq0Wapn3PUUSXrri+wUBEsSbHa8p90XFGO8M4y
         TER4iM7FP9zAXh6mFgr3LwoZy8BfcCLUM70CXN833acWIax2egHIzguu22B7v7MgIiXH
         KAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792870997; x=1793475797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sHaf/2Qx0hghtq0wtT8ShjWK9TnU2WfCdXP+cQBK9XM=;
        b=QgqNMV3+jqiuBfFAIHOai6s1XfBq/RxU9a3Tq8tK+coGBSyI9gkqzjjSCz4m5/N6gt
         1eJThitkFoDHQdex9dvoVF+H2EGaiQdvNIcxKxDWSRzK0jw4V5JFVy5hR/+hQI+7AIb1
         A0tdUkm9zfxvOXgBfIabIAg9KY/g//AxoIVSoqlHOjkSSX4m1me7eELkKEXAvjioTb9r
         nFNCXuL87CDGBT5KKX3+NR8p/RXdbiWhOshZ01zv+eJv+PwIzeeYF1K5E2R46xF+2mnd
         tIoQYH2PuSgZ7LRya5ufI4xH6mr97c04WLBDfEQNKZuO4cbVZCIXvvfuNNsJp7DxZ9ZX
         WIIw==
X-Gm-Message-State: AFq9FYIFFJ8iDm/9Kep0yBhvVS/AkVJz0+IL27vQ0Di4ZY02mTlR54Ah
	LdZueSuHL9k86pFJrhLf+gjVJHp8VuwdR4sk2zrRy90VcoTwY2ZzASkU
X-Gm-Gg: AYBFou12xXQIvZfaaXpczoQ5nKfxAWrjFly0GCfl1s9pho+QU2Yidu5oHN2JtF4St0q
	yWgNnj2cSrpu9dSj+O5wMsqOPs73c8a6x9qqLt3y4PwpH04nVDSAzXUAvgMOenvlkPLyFRN5FT9
	hQEsPBhWX3amzIm4Gx60AYRppK2JvwiAn9mq1VnvwE397YC1go9wvd7/1pv2n17Ew8lGuYff2q3
	MCi23Mtm7N+t3w2NGgjKikAWT7qEAb2uoE2ZenWZy+7Jeo+McSp3ss4cUa+EEnHqU5HCJWNWV+E
	fb6oSxPWnKrbOQcymY6XHVlw7siQdCE8Z9I0JV/9Yb6nmKKRTArwYm0MtL8ScaB9iPGiALujpYJ
	rpLRqL5iUtsMJkcEWjnt9I+FT0zZzPfoUK7ufZ6FRvwleC+KP0NMpwgzzkfMBbvxd+hZyblFlAn
	3Ctfzy1PbXE8/tb46k6ojbVRfvWR1nudyq0yxx4aBEqP6AtFeiCBiqez0upUkv5Z24PN0YJR08S
	epCzcrI575QtLudNfv9dvWRGFSy/zAV9No9N1fSRWYwxLPGmSPYA5q7gRmAD9QrIgBMo/b4Zrs6
	u86J7y6iUBo=
X-Received: by 2002:a05:6000:46c3:b0:48d:fed0:ccbd with SMTP id ffacd0b85a97d-48e3eb93719mr2361925f8f.34.1792870997348;
        Sat, 24 Oct 2026 12:43:17 -0700 (PDT)
Received: from localhost (62-165-238-23.pool.digikabel.hu. [62.165.238.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3418sm5236821f8f.41.2026.10.24.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 12:43:16 -0700 (PDT)
Date: Sat, 24 Oct 2026 21:43:09 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: tboegi@web.de
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v1 1/1] t1450: use mv -f when overwriting a read only file
Message-ID: <at0KTewYGKuUTAUJ@szeder.dev>
References: <atmvASAoaCIpc_ca@pks.im>
 <20261024183056.6342-1-tboegi@web.de>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261024183056.6342-1-tboegi@web.de>

On Sat, Oct 24, 2026 at 08:30:56PM +0200, tboegi@web.de wrote:
> From: Torsten Bögershausen <tboegi@web.de>
> 
> test case 38 in t/t1450-fsck.sh replaces a loose blob, "$tmp" below,
> with a trucated version "obj.tmp" using
> 
> mv obj.tmp "$obj"
> 
> This fails on some sytems, like older MacOS.
> `man mv`
> includes this information:
>   The following options are available:
>   -f      Do not prompt for confirmation before overwriting the destination
>            path.  (The -f option overrides any previous -i or -n options.)
> and further down:
>   If the destination path does not have a mode which permits writing, mv
>   prompts the user for confirmation as specified for the -i option.
> 
> Running the test case in debug and verbose mode `./t1450-fsck.sh -d -v`
> shows this lines (which I have shortened to fit into 72 characters)
> 
> override r--r--r--  user/staff for .git/objects/fc/a75a5be3823dc0560da5?
> (y/n [n]) not overwritten
> fca75a5be3823dc0560da57ade678f212aeb33f6
> 
> POSIX mentions that the observed
> "prompt to standard error and read a line from standard input"
> should not be done when "standard input is a terminal".
> So we may blame the "standard input is a terminal" logic to fail.
> 
> Side note: Answering with 'y' to the question of `mv` like this
> (echo y | mv obj.tmp "$obj")
> makes the test case pass.
> 
> To make things not too complicated use the most portable form
> mv -f obj.tmp "$obj"
> 
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
> 
> So it was not the shell being old - but /bin/mv
> 
> t/t1450-fsck.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 16cc5d5dcb..335dcbf0af 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -548,7 +548,7 @@ test_expect_success 'rev-list --verify-objects with truncated loose blob' '
>  		# Truncate the loose blob such that its header can still be
>  		# parsed, but reading the object data fails mid-stream.
>  		test_copy_bytes 64 <"$obj" >obj.tmp &&
> -		mv obj.tmp "$obj" &&
> +		mv -v obj.tmp "$obj" &&

You want force, not verbosity.

Btw, don't you have a bit of a dejà vu? :)

https://lore.kernel.org/git/20240502185903.GA11895@tb-raspi4/T/#u

>  
>  		test_must_fail git rev-list --verify-objects "$blob" 2>err &&
>  		test_grep "hash mismatch" err
> -- 
> 2.50.0.rc0.46.g7014b55638
> 
