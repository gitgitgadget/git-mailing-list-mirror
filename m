Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D9272816
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179813; cv=pass; b=RSp8xCSxywfGAw4w6e/xAlbG8mbialZknz6qMy/lCgpRsCpTlMkfRN9JiMPiHxZUK5uzQ8CGiePWD2NmSqGUZkjpWfUiIYgM5tN5lrlEjcj1LhAr1vSbq/v3EI8hslx2KK9aH48KNhEV5+xb06zXousHTPlY/tdDva3jCUmXBlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179813; c=relaxed/simple;
	bh=U+6gdkGxjUygfAzOdOvgqkPk/zBpE6J+7/EowLam+AI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBNoMbRIPiqlChxvYSIUdsIuEYP47H+Vxz6o7tM/U+fFeqx7Wm5ulQvZ1zZX2paniSIUQqNHrFpqWsIGdJ+u+cYqPvmVswzMWaTxhUVT6EvjLjjfRvl0uiyiQrtlSa/m/4x6OD7R1r0qeqI4G4WfTxFRPAakkEyTI0cxDbO1ZtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyyExjD6; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyyExjD6"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5f54d6b4047so1296564137.0
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 06:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769179811; cv=none;
        d=google.com; s=arc-20240605;
        b=GCVsYPOMLdoqQbsPsXlrOj0h07rok/tD6yrlkK6xSBH5WdxnXP7pUOml9aVIcoYdUv
         uwKloWOIs9B/G5mnUI5oE1ByiLo9UmI69xEPIP3cnSGGItby9eftd8mhXjbJ6FRw90YU
         wkSoFeKiam1TOP8q/brBG7xUgBPfa0x1/iKFH/GRtboW2+hPaKCscf8cR4paXlhuHTe8
         VMEI1lG7zN8qwapV7YiZ7MUMIRqEnAvXl5Jjh6sAASNfticZiTbD4gwEd4tHswEX7PJk
         aExawnd41XIGpDHMBdWm/P2n0f7SAdZe89FVPAMysPuTu5Uu1e7gjQRjYOq1tmE7cQFt
         7CXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=U+6gdkGxjUygfAzOdOvgqkPk/zBpE6J+7/EowLam+AI=;
        fh=L5xxsVRwqWcigYxjFQPIr8KvWYr/0/xfuoDBCL75eSc=;
        b=dOhtQwBNZ4646eagtamR9ZK3HLhoKM/zOFJhr4rvr5i3c2igfK+MFTCV/LuGTU+4oT
         cOt+AYFaB0YSgJTKuUTH8Ut9CMF9YEQfM7adDVfsCPJ4aHe9hVen5xvSFneAaOwia5NW
         yi9QJ8Kf3b2ZxKI7UjzmnXC+9DVTP4wNCMmWiC6z+tzTKGJ9d732hP9FCRMee8WR3SsX
         Vs8dklo6Jc5APTkBaiiVtIlu2XvU1IwYvzIa2ADTle5J4Esju1MVbmxNVmwEFkHfqmAO
         wv8ofMfUhH2KeCOSmaGKpb+mVabOzIo2pWAo8wBTLVp1o8FPq553R4EUCaha9NDEzAwe
         YJvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769179811; x=1769784611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+6gdkGxjUygfAzOdOvgqkPk/zBpE6J+7/EowLam+AI=;
        b=NyyExjD6BDf6OMjhETXqfRmohC079BxjJnsndTyOWvQZKZzSd0e4tKaPXDzl07jTql
         0KdlxP2s3YmGHRh2cPQOhX2jw+GabdAiobVHOhhJryH4YaN7CwoCI5gQD7l6XOrmRInV
         bZOvZFZ5m0aHnNCqqeOC/MUMmWdIvSPIEyR7Mk1/Jk5dq/TbXNhWTdNE3mtbwIMYdcRk
         Jtu3X9MaqzEbtD+PPdOWM38umFwmVakt+KxEyCAI4JKRoRnE4Hog49pITxqT+IyFAu2i
         s/sSgWvvyQuCDw9bKeDiSzi2ZIBhni7QQSFao69Fii7cy10Ph7EX11pDb9fw8zcW+Wf+
         E4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769179811; x=1769784611;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+6gdkGxjUygfAzOdOvgqkPk/zBpE6J+7/EowLam+AI=;
        b=dMHyQf/HnVT2gBulZdaJsXplmcNckqukxGqmnp1vhU1IP5Of4AR3O4sxGM9tKNBkGA
         lJ0hPa5bpStH6EtDrgdz9qTSXyh+y+WD5nwRY8EkpOwM6YiyPKFUivGYWq+0jLECDMaR
         u7b7avQwG0GqvobEJQeBGgtTsqzMzzsjJqFBGeNzsmjqfma1Hi8v1pJcFFTmDOYImk37
         xqQsdT9DQ8+vRyRpsnlZ0HqrjiC+OaeUt9RvXUXIokrBgoaG8fAW9MPZINuQrakkotKW
         BPShJxTXcaa4bcKELdfk0MqjqORl1ZPhzy7QgV9mfBf91PZfmJE4HpHAnz5I1FXQ6y/s
         NA+A==
