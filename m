Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C422A7E9
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770851189; cv=pass; b=od5PE9nUPY4WvdvqvOBK/PDXMD+748m1I03FxOyCKl9YkleQdDjHUkHE+aZmWSvkrilcobR1mSxsi1+WdXvtlCsu1N5k5lTFzlGRNc2/K452zf0d7f6Uwdu7uv4xZNlpDDl5/HyQeOAy/6kAb6bxKYLgr+oU/Pd4bpZ9dhQkRJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770851189; c=relaxed/simple;
	bh=DvDY7pRdUkaVWLdaDOXCXs5aIIpY5EQ7GNna1keSa+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxjf0OCBBmqUOlCX7jd9KHz6NMZZHewIh1ZyL/+fOXKe0UrKu8sz4umZ6ToDY10tdcD2k4khT4oPVRLlvBtrH+ARr3jVXQjGD3m2WzJxUPV7y865mYziuJOlhr26WysHijgMsYjK1gMkv9yQexxErt0kKHJ0RR1o9nggLPaUyEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=pNwxzPC2; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="pNwxzPC2"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2baa098ffc6so934803eec.0
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 15:06:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770851187; cv=none;
        d=google.com; s=arc-20240605;
        b=HxeDgQN23ArUdIWJR6hn5FiregXs1nFeo6C8wsJQufSUTi+rskKzcV4MotnRT4NdE8
         ONE4xkx/KtmnlTTPOuE3E+lYe4+EzfBZm5tdABmZlsjia4qxySxgxeXjls5ORx/a/HB7
         Ecot+HOmUkscqgt2OtGkl6PFFfOIgSbPkJFlo09+qlYw7khuD/Me+wHigTKfltd/IXGX
         e82OxeU1nCs686he9jwIGskB1dn5sA8t9LlbwbLpdsCgzTCGWwf84fEmlsRSjCVvupEW
         A/GZVhXo3/JlBOCH/SNd39CC60tLajBLI81x3/s68Lh9cUGiMxOaMF7aqiAcXZ3LbEIJ
         hxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RJtImQhwBr07LYXR8PNVKqS7xJhuiuPelxCZ0deVl5g=;
        fh=wHxuNka5B75qdhhuwLF+ll2zFToELQAzo4OHqo5Jhuo=;
        b=WdL4NlW8intrrkFMHHCpgG7NGzV+XlezAq0W8mMEyrTAi7j7TUykOmk2gDiDMBuLo/
         ml0Jf64uZmXcM9OWvKT+l5YDLikTQGbwN7Vbeh+fCcex8n2rmkz09A6bxbP3y4COtAku
         RfSSXMWoiZBwc0nlWZvww1i0wpGSrK4z4atFDl8vYDTlHbSqbRde4R5ZgLByTyTKvazE
         MqZWHNZspCIlmOSkpJ49HwMMY6JYDfVejdpa2t1QMixjy7rRDDyHIzKv7ruqGChIE2r8
         INwIwRoHZQZacH34QgmhSCBChjjAJw5eppYDluNr9pFC37cUMdsf4uN95XQXT+uCpDon
         qBXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1770851187; x=1771455987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJtImQhwBr07LYXR8PNVKqS7xJhuiuPelxCZ0deVl5g=;
        b=pNwxzPC2ikaIwl0hbi8BpyBzFAO9Jjyz1qFyCIy0ZKlCglc4K7BW9CzQ5RIiWQU70W
         uuOeVFZ72YNbP3pCJiPMcqxVUwG3MWe6D4ErnXpkHfN6aFWi6rGzVRB42tbNi2jmWnO2
         bXCyQfj8Ael637DioEn9PRJLm87cVA6UY+fVpKfrd70Q59OXh/nMqjWcGBBid/P0E9D4
         pyV4SMMqLD5RSPfmZyFHhOXEFMh4oxnouoFczHkxBovtr8s4hzq31I0w+WdRMhk3HFjP
         IH3rReZMgVvcSgHEbXj9OgqcoBK5i4XLeCls+JB3zQsZFQeTdY28GmnYwbUmmWjW4nQi
         io/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770851187; x=1771455987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJtImQhwBr07LYXR8PNVKqS7xJhuiuPelxCZ0deVl5g=;
        b=LV8g248a0jP0Ka377YxxSa1cPTaGiOi3RCLnbmQzWXFBlY9Mv/xjpvzzQvPdRHTjv+
         Dopx+2FvmEQujnXjXG0tu1vAXrxZAnI8c5Kl3m5WRn2ZW1uAwMuVTQeGHTcwSFmhCMpN
         yN7VopxPoxGFmMPcVRmiCb0Kx78CbyzKBklvP/XZpk0Nkt2mbrzgxfTAdRm9BF8kYRaF
         Eau9vE70vQgMUMfHAgbvmwrYxAPYQ3EYJnPL4IOE5/r5QCTQJKJwqdkmd7Utq0kQlPUM
         Cex/YY8DvV3vL9cj5C4btXR7bISidovoHIAnr4MYbl6wkBVmp6zitVUcYg6jcQmbIswt
         kb4w==
