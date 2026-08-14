Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C809334692
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735962; cv=pass; b=G88yl7lWW0EpdYEFgORFSoD7XuYBtJmmPKXxrDQxtzHG9UyJBGzoYvwXOUxOxqCMtNLEandmFzr6rXO1BPA7iZYuodkHiLnKfmg6Hs6b3yAuiOgKXPXsHZK1fOaQf0aSlL5+QX2RkKTnGbYnvUqXeZoAxrR5T2O1sJBx34MKw24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735962; c=relaxed/simple;
	bh=5i+BtJDA8ap3EqZjZGE0m2/MpvmvENFaGcRMhC68rN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd7e/XY7p48DcQfinLgzUrBoSn9ChFnmwyBYlkEEYBCQqJu9BCkUnka6OvHNty0oQC09Zwjkh7HrNBPRlNk1HpU+UDVwATL/IC9S9MdVO+zH1yJXxrusJP93Pgx9uQLbSIxxdbfgagN8azicQyaS8GEtEog0XeCa11bgkj7Ma/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHMAF3LT; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHMAF3LT"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84874b52eabso1720006b3a.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 12:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786735960; cv=none;
        d=google.com; s=arc-20260327;
        b=N+98OTYZvwNokoxXIu5PsDKX1WYgcUe7vJAHEOhYxtXuQ5kSrU1qta746rgoo+EeFu
         q102BS7VmQU3WlZbz/L/Pp/LjR6TEK7oKM3dOBVAe7GhtOumu/YoT5vgAJ1BBjgQ0LSB
         IwT6NYsr8oBscr+ueVGsAgExcjZB3kB0MOSPIjfwNogX48n1hL74MwDz0zCAo2ueYYkH
         uae0cMbIO9492bCbjrnboHK17cJUtgS0WDAesKA3AmQqNuuNGXPJYxnWtF0BUwe6C3w2
         B94eRG6S1ATMgaQ4Re2aj32GoH8dM1fp5fR7CFneJgw0BcBw71vpR3wpmP3kTjLiT+lG
         /ERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+x5e9r3zHCPLbCO749NiwwYvYy2znd6iD5GR3mNO9f0=;
        fh=+khkiON+1a3s8lQn/zZsTG+CLGZsznlUIlvWeo0UEDY=;
        b=HcipIgac54XSywIM5OkmvmWLxayHbyr/9Km+j+0sLscSfhCj6+gtsrTGqwuzs/2tES
         OSpH6yEQamt/Pt3ELnswCcbLYg0Rly6Mai7KScCn7Y9kw6Luq1Q6ExbgP2rfyjnYhr1U
         ENiDC2kVFEjueD2L2GKuyj1bIaF3DYizEMnIDWiMGgjCiwIk5dlUrsMa4UwMnMDKz0/g
         M+ccD+mRL5k2YVpfCZJNpi8m30TnfArbK3KP4jO8X6VWVob8RzqyxIArgo4AEBXSj39Z
         teQmNX7z8aEDEIloa6B59bSOORU0qF2pTPz0Jxc6HzmnV5m56SJD+noHLO0bmaO1hx8i
         adxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786735960; x=1787340760; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+x5e9r3zHCPLbCO749NiwwYvYy2znd6iD5GR3mNO9f0=;
        b=XHMAF3LT3CPvujQd1zsH72AQIyQUCUjfyKY4Avxt0KX4+KSrGSthRFThMuVAlwbszm
         N3N9JYPfSbn3YZJ/pGqpSdXM4mOnga4ZfEQygy9zLytUQ0G1+b5I/9DbUhaSPUBjZdF0
         vmgVwpL7QOqpt9cGFZ2X5XmrLuyJrxKrmTslLNPtEBHOE4jINC5i1ajQayh7ZbDlv8um
         NuP+sHoKAobglI0eSdy6yqVkB5oWnWAVspl7u5Rl/1s+/lngw06N/LA4yVw/zOVw0uRi
         gal05eVPVrgLSy7BgiSVH2luEDuvQqbiU6Kdgvwcmx8JrZSGY0XsDZJ5dPJ9gmvS3n2+
         mw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786735960; x=1787340760;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+x5e9r3zHCPLbCO749NiwwYvYy2znd6iD5GR3mNO9f0=;
        b=KYHGOhzqYaCeH2boZ6gdOkW2ouNZGaWKK7vD8AHN4fGWa6/FEniamm0Jj1zSd+dnsL
         s1nXaHitsOaoza0w7Ig2bditd/vkr0KcerFFuJm1h5XnlR6+qsiY0h46dqb6s4vkx+I6
         8hk/RHZS36rzCUB9AJ3DUtnpxVx4+8itHRT+n6vsxjydmvrbEf0emxUKgD6Cp7nrG76B
         JYLg2JJizjDJB8aRlTlDzJsVF6OaYkFBsXuOsyTFSzfFugehZu24stmo7fNv4riMUqpa
         2uE3qgtf29MqAMgVOmFrej/Xm+fdWtumnm+fs2bO+1Hx74EjeJ8Xs0XFohaNA6qZJrWN
         VvLw==
