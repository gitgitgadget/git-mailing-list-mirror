Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05612DA749
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772322253; cv=none; b=LHEmd7GVb8t6B70bVhGlf21wVtl1gjrqgs3Kzo5aQ7ka16oGu7fzYW3FzvHvHZTIebGtti/kngSjTUY54WVPqvVR8B16Oe7VNZ8z2TUI1swG5xdn81gTbwal/4pSh2uoENtU8+xFFvCbburX7H9iMsKbb//CwkhOLpVm2ytklhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772322253; c=relaxed/simple;
	bh=QdD/tGid7belI8DbC1vN2wAfGs6wl4LKCjjN/VyKGGI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FyHZ8Br3N+2YS5Pd2w9YarcLfAse+0+pBpeKQCsQ+GVym4U3LndD4/BCkn3kLZmb8UOqDxxZUjwBqzWPyDZzJMvBjFLHPb1349/za4x8LKY7berRVyQByQNmbvaQlyEqS44iWpTfd/lOQigqYms0Mmq/BwEnKUHzHV30tJk87xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LepcArix; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LepcArix"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso2515482e0c.3
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 15:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772322252; x=1772927052; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdD/tGid7belI8DbC1vN2wAfGs6wl4LKCjjN/VyKGGI=;
        b=LepcArix/7q8WGo1JYcnitVsQ+u77T7C6aM4Fv3SKsWlxONcIrdNDJI3yAcoOhP4HX
         mdVqAV9e77ApVqrw2N1sY2Tm/7BhNwNE4iYtnfCoTGj2+/u5JK3QhlE0ONybU2GlDVbh
         Q3idIAgqcIJYxStB9mPLmra+9Tcl682xshvHAYXWtzSOALensPac0JY4tiIazFHEnCgv
         BnokMj/qDXIgnDc1ghIZ+yn1wTMIzM6km7zbm2LjN8Lv+uxK7M14yaAdSt1IhlTusZMH
         MdCkotz4rHYprH+p1pFIu63S3EA8wH7N3pE/Fw74Elf1U6PuRaIWnfHxidLMseba4MZH
         Ybvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772322252; x=1772927052;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdD/tGid7belI8DbC1vN2wAfGs6wl4LKCjjN/VyKGGI=;
        b=jTZzFmDWgLGKUNRcyziKo5T/QZr/VgpnU9/6YLqa0RjygAvwL4/SnkT9lGvQRBWxND
         6DA8m04ylu3Sb4bVmgK2uJ9o9RfM2WPpBEsFz8kRMWSeEUOcz8s47zmtVbsRQHSJ6SSg
         cNEiUxI4iSIbRO6m31D6Mq/9UnchOnS2UX3isHgJupPiXKFVDeK4IIMN4bBq5j29gUFU
         FVrutfFOI4ZvSzysjO5xQNy0eGjAjZw7FG0/4UmLxt4vpidgRJy+ZtPmqO4A8Rvq2O4Q
         4aLQVCxMihL7yAK9oZ/34fHdCSKSHjWmYT6RHlTmE/yTfb5a4fFC3aG+Y6GZpKIpkvBv
         IImQ==
X-Gm-Message-State: AOJu0YyWnaIn8NCRr97P+Zn65uPwOAKnpyoLJkSwQoTYQQrhlSGwyuSd
	bu2g/bfhJlVIEMDDSRfYCirFOoday8zE4Mp1hsGDx6cYwMvk7aQefijg
X-Gm-Gg: ATEYQzyiurMpXX+zdMngOsAI1F57XN9I9pEB4qm5qPAT9BqJCBCbeODZVTE9V+rIm2c
	zjz/pOutVF1fXaaHl2JToTCK4Tu6lJrMXj9JVvTMtM4C1mlKbiCSfDfgGVR8m+0+QTUvFQyyvAm
	ZDBO8sPdVpEv2oX8GInnnFuL9mJcxVDjPekndGLzYOwRkF788G93dsUH8BiyKzXs9GFIeIwDvp2
	A/9mc/Fm1iGRjqe4OI9c5xnHHY4lAlZ2L9q7kbq3Dj0d2kmgJ5HgJ3AdHuIIvGJjrIFqWZrImvs
	1Swd0BLzsgWlqV2I2cutK+L64xOCHXg8O75uOPTMjndHhiz8FaMMA0ZFlfXiYoOqlQRlkhSKcOD
	IyXXP1CQ7iNYbVAaN26AKtj57V39GwW3TxOjvcG5DHVjXtfpahkIdk1slnJ4Wlf+EfqjNJnX4rO
	r1otKG8cnExQ45PhiTiUBsX8FtBVtnaZGT9bcR1wZ+kKzkxWOB0puyAzLF5tzv
X-Received: by 2002:a05:6122:e265:b0:567:44f0:b076 with SMTP id 71dfb90a1353d-56aa0a89465mr4210552e0c.11.1772322251717;
        Sat, 28 Feb 2026 15:44:11 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a92177fbasm10955053e0c.16.2026.02.28.15.44.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Feb 2026 15:44:11 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 0/5] builtin/repo: include largest object information
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260223174120.2356504-1-jltobler@gmail.com>
Date: Sat, 28 Feb 2026 20:43:56 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 gitster@pobox.com,
 kristofferhaugsbakk@fastmail.com,
 eslam.reda.div@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <EB04AA40-87BA-41D9-B2DC-92E87FACEB54@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260223174120.2356504-1-jltobler@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)

Hi, Justin!

I was trying this patch series and I noticed that it took
more time to run than before. In my machine, I tested it
with the Git repository itself and it took 6s to run, while
it took 3s to run in the current master [1].

I understand the reason and I don't think we could avoid
that, but I'm wondering if wouldn't be nice to have some
way to only retrieve the "lighter" data (perhaps a flag,
or something like the keys in git-repo-info).

Thanks!


[1] 2cc7191751 (The 8th batch, 2026-02-27)
