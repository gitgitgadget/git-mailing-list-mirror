Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E2925B08A
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853543; cv=pass; b=TBZUMIC9YEbU+EWZKqy5zTm/3h5IKNNLuWZXsNORPBGppiJ8m2GFtSs5yzqKd/dUZhFFw4tIGMsVNyoTZAIsyMwKHF7AqCkbDUugKnbr938Arrlaj0X4JB2BqM5v6oWspHuRMquglOn2YB7hJk6xWVTz3lFZfTJ9zEO1RjaLsIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853543; c=relaxed/simple;
	bh=70T6zY+mYvwRhsLDAr5OorqSDNPnDB0aWK5TXEeLb5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVCU75LbQtsjh9W5W5zaMwpnc9F2oVdcVeZXgmqBcouft8ZYCGg8sotMI3NA9mvX+AsZxZBIoDCqrjzY1LYJKWe91DIKFT12GX9HqDNwc4DFvUajgoQ8NS+62ivjW8cX24x7uTSGwE9dAi+drdvZzho3Kp6ggu6fl5Ecd0wCTRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUvWPMJ4; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUvWPMJ4"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43ac6072so17348147b3.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 14:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789853541; cv=none;
        d=google.com; s=arc-20260327;
        b=puaKjcOG0bkLV4454P2UWE7jgDzDZrYCyTwjMf9ft/1OJTT9GquR9UUuiFW+Xcm/w+
         ayCVo7EbFdRXk36YjjyVI7Z4I+F7plqFxHhPsanekuAgkiyP2rx8NI41Tcm0agvqmd0X
         sXflsjUwr/+fGMEf5LvfGgPw8Byt/ZVHDCJaccn2hv6YbYN/Ae7ssHD9+gnd/gEcI6EZ
         FgwqhvVrXLuO8sbJ5SqnPfy7lvhiYgilrSLeYTI1bssna8dpgYW7HOAo9fY1OmRzHT68
         06WVtwJpvaIyzse3bDs5J9LF7PiDEDCbT4MAzdK9U8nRfo/v3QJ71UdKDDPsoalI35Qa
         etRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=70T6zY+mYvwRhsLDAr5OorqSDNPnDB0aWK5TXEeLb5o=;
        fh=UMIMkTtMne4PT5ABr9t9KGvEaEp/KyanD52RrySL8ZQ=;
        b=KCDGqWtqd5KgzBPKBboLTSE6rRHiwag8tDUNRCQH+yoEwm6Ensk9rqqp5hSKYYLv4g
         SPs7qSpr2TU+buw/G7P2aLeZxj2HHPgqupGn50wnsT3jUZW0IEHQzSSqSqUhV0lAyhjk
         n6dG/0euAzeoPKciX+dkxmLL9kLLjObcV0XSQbPh3pmriCXsUOtZMW4fEb9FjkzkIz3K
         Qx+PRqSh1ezOPacz4MhGGrP2b3P08OBZImHrBCPKkZYMGDo2Gl5IJSceWVWE4R2JcNBA
         aEXGXsHQkmF1C+Pa/mXgdaUVdVkJF2CTmvJWuaR9Ao4+t9O6pfi1LX6ntkuHW1DxdCh3
         GLkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853541; x=1790458341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=70T6zY+mYvwRhsLDAr5OorqSDNPnDB0aWK5TXEeLb5o=;
        b=TUvWPMJ42X6bFVf5s8RMhQ53SGHOrtP3NyLqKRYMA/1iz1bflBhH3upwCa87sTCR+h
         6ZhgiUOA1gbk3+B6gVTzS4VWkOEY/BGLc+TbU6UzNalL3UCrJxwFHQO+DnRj0lSJphJN
         qSM+2GggqNBvgMDpkva+R5Y5k1fwNTnf34kepmBaQMibLgUb0mxjWJW5rnKntTmLjkA3
         HLY80P9WCk1sjQtCllsNQzvHUtKSWKnFdUPwq0O9dUFly72A4i+r1GkFLhuA7wW9/oaw
         z+ZEOUGGtNz0/FT4Yx1+yDySvrdOMkWRoN4eMTVsdjrBL148yEgbCuHBFFn7edSkaGFq
         k4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853541; x=1790458341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=70T6zY+mYvwRhsLDAr5OorqSDNPnDB0aWK5TXEeLb5o=;
        b=jR6XVt8O5WAAuQTnL3/CYGUVwvTZ7tZGPCGdBbbMn5XvFNLlwgBDwWFYoaWN7WYgUZ
         c1Ef75JxQA9iiMkrMLWrq4BpWOJUVon3/8aygh+SLI9VUMYkisaowGrW4K2S9fR1CPkC
         I/duktlu3MOc9us7+JJm4coYWWrxPEmMmOieNDAgCD0cGT1CZdWzEHQKFSmX3Haq+oLa
         80AhbaODQHatwsjXQsViQKaWHQ7g6WuREgD3pe3rq4whif/MLuc8p0YKCuHeNYQf8Wf1
         5vZ8KyyfcE6+icUUf+OVlc4dYJ++H49uL0wDmlZdfkv2roAIm9peeUb7eDRbks5k6Mq8
         TE8Q==