X-Forwarded-Encrypted: i=1; AHgh+RpQLm8X7FpPkRIkpXpmeT4bRjtl8a9FSmpbHWIxrISjuys7ZLCmKR9rpU1PJyT84+xOHnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOc4uCtvXNCq+YA2hbXGtJKLyI82VIXrgjzg92AgguYcQqeO7
	idI3hxzxjde1L919cmjjpfgjjbdVbBWCivO6W13M44vi0pxI1VTFZFHfgo/dv78WEfJ22Gp5cJu
	vZoN1dPzT87uyzbSyzo6fBfrkeNKdWiqmEHqY9GI=
X-Gm-Gg: AR+sD11oN+1Lg+TXQvddxyuQSXBH95LFYO/sb3Ng+f82quHEh8nip6iotPQaNxE6zuV
	GDUrPtwB5GjgJcI3IjgIS/dv4Iu3MX+saKRZyngbisYEy4jlllQ2Dsyyc++3WZcggwvgCQHdlX5
	wfpAO4TfnxPlslHjcMH8oe98lx3HdBK/qhfpOlkO6Z3W/XhHh8/kXDvWaW22aZAo4/lH1Zzs6Qs
	QnrrVxN8WC2ZrarrJ4PU7MbsktGWUlbHzsw5YqduxGtxhHkJImYAHXGtH5qD3bO1S7ARcFmXK0t
	z9edXxDtuXNvHGhiVn/OJ8BrsPONnoGCyDzZHWhpAf7kvJ+di5OhCLh73GyAioZtPR0vDevPtev
	U6EE/CK3gdPCAqmAzPDA0INEbZTVc5liLZ6JX70+G2EbnuJDsUJUD/oHwJaHhz9C1UOck47W6Ld
	gQjj8=
X-Received: by 2002:a05:6a00:4654:b0:848:4faa:480b with SMTP id
 d2e1a72fcca58-84fddfce887mr8104671b3a.12.1786735960355; Fri, 14 Aug 2026
 12:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
 <20260813200830.84348-1-r.siddharth.shrimali@gmail.com> <CAP8UFD1esJ0fk3xPXvAmQhMK_5wrpGKZJg9YaFV0-qUAC7bf5g@mail.gmail.com>
 <xmqqqzk0oc4z.fsf@gitster.g>
In-Reply-To: <xmqqqzk0oc4z.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sat, 15 Aug 2026 01:02:03 +0530
X-Gm-Features: AUfX_myumWoxVlMsa0NvSXB0-jaEJLbh8fvJE3fNVn-sY2yGtdogi08_Njg-R9U
Message-ID: <CAGWgyh9EVKBEm6bqG3bRsMCYvBCReJZbj+1xHK3qE4iw2Jp3dQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 0/6] repack: add --drop-filtered to reclaim space
 in partial clones
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	siddharthasthana31@gmail.com, ttaylorr@openai.com, ps@pks.im, 
	johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

Hi Junio,
On Fri, 14 Aug 2026 at 22:47, Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Thanks. This version looks good to me.
>
> Thanks, both.  Shall I mark the topic for 'next', then?

Thanks for all the reviews. Yes, it's ready from my side.

Thanks,
Siddharth Shrimali
