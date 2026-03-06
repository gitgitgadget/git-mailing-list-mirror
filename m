Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E563325716
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772761676; cv=pass; b=X/yJQCdCzywDFZB7rrkUmxpvBm1z/jH3cuNQ9rxbl/Kjxanwi5C6lJ4Fl0MtzmG+uIZrl4cJFyW5saZ6WIkNs2fglXbGxK5cYMLJef6vh9DyiEHw6rwwt0ej1Z3epGMcRQ+jvMzX29qmifryGBDekxvIeP/ZXbd5eyh8GT+p1wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772761676; c=relaxed/simple;
	bh=aXTGJgHwpbJNFIS25oMZQJxYMErEse//6lU5cgAzDvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIi+IR9amaNBoamwBxqUgFyNpHHUw3r3Vl/BaBOu5ehXBG0d0O4LI02N8Lw1bLogKS5BW4lnISKp4hKORnl8M5Lr0yN1exwSEnMrkxP5Y1RPjowOHUNdWYyaz3Q7A98qHVRG+IHoFBUSYhYoC8eOVRvLtF3AwaGdOw0LUUEomZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBw8YgjP; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBw8YgjP"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89a00e8dc04so47979026d6.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 17:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772761671; cv=none;
        d=google.com; s=arc-20240605;
        b=Am5rQeO8/cYtsh0CPJ0Hc/ftCFimBrlIzA7PZImhMCgFTPigOY5Hq5bFVYgzs5XGaH
         G4Bjgkw02p1eCyWlr6j0pfwg61rDJgn8U+i16g4VaSHzJHJQqAmhxkdkS4bJk9Kak3KQ
         qo7fzbAhC5QtFnO1I6vYUQORnEdNxIKqAbPfJB4Dg491i8jjXN8y2twrBRQYpr1yewz1
         361Y6f+/uYZhROTaTBLTXUKTDMZZCyFc1QhfeqkSrog4s3gBWIcf0LuAg2W00nHlo46R
         gCT/K+Nyjo2MK9Pr4zJ5RBPwuNzKyKMnsD9/PkXvT1x9qJo/GX34rvMvYBqD7ea/7EQb
         hQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G0iXQguEX2i7xqT1NZOWl33IuTGao4m8aSd9H0vXgZQ=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=Ai4ICIssO4Ewnf/U6r19aWVoQvJDOwesL04IsMyNdAt39bGQIGmVPFXXh5+ZnaMS3H
         ajwuDzCspLnNkd5KompP+2bjL09tCnEP1+6A2+fLLcUG1nvFCJV4lPSPVl6RMFyB7s0z
         VoJjV6HcZ1pZRNEQO/B/SMWeiBT9JLl2FK7un/5NvX0AM/Tdghm47TXHvyo/8azOoiX9
         ygAA0f2/eRW0xv4LWUeQ/NlVJwzNx427gs9G/XbzaQFfu68injv3nKUeaA4rNF8Fi+3t
         syAFD2Zk+llV/LYkTBHXbsOqTabc4MmXY5nW8Ea/aTAekbSp3jbxGsJHyopIAT6ThzxT
         64JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772761671; x=1773366471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0iXQguEX2i7xqT1NZOWl33IuTGao4m8aSd9H0vXgZQ=;
        b=OBw8YgjPBZl5bIHFoex3k1NN2ctvYYoJE+/Xe86eBWSO6ZGvaGh9iWdEm6xruG+FFr
         xy+YXlQlXPs1B5aKicXiUJ0UNNl/Qczt4nHSVgA507hWA0AJFj1dMFCWahETYfmO+rQa
         B+rO4elsC63lNCE09YY/zR+B1OkNGvjKhCOpZdHBuZeV3j9dIYZl8nlIDUoUb+njltW4
         mvT9RoE+tLUTScjMFL8CXg4Yhp6Qg7RaifzSo8Toh4EBbeo6VpfvGKEcxLqh/oH9j79q
         EqowhEEDqgw3RohZnmXMtKmIAMqHU1V5O3wf7pn5midAgCyUrEH3k7YIfzUiIsGaxYqe
         gByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772761671; x=1773366471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G0iXQguEX2i7xqT1NZOWl33IuTGao4m8aSd9H0vXgZQ=;
        b=V2Mp8KUOYsu4tlaAasOfmq5ILlkcCp+IDDZ55/bwOT47uwayc3/JMDMVMllA6ZmglO
         opadLEf4+Bpw5AhR8YCOV16ZniJzVuXeamvRjrWqjDSQ24Vr5ynLneziMGIoqCmwRcbI
         d1ZsLoQgNZ3N7uEkt+z+hawsLM9/mePT0y2md0NWqBubmBs5xAUPuNgIe08ndedRdoma
         ntuAEDFzjL2JRcPB8GSIlkOuuTcyflPpfC8N6zEkvfBrr56uiflecR/XVm3+gBnnXa7F
         3CFv/uDbLLxnERoC8xvSEkDsmljhvIbrYrRv0AwLCTK6D4anaqpcCXGRXOJ8dgQEkw2b
         wKnQ==
