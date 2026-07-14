Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C933DDDB8
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784068076; cv=pass; b=PxF8T61u8GvyyMoRjfbU9YkS6cfMDGfElwM7zND4MZsCCf0ee4rtpqL98HFOR7S8zjeKwIljsY1jy2/YPv//L1YdOwZqp2ImCaYKjJldBItnU4DROQgKoXhn+ykorJUwia62LpMTHBy0VekoE7FAKsNbbMa59kVQ33Qa3gB33b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784068076; c=relaxed/simple;
	bh=tWgcwoa0PeNl0RVxjbnPKw+bDiXk5wOEJyWKDfKZuyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKOmfr/Clf7vB+z4apqDpC5OcRiOI/gL6ai/LgryaqpNFtUbWSHpxDgEUMvlKe4/JQNoeyVKdAJasQGfXvgL23szfld7Me288MMrrl3OdjMvQDV5C7S4lpBqx3xeJc8I3/bCC69xSWWQHbBelNSklWDvELwrOJzL6tR1b1nGd20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oqKfRixq; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqKfRixq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cea3004256so48434875ad.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784068075; cv=none;
        d=google.com; s=arc-20260327;
        b=GQWwLOIOw5m4IGTKEWc9XFw20HaGN6S65zAxAc/F0JSfsDnjH0dRfdHi7uywBMFxsZ
         bGwxdVdgS6MKX12cdzGMheiK7JAO0PF02qh8yObgODEOGwSyIgj/mlwxvSRMJtWOLA+Y
         S5L1V7WIZT6mtDyN+u0DCXIZsSF+rxDzJlAmtSmTn/QO5iddd/QLaFhaVmlzOSXnJLvr
         VnB78ruxacsjESX9vdJDi8Lm+3c+zp0eJIVCAoACCInjuSf84TmrGwOqheGTCaK4OGpb
         CAdDEt8DH+V8WwqKji1U4YA9L/Q+SoRTtPxP12azQzxKu0WO/kU+bJAnxrviPEpQAjxG
         /xow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rj6XEy2gJhZ6AmyqGMNIT579RmnEGkxbySUZNmAerMg=;
        fh=zfYzhb1CUnkKZxf/OmEce15rkvzvF9nSMVqpcHq6518=;
        b=K5ZyV1NDAr6lp1NIq1UNLXNmlDDJ4a5HrPLIfANaaZY2YAfpjM4B9mPJ9smffTIVHR
         C6hV9M7UOLvRG/+O2++oMxIw5rbrDbq/sJcK77DQ6mRrJeHO58QK8jL5RqJIrK5PiqcB
         3TVTv++cDiJFPNPD2U2PzHWfLDaIrATqhHce7XHza+ePYZF3CE78sUa+n29seUD/myss
         xPoCdAY2EFlSyeJ5C5M20Fsc0G2vgN03N6bFU4qe6yYWoTg/G9RcU0VfHhOTsWXnZf3O
         8hB86fiMSo5Pz7nnGtMb6w8gkeZOnbk2eX2wgY9RDdlGn00cIk+SVONv1CsMXh837L7R
         Tj+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784068075; x=1784672875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rj6XEy2gJhZ6AmyqGMNIT579RmnEGkxbySUZNmAerMg=;
        b=oqKfRixqV6XkA0f6TwPR52AlVO/g8DHOYSv/CgTdGYaVcJdCe5MMVM4tfPAoPTDsC5
         9q9KcZj+VWwac6IRySRveU/4uRGh3AnGZq8hx+f5f3DIqq4WX/vm5IDvwKEctipct1fx
         lcCgKCLYxntJg1MbPEGWg6XrMNXQkt5+CTazS0b4kmWqb6+ILehPhmJrLq1Z0lJwIRi4
         WRou4boSV91YI/yGeV6z2ZX7HgcJkCaIJ/6pTHpCIIPnyTUzfCUXydUY96iO/ynx1jps
         LY1nGPsrHih9fwtKPhdgrj1WpXQFxnsLJq2811wZfbGg2xI60lSTHC1Q/xYCPOPWs2I6
         yVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784068075; x=1784672875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rj6XEy2gJhZ6AmyqGMNIT579RmnEGkxbySUZNmAerMg=;
        b=mVoG5sUs9DRsAOrxOcL/GpGzveAR++5Dqe5KOvH9yiRPU5ax7HvndD/IWBlU2W1SSM
         +9ksiCUgYFmnvXB1CYLhR3LWnKzEChO2sQWxV7STHPI7DCJLikOoTaYRV/bjMrJPFO92
         cY1zJi2hPRDWrELn7ptNfRPXNPYEnXbAegQZ6zrMt7q7s93rb6wgLB3AMRnGHeTakPQW
         VjAVCvkpHn/4H8moq2uTV8ke89WdkA+jAvWGuR0UYAWLAxqSZrxt+uh5t9alBn+HeqCz
         OyxkYM8qhKnbwyX5y3tvY9WMBgOw1qUdhDs+k9toOQgGzrA5TsoU8gHpdc+6GJXaJSeH
         p13A==