X-Forwarded-Encrypted: i=1; AJvYcCWqVhZZTgABaIhyT4grJOzGds/2dKIWkWVcE8AWBqBZ8NjTJukSjdlWY7Zs5WxjQgsk7Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoxgzn21drk+EUkCOkcYQkeucPBXeH3SQEQO8NRbMt8kHgnhPi
	HvcqnMtkojwtR9rnwR5HH5TYcP60cH7f81u3PEe4cvUrwGbQ6yK4mkBKXIWQyfx1bYuGFerp1wV
	MGXx4AAOYz4hfv71TAiTuv8i2uAVdWzgppA==
X-Gm-Gg: AZuq6aJ32XT4oUGz/iM1o2tRcDh9tjnsZ3tcNrUa2GSspzqTg8uxKnNukMs2OhwFbCG
	gtuABtU7flH8sFAjAWq/ggcZKWYk7vCMv5dNaPwiEXwJu3daOqjtXZcu/m4Y+t+WebhAowmnUGE
	LCxwoa2Zyj95oGo90+dkxoW4KsBOJ1SnZW6qWDcVvxvfaNuw/9c5e2QKPEfNxeLyuBedY8FiY6x
	YsCgzLt2ZPMztkRqNxwmIWEo9+dmBdsvyMnIWHvfQja9eYloAuQmFH8xsMutn/U2yPhXxTvhjcx
	XG4hYZjg4EKi8dYEnMWTenXbUyvrmh87/GVl2un/
X-Received: by 2002:a05:6102:e14:b0:5f5:402b:7ee1 with SMTP id
 ada2fe7eead31-5f54bc6d903mr1074290137.23.1769179811281; Fri, 23 Jan 2026
 06:50:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 06:50:10 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 06:50:10 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <453a0846-65b2-488c-a5db-83b854d17640@gmail.com>
References: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
 <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-6-2ddba0832440@gmail.com>
 <453a0846-65b2-488c-a5db-83b854d17640@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Jan 2026 06:50:10 -0800
X-Gm-Features: AZwV_QgrGq78hR9Qmg_esLQG7Y9e5maxwR1VhLuDfokac3KuGKXa7KXzLFiPtog
Message-ID: <CAOLa=ZSGMUHyG5hYPw=RzvK=Hx7nsgCT-_9mFQ0hB-4fnU-+eA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] fetch: delay user information post committing of transaction
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000321fc606490f4643"

--000000000000321fc606490f4643
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> I haven't looked in detail at the conversion of the callers from
> display_ref_update() to ref_update_display_info_append() but the array
> handling looks good.
>
> Thanks
>
> Phillip
>

Thanks Phillip for both the review and the help!

--000000000000321fc606490f4643
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cbaf2d6bcf0c10f3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1semlxQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meFBnREFDWnNZNlhzSm5MZk82ZnFGcEJocm1IVEM1ZgozYmRMR1dHMnNu
N1hwV3V4VHVidHVJTEJCenJ3aHRQemJvNW1pVmlNdC9zaGRyUTloVXkzR01DcUdCMytQQUNXCjQ5
N2RUYkZwRy9Nd09rL2dOTFA5TmVxa2wwL3RIUWprTXU1eDBxYWlYQmdHeW1Ebnhka0tCbE0yTUM1
ZUhsNEEKRDJiNEtpL2JzVXNLUHI3eGRENllsd2pleEczeWpYelZBeVBhZ1ZFRm94UzJZMVFGTW9G
NTh0SmRxZVR2dmRNNApQWHRqdndNSmVWK29iVGxFZjBDM1JHOG9TdHVvRkw2NnpPcDArOENVczdK
ay9jSnJZby9Ta1ZjeklXWUIyd29nCnBZTkJDbXBQYVJOUnorV1VTaFZkSUE0bjduMGlPUGdmcjF5
U2M0ZVlnZk1mSm84dG9zTUlxWTJGWXBEbVNQcDUKNFlOYkVCVzlIUytnbVMweHdCbWFTSVdhaHF5
YWt0akt0RHl5Y0R3YnRLRWpIV29mYmFtZzZuY3hlY2tKTFdXeApLNWtlSlNyUjNuVkp4SWk4dXVa
NllBRWE1eWZrT2RJMWdOWVdTbkVlY21XWUtMTXFWNTB1cFl2RWV5dXNLQlNvCjA4WS9RVFIrQzA2
cHpBSytVU2MzaGllU2lTVTZweEZaMjBBODhuST0KPVhtQlgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000321fc606490f4643--
