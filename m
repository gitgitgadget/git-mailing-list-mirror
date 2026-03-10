Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80A3BF66C
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158764; cv=pass; b=FDJ1PJWBbWqMITd1ATwQz3/VvdUYuYRRFz7vYjuOJjuuTSdV/A48PGOzdtlf1X0NrTbE27RzzdoDs05PIm+fnZydkwrvjjg6HtyFTBTNFBWblHoW8AV9K8VpfbOugWHOZCvtd5deL/b/NtfE3Dk28EB4FI4tvdRORc5ZS04mUZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158764; c=relaxed/simple;
	bh=qEPSdhyyvcyBbherh/H6KwpWH/rV03ts726lwg9mVOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0dmalb8vTna6LocR1KSZOuak/432axq75immLQ1L/L54oTUuWzC3vVvzGyf776bPtdTSMLq4mGSaqSIMxS9a6EPnxfT71eBBcC0T1b3344FhMDlbfyfbEGlVfcwXm+o7ZRIqnEgVYAgcdHo5Ui+cKMMSZSXpHqA21yykOkM5ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZ+M1Jx7; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ+M1Jx7"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso4677331e0c.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 09:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773158762; cv=none;
        d=google.com; s=arc-20240605;
        b=YxZgTORZO3PfyS22QlDkgMKw5MU2i259Et/vNFz9K6W74EbaY4X+FgOov3OcztW64J
         x1DeB0PIRg18IwJB5o0T/NrIJRJo/ip73we3Yxaw68oN3nupFPOqU+7hgZpyJsGBsq8N
         VkBjBZswyjeoR8DojCrcEbYHz+yGu7q2MlHwfys83+KsKw7uiHhu+niEN9IiUHZ6Lm6V
         xIC3q71WetvSjtFDuuW42C+nIwW1IdJbt0xBlvFgecyarcuDje1dclAzHXf0yJwX33tC
         VdWILIhrZIsn4SycLE4dVxTmPbbDT7FKM1qyxq8tD/O7RBXVphwB3e286ivHQxyE/w0I
         KmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qEPSdhyyvcyBbherh/H6KwpWH/rV03ts726lwg9mVOk=;
        fh=e8vZekoJhmvBxc+s/c7Xb15aY9Vnru3zhbBYAnvki8k=;
        b=BP/q0bKzpAenwMTJ9tUgL+Xclf4UlAthJwYcAhg2Ng5w5ItKN7GSwqMEz+vig5JW1K
         vysvkDnO7rhGDSNXPLlBeCPEg9nsKRjF4sU35O+sBx/OcWEaO7WxeP/5xEwLsraKVNub
         vUWhnlSjxE2D+WltqwVh9IzerEoA8bBGZ7+TBEdIDS8GvPZ5D3RSFTtDhsEmCJl5hrub
         SPn9hp5JFmFmQZOOuX/qeP+Jywr/B291gvuHujlXcmlDkqZ/OyB/0RDQWuni+dcAJzC1
         LE6fFZy3ZLb+9Ew3R6SofplUSTXTT6OaJBAawPKY+ISj/wTVSltPZre5YaxQsULtkSnZ
         XwRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773158762; x=1773763562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qEPSdhyyvcyBbherh/H6KwpWH/rV03ts726lwg9mVOk=;
        b=XZ+M1Jx79p9lzE8xHO1ePcbKAmSKwbFjbvr3Jit3egplruf98OitNLa/f4FsXb24Fl
         oRyhD5EhU0UGTkd7pl2Mnv34yNxu3HJan06d2i0HrtuDHLmWWdaGlDbvRKJ94hDmdUGY
         1x06Sl+u4JoMhXhWKN99e92HQUxj/3styZdCllZz+f8xBpNSMpteWftY+k1JilsscsoB
         F0qpKmABj6hHuV7xqaEEFnmeqvayknaSG7v3AcYzgiQInp8qBhr5+iGeEAZWkfDvUvmF
         2nQgAF4ckl//YGKdzf37VIPfhxI1IdGoFho1Dn+n8tiuqAFeMaGwViTQAcVhOltlqtre
         2/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158762; x=1773763562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEPSdhyyvcyBbherh/H6KwpWH/rV03ts726lwg9mVOk=;
        b=DOuHIYGnMmNpxKiq2vFZOoNGZRtMA0WbbexyYp610lcHkOdyZA5RhuHFYt77/RQdYh
         8dzIiW/VtueFBHqi6BjiORP1MkCC4HoBYVI3KBNPOGgIgSDaKyGDSGVsInFtOyh0KX3D
         Ckq8pbteL7WYP7hJO4EHPkx2gd5HVNlszeb53C5fmeoj3tVcL9EesteFeNuRP6a9HTVI
         ekOVFJGSZfPwrQLpUud+B0xno8zyzhVTGWsJWrNLQazPnhnsATwSsdEvnxHLY4BN0M79
         +D/F7y5X3UCGjVRUrw914xjTQAndFXV8eJQyLfqvXEpaINIUnxuAxvqKzxJnxwIhSjDR
         s2UA==