X-Gm-Message-State: AOJu0YzDjkDGUe5fQkSTq98MnZgvV1nPAuh8OyC21qvtjO5SeyjzDKv7
	oQ8pTQ31AhVrO3tQJTEwE4130TgYSCZHI6TDqRHd317TNbPPcS5dxOmBmMrrEc8yz7zNQnNhmJT
	nQ+BNpGZW+kFZd10C6jNB74KfTi2VPPM=
X-Gm-Gg: AfdE7clNIvExNBnV0GQx6Ro4BJO2kX4Gmo2TiAZjWGmIHPzhUT2Wgqy56KRLteT8MEU
	jqvjGEPyqNAN5v7gJpoUgDU8GHPy+OX3hxX0vyGC1UDiyR5mSjSND9EDrDuIa03idlK4r4R7hI8
	1YV7CLGsOlI33GN2qyHXtrInWy+5L9XHjSdFoMiTS9gUKzeREwwOqZJYQ7NoEX3LAUFRNt2oz16
	GPJR2EccT8O4lVV+eDpOfSa6HqyOxQZTeIk78cNLjXQ4jzT5FLPLlfSjXjPIKeX88M2fjaCPSpl
	0wcz9rFswBA0Y3OrY5SEE2d21nt9idFjU/LQv5lqyCntudc63GUaAFYpsQpMdkwKmHQWCzUVYH5
	AQxBXf2F5qJRW3+8psTshlZRjWm+J4abBB1I/Qqe8gj51/gg=
X-Received: by 2002:a17:903:354b:b0:2c9:de53:f84f with SMTP id
 d9443c01a7336-2cef1364884mr48681165ad.19.1784068074588; Tue, 14 Jul 2026
 15:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MA0PR01MB9857F8757F67BD2F8FF358CF97F92@MA0PR01MB9857.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <MA0PR01MB9857F8757F67BD2F8FF358CF97F92@MA0PR01MB9857.INDPRD01.PROD.OUTLOOK.COM>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 14 Jul 2026 18:27:42 -0400
X-Gm-Features: AUfX_mxo-m-3BeSp_zFMdmmToBAtRT1Dsfs4ScU9I-tTj5LogTdPV8UYTX5Olls
Message-ID: <CALnO6CBFSY9Zj34q-P9NQwvMrJiPzS9caP2qjB5KCW3aQYz0hg@mail.gmail.com>
Subject: Re: local mistake - need help in recover
To: "Kishore N.S" <n.s.kishore@cctech.co.in>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Le 14 juil. 2026 =C3=A0 00:06, N.S Kishore <n.s.kishore@cctech.co.in> a =
=C3=A9crit :
> =EF=BB=BF
> Hi Team,
> Need help to recover files from local mistake.
> Regards,
> Kishore N S.

> After merge (and/or related operations in the same session), staged files=
 disappeared from the index

I could only slightly reproduce the issue reported:

    git init foo && cd foo
    echo a >a && git add a && git commit -ma
    echo a >>a && git commit -am aa
    git switch -c b HEAD~
    echo b >b && git add b && git commit -mb
    echo b >>b && git add b
    echo b >>b

From here, =C2=AB git merge main =C2=BB refuses (=C2=AB Your local changes =
to the
following files would be overwritten by merge =C2=BB). With autostash mode,
the merge succeeds, but the staged line of b is now unstaged. The
working tree contents were not lost, though.

In retrospect, I didn=E2=80=99t try with new files on the side branch.

Test performed with Git 2.53.0 and repeated with
2.55.0.rc0.738.g0c8ab3ebcc.dirty.
