Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313959;
	b=a9WkaB5aj8/D2ypNWq3qxAGesj5j5rs6WU0tdgBKx6xoN5J78N+WCq9bj/5IFXP/LC/8
	 KyR1k4jOue5zhQhCZmeD5SSvvxSk9k7uQMfvkfArnifihQHNdg73lnwFU4BWYBJdpph0U
	 2aK8De1IY6g4pnQ1mtEjF7M920foEs6QTb59rcVLavLmO1OY3fVNy3gaXhTXhwnCJree7
	 tKgFhrtrv+Jbgv1BMNU6DlBlelSd6Q+aRSzcn2u0i8yAh5tRiJBDSlPtZKJC+PKcFDZ82
	 ZCNjHKl3GUKhmyZ4i5Hl6dLljFy4i8XlpP77k5MOqOIt4JIs2l3AiBNcyfKMtc4IV/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=VQYRKJslZX3VhLc/o/owtOpTxGGjRYEk7zjBmjOkUQ8=;
	b=mDDWqey0iwvALTTEH9vG1oKR+n/R2WpVYpWixNOpQYKUbA6NIbg25KwX2CXx7fCYoQIg
	 dZfiaBbVjvpmoGCB7QVOm53yHVu40L8quGGnUfUXoCMsWYZGr0iqos+teqd5n2ud1G7tJ
	 zTwO5J/nWSqaIgMJK6Tr3/kQrmZ+AKSgO0DXN7EHrzONrZj4XHyNp+G8xEjuh8QtZB07h
	 aTcvyo2E8z8marraM1LjCp6xJuC7tMGWbXeIzOS/qn92XntBltRwhJ8EcPk/uG7a7BaOV
	 tpqAw7JNyDbj5Jcokq3OPw8VgMj/e+XPu/S+xdQHE/1ZtHK3o2sc3HSNv0inYQExJgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="h7f+m/B0";
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212C606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 22:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E212C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h7f+m/B0
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-847ac7ccd85so109882a34.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 15:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793313958; x=1793918758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQYRKJslZX3VhLc/o/owtOpTxGGjRYEk7zjBmjOkUQ8=;
        b=h7f+m/B0f6n+EyoCMw7iTFNEL6V3T78hS3G3gsXiSKaZ8avRHeGW+TWlSzDyHzNV5Z
         Pkq8jnOJg9l0y/YIm1ac86OZkMBgLNJYCFaS6H2IPZRfwRb8NxbADjjmCJlaoHizMlZw
         0LaCIu1QZyMwCMMVbvswsIqi9eaQLkCkzUGOiFBYzHi9UJ6fCdsPUMUNiZtVh96dFuZ7
         Bovm3caCkJPb+w9wFUhg3mFCCGYhtQeEVcDl5fIHhe/0YfmKtEFafhjfFtvL2hCIfxtq
         6VagOksSd20x6bf9NG2WVjFA+PtMs0Y90t9M8aEGmT6AgY5DW5M78edUSAM1ynICryTf
         SixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313958; x=1793918758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQYRKJslZX3VhLc/o/owtOpTxGGjRYEk7zjBmjOkUQ8=;
        b=BpNAKrBOXJifSWj3GcXrf1G7UBwtUnVQ1gL5weQ2eQygNrmLZfGaOrvnogNYGo5MkB
         c8OGmOW7UX3ROiDWzWEwJFZvDxwxXOUkm5Wr/WbiIl3+HB4ch8USceaPJj+Y2SVbrtbn
         raPbcaVLuzHT1g7tB7JCJFpHBFlThJSNI5bAOF5Qj5Wv70AAbSVUIXX78o6t4B1luLGX
         qXUxQDZCDN6b8L4lipn5cyzNZq9QirGS2jzdBwq9kMAzXei2ALUNw4lmjDjZzRjzEC2i
         7N6K1w9459oeq4xmdJdcBliOEGmdixh1pOqsq5yWxxlyAPMVzq/20PazitoF2SUtR7gi
         lLBQ==
X-Gm-Message-State: AFq9FYJeE6LfS3Y5cYU6ez/ugzKQH6vwy0rg8RLGW/UlBoBOtomaoQvm
	T47xMD/JDLtpMOQahPvon+uoGwDhgr33GQYnOAAz0bZ2xfMc7Ip3BNbn
X-Gm-Gg: AYBFou3JAbziT9EdmmV+mmOPCbFmXL9U7mUXGyQ1cywwU+q+krNq8+3SemRmO9GG51N
	tHAw9EfebFAOHPKcuk4yWqmMvXZ+8rxzckR1oxQGbXMVsiwojZiDmeGkM8dV9DbPFS9YdJdHWHq
	9V2ZcR+28tJAJFBF6PM2fZIIhP3CleczbkytlVYMSSp77tXyATALIo+urxLNDN/MRsHM640S+2P
	5gAZOTqsmYEm9BYADEmfXyckLaqpKehk6d+aZScenFcPDIhSxfYnXBhiDBXOkkIkwQ40I4o1eE1
	XjyLsYHNBpw9vEHQqPnBk1+KKvwY9xt7bEEdXczI2dhBrdEJO07UxKox1OmNdycnH1SrJYJnPuu
	yPajjuOq1JM08ao315XtuHB8wwxUD9xL4eM5JVOOxGdJoJf280LadnklH/eG9e4B7bn4oxrB3ot
	jinwULhll7/fpLLAwGO6DY3YT7v4MfivKJt8AbmytNqtK7pyrGPus7KbWtcPDH+/LfDCFNdQQpb
	4A4TdRXJjY5nFKllgYmTwgR1M7CzB6D0aZgiuFQTWjmhEdA6rITveOnW2uMWrIG+LwDS+/YP4bx
	Ce+VPtJFgUICTcLeJWrSqHn/nRAVZiKrxAGhybJ0GVpeGa81UFeR9hk=
X-Received: by 2002:a05:6830:43aa:b0:828:d647:332c with SMTP id 46e09a7af769-85d3647359dmr492874a34.25.1793313957800;
        Thu, 29 Oct 2026 15:45:57 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3549a2b4sm655290a34.13.2026.10.29.15.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:45:57 -0700 (PDT)
Date: Thu, 29 Oct 2026 17:45:54 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 0/4] loose: fix migrating "loose-object-idx" with
 batch fsync
Message-ID: <auPKJ-hUt22YaeyW@denethor>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
 <xmqq8q3gywny.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q3gywny.fsf@gitster.g>

On 26/10/29 03:22PM, Junio C Hamano wrote:
> Merging this topic to 'seen' had a funny interaction with other
> topics in flight.  repo_write_loose_object_map() function, from
> which loose_object_map_write() helper function was extracted out of,
> loses all callers, and will disappear in the merge.  But the new
> helper, which gained a caller loose_object_idx_merge() in this
> series, remains.

Thanks for the heads up. I see the function gets dropped by de2910a42b
(loose: drop unused `repo_write_loose_object_map()`, 2026-10-27).
Keeping the new helper and dropping `repo_write_loose_object_map()` is
indeed the correct resolution.

It does look like in `seen` the declaration of
`repo_write_loose_object_map()` is still left behind in "loose.h"
though.

I have a few small changes queued up locally for a v3, which I will send
out soon.

Thanks,
-Justin
