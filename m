Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110213E9C32
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785861388; cv=none; b=M93MBmp6fK6MlmflkaJzpDTX7kixuCqoK1JKb0Bo5v0fWfSAqWI4HgdCgNceYML8C5gLl0i4tNh23qHFHy/25MNUqUzXuV0aaMbzvCf2h/MbiXWGvH2z9Bv0YbLbZjK1k8+KZ9SfAQkh4DOoS2nVBF3fo8ficnSBMu1Eq+rn5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785861388; c=relaxed/simple;
	bh=xf7PSXdWgm4RfJ9CyQWtOAQLUi1LQnbRGAHWdaZpKcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEwapsQt2EbIQEkGbzU7t+XjifIahWybA7eqdto0SzXCOT7uZEzb4/yOtX/zXxlodKd4L6l3YwbGhxJTrj+ZwQtR58GtLTUu67DnFKJfCikWsfscIPHzORQocpe/RKuktejKT3UCLrUjLeJxHumuBdLRc5ctPK9wn7mpX4eFnsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcKag7+z; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcKag7+z"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-446f87b6de1so2996534fac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785861375; x=1786466175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oVVlGBlYtuU6+NQRySqIrK2W6dfwedEc3Be0pEmYgQc=;
        b=hcKag7+zY+JQ0m8iuSZVt+SXXRkO0G6QNQ2ESZlKXshdgL85M8RfL0ckp1gTv6z+4G
         cjbmfWFsS8x2qfyJC3opcHVpEYnNxnTJrR1Hs65cnKwK7IcmxIVs2AO65sjX004lm2EN
         xarrv3wN5pyhqGBPnlGz5Wyg3WeVLI+5VjyWG4ebJeBenNvNQcuFUlgwagmMvBLy08ow
         v3lMXsqIZC0tyo9Q8ipYRlohwskrWb7x5N1tW2N+npEEw+3b1fMUpxnf+WXDNW0jo9fv
         X+CB927S/9wb5VidNcp7MhIVxTvaSyQHm6PfuVD6U0IaDWUUuQb7+iuWIzhQGLG9ajH6
         dNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785861375; x=1786466175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oVVlGBlYtuU6+NQRySqIrK2W6dfwedEc3Be0pEmYgQc=;
        b=Ua4TL1Qn0gwD/jDsZ1FmvklWx3cKa+mOh/Cqin0Z/jO6Fao9rIKhes2iwwOwYz7ex8
         i+Aj08WiA0OGz2ztCVZWNulP/2FIK1csoyL0y8VffxGpimwRplYnn+rVR+rSnu3YYRat
         iq2u7G1IPjQQakPeFpRFcqekB9b39/QXwxUn3H9Zejg219ANWVKdCjwS7dFHIo1MqJCw
         tft9HV4sv7t8fVNnsE9//xgeb/AX9xjdZTdOxgbMx1CrrYzfrsaznOypSgrWWuCZN6K5
         fKXho0YUw1MytIFbe3Q8N+QDbk1yBI7zYKWMzbqWlTx39vs0wpTi5BhwourPcezfMhQM
         nXNA==
X-Gm-Message-State: AOJu0Yzj8atHTc/Txjnr5KeGcU+LiyQ9BvNzAfODylgI5s8xryCgOGJZ
	xgQ2LELLfZzLuthNTlD0irNLyrzIZjJmcGP0wYF5H/RJ7eauVWYPgmwg
X-Gm-Gg: AR+sD10PT6g+vtdWRzL/DHpFtxN0bh+GAo/aqS18+0h6cs5J87V4DUDjvRXq3bS5OKX
	wWrOtdRRGb9+NToD105MProiZ7AqOC9RGY7nygKTUjL1xCVgVD24rozGSWAJ+tQoeDWlG21o/BJ
	t1q1WmQ9pefSTmnaQ69ZKtYpL9nuQCR0wN/0cTAO/Tn+KYVfTOTE9quKmCSLCwFSItmu+LqbIM4
	kRyStHj4m6n+o8Azj/Y3s1s/Nl9SH7TGIDghTHl60PlMTUvA8YM+o11Tkqf7pOc34CUO65+5tOJ
	ctBC/SaxrVwIGIHHxwiyWs8YFzO67649lhVtJI8Y88wRHiCD2hCGD3corzCQJTe5m58tQ/WURpY
	OkTuwgl+3AY2DPLfhElxFuJ1oMPFlKm597228799NFWyvv6JYjXChCWZ9X+pwk7zPEBooBDbkma
	XU7S+F5xJidy9RNP019jl0ZTB8nmSENbXJpxAYtmn+DHn1omGcaYRt8Q==
X-Received: by 2002:a05:6871:a86c:b0:44b:7917:7173 with SMTP id 586e51a60fabf-4599ecc285dmr3128fac.7.1785861374778;
        Tue, 04 Aug 2026 09:36:14 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599e5b460dsm53300fac.11.2026.08.04.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:36:14 -0700 (PDT)
Date: Tue, 4 Aug 2026 11:36:11 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 0/5] odb: make creation of object database pluggable
Message-ID: <anIU0ivwnjn026wa@denethor>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>

On 26/08/04 10:29AM, Patrick Steinhardt wrote:
> Changes in v2:
>   - Add a testcase that demonstrates the bug fixed with alternate loose
>     object maps.
>   - Rename the "inmemory" bakcend to "in-memory".
>   - Clarify some commit messages.
>   - Link to v1: https://patch.msgid.link/20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im

From the range-diff, this version of the series looks good to me.

-Justin
