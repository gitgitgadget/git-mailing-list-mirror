Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0525723184A
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072995; cv=none; b=M51/lBL1144Cvpa+7KE7YEW98gN4FIIzQe679XJf/3t+evdkWsWgRZeAyVR8dNJb6OKyXMlPNwAkA8alyVjg80TQhH/WvMkZSiepEk+7rqRLk31CCVy5SR7WwIEucAd9vR/oQm1i5sT6FED1Ltj81zu+xXTluUHRoyCOoEtNTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072995; c=relaxed/simple;
	bh=kSnOQctFWykAhWe2hidFCva/hNZEAAgfHq+Pd/H+20o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEd3O4iNUqKRJkrkEfU2X70288DoUxr62y0wM/8ic1Qn7UphoLt3TAgmAuvoR8wFN8HrPpaZXMSBXH1etfEkLtAxFE+ifLinwjD6rrJyfGxODcnD5YAxIv+G6B2OGOoGFJUt3C/A4G4NHBHQqpkGhqYk6DaWTAeFCrtFsxtrjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA+OcF5I; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA+OcF5I"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59b6c13b68dso195178e87.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 14:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770072992; x=1770677792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkhOqO0t7zdhefnIGn16faBn+XSis9X53YDFvawzP+Q=;
        b=lA+OcF5IPiOAtDMd/z2gOJvsGL0kCiJuNyG+GztG6QzOYf8q/vxb1SFzIjgvLwKQ2w
         Vmo1VpG/uib9qgSkX5vPtOvtSpxmWcvpVV9hUmY10qCBWNVGGCkgdr0qo2QKfNrKyUNg
         f53eBlL1acfrHa//VRBF1q/WgnWsQ+RaTypqepCSCpm6Ehf3AKSO1ODfRmZhvYAHTT40
         klUANT19ZPYKex4v4mU/WxZXLCxMtxKILNu3rjXw5OAtCoEiFQvwXY/LpD8S6IBxQMS5
         o+PN1JOk9BLakGDLF1Py2JDRiqfPrS3QPoEGMZiV35LenUXqT+X/a3liPl2FKNi34n9T
         TUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770072992; x=1770677792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AkhOqO0t7zdhefnIGn16faBn+XSis9X53YDFvawzP+Q=;
        b=Lgvc5r/OLYpbntb+68EAegidNMSl55hDHCyskI5DNLDWwl4dJy4AIjRMe9BqL6lg4Y
         CtJcvUUG5y3yCcecphl9Wf/wOcL4A8fEYjH0Uj50wiX9kvjocBTOqw/hsPOy7yETUYX+
         d9Q++alneNuRCWJNW5MsLcQBpdCXQLRwz1Un363TUfij1srS8faH2olGLn4nG7akc+q0
         ZC7hOTS0Il3qBB9YE3WkhE7kS+aJWjMbppxv8REr9iv00VCLEhM76jMw6VXclJ0wB6Ic
         Oy5nKZ9bUFV7OpKgBk1rJWGERulY+kTx5mMjVcCbvHn7MjSIWJcjpt22pQriWoJMnacb
         RKIA==
X-Gm-Message-State: AOJu0YwtfaTboejmLoSk3TLWV2wHeC0oi1I5/8PNnWw0MVXAPl3xev0F
	WinHmSkDur1kXFUUhLKQ1tjYkVNlvQJtds5ifpmRybUPK7PzIZ2JD2T+31CIXg==
X-Gm-Gg: AZuq6aL7hWS5AYzwcOjUflLSgMpokos+8mpmgdUnEmo017GHuSG+3OUyDjH+0yxoKkJ
	G/sBsa5TS/pwgxDzDvi611npYXlY0JlymL5OFBLYLR6whEoAZK6U9rdTg63DsKFlICNwHX2T+nt
	UxyLCKXL7LA/7fL2teZapcjw33tAQVeuhlbETTb+nCpIAolLbSv/EkOsuFWchLmY6VxCpFFhsAv
	XxquCXX35GnZrqis99g7VZOAoFJsV1AJ2/DUJQDNlV/As5o9iVkGlfaRaL8TJZjQGe+ilh6AP4s
	QxONRRljKkjIUyxCnqQFgPMSybeBKV5ylht4u2Za53AgOjtgz4xPLNUe8sT81ZnYchDF501jxIs
	LimtHiaHq1a74yiZ/m2LpBDYKFejThmyYKQQ+B3aw2DpwQtSpaw2oMPC2ker8MjmJ9hFOL2gZHP
	3ihstxpdNBxHLwj8vVcA8fRR9pvtO8s1PoFMjtnqnf9N+xzthZY5NuWbphgLJRC+j+pJ7hzFk=
X-Received: by 2002:a05:6512:33d1:b0:59e:a46:ebdf with SMTP id 2adb3069b0e04-59e316e2fdbmr325009e87.11.1770072992066;
        Mon, 02 Feb 2026 14:56:32 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bbe5fsm3696333e87.85.2026.02.02.14.56.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 14:56:31 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Mon,  2 Feb 2026 23:56:30 +0100
Message-ID: <20260202225630.12507-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqms1qx1kk.fsf@gitster.g>
References: <xmqqms1qx1kk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> But for that kind of "I go there to see, but I never modify anything
> there let alone committing to it" usage, detached HEAD is exactly
> the tool invented for.  So while I can understand the allure of
> always having my local 'main' be at the 'main' at the remote, I no
> longer see this as a "must have, somebody would die unless we add
> it" kind of thing anymore, even though I think it may be a nice
> thing to have for some people.

This makes a lot of sense 👍


Harald
