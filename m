Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC82E7366
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562578; cv=pass; b=U5awSF1Toq1h1k8uN9LXJF7QIFHTMVHMjM9HXqc3Ndatep0cWRqM4F7WDZnuY97Pxd+40BJq1cTFkDj2VB3VxC1kox8iRe++szXJcfyll096TKAceNqS5ZwHtNKTTGKaBDianadgHqmDbQ/KZxHVvnrxvrfjvJabXEQ/DiDLwTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562578; c=relaxed/simple;
	bh=EDUKoSZqqUruWR6iLE2H/s2fq8pW6ZLTdpZ/Xl8ELD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACYdIncUiPHyDM/KZWbTFm1Je5fBdbwhstgG5SjQSByoGFkBwJFkBjNOkB4ogidMTdLSNik93hOahYkIooxfFhMaCZC+sTysqsDXMqVhpAsL62EwyDbqpLxUafm0ZmPiE5IWaIKwcMG430CjHf1EvkpwdWywzD4sxKGBD6+YTYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSmwbHYI; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSmwbHYI"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1245186b3a.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 12:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786562576; cv=none;
        d=google.com; s=arc-20260327;
        b=UCWlItnC9tIz+nscJrQE/HotPpUroz9sskcrnv7fMMpVMSmrO6cOsZuWWglbGd54t+
         Z3gd4DCxnNOkMskRDgFheccZ9cln+r5ObZA63HdoK0aelfJ1R7lPicKz19lLZ2lHKB6G
         ihmx+tSbthq/bKCyVHQv+ycjXsyVU5pqond1zZDgBOM5UxYRVzaXgQyT62r458uk7CQ2
         YKY1J/n3TuGpZWnBW692FPKedPNdh0gxsyXsA62LDiHB2hZYUv99hgcpkacmwknMXHtJ
         yTeRTa60tIFZAy8N6T9Xmv3vUxlAdpLRY7GlG9nlPdTc3WHLA9lrNXRNS+aSzRZJ3X6J
         aTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZyS248P5GNSCcz2Ttcr6BfzU2KMvImFKqqxU385O2qc=;
        fh=hCy3g3jcmsZMic69i8Qg4M0wM1zy59M/KJhXdYGQZP8=;
        b=ApRq2bNE+OpUs86yhAnqTZ19jasrP0LiiFrIWF+hxAJT9gp92/UaIzeIWxfFwY2qDC
         1/JkgAqEMaOEZSu1vUbPt55+uEnjeuEQd8jQhQV0w/Da9VhGkZ3oF94nywJ+KjucKcHC
         yESlQJbZ6Zx23Re9rRd6y3FYybl5n7EE8XBGc2aman3tGJjLZuVgivu5LHuVLOZ5V2YP
         6yjtf3C1otnxjwI+MUzUhBXFyLavjeKkSg8GtsEC8rZ5HfH9/U5m8HGBqh69zYN9s0Cr
         16blOLkFjctFM6gWpa+Zl3a5FNUU8mn+kMODWE174s9nqaZycze1LXj6Qcm80Mb4fXa5
         28vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786562576; x=1787167376; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZyS248P5GNSCcz2Ttcr6BfzU2KMvImFKqqxU385O2qc=;
        b=JSmwbHYIuHdhRW9R8fsuDS4zR6PjWUu1IJxhcwQe8GsuEtaogNPK94GwAHCx4wm/Xy
         Y/m0ErOsBAbXcL2E4p3bsOqph38u2AHaHT3GUhI8hn/tQK6Imj7jWy2sf0jjGv7CMJn7
         shADNeK3uJgywfLiURHjuMdvXNnd8/ygQP+DziWbLkO/Tui9TxyzpZyH4uqBxqWSNR+C
         ubs7hBZ++wsfu5OtgxNLegZ3sXUwyrkw/zQLiqrk3MYAwGBoig470MalKDrqUG24l179
         r265CisS3d9eijJBVsrqEv1nHRkx3klvK4so3mtit34MFulPZn8H5n0JERUJ4mcCGHeC
         KTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786562576; x=1787167376;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZyS248P5GNSCcz2Ttcr6BfzU2KMvImFKqqxU385O2qc=;
        b=MPAm4bBcEmh5yGMXyk89tW2/Qcm2tMNVjQSx3bSg+Om4Qp0XdDrbWcIX1/V+pQdt5D
         5Nb3vFE1h0KrFpl06CIe6citj+EmqM9YfbHkpwmS83t5CkkHy+V0VnAM3ncR8fffQpNY
         pTmo/NGmGZcPKXH1PQgU3CE8cXj5VXDZvzBQZU0JqMaPY/OPNZFX/bnL/xqgznXzG5FK
         CaKsyM6n9+/md1qVW344VObXNK+70aJPDW6AOUsN4TtFXctmhHljEVeZffjWroIbYZuX
         FiYt+YY+jjQFfqMOH+SPtHo0p2KL7i3U4S6/O0qzI6B2X6gFkDBxvLfFgSqaiM9BAb8x
         BL9Q==