X-Gm-Message-State: AOJu0Yw2hi1myiHi/sS6xFHZQcu0V0HqgUpswrcE1rHMUXev+AqUfOOe
	ZRqzmBNP/MgvACfjQxz6Z6wWhvHcsIwR/D2hgyo10K1we6CbMlTYJRtqwdxudXL13J0bvEGrQor
	vjPjlMPS7FW1K3Jy+IGyg2q3DjhUgAvznYGgSBQY=
X-Gm-Gg: ATEYQzzZ2cBlU98U4a6HHH4xotBgO5ifTFHiy5wYg4isfzqFo/DsbU39/pz1uODBTi9
	h7llhapOBMqiEMpsGrdSB6TY17463+5SpRDxKBShBKJC8R2tcGUHkzr5FbiZ3MRTA6yPtBnHG3G
	bYb6tjnNIGcTeqKvFxFavikO2RsVQQLdDUKIiXAUr0ykNisH8S5SiIJFlbp+c4Tlqcfar6Fi+8t
	CKgCnLvJ+5LQAHxxgciGCu6L0n5O3piI1REPmuYNNPx8BbnsaKz8SC0CladxGLlTTXTaVM522hW
	JiqB1T7HomtMjDPfNhjvMeLjC5S4FqWgO9QFOgQvWeRmp5iV23elJpBvnqzmkeIDmGhsZKueHBn
	tlHi8fE6VrIGDm4QJ77KlL+uLrOkl2bZAHejA
X-Received: by 2002:a05:622a:1304:b0:501:147a:a215 with SMTP id
 d75a77b69052e-508f497972dmr6821381cf.73.1772761671122; Thu, 05 Mar 2026
 17:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
 <20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com> <xmqqms0m2hn1.fsf@gitster.g>
In-Reply-To: <xmqqms0m2hn1.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 6 Mar 2026 07:17:40 +0530
X-Gm-Features: AaiRm50_NPCH7mQQPkLy07WNZfszfSKKiNCZkagE3cqA8Islkg5fONiCrM6Phlk
Message-ID: <CA+rGoLfpyiKjLMOOHBoGoQAO2eLraejRGgpEpMGqP7+=VDQSkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] clean up a few things
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 1:06=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > Changes since v2:
> >  - Update commit message of patch 2.
>
> Hmph, they look identical to me, and more importantly, the previous

The only change was the words "a standard signed int" -> "an int variable"
"overflow vulnerabilities" -> "bugs due to integer wraparound"


> round has already been merged to 'next'.
>

Whoops, I didn't check the what's cooking chart,
Thanks for the info Junio ;-)

Regards
- Jayatheerth
