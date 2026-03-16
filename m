Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120961A9FBA
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660097; cv=pass; b=JY1jVgC1XlKHX7IFVrTo39ogWlZT/8T6u/XWydRMNtzPyl+D+rRyUZAeATCpz3a1UsAF9Me4mgNxd0+kY3n69Gs8Tu/xyY+uX8vxTP//yVTCTA0RHKP7fwD3ZbMd5eKbTjKphqpMR0hMnARbSqJuJUwslv3ujNN+qMygnYvvfyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660097; c=relaxed/simple;
	bh=/j0cPYQecR7YF20g2uiS7tgMFrmoQh4V9XRnNWHj+B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBCx+MH/waOnRwIdSo/D3OrcP2XCqSLUkKp4O9SmFu/XRACDpr/L1tv5rMMoKh3qce8Vh2KuBZWpRPl0f/5YIjCAiQ5q1tuHYSF8odVTm9/tBQFWGKdwtGIwCAP6d2pxmGL3U3yOl3PMpwm65xuqklV8L9/r9tMZV7C2KUOyjQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny4sNOp6; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny4sNOp6"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12776bebe9fso1486971c88.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 04:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773660095; cv=none;
        d=google.com; s=arc-20240605;
        b=WOpnVuWzVcY++XPoAa80tPwVoKKPMP+VyKZEZewxKDHBcZ2llPWM9uhwh9ciiMUUMl
         jtkE1hP5wtOzXdbfrG8xV56zgKQ5ZrlNDJIEA8HTRU7EBZgSTzMRWsWDa5MD8VnM9nvJ
         gS3Xw/LUx+7bcJ9lm/sstYZGUDGvnzwHlD66ClUhIXkrLFt58gkiatE92pg+gKznE24n
         lyJ+vmHNUb2GIvFLP9lpGJcZbklkbb6Bc9LbW00QQYAFVOtX1WmpaCEuX+/N4jUVLRcB
         8QC6nctZhTb1g/M5uNslsT6dpEIJomMA+NX+NwX401oHH9cOGJCtuuN1C9WYzQ0f2Evp
         FgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nmT4cy/AzLx//Wb5hVEUQaTLWeeTGBYFUPuH4aFn4Qs=;
        fh=I3mC+IUmnE4Tnx90Pd8wr3IQ7gMv98hW4XzU8G757OU=;
        b=Bk4STaWW3JyEtMYraddJDNaMu/VuS7gqUQkAQnV/qxkmKmwBIVNPiBIPiPNzDOnTc8
         1IFTukl8xo+lFyHLLMU3J9mT5uUhpaQ2Pj/YprBqj9QzyOChmBj18hwYDGGyULrc273T
         wknSQHl+AGvdHCDfKyIaAjyfvtlPdq8J5kKyxOF4k2M/8ZiQw0qx41Qibm5ZtTjnLPdg
         B93es/hJ4BxZwGdEVq36iiSpFW1/TMevZhcVBIYj+n1aJg+MFZLUFmbE0rrZDUO8B9gs
         +bwUdEbl0jRwHQkUoxtpLX44tky450UEU4EvyE8sBMNEr9cgtBpjfy1nMx1NELXqmD08
         9ntg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660095; x=1774264895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmT4cy/AzLx//Wb5hVEUQaTLWeeTGBYFUPuH4aFn4Qs=;
        b=Ny4sNOp6pjvYMYzwLOsGSdpTLuElvJZmFqt3qU9mloRqLBMmUjkavQrIu2snwvJUJV
         5HPzr7xkacJ+uF0S9Gx/J1fKuXIK/egvERLak3yraHeOhI4aUY35VP0RVgMqWryoZe/9
         o3uGqovw7bhJia5fVngj6X0ZwqB9cnhWIc1ReEg2LmXK9TlqkZYGAZzkEP0S8tXhOByp
         aeqGnD3lCEMUvPmMZDvNwinsmuZ2nq+x22htLzLN7yxqCRJb0exh5BhdcTfsACSoMFK+
         W7C1IaDq8j5glRM7znCMYRgU765ALNLQnKtumYOipjUoVIuVlNTO+jmVVLJ6FZ9nQv13
         14wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660095; x=1774264895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmT4cy/AzLx//Wb5hVEUQaTLWeeTGBYFUPuH4aFn4Qs=;
        b=RI71jJzXSR6QisW++JnUkm4dNCm5xlid/QOQiBUpLi0prDbRKY3A1MuJsdU3/Ba2Uv
         e1DOysckZiAHFX8X+gq42rW7akOMSRWDYHSktcbyrANJ5WJnWvlzm7ryeifzGT0lWNoq
         6nOBKNyKy0VgmODwH/ZEoc2JtcFyzIXHTz3k6f9tXPGXRCsCb5AFPWJnVT5eyidSqq43
         6ca7jJhxFbhdjHnDZ+K/JdYjGJtw8UBBnMf8HdLhvt6C1c3IoidJgqoweByxb82R085I
         4xwQwgqDwxjm3hJZNFvrvzc5aV7c02BPcTq7qVIsnvn6BxjPqR9rKpfXiw8o+ODpsqAB
         tKBw==
