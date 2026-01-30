Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D636D4F9
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774776; cv=pass; b=rQsHmIxI8SvFoS0qoMDOUDCPrAuDuwqqlLZXvnqSKyVDvIdgnnzOIhWriRljOoOLR8wGCmrED3s3KMjdPBWTRFwqR9mUU/SkAoz4qXleTYgSni5Jl2rFHXpqj5rUWYRs9i5C2BMvZbLk4XU0utU4qWEaDBXBky5U9xhE3MF13Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774776; c=relaxed/simple;
	bh=9+pp2l9X4q4iWYcmw2GbTA49bbFUjppkQ5n4BYcFbMY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=XecfRwWP+/qpaCSwnTe630HT1Hw9vWwGQpDraWPJCQXl5BZGb6NhMRF6DTIUMhUvpAt21bPzjzKziYPAsZxBZvCfnNxAdmHg/FJp1kxmFXwVhFiR+CK2phfylPcPdSTr37JXUyNkWiHnupaOpBklyds0DYnHopRLVfLgaxRJwmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvhBEHnr; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvhBEHnr"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-566360cab02so1346056e0c.2
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 04:06:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769774773; cv=none;
        d=google.com; s=arc-20240605;
        b=aZlDLMJs2R/Sk5n0s89q2Y2/CuTvEIbo7ncI+n1gECw5SPd/9pNk8d6f/YHE5nlYl1
         9u/WQiKX51uFZ7hOAA0DmFfmJflwrihXuA7W0dxc/tT3FNnrYtE7FqpdCmLeMLxBNGjn
         RT//ivez6Pkcytv4O5d8esAAejhi6nSZXHvTw+La33beRoijtlOx1llTUPeOpNIQOq4r
         UADNNFUGDcfclinMzFs5/KmS3AA1ZuQub6gQE2d73+99kk+BLKCbsHr3i9lu6E96J7TM
         Cdv75yFIh4q93UQRUkvFzAC97514Lio5xuPXjDUanTTKBKSr4P1ESfoifuYMMvIMPhL9
         2r/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=EqPEeYiPm/jzOhiPngOIMxG0lv1HSKxJmwIX5jXUOL4=;
        fh=w461ibhm30OQjqZ89Vv/cv3XJGC7s7OzPk7D+fzyOVE=;
        b=S+uJsnguQlYOjKrf9lWPFPji65DQkQguHBcnT+tpDUi3lDSCLVqrNztQ+Ws0x0Ua2X
         yZk6gljYEuT2DAHDNcowSRMtpC2XvlBis/Y9ULgYa1kdS5IfrrOx0P/0Ex1wdir4SV/R
         APXbYnzO3O52FYFNEhth5e8/Z4ppMZlIR7q5GeBRWfFsSOtKokwIz+mouHZjRso63zz8
         gkvNWeSLLHdz3YEoZ36VNyl+Udv3tQcfzLagHbnnPYGVjFWR+f7bItGSxjKJDw3Urn/B
         H0DRh17OAj7B2y/FpMiirLMqE5YyN9HaDwGk2x5disjCM16lICfkDIOJF7VjZ0h6tIXy
         MVww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769774773; x=1770379573; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqPEeYiPm/jzOhiPngOIMxG0lv1HSKxJmwIX5jXUOL4=;
        b=bvhBEHnrSNeEsPFoJXObIktNP16qyxONGTIlgxAj9kbgbXDFNGRjPhl2k0QZauOjcf
         tiIXM6vcpueZTbIWLvtAnQQD9g/tvePmKNTALUMD5waV1wfqwkqNtVXvKT5HUwSbl/Pw
         M+vK3AhgqZi4tnKBtQutS1rIjMFwXoYrXeB97PI3uGW/DaZDFikzz+87+sCcdgbDDGAt
         8zHf59dFmbGz++6t03svsza8PRlv3B9uaFTs10o3PBXLOrVIczPxjV/VKh1nZI7u7z65
         4lvoh+RTvupTN/TN/S0tfHMz0xZGEmcizWgYCMBPVs05WeoMbVzuxD01Qc6QRNoK6By+
         Mh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769774773; x=1770379573;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqPEeYiPm/jzOhiPngOIMxG0lv1HSKxJmwIX5jXUOL4=;
        b=HvFvHcnLF6W11K6JpDv5C8YC3aHTEiWT9PuBs/3j/zt54QhPbtvyfHzGO46DVJBcGV
         7QW6X87TVEx+dw/IFgqqwE6Qjf8ZnQMPBeaJfba0x4Wx+GpMtwsNp0u1VjnpZq9UnPg+
         gtRMzqWawuf/B1IjB69kZn7T+LWU3SHvtBrDIJxZMWe2d4b2cVWrhBbqY7uObR4vnAG/
         toV7ZGk23cg+72dZzq0jrTx8DdfkBd2h1/04wao+aD3s+s9sNc/AaITpeaXXQyfXnVKN
         6Tmmv3ttdygoKfaqEb0HsGM/oLxhpiG0vkaDoJNmvRpB+Q6hvnRNrrIRVaN9C+9BWV9N
         7/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWedR4S23qBMRP8gfHZGVktAVsWOtC8cQ2BGfSZ2JQYstEfmK4DIkDw//rWvDuwPkpJqx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg5gtRwx4CXJURLHNCixzzcfIan7L9592vxHNiqLL2MYg0c4/g
	0G539uruyGLR1wnddghWBw3XUZsKQtwtZjk7yLShkp40XccRqVNvpmTzxqovHB2vZKdHhrTGZXY
	x1KvueEyZItpF6LMLar7jnvD5C8bzljg=
