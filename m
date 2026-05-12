Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB31E4AF
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778547802; cv=none; b=FWYxAZRmUvpuQA/ab3j/IzP7/RsB+2AT/MpnWHoS+winkSx9n5gQxQQC5R+k6sV3gxRTp0ihQkqCVcBo8ojFCIcUbukY8rtEHxviCnjwK/jntZsmTBxUfpm8Een0AEb4BKcQouUbIxWpZrEcF4ZcrL6UIhQXETYQM3jhrtJFoNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778547802; c=relaxed/simple;
	bh=IgMPIWLVu/9/+EC+TTQT4lB4xUek705IfBmQ5ggSx/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwTePjMW8QcuAsYR3h9P4+fWR8qxsG4p+gK7KQiUR63y6IT+8TSBLnzzSo7AJ8Uz4UUdAuBTE6pOGi3vFTF36OTOHC1ppzOPxQqHwlWd4so+cvOnkbfRfoZS35D6dNrm+hJM3KO3wiwV+j/OpVmLGqVGivOhn6vZUeMN8XWpAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=E+OwNVNy; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="E+OwNVNy"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64d5a7926cfso4592927d50.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 18:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778547800; x=1779152600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgMPIWLVu/9/+EC+TTQT4lB4xUek705IfBmQ5ggSx/I=;
        b=E+OwNVNyVAzpMckZ646cu9u38pqnE4NgoIsS0V7OwbmQUW0USMJvhiAjIlfpL4MZSa
         1dss/+wq0ngxZFsicHr4ggX2OPXbjHA0wwwMmXctoBTs+9QVRzP7yBNQWaKlmOYSkEcc
         EIXVLdHu4YO6PrNdnX9+lsBEl5dBs+VNd+LQxYZsYjhPCSqkvmWGKCkTfTMYTKyPa/Ny
         +u176t2OPZjU3fmrmoOnb68uVVgGFG+GzfpsZfZCFHBVoya5nUU3MlDXuqmE71Un7y2I
         Qxcpr5sHIFr1qzAt/4prfPyri8stVUu9m8pPaYEUFM7jmhspftPy0RufQlUwZmg8uyw9
         G6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778547800; x=1779152600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgMPIWLVu/9/+EC+TTQT4lB4xUek705IfBmQ5ggSx/I=;
        b=PyKTIXLfL3F8kruF+hoIEyzlJ6lgBeGE6lDss4ljXGI7KVIagWrYFu9njMEMaqKi2H
         oa/XkMJw61wI2SVeJ1a6CNTO19KW6wlcu6b5gXPmmuGI9hm9eUGulOPgZgEJWAVJST1f
         vch02CXlLSsERdHh2wH8rRcnU3+gqjz4GwKwGlW8mVmv73vfTEY+4eEm/rRBSwg/i20Y
         Jo9bdsagTNIFopja/HbysSaNE3SalsweHnCQKnK1Wpzemn6+mjbYq8yjVAKL6WvOQpTy
         SGyolwOnnbLW9LxRYppL5GuG1+u8IbaIPmWhEVmYQQPpGGjsGuuhasBZvVmfE+xAwqcQ
         gGbg==
X-Gm-Message-State: AOJu0Yx0uej4owDENeMktW9/yeXvxzWnsRHHRbCB//ripjnjHaYrXrjz
	/GJdfTr41v1KIg+ffHn18gFzF/yyCRuzi5LRAbJYbbr/XlaHra2TkeCC07ZqXnS0kdU=
X-Gm-Gg: Acq92OHmcYx+5m5GRSMxrjSe1TbWiL6E8Uh7o12kDug8xb+igCjVOTTc6xmJhxkWIkd
	V1YN6dM5PfiLoc3/s9rHu8HxGgcp0xX0rK8lbBvfyRA/1NlYMyukvVlq4HVYLXiEZ7T0Dd3AJN8
	F32hM6/JacDXehqQeLYN2BluzQfPZOlfqLCbao4qP4knusRvBvr1BoxD1XQa7Yv4InQuUlUx+/N
	3MWiLl80fYVayw5hJc/y/dcTo+tlpLXTNRs42TDCLrwflJh0dYkHGr/U0pOpU23JWIghLcthTRz
	pkIELbzNLn67DNypz5lDwlsm3w/terXQsoFu0KtiWvd3JVNa+MLBSmMLtF7z+3iYz7ZUclNqo2C
	lpbAqzaAE2tA+0pEvY3x9BU0UuINP8NMEStH0i6rzEZOCJ7QfQmEc8nq4or+HMrxRTUAOTs1yit
	Ge1eQBv23ytCe3375K9n6O7AQRx2pwHrFhWuRUeoZsp7LM2SEBqVOLaMTgXRHTd820YnVTKD7oE
	Fl7SVI+T5e46ZkJo45qQt0MHzr5bflh6U/30jBMupHLVh/IzniCyPZar6mOazA8txEL01iYvWcV
	TwykS7Brm9cYgikB
X-Received: by 2002:a05:690e:12cc:b0:651:b2e4:63c1 with SMTP id 956f58d0204a3-65c79c2b00dmr25328482d50.22.1778547800679;
        Mon, 11 May 2026 18:03:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96be4aa2sm6196374d50.15.2026.05.11.18.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:03:20 -0700 (PDT)
Date: Mon, 11 May 2026 21:03:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 01/12] t5620: make test work with path-walk var
Message-ID: <agJ8V4wKF6NQI0fO@nand.local>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <0840110116a967d39d8b63dbfe822ea9b2500088.1778523189.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0840110116a967d39d8b63dbfe822ea9b2500088.1778523189.git.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 06:12:58PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> The GIT_TEST_PACK_PATH_WALK test variable allows enabling the
> --path-walk option to 'git pack-objects' by default. This sometimes
> engages the warning that --path-walk is incompatible with the --filter
> option. These tests in t5620 fail due to this warning over stderr in
> this case. Disable this variable for this moment until these options
> work together.

Makes sense. I think it would be equally OK to set this at the
top-level similar to c51f5a6437c (t5326: test multi-pack bitmap
behavior, 2021-08-31), but this is equally fine. Especially so if there
are other tests in the script that we do want to exercise under
--path-walk.

Looks good.

Thanks,
Taylor
