Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642238;
	b=PqG6ilcdL6AYlKmIAm8ZURfuAIUY1ZNGhLVcz2drKwd9zq8U6fLOPAU6m2BdKNZfztcp
	 GPYcR1M8p0pOz8v+OnJOGXe58RZMp0frLD1W98vzfEJvqfP3EbH21sVTXOQbbUmDJRnsx
	 CP0O+rs8yfBwrRzaVHjvZ1ZVJs5iGQUeNEwSqH3Wqi5pwZubxpd9Nd/3+N9JocQvNIQVy
	 fAeQ9w+g+l0m9wItAVBsueQLspUTiu/tjyIG4SWQ9lucV/g0q2YPK7A4f6e2tucZ5j7ft
	 6nEf0mMiWDDOxe+ZwYLag3a4Qf/ssolgMVFDc3IBhHsQT4au04RBXwZbyVO5EIIhuQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GoGIJ7dz2bS+cHMuDShEAsNtzVqGuDPc5sQDaPLR6oA=;
	b=d+160CFJOI6v/ofvEyvJ3iKa9KbcbJFgIfHQCZI3O2J0iaBcgHjy0bcM01N9DlDPQkTl
	 Xje/l1YDzcN9/JEaSa85gjJ8PY7ULuy/3Rq44ZXM+ddg2bgrskJIsOaMFXaZygK0s9UNl
	 dVcw/ZaGtSH+K4aiGhPfRuLauOLSETcehGDp+ACn3pmtl3RNoUYpGLsSyjseBMbkm0QhH
	 UC9fta5BzvJDak1ldzDleDEVnnjjF3Pm6POiA08DOTrXnRNq9pNAEos4yn3RfwLx5Nwt4
	 OCPYGlC8VnINtJ+oIK1jaKvOLV+B6FhHJxqZFEsUsUaGLJt1NbOFguXBAYoVUq5qOTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=OYLIWJlE;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6425606D825
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 17:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6425606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=OYLIWJlE
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53669f7b518so42096861cf.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 09:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793642236; x=1794247036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GoGIJ7dz2bS+cHMuDShEAsNtzVqGuDPc5sQDaPLR6oA=;
        b=OYLIWJlEwg4eNXMyn3cIJui6J2hZOWmW7UB++q2pV2uo34tZESNNoZ6gnLXUzxz43j
         2mAxCIKCeeORliYIhYSGo8IfGrhoCIy1rKefj5m8EHrfhISMWHnFpQ1rVjzSB0EjHi2c
         MfjSvVZ1ejke0PyQM0JU+R72xQXkFzGI5e34K74ZI9v5WgQTXynki0gS/O/G7i5uy105
         4mVfUKigJaPRNqlFhrgp35pf2j7H78lbAnx96H2xYJ9KzkJ1dBim2G1vLj+8geh9M4xg
         Y2cf+CIRGNxS9jkgjmDKgj+nZnqOIe47LekgppsEDOJXhxqFe+K1XqCrCe1K7YKr9Vtz
         9obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642236; x=1794247036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GoGIJ7dz2bS+cHMuDShEAsNtzVqGuDPc5sQDaPLR6oA=;
        b=uJVGyzvxRqjuj5j3LEqHJaJ0HeEkpHDaWK7+K1O7K5XM8WiQDAvrYOcTNDciXfyN8a
         FFm5rPMZUOsun9oXN6M4lljRkjJEax8u3O4cMRKnRVQE2JFuJWJpST4R0iF1gLDz46ik
         3ekkdFBtA+OUXqG6pS8kL+nIESwURG195wGBP8c5R8V0o/zbeJVgMERvE6pGgiOk0+pz
         3hdYozxXocP8o6eyF2H/KFD9TuQQp6iJG++SU41I1Ktdq9Z1OSNcP330+LnVaIVMDFKX
         c/fLjG5+s7fwxC+xG03oyiibcPbcudAiVk99pPGj6HMoHj6Yu8jkEh/fkpTLYS/tHBo4
         mMUw==
X-Forwarded-Encrypted: i=1; AKwUvByU1C54COtT6c3AIQGq5Urg48pT+IjYjklM7ZJSM35Szr/FL7BMI+DZc6jjWKrl+y70yKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ySwCRMqvQT6vuuhyqrSc1VKPiCSvAoSYAFcs23KCliaB9Fj+j
	Z6w2Z/IWSyaVSm6Yg5//F94+S6mS0F+LVdYTM3UalWwS2am43V6k79fIfW29viXa9W8E6DZwuts
	pJr/yy0hx/z3C+BHzknQocgGAJN9Bvo5njxc21VFAKaRdU5OuAYmTJJHgta2hmj9T3nOmO4e4C+
	ANtMPdRxvHnVqx56CTe/XixFTolB56G3hrQC9YESJjhUofRLk=
