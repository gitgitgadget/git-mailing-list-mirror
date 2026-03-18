Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF0344052
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851780; cv=pass; b=BuY+uzh+Ln/TlBoH3u6Yjf/MHjVWLkBku9kLb9cWpOgsOQsaDxkK7r645WUbo9Fwk7ykh2K9vn9N5H+c3MRXBnGPICptQ//vMGO22nmM+S+neKDuPHwQpeT+0F9a7atEM8tk7UtXZ2DzYjkxgyrLuX5Xgsm2vgnGd2GszfSUkn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851780; c=relaxed/simple;
	bh=RsxYTuM1LZ+FWAujjWuTU1e0RxyT+fejORiSJGJ0sOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3eipmwCWZSz81FDVjaSw7Y6pnhvDcUQ8hbPiwvZ8hr91UtxfCTYZELaLVtjNfUY4th2Qix89195Fh67LBgyScjRmolebqZyhg6gK1oCyeJh6H17TSe24ApvKv1iq5DQVLtCpAW8ZbqFgzkTmWTANthaeomRa0G9FY5jyfUasFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTTuw+2a; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTTuw+2a"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c74244dc0b3so24577a12.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 09:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773851777; cv=none;
        d=google.com; s=arc-20240605;
        b=Zpe32rAtPV9LKcK4LxRMqnKJ6weS63sRY3vGcbPapPmq17HBiE9yWCP3L+DLETTdOr
         Lm6Jum0i67Vnv8qZBPPa+Fzp+FxNwWCeVj4e1gLUK0SqhW1Pw2bzVF4kuNT5SW+AOr2V
         HPhxemKGemwNktjNSfdpkqy6L3oe4HMRWy8crL/FMjeUuq93Cr1no4wjVsKuk/9CRYEQ
         jvb/THrTWdXm741eY/WusFGzOWFLSCQfjD66qdkm55/dfQyMR00Qn55ZApRjKULjeheR
         JQ4kAPGxnKEkTqiA9t9XKWSjIFIqEbs5RPZG5lPWk6b+WB6l+W+3FycjHPlCifI9BS0s
         JlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YPfspBPm8cJGlxvCBwPcphc/1t4ika1UHDyy6AGlhtQ=;
        fh=1ogrZAxdTD41i2O835yr4uS49lcb2Zjkjaqtl6MKxx0=;
        b=af9HTRS2pd46EnC4XaoFKLaBdS5Vwxr/BUifCVrHCTfWht03m1nl24P/4knocm23Pe
         Nqyf7QJBgb8ho9VfIHo7z7DCGSz7OVvf2DhWLUOtaxb9oG+70lMZRftFGZAxS9LFyJBX
         6uz23a3mMddcK2jVExUwrwFMen3fR+lJ0u0uQwrxJ36JnjSMHH9NtjMkQ8/prZ+2+JIe
         EXlWdvhcyo4mJSoZWgJobR7TnBe2xIVSHjyf1eal0eruKO9fDjjrZD1/BeC2UikUaPmT
         VCLkYIo33wDjpPhS2jKqyBKrbpSD/GQxt2n1P9JPgnIwtDEYrfAPBoXU5UiY9vjeK8KX
         BfiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851777; x=1774456577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPfspBPm8cJGlxvCBwPcphc/1t4ika1UHDyy6AGlhtQ=;
        b=lTTuw+2aw9aJSR8dokyAQ/adLCSyR7T+vu/jap4wZNyErrjFTI3KKq2sVb3CeEr4bV
         0GLfaAVgfeCM5LjhyJtKNCx0WaHs1Sg6bD/FAcpkhOxDt4okNebM7E0noY02BTLfG30/
         0LlzAPgTWy6jmqhwDJx5vafDouHiJafdjQuBwpkW/PndmBB8Zp4xzuuvIu3wDbtgCdaQ
         MbbtM+c3cH+HIMqgX2w83IQraAvV402JO4ZDME9S1wSTMKaVKdRvbD2YXFPVjCnx71X/
         7giO7GRm70MMjg5VevaPR2wHPwQC5OkAyKZhLrGjQZqXqSoimuJBmVYL8PL+UuKgoToS
         QEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851777; x=1774456577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YPfspBPm8cJGlxvCBwPcphc/1t4ika1UHDyy6AGlhtQ=;
        b=OXrCS6LQamaTa9Ns/QUAJS3974N2gqW/yKE7lz9fu3bPNdKfUFphV5VDLtlVmm0/8d
         tu2DXVKMacHMLU4IBnMY4Hn3TfH4h+jy+W5L2xluldVaFDu9ZWtFGk7tYaqdQ5tnlZrR
         qvmzN7N+FrjgP5QO1nOEwF0xDETBzVa1VFNd2gTizQmfF5dECPNQxH9c9FsKsTxqR9aH
         uC9oqervbGYGULGmdh6lgf23SCbIblWewTuJkdPKokPR2MKsG9ZmGdO5KZNTRTikQmMi
         Zlq7bJMfVE5vHqXVM2ymj7dOXm/dyNNr0TbGAjU+Az0y1XyD3ppPwB8vELam+dolob1K
         XGDw==