X-Forwarded-Encrypted: i=1; AJvYcCUebRQNjvU4pCc3YxyB2ept5CT+yICgPMzmqCkDrgwtonhAu71Mvn/Y6G3Vh/QNHB4/p84=@vger.kernel.org
X-Gm-Message-State: AOJu0YypP7hQl36PkF3hymx9ZTYT48ifTh2tbsFlGO2sTrH60HDk5zfM
	KynItSKrdF9Kx1cC3RnpJv+wu+MM55Ds4WkFgMhLTZCxecG6NfT90v6DDvh/Jni6IW214JEpMGA
	DDjjR3bL1bwAGj+LyS1iMUawPHcDGRMSx1pI2
X-Gm-Gg: ATEYQzx6DiEPqz8XZ348uK1bKVQ41/BEM8mSYHD9AKqCUA6Xtkvb4WR8miBJbI14pxL
	bkC/kXGWtHskf9Zm6L66lWjMzxIL0zgJdq8ucKn5oEjsfh5apc7x8EbiVE3gTwH57nnBQdXlmgc
	wXe++riN3ny0+8YZDm/GYA/7DZrjbqeO1oC6lBvIKccGnfi4GP1T2JIpySHJ1KpANSRZmUiosZt
	IWq1tRWj79KgR5LlRk92oPC6yc9mMCfIVTyLwyjrIYz9ry2nfQV3e+9xKEf6q3Voyw/rcGTYw6r
	PQaSfJ/dw0QNE+7sGHqD5CRNPdEY5KQjPUZsHLxaGLB+b4AZHR76o6LC12D4e+1eJ7H0
X-Received: by 2002:a05:7022:20f:b0:119:e569:f277 with SMTP id
 a92af1059eb24-128f3e197c3mr5866961c88.32.1773660095004; Mon, 16 Mar 2026
 04:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=66rjeY=NqKbqRkhA@mail.gmail.com>
 <CA+J6zkROsbkr6mWQrEhnswtb4sOh+UMO+bt3P-5XDiAjhtcsMg@mail.gmail.com> <CAN5EUNQdNtPq1mEBUXOjRJ_t2n=cSUS9dz+HUfqbFjrjZVoGLQ@mail.gmail.com>
In-Reply-To: <CAN5EUNQdNtPq1mEBUXOjRJ_t2n=cSUS9dz+HUfqbFjrjZVoGLQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 16 Mar 2026 12:21:23 +0100
X-Gm-Features: AaiRm53qKw6EjeX5q3esoRMl62Lo3tj1aQtQLjaMnK1AanTcONYeQ-YE5KcDng8
Message-ID: <CAP8UFD2PDqrpV-Y8EntJxfaRDP7aBXr47nQcVPeX=80yiLAoHw@mail.gmail.com>
Subject: Re: [GSoC] Proposal: Complete and extend the remote-object-info
 command for git cat-file
To: Pablo <pabloosabaterr@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pablo,

On Sat, Mar 14, 2026 at 7:31=E2=80=AFPM Pablo <pabloosabaterr@gmail.com> wr=
ote:

> #### Backward Compatibility
>
> There are four possible scenarios to happen between client and server:
>
> 1. **The server doesn't know type (new client but old server)**:
>
>    After receiving the server capabilities, a client will only request
> what the server advertises. The `allow_list` would handle this,
> returning an empty string when the server doesn't support it.

This is not very clear and maybe answering the following questions
could help clarify:

1) What is returning an empty string. Is it the `allow_list`, the
client, the server or something else?
2) And what is actually reported to the user (en error, a warning, nothing)=
?
3) Also is it what is implemented in Eric's v11, or what you suggest
implementing?

> 2. **The server knows type but the client doesn't (new server but old cli=
ent)**:
>
>    Following `gitprotocol-v2.adoc`, "Clients must ignore all unknown
> keys", it will ignore type, and request only the known capabilities.

Questions 2) and 3) above might be relevant here too.

> 3. **Both know type (new client and new server)**:
>
>    Server advertises type, client requests it and gets the type data.
>
> 4. **Both know type but protocol middleware doesn't (new client, new
> server but old middleware)**:
>
>    If a server advertises type but client doesn't receive type, a
> client won't ask for anything unadvertised, if a client asks for type
> but the server doesn't receive it, it will only return the known
> capabilities.

Questions 2) and 3) above might be relevant here too.

[...]

> Thanks for reading my proposal and considering my application. I'm
> very excited about this opportunity,

Thanks for your proposal.

Best.
