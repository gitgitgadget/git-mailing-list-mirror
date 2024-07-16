Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508F2136643
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137692; cv=none; b=eqoMHjcB0thD4AMd3fW8J1CmLkhhdPwXcrM+WHI1cZSuZj0A+9YO8+G1M64IGiZBS+nMpgoHP3+znrQyEEDh+8B2Y0jT8dPZ/caj2PVDOXMtgvJc6uIX/jw9RdMFN/0q/TqXXiRLQ5rKR+cASPYX5D4zkO5HLg2SqRPVbcDU/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137692; c=relaxed/simple;
	bh=Z+5nhSFq1qenJY+aXFkoDPQ39wh24jCaTcWYwmldoPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN/GxFbNlhsfP1EQHKtGhGU2IW42PD43cxCu8wrLMsaVc99SZ2hCF71de8C8LDSzPRf7KdnNZz+IYemPApyicc1AzBQCvNueskha0fljDeC/O8VuNOSZoQk0jw6B8fbDgt+EuKBpPeLG/m7t6DScAF+RcDBGXOMJShR65abazv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTCpUNv4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTCpUNv4"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b0d0a7a56so4166056b3a.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721137690; x=1721742490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajY944qV40SrBOKsnR5So3IcbCzm5kn3Gubx8sIwgKs=;
        b=dTCpUNv4gxBjOMaN67iH1a7Ln160iP/htSYwPiZDaaIAhzMZ5MtR4TIGXliwQ6uxp5
         f/6VXJCA/hR/7TJOQlzNi8bej4TRMtYjtGGnHhqhBhL0UA740gBxzJWFhSvW1eUJlBz8
         kembHZ0jX0FrnIhKzzglykfahViEE0kkQsvDUvnpUkt7dnXgXTkfHgRhT8o7Mb0sC3wY
         kmwLXsRkeWETauKcXNNMIuF5Q3D1sHdFCLhqT2X7QFL4kX2c4cbxCui11A+cPFbjlmb7
         Up6GEdTtWLKqhtxHRlWkL/wnojtk128wmx9yqjs1svLwJkBqmrGsX85FTj3GyKrsZj1K
         0L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721137690; x=1721742490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajY944qV40SrBOKsnR5So3IcbCzm5kn3Gubx8sIwgKs=;
        b=cs3GjBStClhqIzWJCBfzi8LE9HxH+D5Id98neD/bioDwAGNq/hT5vZYHDcXbH0SWXM
         3aBgPuI9/obhgsIs3XxHhPSCEXG1qk3JRiILrD6ndzs7rHwqFZBnvzTXWGg5w41w99Sd
         r1y486EF1B1Q7/BUVyd2clVza28gQbTBB10MHRP6cdnoa1qoa1zL6rXMYSMPaDZBPoSa
         dPLAheHnLJ/SLDPoXH6HuvRCHDenfCb+ICZBC6BLPHNG/k10JBRMWHDLyc5ON6bTBOui
         5A65mil81hDoutp4M0MBlN+5lviS8bHp8soVAClfYinH4ZAgDGjuQRFHQyV+LnKEGiI7
         1vKA==
X-Gm-Message-State: AOJu0Yyhg2X0AnE9vtI+tUO0K5Iqh/U12fTItj7EjEI3zIquJEaOrOfe
	zIrspSXM1tCkuS4AFUdfF5Niu6Nvply8bcjdxqwE3IZc99pOFUbC+F+gyQ==
X-Google-Smtp-Source: AGHT+IEbKhTqjua8j4ebva7dKR2uS6HfM0KOn4Tikr4CHXrRT3Ribxw3duhvARK3Q1bRUlS/ZF7Fpg==
X-Received: by 2002:a05:6a00:10c3:b0:706:6c38:31f3 with SMTP id d2e1a72fcca58-70c1fbc227cmr2839842b3a.8.1721137689930;
        Tue, 16 Jul 2024 06:48:09 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7d957sm6268414b3a.110.2024.07.16.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:48:09 -0700 (PDT)
Date: Tue, 16 Jul 2024 21:48:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC]: Implement consistency check for refs blog
Message-ID: <ZpZ6H6D-a5B9QvhG@ArchLinux>
References: <ZlQ7j9HYVOpP2Xga@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlQ7j9HYVOpP2Xga@ArchLinux>

Hi All:

This is my week 7 blog:

  https://luolibrary.com/2024/07/16/GSoC-Week-7/

Thanks,
Jialuo
