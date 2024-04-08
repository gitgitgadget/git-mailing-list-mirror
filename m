Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146B5B1E0
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593102; cv=none; b=kLY/ZLizg/4U8rZDnHMO5giMhWrElD+WmZ/zRhkU+5wP0vgOplnPJPYgCiiBFKPwXpQvpKSB0NQlh/VaIwsbfrhzwSRflqFBfS0g8zX5V/Pu1HXJLZtY6Ne7HINQd8wVEFQG+ob+hBLt5lMgpnqDq/u/3s4wwZ0MSQRuId03XwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593102; c=relaxed/simple;
	bh=3mo9ShOj0TZgULQkpeE+6y7jkAS4KUe9Rz4tckeUyMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NETrvPMw+FFtW8VT7Jhr2i54R2evvq3eKoDygLuPrrwnGQBHgewcalXSX4x0ZKQ4MPyuOCQSTbcj90wHT3wf5T2uonSpMLlcOSLGEy80LANySCvEJrp2fCBQ5sFJihnm/kC6rvpZl1uc3G1bdWlImG32VD9SXBsqaL27JMTeIaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWfNKrxP; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWfNKrxP"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5aa16c0583eso1360263eaf.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712593100; x=1713197900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSMkVmw22REgjT3jGscjvPrX2NuNHhZ0IpTNCl8M0rE=;
        b=WWfNKrxPcV+mcjvZ6MQC1lbhbheP8spL/Z9kBxU5j2mPhdsunPvUbcObib8lZPO2q6
         wWujNLYTMuiKLCwFXxD/cRys35qTygIaaIYTQqgy82b3kCvXOXR3+q4+ISbguZtxl/qH
         zgQ4FjCY3jGrdbwHj1qTAOx5eOSJKsqhhYuvU30NKWyncu0XymwCsVlwHyLyPuwWCTza
         1w9/uue+QlyDfz+5lvaNeCFjNF3/r0AAv0fDeRkfLQgIKbFVVEfSLc04vuPUpJfMN3B1
         5TjJIw0Y49/3YL9UXc2A3IZ3ivJzFGONVsD0XTFq3mOdZ3PhoMotCNVBKE9yZuEgu28z
         5R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712593100; x=1713197900;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSMkVmw22REgjT3jGscjvPrX2NuNHhZ0IpTNCl8M0rE=;
        b=d5pD9Ga6QzSqba2G5bQgjA2ZnUnT7pkJfotGCIX0z5Wnbah4kZsY13JtQJ2nGwaAxW
         eUJH2k0gWxTJjQ0h35/lBMST95uHlu5hOu5reBwgkXJRuccygmbukrqB2bvs1IC7KVaH
         vAFeaVaBbY1pvVanTmMLEnCsxlRTulYgguQf8yc7mid68U9VlEyo89Nbi8wCe8RZaufd
         g2Wwx4Am0xARFyY3Napg5a+GKAdzY7v3iA2GL5w1sqPfV1ZwuSdymPoE5VkZlfY6c19i
         7BEBWkVOAHOL9nMoUFd4juo9Yjv1YXhevgD5WswCR2zvCkRBoTCn6QGNf/w81oraAbGt
         DZYw==
X-Forwarded-Encrypted: i=1; AJvYcCWq1Rupmm2geX29g/kLntwgIEE5xRvBAYgqih4iufp7lS41IhgapBsXIYBUjSTf40XOICd0Wf7SdBr4+4JNrprEoReB
X-Gm-Message-State: AOJu0YyqeOYhCWanAwbwBCiJRDmsP2KRAeitGSZ4/E1jD707+k/AeTUX
	OhNXY3SWv/Z68nZI4DvHyT9a9tJ/GWljEzTTB9QS3kldY7lmZe8c
X-Google-Smtp-Source: AGHT+IHv3SKq2D2jGB8VfbEYhHc8tb7HobSKw49JLDKeq2e3oI0U54lkaVOKwjHZFp1jHXgrLLCh1A==
X-Received: by 2002:a05:6820:2d49:b0:5aa:4fa0:eb4b with SMTP id dz9-20020a0568202d4900b005aa4fa0eb4bmr1109240oob.3.1712593099830;
        Mon, 08 Apr 2024 09:18:19 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id p14-20020a4aac0e000000b005a11e5ca919sm1608804oon.32.2024.04.08.09.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 09:18:19 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:17:20 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 0/3] reftable/stack: use geometric table compaction
Message-ID: <n32hb7imvnr7jfl3nh27fhmcpstwm65oznxmqky3g4gcleu6ao@jiiq4avcqrpm>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, 
	Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
 <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
 <ZhOKxLCWxp-lOyVh@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhOKxLCWxp-lOyVh@tanuki>

On 24/04/08 08:12AM, Patrick Steinhardt wrote:
> On Thu, Apr 04, 2024 at 06:29:26PM +0000, Justin Tobler via GitGitGadget wrote:
> > Hello again,
> > 
> > This is the fifth version my patch series that refactors the reftable
> > compaction strategy to instead follow a geometric sequence. Changes compared
> > to v4:
> > 
> >  * To fix some failing tests and conflicts, this patch series now depends on
> >    the ps/pack-refs-auto series which is currently in next.
> >  * Lifted the GIT_TEST_REFTABLE_AUTOCOMPACTION env out of the reftable
> >    library and into the reftable backend code.
> > 
> > Thanks for taking a look!
> > 
> > -Justin
> 
> I've added two additional nits which you may or may not want to address.
> But overall this patch series looks good to me. Thanks!

Thanks Patrick! I've updated per your suggestions in the next patch
series version.

-Justin
