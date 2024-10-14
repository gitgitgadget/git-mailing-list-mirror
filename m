Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB311143722
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944048; cv=none; b=L9kgkdy9I5QWS19FT6jHfXi1ZXVNHP60q25P3c9GVfVWQr28Foa0XGZhm1uDdW9AjUcujYWM8RnMY905lmqrhGa+pWi/3wjq1/OFiBCA14BWADEMlcRDzVc4f2AwC+KKuerkjZqSRZRlJ6aDPNs3YQ6gmoPLGYO000mfB47CGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944048; c=relaxed/simple;
	bh=JvRG7QHiTfMOrg3i87MyaoxvKtsKQzup7uKwjsQsuKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZpDMxDAgiZQBUyhv/WFSgt6JifOjmDRt9a3N+X+8Cs2Ke4GkCmNmtyobPjL5m0vJFPVH6x9GYIyIHyG1yFDe6I8bqI09S+iC7K9t1mV6v/6EchL84YM/vJFRTnBsq+lF6jdldneyJIZOc5GOCmIzbW+FfeNATDg8cySN1pip9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DLD5RsCR; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DLD5RsCR"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2f4c1f79bso40799657b3.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728944046; x=1729548846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvRG7QHiTfMOrg3i87MyaoxvKtsKQzup7uKwjsQsuKo=;
        b=DLD5RsCR4cU6eqt+mSy2s/7bbCJL8ZEigJtx0z/TNxC16WiDUPez0BST+QRgLEFFJd
         G1eSkYyEQ1utzM9OIbrL5pb0tmX9UloTfgrfRSZ9WwMqQz9wJeJ4hSS1fF+mXiTIVCu0
         FcG0cuOMeNkullsTCYea1XmIANI0kd+/nmM9wsqvtGfhPtC6E59TdIf2HpLddX0kN8x1
         M/PBpnePGyLaNvlpWChioEXsc5Nv66sfl4sWsmjhOGqUvmz77lVqC+u37cFdFmLLsodz
         Jm0Hciu2frnCUQ/QxdHGxgd+R2MZW6D/nVzCCH4wvnpxAX/IX6Q1alIHre1D3RFgnXSO
         1iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728944046; x=1729548846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvRG7QHiTfMOrg3i87MyaoxvKtsKQzup7uKwjsQsuKo=;
        b=jX1odoO5loiqX0wU5kth6SGt1ldxkcq2QNoIHQJAyURYZ1RgnpxmV2QOVC+CMDqkiB
         WjsA1C+uNQNNeKrzYgA7+YbVpybkGk/QN3s8mYG5patAcucN+ZG+jLAzBE8pGvKj9p8z
         f+/ovKt3qi/AUdkP/1P5pF2sZrqvlvi/SRheOrfn6he2cDyvvq8WTRNDi0dAwMW+jWXZ
         lqywF1cU8CXy9hoJfGTNxF3YPmeuK8JklwFOvhalGf6XChhEa7rscEDBRr7KHR39/pvy
         FjCMW2oLFiTmoJor3Ch0nHpEjvUi6epk0V07A4uYzMZROp7fJ4LBQK+blkfPer0cUfX1
         SanA==
X-Gm-Message-State: AOJu0YyOq+JDHU7eFnz+/R79C4AQZPUipqfVezv/F2XcDYuJczH3KBZC
	Rq/XZTFIYOyrdOjdxW1U0PkEAiuJEZDEFzxlU0jpIHd9GJDXgzOoskHWM4hR8MiF6DQu4dv6J1k
	n
X-Google-Smtp-Source: AGHT+IEMs7AAFBQ4MrmE8RQ5+Pgj5rJd3aDg+wqGWE+AONhK9I/JTIAtpPVwZOXZD5dl97CfHHd8qA==
X-Received: by 2002:a05:690c:4b8f:b0:6b3:a6ff:7676 with SMTP id 00721157ae682-6e3477c086dmr112432497b3.3.1728944046013;
        Mon, 14 Oct 2024 15:14:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5ae1910sm87077b3.5.2024.10.14.15.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:14:05 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:14:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] http: fix build error on FreeBSD
Message-ID: <Zw2XrAkyOvYFwEDp@nand.local>
References: <cover.1728906490.git.ps@pks.im>
 <deb30e12a5861410b6c3b7385fe09599ddd0394b.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <deb30e12a5861410b6c3b7385fe09599ddd0394b.1728906490.git.ps@pks.im>

On Mon, Oct 14, 2024 at 02:21:39PM +0200, Patrick Steinhardt wrote:
> The `result` parameter passed to `http_request_reauth()` may either
> point to a `struct strbuf` or a `FILE *`, where the `target` parameter
> tells us which of either it actually is. To accommodate for both types
> the pointer is a `void *`, which we then pass directly to functions
> without doing a cast.
>
> This is fine on most platforms, but it breaks on FreeBSD because
> `fileno()` is implemented as a macro that tries to directly access the
> `FILE *` structure.

Hah. I'm sure this was another fun debugging story ;-). Reading this
made me chuckle aloud, but the fix you wrote here makes perfect sense to
me.

Thanks,
Taylor