X-Forwarded-Encrypted: i=1; AKwUvByGBECguDiAIbJTWvd1iQAMGxnMIakk/HCRo13LEFDm7sNV8yMgxzPu0XiPweHwB9972Os=@vger.kernel.org
X-Gm-Message-State: AFuF++nG/OFpxfugPCCRuX4crsG1VUxKx66iCa9rzRlCKCkXxfcgJlId
	kRp7RnJV4ktiAX0I/MoCRpNvyttUMpUT8HYgUXOk8gjfy61OgBLPz4BYDnOkny4ahUGcvyM6bx9
	3lWBTk55afNX2Tta3eEL9C6Hu1VTL2JQC4ek6PIw=
X-Gm-Gg: AYBFou2tDEaO90mXarlraOhcD/YaO7zr3pvrQxIbykepGqDkT7BiUrh9XYJ6ta8s55x
	Dt+xtVUn+F0hBodCcwtnN1LT8ECG5OmOPGhhf07GCpmFOqCsyIf9Os8v8PD5p/yiQbyCE0GrmIT
	FtU89/h2XJjIGfo6cTRnZD5JHEB9C+Afl06hy+Jo9UZfQ1vSTwY2ewa5Mvxo0f0vPKAwp06tvmD
	juIPIAgMA4k0McKTEl4JObil/GdYDXCd42h1lLgLBPf71x3YPTxY4U42TPkYlokqS/CILG1o6ZW
	WKaVvgnzBZqPOyAl9mUR8Q9OW945R0nnVFoLlgAq2U9tqMVyiOqtE9M7MvesxMmhViZ7Ai3t4yO
	8wb8C1EwI5x48KKdbfkE2vNKsSMoHCmmuT3s98UtIsIoETOPa0aAZ0mWi7H5jOrGq6iZCKQFAIK
	UHBDsJqP2+2Z92wZqdMQ==
X-Received: by 2002:a05:690c:f16:b0:884:b55c:312 with SMTP id
 00721157ae682-89731d9628dmr23046387b3.16.1789853541118; Sat, 19 Sep 2026
 14:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com>
 <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com> <fd4c2cc3-d457-49b0-bf3c-96063e40700d@gmail.com>
 <CALnO6CDfwscMWZktBu3FtXOQVbcBRo76nqK07kMnrzC5cPyZiQ@mail.gmail.com>
In-Reply-To: <CALnO6CDfwscMWZktBu3FtXOQVbcBRo76nqK07kMnrzC5cPyZiQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 19 Sep 2026 17:32:07 -0400
X-Gm-Features: AcwNN1UhXyDeHPF43NDuBFr9LIQ5WyJxIGwNbLrJ5Av01V3rgi1psZS6HsGMBk4
Message-ID: <CALnO6CCNEzvit8m4qXr3_oOzGWy5JwU77rp7Jr-7Hbcr1Vu5vw@mail.gmail.com>
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
To: phillip.wood@dunelm.org.uk
Cc: Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 9:15=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
> The attached patch [Gmail headaches, sorry], which needs some
> polishing [*], passes tests and fixes the bug! Yahoo. I'll send a
> series later, tomorrow probably.
> (It won't apply directly, because it's on top of the experimental
> reset_tree() version, but resolving conflicts should be easy.)
>
> [*] namely, the log message, some tiny first cleanups, and removing
> now-unused functions

I've sent out a series with message ID
<cover.1789853192.git.ben.knoble@gmail.com>

--=20
D. Ben Knoble