X-Gm-Message-State: AOJu0Ywx9GS29AWRYOXFGm+JamYahi8uz/5/YejWNlv+/sLRlMXfshmU
	B5y/sjIMyEEV5ciXXxlJ7GIk8trLHgXoQBdF0tlc6RQbY4SUN0unptutvUVIc4leVUhOEiyyH5W
	VXxkq0NghFCghdW2IunA10Yzz7xRVC3A=
X-Gm-Gg: AR+sD1374FO5RwiHG8u+7RXh+74MS1CnvNs3I4Far9qmRUURg87Rh7fktYCoZBoCQ6n
	lNpSvoOrl5U3q/dGTWWVHKcpPpmi8gNm6Ad1pzB09YiapYRmrqHKmR3cOMiHxvTNoilJ7INkaJX
	KH+J/6lFInrpR6tD+Hbo4AzQeCzylEx5EGJVseHZPlnclCFAIawz99JoqGSHuoCWn9nBz7cvJTM
	ABgmYpZcIAkzKTV7GiGDhG0hfskscPydjcPusz/Vu+9jYLF1FRvjbnNVe2CzI5MHpYwA5JZoSxQ
	U8FQ1aQsWPJfbEGqKDBP9g66uELIkZBbbZmuNZIYGrx0yMI7l8+wyKW++ltEZtmQTvRo+fTI2fs
	LX9PpmLfh57jA2XweCGjmmpIQVsqOhteWpHCU84YjyICaxd4MPb6Ol2fcQY+bwMDCeoAOJ2d9MV
	I=
X-Received: by 2002:a05:6a00:4212:b0:848:417a:d1a6 with SMTP id
 d2e1a72fcca58-84fc75397abmr177781b3a.15.1786562576101; Wed, 12 Aug 2026
 12:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com> <20260810174047.6524-3-r.siddharth.shrimali@gmail.com>
 <xmqq1pc3xlju.fsf@gitster.g>
In-Reply-To: <xmqq1pc3xlju.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Thu, 13 Aug 2026 00:52:19 +0530
X-Gm-Features: AUfX_my2S6rrtN7fHBrejlwOaNjnY6gK7gnGYwSrxd2WHkdGAn82fuQAdbV5xNI
Message-ID: <CAGWgyh9bJ=BSq1B8LSEaQth_4fQHB_YHDgHmf5m5MYcENAkxrw@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 2/7] list-objects-filter: add list_objects_filter__filter_oidset()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, ttaylorr@openai.com, ps@pks.im, 
	johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Aug 2026 at 23:34, Junio C Hamano <gitster@pobox.com> wrote:
> Here "struct object_info" is defined as
>
>         struct object_info {
>                 /* The object type. */
>                 enum object_type *typep;
>
>                 /* The inflated object size in bytes. */
>                 size_t *sizep;
>                 ...
>
> but local "size" whose address is assigned to is of type "unsigned
> long".

Oh right, thanks for catching it!
I used "unsigned long" because that is the type the
older object-size interfaces use(odb_read_object()), so I copied that
pattern without noticing that object_info.sizep is "size_t *".

I will change the local to "size_t" in v5 so it matches sizep.

Thanks,
Siddharth Shrimali