X-Gm-Gg: AYBFou3nMyebRfXlZVQyYRuK5lgqSQjrNfiJ7F6JGt3JmVmshcTuJGQqEGwJ4opzZ4r
	w7h/ief1FznrvdeFgh7EyLwTnIkaaeJ3lvLwRFnLCYccLSsJgcrFj/hh6BTcNvGX2ctDhG0OrwR
	Wd4xmaxDPogpwfTOF8CxxDN5qbixH0B9P7DmMOWiFVaerNLzbw2iqMJelfa0nOS7TO+8F2dagYi
	PjX4iQmBPnaPa1SfTy55u0Nb2TcBs1r1iw+Is71c+Odh0hT7XNfTNN04ktXtZ4+9T6vNS3LzLzK
	/n5tnX4d7RoJOquRwzmxAOMi7XiDEzw52QRimG9R2K0haFKFhXK5OhiVts7qYMRGWFzXUSk8Gac
	/79uAjYmiJb75nxvE1iS3b6jyxUIQ8Jp3HjjN9P7T2qRKshoQsSSq2KNMyrg847TZOp12EziKTm
	L6rB/42gC/N7mv9slnOY7PG4dPt9B40iLR1/O3ji+y/l0esKfI+U8iHGip7Sq9IpqbZCXIQqXdR
	EuiyPVU2SkSHTchGNHpmiaOp5KxdtL3Sd2ShAVkXVBSVKTEox2SfUhbXBRv3zraEC55pS8LMi6A
	R0yPXyVA561tsrQc3F0QHUjloP5xL8UGMstf6NGa667308rbflV/t7qbYjNLUcJ/oGDixPwT6G6
	b6t+12IjpIdKhw4HECZjKUVSQxPpC7BFCzyErEv/K50JMX6O3CWh9Ov5N6MzzLOxVwb3lOdjE0W
	Yne0h64srwNqVJKbjLbRw2qfCgxtcrSfHZbxa9AgU7RjaQQo0DYuGGhEBcr9/7WXxuSDuL8JQ7J
	boWDKOuXCcdUoemCzSffH+n/aDTg+HU9B/UFXj7dxQ2O9A=
X-Received: by 2002:a05:622a:251b:b0:535:9686:b9e9 with SMTP id d75a77b69052e-542b405b6d7mr186585281cf.11.1793642236448;
        Mon, 02 Nov 2026 09:57:16 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f25fc2sm97468096d6.10.2026.11.02.09.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:57:15 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: phillip.wood123@gmail.com,
	git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH 1/2] worktree remove: refuse a worktree in the middle of a rebase or bisect
Date: Mon,  2 Nov 2026 12:57:07 -0500
Message-ID: <20261102175708.75996-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <bf554c5f-066c-4e58-a583-0f95aedecf95@gmail.com>
References: <bf554c5f-066c-4e58-a583-0f95aedecf95@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> Cherry picking or reverting a single commit that contains no new
> changes also looks clean, but there is still a cherry-pick operation
> in progress as CHERRY_PICK_HEAD exists.
[...]
> Fixing that case simply requires us to see if CHERRY_PICK_HEAD, or
> REVERT_HEAD exist.

Good catch. v4 will check for CHERRY_PICK_HEAD and REVERT_HEAD in the
worktree's $GIT_DIR as well as the sequencer directory, with a test for
a single empty cherry-pick.

>> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
>
> I'm not sure what I've done anything to help with this patch

You are right, your help was on the other patch. I will drop it here.

> A list of the conditions that require --force might make this section
> clearer.

Agreed. I will turn the `remove` description into a list of what makes
a worktree unclean (modified or untracked files, submodules, and an
operation in progress), and fix the "or" chains and "either" you
pointed out.

> If we're running a lot of consecutive commands in a worktree, it is
> clearer to use a subshell

Will do.

> I wonder how hard it would be to extend the "setup" test to create a
> branch that has conflicts when it is applied with am, cherry-pick, or
> rebase, so that we don't have to set up the conflicts in each test.

I will try that for v4. A branch that changes the same line as a
commit on top of "init" should give a conflict for all three.

Thanks for the review.

Jasper
