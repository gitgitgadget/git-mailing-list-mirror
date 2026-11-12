Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488898;
	b=z1ZngJmoJuJXboogjqd7beCmlesje5RcH+4Kr6pEWpFTAwn43/76AOIcDxBpZ6W7kvJ7
	 rn+gHFlDgIGGHJ+cnL3mh1t2Q28UUTusip4vnMneZQXUXEOdudqBt3GUd7aGlMt0bcS78
	 0r+Y/iqk/0X+MtVAMtqQS4it75y9PrjQMnyppIo5CKqCoKzaXfS+KMLjZwmPbdIvq2GeF
	 15eEJHyGQL5D1mOT+0B8ZMJ5b1T7JxFqCImYoKeOwEZXKeyoYLLVivgh3JELnQ/airKYI
	 HmMXzXiAmXicsPQ3geS1/FzOaqYZISjI+DXtXhQtlTx3P0WJbHLntaAFeNdLIJGPNPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I1R0/DiW1hFMsAu1OYYe4+aCtvM6qXm17R2fxw3JpVI=;
	b=aeaeqsNxV35M3BZQof8RYNpkPRCqDRaaqRCX9N1AhyC2P0oM64nuEe0LxZubGBaGbTj6
	 GhDLboD1dD8ym87woI5SVZ7LelKzPiAFWycnuQ5dWivobwaEzS6NHFc7v2Bm1YAkwZ6z5
	 Ayq2cA91HPlr0qNROncXC1nqKoNZk8SLhCulDv1oXMXyJItqSF69WNXJL/Na6FEOR54Qk
	 I5Ava3VU1xVts/cO6INwx/FPqith0UV/9pOYu8mhg6hc2u7RAbmFJidthyq5IHvwQJpys
	 OV4+QlSMhyeC3DJiB6yrQtaWDEAoeV3P3qX20dOros4+LzA4as/KS4QcuwVkEjvnuPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gAaGVUB6;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C699606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 13:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C699606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gAaGVUB6
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b8ecfa886bso460953b3a.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 05:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794488897; x=1795093697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1R0/DiW1hFMsAu1OYYe4+aCtvM6qXm17R2fxw3JpVI=;
        b=gAaGVUB6AZXWlNEz+dYaNUFje495clzCwOGncqAr/gwuQ9/xtuq/GuPCI/GrUeKKA9
         wg5k5vIYQ0TowGOQZCVhB4BslsbU9jElwue8ptjuudXtX/Qh3OMw9LoSNKWujXsyi8FN
         qaX2cEb055Pfxmv3H+V85+xCGs1QT3YjhkPup0q0x3yWPl9b7bPonmzXS7Klh2UR7Bf6
         5n0+DSMyr/l+nv51SDMDGaJ+HELoOVWlm/+Bu3AAJAbhjaa00oqt2zC5Mm3wvhSRVAot
         vcRUA+5mo8O5oSTKiu9wXr1vtQMt/VEbXsbaUE9IqYCIgHHGtuvvGPRBKpN0cal8J/Xx
         HFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488897; x=1795093697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I1R0/DiW1hFMsAu1OYYe4+aCtvM6qXm17R2fxw3JpVI=;
        b=aNS1qV+uI0oru5lkjsIyKhPdutSuK+b8F14FLf0hpxrtaIxJTJL2CPKXV9FfXu2XQX
         BCIowsfC77rJzAH4OADIRUUzvHE2hOhyiAaf09bD/sXLH8aaZeY3U1wtyzoHB4Vl8MGT
         W4vA7xR5SH4j2Gi+8UUdOgXOOxCEe/BrivyjzMM6AuqsSAm5adtKmjGxvBONTPh20v9Y
         GIxcM7ZqOkUt9Y0A9iaEEvJJQwRrNpaP4BwQaJL+imqQeDZQOQq8l8H26xO+imqMM3tu
         fD+aW1UHnZj7DG+P0KRCJk/78rLcMVpm+mhSB6Apo+yyrN0IOsnlnydZWc/HcTdTqFaO
         /GpQ==
X-Gm-Message-State: APuU4Z9KN7AFsOB6hCMYFnPoHrKZjt+4tViE8CsKY+M2EbqgBtUMZuTx
	fduLqhsZEZDM7FYHRuroSd3Ef1sTNP4wUCNf5DPxQtavKW1NhgQzefeQ
X-Gm-Gg: AYBFou2HC61Ugy7QqYxnpyRuZp65QXm/FxxTUP++Vsy428zm+lZGLU6Ft7KfeYjRlED
	DXSsmlj9x0xkS1uHRbfs92QhQ2XkH48FKbS0Ef8oV5OWL/epxaDyWCl/DbQMs/7nb9GMSwiRBbl
	5GvsqimpkU6kgbLB75iqPC9Si1okKUN937iT+F4jybo7Fmt1mmHn3I6y9rmPdkXF6bl7C6Blj7Z
	RYoPOjHjO/m9YLqB5BiqLzYJprSXZGRujo8NMwieu4DU3+EzB1HC2t5dQAZ7tnTJ5gNSUZygdEw
	G6Gz+QMTOZLeLTJYUrrFUMpXEbJd+G1nxgSlRtn7srN8eGta7ESKtzV5MJiePYhUA39w5bQOxQE
	o1OT8nF/pq4g63x+A8OMRG8OGYUejlTW/keURdwRQp3WNT3LSgEsHgI+JH68pcPaLgRq3kp+MLn
	4HvAXXpRj80I/LHr+re7vfzETGApWMHzxE93dVNlNQbDVN22NtLqt4BMc1bwtPW5fn0JJYYy2CY
	k/8I0t1YnNUEPUgh8s3C7rDXomGEJuuXwPKy0hB8s/HQavghOvRUvoT11nbGTCa8BvUKco3c58q
	pd9GDY92+1Z6VCEXvuQiUHCamXmlg5CfmZnQoNuAcRpviKwoX+gylsHtHuQ3lo+KFCotvxjM+/O
	q+5twBE/tnilWeKPmgnNd/w==
X-Received: by 2002:a05:6a21:f11a:b0:3e1:6f0a:cf2f with SMTP id adf61e73a8af0-3f631771e6cmr1725370637.28.1794488897344;
        Thu, 12 Nov 2026 05:08:17 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa2a6c46sm3549020b3a.9.2026.11.12.05.08.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 05:08:16 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC PATCH] fsck: report the real object count in the connectivity message
Date: Thu, 12 Nov 2026 18:37:49 +0530
Message-ID: <20261112130749.51747-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112025559.83265-1-laveeshb@laveeshbansal.com>
References: <20261020102134.42151-1-aniketgupta3001@gmail.com> <20261112025559.83265-1-laveeshb@laveeshbansal.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

> In a partial clone the number counts blobs that were never downloaded.

I can repro this. With your setup I get 9 from fsck and 6 from
cat-file. The three missing blobs are counted because the trees refer
to them.

> Would "report the number of objects checked" fit the title better?

Yeah I agree that "Real" might be too strong. I think "checked" might
also not fit because the missing blobs are counted but not checked.
Maybe we can use something like "report the number of objects in the
connectivity message".

I can send a v2 with a new title if Junio wants one.
