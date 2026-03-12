Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985983A6F0F
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342784; cv=pass; b=m9bSI8U4oyeZnXhOtNAiVseoOgX8SdeeGePixnkWjiMokqyT1W1KM1CFFA3mSDTRDkkbfCcyl1nnS8MBajorhtW9SL62JUblu8KykVpRKR/yPY+R5ypRNXfjOfGId7zYdUPQt56tsKLGK/hhNrINZQU1Edjg1ToSH9Pch3rdHZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342784; c=relaxed/simple;
	bh=A+WYX3Zj+K5UHEFQ63KyrozjtWuzXXoe8px29Ibr494=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOku30YW1epSmch8+ZdB6A74rCwjUbsT2+0RNCpfilB2R9UzlKtpitkCp4LGry9t9FntOA4w87sGd7iGkcDxuRq1HvOjL4DVRLw8veXe+K9impQOWs+yNjxPZT80chbZrOAmwV34bH/CZ0E6v31bpLkFWoF07pivVAGqakbOwCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFjlqHki; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFjlqHki"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94e82e5b262so358461241.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342782; cv=none;
        d=google.com; s=arc-20240605;
        b=Mz28+mfXDWhHtq7m1arlZSdsct72PafRCTovArbmgthJrfnPjWgLZ+SOH/tGBdTk2k
         YS+0b3ZVt+Dxtlo8J9SVuWGT3tbNPbpG3ZPZPTJZMYb8G+Bkovmt3cYHAIgusQA1rk37
         yDHXSfbfiVh1F84s/dJC373Zb0pW7zfnIzTfOdRefYPMV+i0AXsGkDxuQDbivl7fLfX5
         MRAUTtM7rIikwgB3EKDhKn1R6hNSNuaKBD46nzbLRuWZiVl5mBoCWSYyFf+jE+X6M3W/
         P12WU5NGV0tZxHBOll0jOtMlBJmrIpmL+nHJ/5XitOQAcYR2aCJnWiaPJi8CSgayskyE
         mW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A+WYX3Zj+K5UHEFQ63KyrozjtWuzXXoe8px29Ibr494=;
        fh=zvznNIvkDpaA3vVVhZV4hpF9gI2TYBb+++47C6EW18E=;
        b=BRP/MV8FgMyLmfh0T87OUTbpAo/GgRNjOtFM9OQ8tETuV2IVC3Nu/SRlLzQynthSvN
         fj+RLARQUz2QqfwO29UohK974H8AiYucTL/MLtNPY9rhZjna43PWDu0BtXeDeQK2xcJb
         BnakEZjORyfzs95IHyIac2gKOuSLf6/GCs7GG63SUF6yCIN63ncSDhnhTJNLzmoMuZ+U
         tgVS1zispMirY5L895XyrChgA9VH5Zd+7q4UHyVoJwoPasFWwuwiFo+1VkdlNh6AWZQB
         4p/WUm3lpgB+7d7MbpAyYIK4va1bG3tDoyQ/seQSXRkXekwXlNIfb2lwA58f7VtEHOAs
         mBig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342782; x=1773947582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A+WYX3Zj+K5UHEFQ63KyrozjtWuzXXoe8px29Ibr494=;
        b=gFjlqHkiRVOBRDDSq/NK1Jp1lMXfyYXWA/cjToWE4DiUtgVoVJqCHxnhjb1x8bU7bw
         SrBXJZulw7HFdZ9q4nrxg33/yg+pkHq8DElj4bH1eErYvGBsvyGRqoRBg/BJxXl+xjBv
         GG2I4W5Z33jYcNQNzjyeJCUPqdn6sib8pD9yTRbnvX460KpBam9bjD+JPMOEGzjvZ6nf
         o4vxuG9WgbBUKEZAE4zo3XyMV2sNJ4YE27TEBgmGHQYvVS8HP1q/UHiDjzvzma/dbY2E
         zyEK4HxMJfcSskw4r5otwN3RlIC56K/oN/CO4/BIjS6ktDsjTjnJPW0/UT0QH76rO/hS
         KIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342782; x=1773947582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+WYX3Zj+K5UHEFQ63KyrozjtWuzXXoe8px29Ibr494=;
        b=D2nKxVs7LeaZhz6JuPIds9fUxNrcg10I3Ju9kZJMxXVuV8B0oDtgwp+GQZ7Ca73r3O
         frZ2fbPlt5rvTG8vl1MZrUagVt19Oqq/nrjA/Z0+5lVpsDijZpdyoiqx9D/9qBfDuMQT
         2ldsvz2UWul0dx0GFCLsVE2VfIO9ZfTpGjuKq/RVUHID0SP4JIvQRtDD8HU4au1P77UY
         M12Cnjpzfh8hy/oBPmgo2/Rq0/3ypZ3TkG4YZvFfaEHxG0oCGEfX0nJYtwSpHKDV37lC
         zZnZ05p27w4A7rJ7UOVjMf6iZsu04OmqczUPjp4s3g1wlTZ/w9nN5+9F4llnLx1KlPa/
         KiPg==