X-Forwarded-Encrypted: i=1; AJvYcCUKMR6oRx8ImsUwzFMNTcoo/K9oxs8vmVsV+T6f+/VoZWTuz9/42gT1S5deoObqDIDEf5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DWAZH8THK62kdgVRZ7jdQQm44xpJXEqv8FzJAxBgz1+yEfOW
	1FpxY/DyecuoprsihBNVjRFgZ2aE7/nV/Pv22k4Kp887DTaucd36oaaYyM6+pwUYANZWvCG/peA
	6okEc4rTrs+SVKugb67qtWzYodWceRP8ytA==
X-Gm-Gg: ATEYQzxZoxk/7PXV06pPXDp0IeobqAKDmNRwdvn/zraadfU+A/soUEiJTaMB8p+3NDI
	/j2C9VrM9sRUZqjtQzQOd6NyHM4S4tqhq+TFXMKQrym3GNgWb47M6VkvehVm8w0rU9z8RZJgaZJ
	QzUISxhSVcKAFH6WsYhbxO4dVOuhXFlcNc2/PYBwwpveVdPCH6zGRi/DtM2qvOx+IR/m1scKVCS
	vZtlkvB9MV4umfHNB5gJu43CJgUdQAfhVL73RZT9VqW4GlVEH7Itl2JF1nWsgPTJW+mFKIadnNq
	C9ZT7gpFZ49VI854pEwDJVaCChMLyBZ90kqs2dTDlCgUJYsBbueKgb25Wy44K2K0sJkHI93W10s
	2N6glzJCoZXskEZ/sofymcvhilA==
X-Received: by 2002:a05:6a21:1343:b0:39b:81bf:15ee with SMTP id
 adf61e73a8af0-39b99fc2bdbmr3702954637.35.1773851776983; Wed, 18 Mar 2026
 09:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldfql4hp.fsf@gitster.g> <CAPig+cTTgLVGPG99gsb19BeJVWS=VZCU4F-rjb25yHTAORWwzg@mail.gmail.com>
 <xmqqcy12l2ft.fsf@gitster.g>
In-Reply-To: <xmqqcy12l2ft.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 18 Mar 2026 12:36:04 -0400
X-Gm-Features: AaiRm50Edx-5SBFunB-A9kyUBvhHmVWGvP-8E7GQqkdehxnYjGjsleOsfEDhREY
Message-ID: <CALnO6CDNwa8Ez4Ug0f8zNyxF1n3C_j8mLRbH7wChVioNoC5QVw@mail.gmail.com>
Subject: Re: [PATCH] apply: fix new-style empty context line triggering
 incomplete-line check
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 2:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> >> +       test_when_finished "rm -f sample*-i patch patch-new target" &&
> >> +       (test_write_lines 1 2 3 "" 4 5 ) >sample-i &&
> >> +       (test_write_lines 1 2 3 "" 0 5 ) >sample2-i &&
> >
> > Curious. Why are the `test_write_line` invocations wrapped in parenthes=
es?
> >
> > Also, is the whitespace before the closing parenthesis intentional?
> >
> >>  test_expect_success 'incomplete context line (not an error)' '
> >>         (test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
> >>         (test_write_lines 1 2 3 0 5 && printf 6) >sample2-i &&
> >
> > Perhaps the parentheses in the new test were copied from some existing
> > test, such as this, which already used them for a legitimate reason?
>
> Yes, the existing one was concatenating output from two commands run
> in a row into a single redirection, so (grouping of the commands) in
> parentheses were justifiable.
>
> The new one does not have such a justification.  Thanks for
> noticing.

I think braces { test_writes lines =E2=80=A6 && printf =E2=80=A6 ; } would =
have
sufficed for the second example, and might be cheaper (avoiding the
extra process for the subshell, which we've been told is especially
expensive for Windows).

--=20
D. Ben Knoble