X-Forwarded-Encrypted: i=1; AJvYcCXSuk3ALJ+bqJGgudcJkfqepDK8bc3vl668Wpq13A1NoWX4XeVP9kTp+g9C8rsK82HB2DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCT1gMyPqwpUP3CNFupMH+YgmM6whJF0VumX52jQlZ7KpRaCAd
	TVWU0OkLUi9TV7JEiEXGzLrMOOt7qgAnatJoM3rF60A2IN4Monsszqo/AGoIkqFq5m02JLm3VLr
	KSg/q1a0ppnRAx69rLnpGH6pL92GodJh2rIVm/ymOeMR1/vBnrRPVeKTgFLOOcykIeY+dMrFcJl
	l+8VCIc0Z2y8XwGg3taHnWkZLB8u9TKZ0Mw3lSjCK0+TnGewas8saIyTHYqUaKl4rKULPKyFWY+
	UsFaOK0TW5ayoMzXqyeIZ3T+4brZKCNjzEcY+SC4XkQMt4MiCNcOlJvrHARksJ3aIVvYNSqSfsv
	WF05UGpnMS9CkeY=
X-Gm-Gg: AZuq6aLi/L4hocCklSCINUmZGRCUYmONZkl2vVj7UeO6aO668DRa1110V1aPxG3GxVT
	2Ng83WjtkS3e0f4BsbcO7XKRaEFDBX1xwc0w3Qt5UZXmPT8ZkAeiyoeBvpCyxAOR3waB26JZPPK
	VlUqoyTwXPaSWvZnDAGHhv7PxSNMC2q8H10DBmHFMLSo9gzjNCwrt51UjUe34hpS0FJ6qzUCi24
	hMPcB5bOS788rIynY03xXw0UuRwFfIRcP8NLpMduH8W5ELNslwhPCixugtj09YcOYBk4U2VaKAm
	aEPXVcz5
X-Received: by 2002:a05:7300:bc09:b0:2ba:6e87:5263 with SMTP id
 5a478bee46e88-2baa8077539mr444229eec.32.1770851187031; Wed, 11 Feb 2026
 15:06:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
 <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com> <xmqqms1fwasx.fsf@gitster.g>
In-Reply-To: <xmqqms1fwasx.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Thu, 12 Feb 2026 08:06:14 +0900
X-Gm-Features: AZwV_QgKWCVHdOnB6Q883PjVQZfUv5pamM-Z9U3GVJkNDhuJG4kmOGQ_GoP4734
Message-ID: <CAOTNsDz0ZtdsM8Z2NW0WBMGs8xyWz5ROS6pf8DKQAx26LU4xRA@mail.gmail.com>
Subject: Re: [PATCH v2] osxkeychain: define build targets in the top-level Makefile.
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 12:37=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >      -+       cd ../../..; make install-git-credential-osxkeychain
> >      ++       $(MAKE) -C  ../../.. install-git-credential-osxkeychain
>
> Will replace and mark for 'next'.  Will squash the double spaces
> after "-C" into one while doing so.

Thank you again for the squash and for marking it for 'next'.

--
Koji Nakamaru
