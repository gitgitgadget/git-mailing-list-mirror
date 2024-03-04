Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB93A1BD
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552742; cv=none; b=MRfywLzXUjtyeSfaxfYK3w3N1HjgqxlCHBC/wx+1dZxYfkhpR+ld3FWIjc4P7WHd4rOi6eVLMemFCSPOac6/dKkFOwvWSVOcCd3m3zl354H8YtPbTrIr2Pdtw4S/pmlTN5g1Wfcf4k6+Fu3EzL2DgX5W3sLXH4bndfER98rugqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552742; c=relaxed/simple;
	bh=2/WYxnEGrqM45bTH0SKS+72mn6o3AnOejNnYpH6WHpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwTr77j8Sgta6c2ylb8EwCIichr6f2/kWAuTDxl2LO/+S+m6Gbwz7vkkccuXRFtY3P7goXoqWVHW9tDZXILvfZUW6CC53khcQX/zpJ+UYNnb4F8RTn405rrfy6mvB8FOUM3rEhp14ZPEJ9rpCG+BdMKhxz5anjTafvrHOxJedxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN5vonNk; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN5vonNk"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c19dd9ade5so2639912b6e.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 03:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709552740; x=1710157540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/WYxnEGrqM45bTH0SKS+72mn6o3AnOejNnYpH6WHpg=;
        b=eN5vonNkUzMQPLppuwys4OzUdZpkJHJ8nVioOjboDgc9tFddUh+D8GMATPsT2TjNVO
         69Km/BiPTWrPtNCI2K4+Xc/fO9DNn1UCJNAo9N4RM+L+HvmUcQu4ZpKUWJVoAxfEFx+H
         Bp+lkERfWxGdz5FtwZW2wUSZTCftMoKYKXnvCsWs+fQFs8/YIciV5YWkz7G2gZAGZl2N
         PXtJoi5eqSoH0w/oXa2yqPzhv1EcS40fkYFzkeHq7oLFjOhKdnptgWTybTbceqjd3vc8
         bpOrCAL7GQBw0vjXeU3Em6wgfpOIWQG4VgW4F2TFJRq9+1brtWpY++grk15zNKUWHQv/
         YfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709552740; x=1710157540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/WYxnEGrqM45bTH0SKS+72mn6o3AnOejNnYpH6WHpg=;
        b=AnfgeBJKfOSZ6DMNK6FFOA3Q1H18LCuVSp34PqwIlHCp14Q/btg1tZOkfKDW2q4OZY
         5NisQq3meSa2Sa2IR/6xUVGplbIp+1e1N02ZbvLzfcfKVrWAyjBq2zFA4wJmZezvLB0O
         EkY2rBNq+eCvl2rNmSyA//l7jXvnipUBHlZEhjdJ5e9cEgJ3n/xx+zEhkE8IpVGRiqiR
         Z+iiocqQ5tZQE5RNIqaOLDCsUx/gNV8XFBZJagF/O549MY+/Uode8JXDqfXeryf1Pz6L
         XKzbRS2rPchGaJl/Optmkkf4dODQ0RYHiiYcHOnE83exLnKMOpxR0rUdzNFkopcRRyeu
         WLng==
X-Forwarded-Encrypted: i=1; AJvYcCWV1S9e3gMqvL6AiM8ZfYQef8Kx8GNxAogpzzCLL/eu/V21N4XzTrOKha95qgUVRzWgFaHkp9PL6oXCyNaYkVKArFA4
X-Gm-Message-State: AOJu0YzW8M/+I9xAxRtox1huOeFJSPNXUZBe2tHzDTc2caEJxMFwHNAS
	2qRk+qNLLIMZ5z+29xTLj9l+VL6ppz0AbpVSFUOaGwIAyEUwWgil
X-Google-Smtp-Source: AGHT+IH1RgRy5BsXI6YZD0dSD+kvt/6gg9QmOQZ+6GgIiEjWA6r6tiKISHC5VHrldqz/JP9oGB6dww==
X-Received: by 2002:aca:241a:0:b0:3c1:e9d1:2407 with SMTP id n26-20020aca241a000000b003c1e9d12407mr3405272oic.38.1709552739819;
        Mon, 04 Mar 2024 03:45:39 -0800 (PST)
Received: from ArchLinux.localdomain ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id m6-20020a62f206000000b006e56a4a2518sm6988013pfh.203.2024.03.04.03.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:45:39 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v4 1/1] [PATCH] t9117: prefer test_path_* helper functions
Date: Mon,  4 Mar 2024 19:45:31 +0800
Message-ID: <20240304114531.62770-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <ZeWbdvFmhUYN9ekE@tanuki>
References: <ZeWbdvFmhUYN9ekE@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for your advice. I will remember this suggestion.