X-Forwarded-Encrypted: i=1; AJvYcCWSs2ezGZEfP96rqTBVYNVvuUhDR6VfLBfgbDgT3TyReRq8DU2wMsNut5Va+OTu2JtBNkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtkBeoa//bpC1moJN8HqZs7p5w82HCkEZhCXTGNWqLz4jPD/F
	W+wdQqv57YRGWg2PCIgcZkHsVeQ5lddSp7Tk7CALZrZrk+LkF6imxLpVpT2DQHUrOyx3VZm/fOv
	bfuL5rhR7jF6M47sJS5jMxGJMDp1L1RyYecngl0ME/w==
X-Gm-Gg: ATEYQzz9aMOt0ZljcKuYNketLG/xesec9yyEA3LmQg24FG8likEwyPy4LW1Ue5DRrn6
	eF1TLCnuT3cQxrzmq1Oa03ngKNUvQBimwJmk8NAY5DVuYt9ZOm67pOXEPSabFcNjijhhtpZV/+u
	YDt3wGsbDZEas5K9dMLoTxS2rFgYA1GEyC0Gv5sLnkzg/HapahQ8lsb1wH/PRXztd8KD9Y4fNpl
	ynjfMTco//6ekaNpIT2MknU6ih39jJ8i2msuL2xP39dEv63pr8aVhWu6HgalV8WHSSDT2gJGvg6
	eGkvpccWcjb2wHgXLWogvWy3RYxDE2YHkQlxcq8Z4pUDdPY/J9HwQICTNAMyx2Srd0GM9Knazna
	Ww+JLksVM/4ZG+830UVs=
X-Received: by 2002:a05:6102:2909:b0:5ff:cac8:b1fe with SMTP id
 ada2fe7eead31-5ffe61bf244mr5392220137.30.1773158761903; Tue, 10 Mar 2026
 09:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <5f100fe0-d601-4ee3-adb9-a2458203d10d@gmail.com> <xmqqzf4fx0vo.fsf@gitster.g>
 <CAOAgETNoQuju_RWbe=jo8JF7J2+V_pVoyr6FeKw8LwYKi_HipA@mail.gmail.com> <xmqqv7f3wv51.fsf@gitster.g>
In-Reply-To: <xmqqv7f3wv51.fsf@gitster.g>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 21:35:49 +0530
X-Gm-Features: AaiRm50Tj5PgEnOK27qm0DpsSK9iwF9p1gevxXV8Y00e1QHluSc6HkpvFMYNxUw
Message-ID: <CAOAgETNkKrJHpPjfbW2nfZ8DUJ84-Z-zBx-WefYJb2sfD+EdWg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Advice on checkout dirty files
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> It is understood as author that I understand.
> It is the users who need to understand.

As informed by Karthik Nayak <karthik.188@gmail.com> and Patrick
Steinhardt <ps@pks.im>.
My PR seemed to have redundancy for which I will create a v4 for my PR
removing it and giving it proper description for users to understand.

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>

On Tue, 10 Mar 2026 at 21:10, Junio C Hamano <gitster@pobox.com> wrote:
>
> Arsh Srivastava <arshsrivastava00@gmail.com> writes:
>
> > As per the recommendation of Phillip Wood <phillip.wood123@gmail.com>
> > I have changed my files and added git checkout -m after understanding
> > its significance :)
>
> It is a given that you as the author of the patch understand it.
> What I meant was that the users who get the recommendation need to
> be told about the potential issues.
