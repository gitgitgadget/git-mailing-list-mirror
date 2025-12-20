Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49B1E8329
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766214869; cv=none; b=vBW9nT1AsYwsNAUXq+MkdXP7FzCQyyOIqfEPkAJAji16+yvwvgdn4lPrzFpvMOCzohRjtAzUoKNtaLfHWZ2AukqsuyJ4miLFf5Zs9pPBwp0oPTO2bghbc2qIQN32CggMet0zfQId5F5o9JCrL6/Ppq5TuCeUToLxih2F0kmo1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766214869; c=relaxed/simple;
	bh=Uyqd4pB3T0T3uqHS+Zi9KYPOqaLcQr0iK08MdPqYkP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2uTw5v1YFIeiinhxqHDKSL5JeUsXE6nrFYW5Vwil16FOGguc7+hWOqVRVgbhvSjx++bfLJDnanDQhSl6yotXX94m97Mfuvyo51fqdN9eXmV96K4O5LdPX26M3HpoxIS1wQGPE4HDnwublt2MlDcZzpO9xbu283aHSVBEItzfj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c0b24cc4ddso7320685a.3
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 23:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766214866; x=1766819666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDQBtjpwljTrKeIQ1pikinnZuvWfi7XXnJBmXeoK/pQ=;
        b=w2TuUYI0uRZXrrddpMfhtDJIsoJJ0IlTSAhctZi7A94IVIMiCOdchj2+CgCiFnufaX
         xrP43OcrLkjGEm6U2WYIDezRWpqa+U2IF2VKXQG1oIo51d3Tkqt9kPUYx7ZidcLbddWv
         J5uWAOUzbBE/4LGpLj/5Bz1dL4WGkiWkqebHqzmzAEHKdd6KCcPd4QmIXUw3QtQIg+UI
         Jo6/GBWWLGcSB+v/2TM+f7lpP3aZDxHlMF67z2iITkgwFY5/NaPXiDyl3088JEqcy+uF
         oR6V6jB7Ue8CaHhiYiWb0oyHh2iXu8G02/KrfYa+iWVdWWAj/4Ovcw6w4lrmTTP3jub2
         9Inw==
X-Forwarded-Encrypted: i=1; AJvYcCXp0xFSboO4LVR7eKD8ceEu8xAj5LnX/iFq6uCS94o3Mtz7YjA4dsVE4STJQ/Zhj7Bi0YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Ta9ef0Drr8zSLYj4lVx3XAmoiPeqA/Yqrxdp+6Rbp/shFRrY
	ol2/YhB+w7kDEA/ghyNT8BaV3Zf762ecn+67uXmtSjBYyd5ZT30UvjJg/xr7CSY5CnkzKRw+IGI
	akGW59RvNWg9IFuJoSD9uR1uBKnuQyXw=
X-Gm-Gg: AY/fxX7Rr5RYPCfnnp+cGvYPfW4+DjlNMRy6v55BnPejTmKdbSU4TIoQ3zsHhR7YGBi
	dxFnkbNGAxMURz3rwR7TbUEHOZDzSdnbh50Ae5QOkh652RuKSRpRlzg6jlWRNehHrpsSYy6RXAV
	AibcW67l+cVN/ucCO6n1CBhBxjkz0YfI3vTryTUzbXhLNQt3wVqiuiyP2wr21kalFC/0kTzLKIC
	abfKpQI5scXmy/7JiqF5wC6wCdXfXSD9u/sBst1GAQvurJ4sylM90cRw8ThV3HOsRlHKYi3NyO3
	Aa65j1TVRDgkScx7d8OoJgv7P03H
X-Google-Smtp-Source: AGHT+IGdrdQPpjkreb5xI4v3W5UmeGay+MgUElduOOIlDnhW3h+33ZVJ829Y6ThnlrUVsDYdW/REBXnRYu5DGY3kdpI=
X-Received: by 2002:a05:620a:1925:b0:89a:7d24:f5eb with SMTP id
 af79cd13be357-8c08fd1b336mr561492485a.9.1766214866640; Fri, 19 Dec 2025
 23:14:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
 <CAPig+cTC8ROsf-cOhUcxovUOcQ47As496SAm7FcEFnzGChhLww@mail.gmail.com> <xmqq4iplvhao.fsf@gitster.g>
In-Reply-To: <xmqq4iplvhao.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 20 Dec 2025 02:14:15 -0500
X-Gm-Features: AQt7F2ruWPv-VdxMs5OCZoYp0mc2Noov7TFDrtME3XilUJhe-jsDb7XySPspAdc
Message-ID: <CAPig+cTsKgzLvz_BJxTLqRfc5A7CK_FNo_L6TDOGPVGG9eXDCw@mail.gmail.com>
Subject: Re: [PATCH] worktree: clarify --expire applies to missing worktrees
To: Junio C Hamano <gitster@pobox.com>
Cc: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Sam Bostock <sam.bostock@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 12:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> I wonder if this would work better.
>
>         `prune`::
>                 Remove worktree information in `$GIT_DIR/worktrees`
>                 only, without touching the working tree.  This is
>                 often needed when the working tree is lost (e.g.,
>                 the user manually removed it) and the worktree
>                 information has become dangling.

Yes, this is a useful improvement, although one part confuses me (and
I would omit it). In particular, if the working tree is lost, thus the
`$GIT_DIR/worktrees` is dangling ought to be removed, then I'm not
sure why you would say "without touching the working tree" (which is
already lost).