X-Gm-Gg: AZuq6aIQxThVomqDPv1Z2WVJMgXrd7/YjFvvBafXOgFXV/rHRqHyKa8FzH9FGqW0/CJ
	GDCHEPZ9u7FjCcvkfXAVatnbXX5++tN+8OkT9K6SnWX+0zJpJw2ZF26ykvOvNKSqVykzhgDRVsC
	fP421KK3lWVrdkNpkuD9fnx3xPI1pr8QztA8JrYcNvGN4XgChVAkonXZjcesGakXo0AJ86zoBw9
	6uRhC+0lFnc0swIsYO5ivw39UVLM+PvuKBKFuPsHVPD/DU96Z4ZQGbjE/VE1ptpwiLWAV8S6DCg
	GwrVGrhyOST89lqkzLQkZJZxRxgy6Q==
X-Received: by 2002:a05:6122:469a:b0:566:3d03:8e1d with SMTP id
 71dfb90a1353d-566a01176a8mr873147e0c.17.1769774773267; Fri, 30 Jan 2026
 04:06:13 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Jan 2026 07:06:11 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Jan 2026 07:06:11 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwm107za7.fsf@gitster.g>
References: <xmqqwm107za7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Jan 2026 07:06:11 -0500
X-Gm-Features: AZwV_QiaNGocF5jmJZVKREbAIYgO_S5ZeqQNzHwAJrKjolR5HTwdAJyjgd6tQAo
Message-ID: <CAOLa=ZS8zbWoetOrfj9wXTQ78Ns663S6vCADabzTV26uEQsKLQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2026, #10)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b18950064999cc15"

--000000000000b18950064999cc15
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:


> * kn/ref-batch-output-error-reporting-fix (2026-01-25) 6 commits
>  - fetch: delay user information post committing of transaction
>  - receive-pack: utilize rejected ref error details
>  - fetch: utilize rejected ref error details
>  - update-ref: utilize rejected error details if available
>  - refs: add rejection detail to the callback function
>  - refs: skip to next ref when current ref is rejected
>
>  A handful of code paths that started using batched ref update API
>  (after Git 2.51 or so) lost detailed error output, which have been
>  corrected.
>
>  Will merge to 'next'?
>  source: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
>

I think we should be okay to merge this down. I've addressed all
reviews!

Thanks

--000000000000b18950064999cc15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f66749fe55ebc393_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sOG5yRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1pNQy8wWnFyS0xIN3B4VTFtdkpLWjFLb1ZzSzdJSQp3Y2JMODlqQU4y
M1Zia1M4TGdyVUhKT0tGWXA5TmdYeHJ4VHZwZ1VVamRWNnRCbmNJenM4cFUxTExuNnFReWtmCmhz
MklEOWhQQUZ3Y0RwQkx4WkdseFZYZ3FEelM3bzFyWHdiUm1qalA3VVpHQTFBNlgxRkxoN0p1VDdm
eU03bk0KZFovM3FyUGk1eFUyUVp6eldncGwvSDJaQ2JBY2kxem9yaXYzZXVkcmVCcmpCYVBHUkpT
V212OG50ZmVFbk5Ybwo5NG9WZkdJdllOV200TWY3Yyt0M29UVCtPTjdsWGNEUFNCbDNEbXBBSmlF
TnQwSFFkTHRYVVhCSHI1QXRud256CkZacGlBMzd4WkpUY0RwWXJtOWpwTy9tSU4zZDJJSWIyOGFq
SGt4MHVCRkVSc1BWd0xkNG5wRWs3OWJSQkxNdmcKZXdGbFgydVhHZTZ6NS9hSVVTRzJUNnhhV2pK
R3V1elU4VEwwc0ZYWTQxT0VreHpqdHptVkFyTk00TWI3NlRLZApEanIwVTRwSndWSTRSZ2NJNENJ
N3ZzTjZCSWYzdW1wWXRYaGlXWDY0czFVdVpTQW9uVVVBQk8zNFVBNE9uY3k5ClpYL2xzdjIrVkkz
VXpVM0NablJWZEZmdmFOU1B0QW9jYTRtOVp0bz0KPXIxVGIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b18950064999cc15--
