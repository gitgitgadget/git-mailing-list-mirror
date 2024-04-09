Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373E12D1FD
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665633; cv=none; b=kSoj+gQGmtRMlmgdpCv4sU5OpietuRTKGhftVWG0GTzfSZ4HGahca/3UgZ3RNyctfj5ZTiGVZlJxQHG+8VFHYYs6+7SSChkpWuNRALZU35AWrUhW4NsisOrpN21CMTu1sFt9Ks7RP/Hapbdk08W3aZWlndiYTecJiFX2z6x3XIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665633; c=relaxed/simple;
	bh=O943G0HahG3fQaycyBmbkYrhxuovKRfH0X7DFdd+Olw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMwVsa1c+kzRln2uAg+n2c9pJPZ+DT3Scwrr5p3a93UE/ArKqgXu8RBqSHfRmIFGaD9/J9X7athL6x0avlidJMpO6i2RR4sWJMPW7zll34B+CeIBvPMlZX0aKJCHD0zC/dLdV66Fn01V7aas0m3cNVv1+UljTG/UyTmxxzDW/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fisherfam.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fisherfam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so5788227276.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 05:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712665631; x=1713270431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+kPhAwFDpXtrRYbT4cVa4wOq4cCqLgVVG9Y+aNgdl4=;
        b=CGK6IPQrT9pncLNowD4Flhxdgd7VCaQ6ONyhrPAEQYiZgh2lBjl05+mrSzPNYtI7MJ
         Um1nNnQ0sgt77hPWLtc1A1w2c3V4Hs710RLyK1GvBMT6vfAJDM6hX06hENSU8koblxAH
         8EqbJeQrOeWno0dZqfwrYRlNl7pv2CyqKXn4or75U56eLDbRNDfzMwQ9XbaExD2nO7v2
         CkAjSLOfHZ5/rzgbkJytXpjPOROCfOT86OeMSYLD7v4kzzN/w+EILxEg1jQPkOg/PVbX
         uso6h01QIRUeok+jR8sWmqij9nDW0rJcpuXNR5hMu7W/IMd+U4V7f81f5LZqte9Fx71m
         drIw==
X-Gm-Message-State: AOJu0YyuPbHIFqR56ByxsOFa+2vl0k0R7FHjdPFjdpuGder4P5O0vPX5
	UbX15h6p7qiZy+gfq3Fm3kEOXdj9dTbSrfqsGV/CljZSVMLvzIF654MCBAnf/bvgOGgQ5tV045h
	Kc/MSQUSgbeXpItDUB5Y9fpNKz2s=
X-Google-Smtp-Source: AGHT+IFWdpu7Xo6dc6ivdXIJQ6zygfsiPqMa0Yl3U7nMqHQQ+m9V7zeeEc25fjb9Lqxm5OF+hIjL/HbSirxPWp+BA/A=
X-Received: by 2002:a05:6902:1101:b0:dda:a4ba:2a5 with SMTP id
 o1-20020a056902110100b00ddaa4ba02a5mr9627307ybu.63.1712665630881; Tue, 09 Apr
 2024 05:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407212109.35131-1-benji@FisherFam.org> <xmqqr0ffbvjq.fsf@gitster.g>
In-Reply-To: <xmqqr0ffbvjq.fsf@gitster.g>
From: Benji Fisher <benji@fisherfam.org>
Date: Tue, 9 Apr 2024 08:26:58 -0400
Message-ID: <CANc=FSNXzsFqzbgGs3CVAPxtxske_DEorNrk66gvYe2+1d_PAQ@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: use switch for changing branches
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 1:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> For this particular patch, I do not see a compelling reason why we
> should make these changes.  It is not like MyFirst* documents
> consistently uses "git switch" (and "git restore") in other places
> and these three are the exceptions (in which case that would be a
> very good justification you would describe in the "observation"
> paragraph of your proposed log message).  We are not deprecating
> "git checkout", either.

I was under the impression that the new "git switch" and "git restore"
commands were recommended in most cases instead of "git checkout". If
not, then I withdraw my suggestion. I apologize for making noise on
this list.

Thanks for considering my patch. Thanks even more for maintaining git.

--=20
Benji Fisher
