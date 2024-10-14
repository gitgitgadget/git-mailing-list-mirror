Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1F155303
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943239; cv=none; b=P+XmxEwW3gKCpSHBrWbJMnOCWJNJDxCMlUNf5siQd9QRPMDebErPaGcQsAl4bzKNEML3f1VT1766x5EEmmbTagclU0NlUy7FKySt5ni78rqQCb4nFFGlziNNjhxkFLQaT1Bfl7W1wMin4W+/yGOXiNqUWvQruqRAU79ZyRETRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943239; c=relaxed/simple;
	bh=ubUKZ3yDmVLAwscF0dKdZOhvOOIHzv4aHZwn70X+Zq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRtZF4OPJ6k8/ZRNkrsKk6C41+NNePM5i1DLyoVNtNf6ZW5JtDkHLuwHdeC+4v8CmNuEEeddrGFLZAFOvLSM6z3F6m+cRPP+S224ZAexWC3gU0xiE9UG/C2P/mLJQdyZc9vkFxglDv+9Br7cheE8WTRIaHTJ/3Y7cFOZroCE994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lZRH/mxb; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lZRH/mxb"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso4044109276.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728943237; x=1729548037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWbi+0LHIJHFZtKLCdyJXE3W/PF5g+BrxqEpzjZMI3Q=;
        b=lZRH/mxbwhXVY7IwGGvUhcuPT54e7RNmtz4+KxnqOV2kbxaEsHXLT7oFh7QZx5b6V6
         ceLdccope+ja13HQI83kc/hqb41BWc3asUluQ7n7PmNx+E39FU1fVpFLpbL5wYG/p/or
         95sWxCir9lbPbMF1LrMmWOw4pqv7+tVmTV1gI7CIXxcNNlo/vOfEHgWoAoVZf64x5DGr
         cllmZSUCcyVjngfkeG95/D++AQ0H5aNu6EacMKDWYkdt7JLc0dQwAWR61wDN7I9jxReS
         PZLFpean9UjE6UDchOeJdFSfqwHWZ6CI3tqvzpnc6l/W/dViJhOeefFtqs+t8hPB7Wlv
         qYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943237; x=1729548037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWbi+0LHIJHFZtKLCdyJXE3W/PF5g+BrxqEpzjZMI3Q=;
        b=GSoDlSkpJG67Vfv2y5o+au/vGySpvsV11hySPDpTA6aeCS7Gtvp6cicAb0zosk9s3X
         LJGWLG7t90i6uYiNwqwruWmOfI/dU+NaQUgl0SEKue0Z11kjLhK6TaBz8dNZpRDNL35u
         /9IACzCicof/fTn2skYG7cmdnme8JcnFpKGIQMOlMNxzHYYpoclnamgRYpHCenltw+m4
         6UyEcjA9U83976zEEZ6YgwRcL7H4DHP1DEaxeeDyFJandCKuO/c3H6M6LihQOhtCeUQq
         DWKyeiT9KSCTXTMW11nHqo07D+MlVk0Jabfct/kvYpqztY+isSuXgdqaKxbDdvmZo4WI
         sFKQ==
X-Gm-Message-State: AOJu0YxUMBGv3wZFE1H48O01+ff4qlgy0y+noWiZsUdkFtrzbvnXyhvW
	2/7xMH5pGqEiBXSVsLOnjPOb43vz8a/BNIqhG4Q+XuTN5Zpg7J1MxDsqbYV+j00=
X-Google-Smtp-Source: AGHT+IFm7z4ksrSpscaPXbc1B6Q69P3eAf+NYQ1Mmziq+0mbXe5eIqR+pJNnsjlJHKI658tTmYtXjg==
X-Received: by 2002:a25:748e:0:b0:e29:890:c6d4 with SMTP id 3f1490d57ef6-e2919df8577mr8879124276.41.1728943237019;
        Mon, 14 Oct 2024 15:00:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cc0866bsm3078276.14.2024.10.14.15.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:00:36 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:00:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
Message-ID: <Zw2Ug71K3FhlC9m2@nand.local>
References: <cover.1728906490.git.ps@pks.im>
 <601670912eeb80cc599c0e7af4ea87c370ae831d.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <601670912eeb80cc599c0e7af4ea87c370ae831d.1728906490.git.ps@pks.im>

On Mon, Oct 14, 2024 at 02:21:12PM +0200, Patrick Steinhardt wrote:
> Properly quote the value to fix the issue while using single-quotes to
> quote the inner value passed to eval. The issue can be reproduced by
> t0000 with such a path that contains spaces.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index b1a8ee5c002..241198ba95f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1572,7 +1572,7 @@ then
>
>  	prepend_var LSAN_OPTIONS : dedup_token_length=9999
>  	prepend_var LSAN_OPTIONS : log_exe_name=1
> -	prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
> +	prepend_var LSAN_OPTIONS : log_path="'$TEST_RESULTS_SAN_FILE'"

Makes sense.

Thanks,
Taylor
