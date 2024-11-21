Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB59143AA1
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732219944; cv=none; b=U4+z+Q/hqOKXiFvZ0jyWCEedhFc2jMzHXxW6kdIIKu/cJCkcCeg9p5W+zxd13G4dl5ScTe289Wn/9/acFZzLMTgtsqRk5mKow6JVp4QP/u2ofoE55brgpvfII278stgGyFwFWXJjOs+Ts18Dq8Cfoc52ileyUHnKTtwoeSyNPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732219944; c=relaxed/simple;
	bh=5dXEohPY2jsQtJu180MzNMKzkmTR4oMrLSkLgSFFfBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGOCeJBwQRcHT2x1hhzIcgKGX9qRKUDtw4NfqyRLJO0WNVyHlY29eipzpB+ggs/0vzFjOVaCi6P2vDslMtDYMoRhiiLFRZM6HRYx5mV0tzry2dwZQFlYXJ94rVUjfSqD9PEJ/vM1cuTQaqBLngjR9GxnlY9PsC3zJCPhqzpjs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QpMU8/Xc; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QpMU8/Xc"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e333af0f528so1237369276.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732219942; x=1732824742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0MIsvwnjTHNY0U6pjbnctvPMCbEJwcwm2Pe9+vxqcM=;
        b=QpMU8/XcGrbXtYEVY9f9o870SsqUVZBIAyKHs918r9xJ1a1qV/83AtKaSKkgJpUHKX
         vrJWDY0zn3J7isCfaH55nuXwWAc7BD5iUlu+2NGPwH0ugTcaYF+hyIKcshATLStYnT1u
         l3VgamdWFu8bzpBki7kflG1gi8QxORBE9ZSIviPfq3BotnmfjcbhcPeTmCxg4fa/aZRf
         tFrLEXB1WZCgLjHcoHgk4glUJeJEcVk+z4+oF3EFHfQpUDCmeNTb9pS3rZYnlto/tH3D
         R/rReJq7bM3kycrjNVt+FHD2kHcFoZ0DslPc7vV7+YBP7DCc0pn74rS9DrK5Bvcp1YGZ
         mAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732219942; x=1732824742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0MIsvwnjTHNY0U6pjbnctvPMCbEJwcwm2Pe9+vxqcM=;
        b=h/o2PwV1wRQcUtiD8A5ZGLG3h73pE7uw6EmHrDdlTAMRaTKF7HX6BjvoXMxp0QuHdr
         dmWGUS/tmf/WApUPcNoCWmN4QgO2kuFKmKl7RR/L8SrWC5ADLxOwZwz3BG4My9OmWfbN
         Cwb3O1c+daYcIQB94XQYrV4jMpT3uByjUf7fUgjlA+LoLScNvaCQLU8iqS5T7oZyvizx
         rhiCBIMScs3QLidfCU/crfjBZavd20s1S2hV+f3sus4ZvZJpG7PJyG8lzo+G3sw7MkCu
         HM+cfGZwyJtnlde5b1fcL1FaOxzb9DnKLJoDWEtjWhZLUFHpDRXQV8UQ96d1JrAUQUyD
         XQUg==
X-Gm-Message-State: AOJu0YzD2kzP5kbFPuLyuu3w1XvbrJkLttR5dMhhy/7xoHrp1YF8Ha+n
	DTnUMYMS7cB4HQrEkM9qXtbT7vkiFJwA/E42uaGg4XRmhvxYeR/oxIo6KbtbaL8=
X-Gm-Gg: ASbGnct3tAGG1wq3bsKHTqGKAxo5m20b3LTxptnGJyjhoYJxnvRpYgaqj5FJoDTbSiZ
	vJwBCHY9cf5EGV1XNXwWdcJJTY9+SErIiRbtYw5CO4V5GL/CaQYhqxuyBZFcCjuWE5zJWudyFGm
	ap/EA3hFu/skds/444vowwVou4zgyKyWuHDvRvYZzWoZ3ug73HzFQIZqX1xMoNCXNYH5e455YkS
	6UAL/DG0MSCRkaPBX4RX/DN39XLacpGGF7IWmYVcQEbzQuC5zJm5KwqGWGQvhjFR29RIcxFQmeW
	F2IpIOFyZlSp4ARnU57NZw==
X-Google-Smtp-Source: AGHT+IGFcT1Sz5pr3SIQhIaf2SNaHh1QyHblXjIBvCCzObH8TGoETDVfSWepBBZw4ke9AdDT1jBDMA==
X-Received: by 2002:a05:6902:2743:b0:e38:c169:34ec with SMTP id 3f1490d57ef6-e38f8be399cmr210445276.41.1732219941930;
        Thu, 21 Nov 2024 12:12:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f604c314sm125954276.21.2024.11.21.12.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:12:21 -0800 (PST)
Date: Thu, 21 Nov 2024 15:12:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/7] repack: add --full-name-hash option
Message-ID: <Zz+UJHclSsb+Bgfo@nand.local>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <93395c93347274d075c3e29b3bd20dcc221b15be.1730775908.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93395c93347274d075c3e29b3bd20dcc221b15be.1730775908.git.gitgitgadget@gmail.com>

On Tue, Nov 05, 2024 at 03:05:02AM +0000, Derrick Stolee via GitGitGadget wrote:
> ---
>  t/t7700-repack.sh       |  7 +++++++
>  t/test-lib-functions.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)

OK, I stand by my thinking in the previous patch that this one is where
the changes to builtin/repack.c belong.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index c4c3d1a15d9..fc2cc9d37be 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -777,6 +777,13 @@ test_expect_success 'repack -ad cleans up old .tmp-* packs' '
>  	test_must_be_empty tmpfiles
>  '
>
> +test_expect_success '--full-name-hash option passes through to pack-objects' '
> +	GIT_TRACE2_EVENT="$(pwd)/full-trace.txt" \
> +		git repack -a --full-name-hash &&
> +	test_subcommand_flex git pack-objects --full-name-hash <full-trace.txt

OK. To be honest, I am not sure I would have written the same test to
test trivially correct behavior, but I am not opposed to having such a
test either.

I do think that test_subcommand_flex may be unnecessary though, since
you could instead write this as:

    test_subcommand "git pack-objects.*--full-name-hash" <full-trace.txt

and get the same behavior.

> +'
> +
> +

Nit: extra newline here.

Thanks,
Taylor
