Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698623D1CAD
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070779; cv=pass; b=hgeJMbmX/GdAlBaCAXKKemXOTKXKjJkiGezv6jd1meCEzu61dlJ9+pL5/btGLWRHWBz/zlWUcU6317czXs9lPJ4wkxF5GJZ6hJIvqUCbUqj2QfnffWwertI389DIEE5IOO8HXAkmauYzKIZrf6PQNv6Sz9LLrQe9dbHbhwjAuzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070779; c=relaxed/simple;
	bh=U2TOpYXGmEt0uLpn4tvzjUIrI3aDCX2UqoUY9noPI/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3ZsCV6hGBzZiHbUzjOVmwosOghcxE7VsJ6gMj1EfjKM6swIYyFIKJqV+dYTqc54jU1/+2c2YD6DH6/sMrcYeuOBOxOODTxFESZeXErMIs/PwOyoZf1cpj1ukieNTNPD1QOOkM1UyHO8hOLHdW+8iVUehFJxwRfj3MhJF7c2Dbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp7+dNud; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp7+dNud"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7985ce90542so113167547b3.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 08:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773070777; cv=none;
        d=google.com; s=arc-20240605;
        b=aT/OorTTfg8YvNrANDeVXSpdY8g0S2iwSTF/pRHGFaBHu4x3sMVgQv7P0r8uJlf3pZ
         lszWibMKBEpG9Xb0jNkgPwQqSgztjkWpO+WcNq9uCYXxKPI27OsbACO6SKmBpx3owjI2
         WBbUuf721wdZ1X1Uudq2kZTksiOBVVjZTezZa0d94G22k81Ji1VseEPOm4Yd+qB1DBz1
         O1/e2n2FO0D53gpbD56ZhfevAD/XZcYfYrb5WN2+2+gGE0lsjxTGuYdswuVFyyQq6rVq
         jMc02g6aIopWLxr0x66TsKYst7U5dVWQhD0gKajBd3qOKtmg0CJNJ872UqEAVvsnFxFQ
         Cjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U2TOpYXGmEt0uLpn4tvzjUIrI3aDCX2UqoUY9noPI/Y=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=G47ZysfDBzuW2oxzsZB4nymJG41TWCt4e7lSjwKcBinhVAdNTVwkNI6lQ6xBTRbc6R
         dy1q18JWaZIkaUzKeOevvohQHVqC/GlYI6krN9XLAr31gasm/YzKFYEfw9evb5NBSnIp
         2Rqbd9vQTQgSqlN8iFjYqLb8N2ZL5TyRXc/dSAVdjKusdHLr3cjSAvuqXdcccfX4PybV
         YG+zMvQy7CW/wS3q4ES5lZi4bVxDchPlyrNdEe879dGCFYHZjthcwCJ8kO3XEc43E7Wo
         yiwzSLX9ooj2270CzhxHp6ieAK8/XIKRDbpQrX+AkHfQJXanFyX0z5Pu4rT6k8RXfjjj
         Ql2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070777; x=1773675577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U2TOpYXGmEt0uLpn4tvzjUIrI3aDCX2UqoUY9noPI/Y=;
        b=Bp7+dNudkbxewKmtzOArBEn5IKA7P1oo9TWHRfSnu8M15ko4UKUxjWxCcsxlQsNZ10
         RZc+N+Qngd+i1JC4VdexjQytAKpJ5Z1LUVxFWtdmOLbiZauTOt7yRZw/AJT5QvcM4p2L
         RJPSCtI7zRScqcnP1ezNlKQLpxAgrruwQeAiTb8OAgCB4Bpsh8mQpJegfjUhDK89lEvN
         92m2pJ4hAvj5+jzPKB1zNwVRoH8DQZRLVmD6dfEf3iN80TVgdD+WkCyJk8L4B3ND+/j7
         0+clkNdVYococQUG2+UCuVztr2U88hp2mZnYXc9OibDGtjXEuf7gyZyP95pYyO2hivtT
         LMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070777; x=1773675577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2TOpYXGmEt0uLpn4tvzjUIrI3aDCX2UqoUY9noPI/Y=;
        b=gIZoAWjh1thiUIfkoZIHHuGe0wmFsk02BB3QHXrpWy3iRVyNd5r4NDV1BXrHzEOlx9
         Sv7QaUCqBRqp0jGo1o0vOSiuqAddw0p5srDRXVgF5udCElQ38Tv5LMkvXwg+sLGeYECX
         2HrrruV/BYIGGxzk7QGiTmi11RY3+7tvqGe3PQk9SVzSh2JwLTdXqQee4ILnnCQkrSMf
         4yHbXHmaoL3aH58rvMktUnO2sZ9vSlasO0oiQjtvu/wr4UXCcnbIhVrdu5FwckG9xiui
         eeaRtEYq0MPDHzAXXDXgYldGp4PArC8XrNRbh9l+1wONoeWcvKRD4+Gvz0WduGUAJWnL
         8DcQ==
X-Gm-Message-State: AOJu0YxO+60OHxPo1Oj8ofUhiu0PsG4QqLa3i7d3WllhLfOIMFLMp7zS
	TIjDoEx+xETR+dmgfFxDX34WvaxnXvMYsIGWoKcID61Pd7+06skXvYbvgkZEWZS3L+vY7pQ/T13
	wRMPXrfS06mzsmPLEVwd1SZqya8OhLBw4c5+xN0KhUQ==
X-Gm-Gg: ATEYQzy4TMK+ehJ7StoaAWeikGnS9/VHecZrJ9lMyZ3oAcXH7IEydOV4gCc5XkRbkpi
	rpv1NrxGTHB4Y9gpA6WkD1r1YLkQ04Bfe93bMggakZCrFMFAdABK7hCEmw5hkkLz6dv2jt871KL
	YZSYTAFkaZ4ehJVQ0LBkLZ6UbYuIYDEE0aAQhxFtHoki5i1oQy2wdhi5Aq4SvdWHNLBqGxYnuEn
	qCgPrdcycHjJfW1Uk2je/5UsLjz6Jn0oB5z4TR2kwqGdbplQUfIeVscev6Bl8yBwIRH5H4bR4mN
	XjnxUujH6GD0/SGM8cqj0FbhrJ/jZZP9VP9jBFEneY6Bfm2DJJceJF4SAwhYPNnVvU2K0z8RWBG
	vfXMu09ysjFq4NM7Yk9MsbhU=
X-Received: by 2002:a05:690c:38a:b0:796:6e88:30da with SMTP id
 00721157ae682-798dd6d9336mr116839937b3.15.1773070777413; Mon, 09 Mar 2026
 08:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309150935.578465-1-pabloosabaterr@gmail.com> <xmqqo6kx58si.fsf@gitster.g>
In-Reply-To: <xmqqo6kx58si.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Mon, 9 Mar 2026 16:39:22 +0100
X-Gm-Features: AaiRm52qLZX00jOJRAnL2D7g9ZPS4QSOrb5UzYE1ksZtXItDvS5RZc-vblFxC1s
Message-ID: <CAN5EUNQzbr50JZ4DPpyWRLjx0Wgki1rFHm=OPEiD2LjeQ52ytg@mail.gmail.com>
Subject: Re: [GSoC PATCH] t9200: use helpers to replace test -f <path> and
 test -d <path>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> After studying Documentation/{SubmittingPatches,CodingGuidelines},
> use the list archive to find what instructions GSoC participant
> candidates have received regarding the proposed log messages in
> their microproject submissions.

Thanks for the feedback, I'll work on that right now, once done I'll send a v2.

Pablo
