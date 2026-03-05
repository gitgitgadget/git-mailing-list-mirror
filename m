Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528DE2288CB
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671805; cv=none; b=e7/UukU3R/17AcVMtIpn2yDCQ8K5Z+6924zTaKemyzfLJe2j2JmI1N/YG0Xh0NPL4aoBf+eOhWJCJu057SEyogoOIroCKYo9XjyGuVArlP15YdUxA6+PBNGuQxl7NcDofcBTIvb2bVuE5its4Ckitk7zQQfhPBvA1y2awJh5yes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671805; c=relaxed/simple;
	bh=GaoMI2pBU67ShvG4VUvnfXLXH0rKscBtOjFOK09MkxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze6/FYbZPIqcCau4k80D7qYRKGJAPVtuBzWdKxPO8eOYL6AAXpxn9al9BTUMizM8AE/DTolUgrDLrR6nWRMQS/2K33asToK/zR5yNfAj1mm5YBkBymrQ+JeWcVceYBhO1yqBrxkhfOuaNTRsFuao4EGyf+SFTgBu94ah9cQRBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxhVF9wU; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxhVF9wU"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89a06bc2f1bso52148176d6.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671802; x=1773276602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaoMI2pBU67ShvG4VUvnfXLXH0rKscBtOjFOK09MkxU=;
        b=LxhVF9wUpeN6JV309JzNEPKEF2iJRrAz0yYbtTAE4JrsnfdUKJyLMO+cjBs125txqT
         vtar1bTXjxri5wnV/5UustJvQCVWHWoDi58Q18dFe8fTDfY2QvLyL9nlE7sU3cEp/W7b
         RMr9dVgD0OaeqlSdKeZvsRAhFGMhspV5sUFELJ/G+fgDx7MvOfsXEHcwrZQdRG/vyqJj
         fsxWZ5nrGmDYCYqNiNiMlG4BzKlhRqS6bY0jogz3MVQbhGWFk9Xa3UsH/o6PsaPjgCXv
         O8RFjKv2/mzrQfx32KPqvgJg7ItoaRXA6D458fteLm0FdLnQoIvr6J/J6ZSMaWqibVCo
         4FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671802; x=1773276602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaoMI2pBU67ShvG4VUvnfXLXH0rKscBtOjFOK09MkxU=;
        b=V/UJalSqLGzldOcGA7gTXogAnELMf0b6ynfA2rjZFvhmgLZuDXP6xuFDAOMFzFtZ8A
         0qOWmTK9QjrDb4PLnyBSaeAjX5ex4ZqOPlb9f0i54V4J0qJ7XrpT+FHNkRMKe2JA8m2D
         yIRtoly2ke9cYG6ObDcg8uQ3p+9y5OTicJCI0UgZ7Tfs4Tf/HUSuC2Wx1BG+e346J5kj
         hWr7nXWVuPIY14AGh7h+wJL8/irzCMFrXCgfW7vQQhw0SUZf6Y+7bd9h52Slc+D+1Y0w
         1X/G2G33KdmFrFRpWedwvbfrCBQAZ+1SJjrAH+XYOemwCnq/qfXDsPyyuc4b2HwV9P4F
         8xlA==
X-Gm-Message-State: AOJu0YyUuQURmD5s1aEsxeDV/hbhbw55O2zdJuHXJJVpz66P2836CEdu
	ZFh1PGMd5Duq2xElSs65/kmHTRbnhjVY+TEPmf/bG7576vW5zmGEdH1Z14OOyw==
X-Gm-Gg: ATEYQzwh2Cy5pQ+YmPEJqkE/FpsMHTwbUvHnc3hVr6FVxM87hOT8GUPKwQdIcStxlCp
	Ees7nUOdImdFx/XTRqUb+DoxrApEQDPjM2NOSL07sndqJMb5+Etu6h8WMs5s2JPK+ZNSt+ZR17H
	VHM7n5XSkaZlukqohnGXHSypLsONQCwZziH8q6B/FNLvoTFpLyBgW44BI5AHlOebvAf/v3pZl7+
	J4sQCnxPLmPvMWG9NDPBsZ8dw3LGOR5H9Nj8PXuNJouRsRTk18ZVP9dfvwCaqZob0Qo1tb5sMi2
	lAGIwrv4P+vup5ZgvAE3GZfCycJgIC82IBi9e8ib1xxF1l5HYsP8VnfFRlSKxoika8AugwJeH9B
	WSpS28ofLxUNFvV6T9smwQ0gj6iJ+oZDSEZA4OQF7Xe1yEctX7z9CLNvP6c++wviSDbeTDMTQJT
	e3sEpStp5vtW6FgJO+zhx50t2XhHaTuYx5URn43VJyh5Fv+4pOmExPHImnfxerPkxEPM3Ms4VUt
	ozYjE1YDDpNX+D69XvR
X-Received: by 2002:a05:6214:29c3:b0:899:fea9:ccf7 with SMTP id 6a1803df08f44-89a19d05cbcmr57642526d6.57.1772671801756;
        Wed, 04 Mar 2026 16:50:01 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f8ad5b8asm102667586d6.0.2026.03.04.16.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:50:01 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	paul@paultarjan.com
Subject: Re: [PATCH v8 09/12] run-command: add close_fd_above_stderr option
Date: Wed,  4 Mar 2026 17:49:59 -0700
Message-ID: <20260305004959.83647-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqq8qc771zf.fsf@gitster.g>
References: <xmqq8qc771zf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Mar 4, 2026, Junio C Hamano wrote:
> I wonder if a generic callback function
> to call here in the child between fork and exec that the caller can
> supply would be a good thing to have.

Done in v9. Replaced the close_fd_above_stderr flag with a pre_exec_cb
function pointer on struct child_process. The fd-closing logic is now
a standalone close_fd_above_stderr() function that the two fsmonitor
callers pass as the callback.
