Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3694B259B
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585610; cv=none; b=ACxaj4Gb2/cZMZS+Jmiby+tZgSpNdfcO8ZL2ig8oZ3hEhnO6d2YfZimpKqBTzQh8s7za4vJtWU9FyxgGNO3aqKBUVWZzpfc99+rcRVzVxCRSItpemvV6rKAKYF5rtFb8OwOc+6RFVq2vPN/v12fEVZJGfUcyUDe8H4cZ01l92EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585610; c=relaxed/simple;
	bh=f2l9E65ixeUFK0EUtgdCXGDmFUuqrdI8tdgvN+nf/UQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=F+a7K4VGTOI8kgBbmxUC+sXDRc3VnW7dwCQLSHc3Kn9G3f//JBdMHq0JKkWk3Ico7pHuOpY+pGb2GNokm6USMZX1YIEfnIZ2enaaZh7Fvgl6/GaSnUDYo9sJdU7RfGadvJn2iUnmtDl1WX93PvYKcC/Ei3qQKWLW+IXYVm1d3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/fIyUab; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/fIyUab"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68cd04b9ecbso5579026d6.1
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 09:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707585608; x=1708190408; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=+pm5z8D/H++kz86Kbl225jV+1t9wRlGqqLHvRiJSuX8=;
        b=D/fIyUabzKGTiPZBe9WYdZ0XMxzVJbF4MZrdPsAn+wZq8WY/qwEYOrI9qnWZWTGho6
         6mM1KadJzMv77egO01TCb82kGfaB/oX88SNTQjzX3hQSfBvvU0AN9bm02KgURfVeYtjZ
         iUWHDEtC2Gh9MtX3yVkSN01+tgjQF/kXYXJiwJ7LFzPcrt/5TCo2viPvSkJogZmgoTZd
         TU3LemxXig63qxq6K8j80/bjl8FD6gfnfhEmX/VTmtytZXZVHTc/PD8EIPqT1wheyoEa
         jUVYoegub2I0icA8cpXT3poJofAvt1436ha7xTNd8i4VzhZfWhy464V2Tc7/IzXaS7JR
         WWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585608; x=1708190408;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pm5z8D/H++kz86Kbl225jV+1t9wRlGqqLHvRiJSuX8=;
        b=pG7gDfa/Ig9wo9Vv8yd7+7ZiTYcLersK8KPSu2IXKCyXdKcnZit2qn2wqt9Lcs/Ivj
         ribQ7Dyny7xqTopvElApN/LTx+h+cf0emKiH/96riUa1RYB0EmVDUl6wLDYj7Wwh/ONq
         f3gWG9yKyJBNTsLJw+m5dxinkYjl3LNp2kaA/0CjQQXCBva8KmCe4mJjiUOpowNJGz9N
         q//lswqXAQeNbbKz/3otFU6hSGXplMF87VJXFEOyKJ+RyI6NY1mk7RCnhjkldf38fQcA
         AOx2kb42Lz1NAcIlGRLd8+eZXiFr/IuroRnSfwAxEcg1b1Z3VH36OsIcO/jr6ZlIwSw9
         FWzg==
X-Gm-Message-State: AOJu0YydPhGlvktmQeVTLaO6GTqfoSgFvFIAbgo+TuzCQ7x/OTWiQtfH
	4TlS0eCx84wSV5pz2InEP147kfqRQ9CSbb3B/Oz2/yoXTLRBX//w
X-Google-Smtp-Source: AGHT+IHAgpmdaAONLecXuSQynfLku/9RYT/ahsTHo+e2pCxkQeLaIALVQ7R9KRus3QWxlYF1HxWU0g==
X-Received: by 2002:a05:6214:5087:b0:68c:d45f:6afa with SMTP id kk7-20020a056214508700b0068cd45f6afamr3094437qvb.5.1707585607985;
        Sat, 10 Feb 2024 09:20:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXt0uWR9QQB6yqBwWM690kOiSXLqTLGzUKYbVSQ0BuljRSVHzJqRuUdxbgyE4ohlEAzqRR4drx1lK/YZKQxy26ECA==
Received: from epic96565.epic.com (pat-verona-l.epic.com. [199.204.56.217])
        by smtp.gmail.com with ESMTPSA id f12-20020ad4558c000000b0068cb1855d84sm1931050qvx.130.2024.02.10.09.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:20:07 -0800 (PST)
References: <m0y1e7kkft.fsf@epic96565.epic.com> <xmqqcyvgz3ih.fsf@gitster.g>
 <m0sf43abw7.fsf@epic96565.epic.com> <xmqqa5qbmnrm.fsf@gitster.g>
 <35f24a01d15ce28932bb6be098d6a164a49cc542008f75673cd6221a9b24b578@mu.id>
 <m0frzeu89w.fsf@epic96565.epic.com> <m05y0au2od.fsf@epic96565.epic.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: Sean Allred <allred.sean@gmail.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: What's the recommendation for forgetting all rerere's records?
Date: Sat, 10 Feb 2024 11:18:45 -0600
In-reply-to: <m05y0au2od.fsf@epic96565.epic.com>
Message-ID: <m01q9k9qyh.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Sean Allred <allred.sean@gmail.com> writes:

> I've driven myself a little nuts trying to reproduce it this morning,
> but in doing so I've come to an important discovery: this bug presents
> if `core.autocrlf=true` but does *not* present if `core.autocrlf=input`.
>
> For completeness and future reference, the following script reproduces
> the issue on Windows:
>
>     [clip]
>
> At the end of this script, the 'bad merge' is still the recorded
> resolution and no rerere record exists for the 'good merge'.
>
> Just in case there's another piece of config somehow relevant, here's a
> dump of the system that reproduced this:
>
>     [clip]
>
> It's worth noting at this point that while I believe I reproduced on
> macOS last week, that doesn't jive with the available evidence (and I
> can't reproduce it on macOS this morning, though I suspect that has more
> to do with native use of LF over CRLF than anything else).

Is there a good way to convert this to a proper bug report without
losing the context?

--
Sean Allred