X-Forwarded-Encrypted: i=1; AJvYcCWEtA8OtyAsajcTc/Mtnn67FQFeSU1Ne5GW7RdbhZfFI2LjAtLh8M/ojO1uSE53cGK42+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZifWsXwddp1xGN1VMRqqYwbYcT3tqKp1HBHEvGO8CsjmJd6f
	sYR8RanmgYPCUL1xF5s+ZkINZX7OwFYROQ4R+4vhioYjCqzc+GmU2E6XlFheIyH1NVPBbBEKJvT
	3zEpXyDKoRVxoAPRP0+yW5LoFfEHQvxo=
X-Gm-Gg: ATEYQzz1iDJNaAmZW1+vxo+bdKQZXaMI5HzD4qTdwByWhGv5ASOHQC+ueolrv5+OjP+
	ewqVafeWIMV3hBeoHgqJ7hqXb/2siFmo9be2bfiYIppfHifKw9CfWUYe2qT1gk7o8cUUlXIqNn+
	hg15Q1gxUmxgkdfWnxGYlPY/+LdQzz4HQzZ0kLzXgQBS/t8Zrusf3QjFCHIbGABo8eg39KYnyy4
	t9F1BpLnVFx0okbel1QmSp+r5pdZlBLlXZJx4g6zP7OlvoDbGJ4mQgrVmM56fQjfG5TmIL/wyet
	51WfWmda3EJTrM6N4Ge4Uio7dmHiAg3JBPV8lQoBOW2cp43oGU9qCVl1eKGyzN4s9utVr4oTaUb
	UmWd1ts1QG54yjvztUTz9Sept5CK1SZG2Y6smLlWdCIbG4x1iNp+sOSnup+q/MV/atWfCvsvg4q
	HA9vPi
X-Received: by 2002:a05:6102:d87:b0:5ff:d299:6679 with SMTP id
 ada2fe7eead31-6020e56c4b6mr267388137.27.1773342782456; Thu, 12 Mar 2026
 12:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
 <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
 <xmqqms0dghgk.fsf@gitster.g> <CAOAgETN-UVtee5OjjcLE45sRxajCkgF3nipBqXpec4JjN8+vfw@mail.gmail.com>
 <xmqqwlzgev16.fsf@gitster.g> <CAOAgETOd7-vPpBK+8rhE-i_vpqw48gDBdc3QPm3xWOR4w3c7jw@mail.gmail.com>
 <xmqqsea4eujd.fsf@gitster.g>
In-Reply-To: <xmqqsea4eujd.fsf@gitster.g>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Fri, 13 Mar 2026 00:42:49 +0530
X-Gm-Features: AaiRm50-aKmIQ75HcO0Xp7RJEJxe76YEzVa8jioEB4sRy17UuWrkyMvmbHAWihQ
Message-ID: <CAOAgETMXbFVH=SLk5xHZ6uvO1BFpfP93WNRUn18uDzDzsbHfEw@mail.gmail.com>
Subject: Re: [PATCH v6] unpack-trees: suggesting 'git checkout -m' with its repercussions
To: Junio C Hamano <gitster@pobox.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> write:
> That wasn't what I meant, and you are still top-posting X-<.

Oh.. I understand now I mistakenly again used top-posting mail (-<
which is frustrating
I will use the recommended method only from now on. : )

On Fri, 13 Mar 2026 at 00:37, Junio C Hamano <gitster@pobox.com> wrote:
>
> Arsh Srivastava <arshsrivastava00@gmail.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> write:
> >> I wonder where this came from, as it is quite unusual to have a rephrased summary of what you respond to.
> >> Is this LLM-generated summary that was copied-and-pasted without much human brain effort?
> >> What is more usual is to quote the message you are responding to.
> >
> > Actually as suspicious as it looks the mail was written by me only and
> > I thought that each line was as important as other and
> > I wanted to reply to each point you mentioned
> > Sorry for shortening your response
> > next time I will make sure that I will make quotations direct.
>
> That wasn't what I meant, and you are still top-posting X-<.
