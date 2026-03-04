Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA703845BF
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657203; cv=none; b=Rjab6Q0G0ENyHb6mrgxjKQwYQyhKjqB+ahNsIrmMst+VrlvXFj90DMa1b6IgqhIKLlL3VJ3sHbJFfbm/i+LqlacCIWqn5X9GKTwtWTH5cHgFxFwqFmIoD/75Lfh95hx80ImtpbOyJi0ia30liFGaUXR5jFMOJcG2a0J0A/oIg2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657203; c=relaxed/simple;
	bh=P4yoQDuWvq/w5jwyWDx3qKEpLdkGJ/i9dZuNQeISopo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLo3pOvQ2RH7VgbJTia1PjPTCWtxJhIC2bGR7aRKJ/276mFq/f4hlGJ8s28nArKss91PsVTX586T7T/rvUy1+td8Or/lPqwqlGznOGWkgWBD7Oo2iwEbw8L3pooJ9mrfyIb1EDj34e3K1ngDVzwgIZj5e3wqAEaHJ4qjK7XM1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK7IYzUi; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK7IYzUi"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so1597110fac.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 12:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772657201; x=1773262001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4yoQDuWvq/w5jwyWDx3qKEpLdkGJ/i9dZuNQeISopo=;
        b=LK7IYzUiKP83211Zzx2jNy3r4QY3F6pEExE7xDR0+1WyRQ2Y4kFISw2Y6aRAIYsRu6
         oR6gvM6eufjWSWShsNuwWCLx40KR0b3LOz2m/iGW0UExgeUIoG54xJjMTC8pmJsz63ls
         07derDtNKTVOHa8qDAWCHsJqTifS+1kWpwxv3TEKMGQPMiRyOGspQLi4RYzrdLpFiwOg
         SP64D6KepYimdyGLnHYvIz1bapW9zE+3N+qSW0XygizRVuK4cwO7LYZlOkPJJqK1sTG6
         zFUpQc7d3hI01s6O/p+MwgVIjUIPlcAQrfe5I44eKDK5xSvdC29XHm5nZpahvISuLOYn
         lCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772657201; x=1773262001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4yoQDuWvq/w5jwyWDx3qKEpLdkGJ/i9dZuNQeISopo=;
        b=gb5APLhw8ijBgs3wRQLSMH9jzRbvfXQGHbcWpMFmOQQmpM8KW1PDzRisMcMULnnf70
         Xq+Mnmz9y3H9ofv4U74GbMVR10LAr0NlUrF9aCdgyCkXyGTeCNPjeB4Io3DkEB2bmlj3
         wIn2q/l3SFDRHUIDVz4IJDAcpTnRF6ajcPJhldvvz2xEwKd15SN7N5z+wYNl3uOluSKz
         EY4MWDFEnRliJn5/PdUMuIrx/vr+doCPchopy+TvaS8qpF3Ufz67wEPs9IZaxoD4MYv4
         Ed0hlGdJQtS6XUkgN+KvOmuWEKt0NEQObc+ZomCFkU0Td4NojDq6mcLv+IFMdHnOGJNI
         9scg==
X-Gm-Message-State: AOJu0Yz7UvJ4KQw2HRQ2MEvMSE1INBwi1WlIzi3p7iAg66zcm+MbHBSB
	jUNTLR2s3HOKmt4IJNtNUjwvixSlEL16aCtRphfz4oQiqEgseKqhj7JxsoOUbg==
X-Gm-Gg: ATEYQzyB6jTwyPXRtKjLQ7Db3VzclUbS09BPHVbBKhKeFDv/VpvPw4QDcqPVMjDrkJB
	E685ORvpmnzVKuzNY2wSdHom7wuLcam67UQlXhHnF6LZUfCbSAFemc+bf8uRs/0P5gqfoSoaNCe
	84AG9aBcctbPvFRwfALfHiKAGZetkWsSQjsdLAkNzBgq+ksQP1tcexqPIqJLgRvPnmB45evjH6N
	hFYNU3s0jythC3hruCr8tw82zkgaapfFMhcpuANFR5Q9Ik7pQmSRPQ6Hll4rgWDV7p9gOmp+7a9
	7ygyufpzLYXwsEY7bJmCJ7T2EFvaLaCialXKZ/YGKhBOJBzzNaqIGVWzxBXAJJIZZ1RD0LhvdC1
	GS0cJvM1t2mTi/MqRJcivh++WalEBWZlnaEQtYdgblaYGpA1sLIGdqSf4Q+eLcTDLOFpeGjW7L8
	baBQ3dc2VdnEievWQv
X-Received: by 2002:a05:6870:45a9:b0:409:7c12:a53 with SMTP id 586e51a60fabf-416ab50b057mr1872391fac.1.1772657200668;
        Wed, 04 Mar 2026 12:46:40 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b240sm18589577fac.8.2026.03.04.12.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:46:39 -0800 (PST)
Date: Wed, 4 Mar 2026 14:46:38 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/17] odb/source: introduce source type for robustness
Message-ID: <aaiZTjrK2oHpqmVQ@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-5-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-5-253bac1db598@pks.im>

On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> When a caller holds a `struct odb_source`, they have no way of telling
> what type the source is. This doesn't really cause any problems in the
> current status quo as we only have a single type anyway, "files". But
> going forward we expect to add more types, and if so it will become
> necessary to tell the sources apart.

In this patch, it looks like are only using the ODB source "type" to
know to properly BUG() out when downcasting. Do we anticipate other uses
here?

> Introduce a new enum to cover this use case and assert that the given
> source actually matches the target source when performing the downcast.

Does these mean all future source types would be required to have their
own enum value defined?

-Justin
