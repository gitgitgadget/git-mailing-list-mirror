Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108445;
	b=cjj4QbS1Skn6gYYWPuVEjyZsk8xZSvZfAaRTeCDija0tWer9eSGRcmBRQaOeyTQNoDyd
	 5b8w5T84oblk+KN1kiupC3tcwNTa2sP4PC+AjFOkGJsksAv4+9FtmLWdG8g+4EoET5UC5
	 Nm33CiK8cvwDAlsH0ZFJf97wrQ8wjUuLB2RRMhR9yangnw7JOzBy36j2hYs9r93DCguif
	 UU+3DmfpiGODeVvX0bSNbIrfpN0oxRKAbNm30Uu2rcg6fIPiQw1Lyv5ZnESuUbAzvyFQX
	 XWA4lUGb1Ee6XAe2+JO1Mh9agGT4mOHoUGMThzCM7Mtomw42kO+VHRimjpgvdDxcE5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:From:
	 In-Reply-To:Cc:Date:Message-Id:References:To:X-Mailer;
	bh=cmJ3ORsIxQD7hxXHTCa9FQqAcA+W84WyAcv7aLQ0frg=;
	b=gAxxrJpBFEvOpG35zrPG077LwwQ6MQ0AOAwb54Y7IkxtfhwazAe311NUPpx8hfDKev3A
	 RQWsUueXqaf4u/Mdhlt9rBZ0ok6yKZFMYSM7lTWo94l58QR/pB9dOUeoAIav+cnGERRGJ
	 y4X7MMHrOdu5UroC1P7wbv4K0sagCOfA0Elr1ZBxdxJozXbpTUqHndkDBtXIvxEIgRBhG
	 +m8l3Rluu9HoWuft0hgazmQTKB6Rh5HH//lMOTCYVeXJojBxkj2bjDl3aej7O8Go0cBlh
	 cCRkT3U83tjBn0BEPP5HUOR04g+pv9a92vYsmtKDNkXnoYeUldmQEMdFhMXoIS1wLbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ckDABJC6;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2A606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B2A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ckDABJC6
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f2b8cf037so354126985a.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793108444; x=1793713244; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cmJ3ORsIxQD7hxXHTCa9FQqAcA+W84WyAcv7aLQ0frg=;
        b=ckDABJC6uV+DFGyYuza1Lh+OKOZTUkrXhUlUsopSedYSXBiesx2viMCkHYfLCy3HiR
         owpzMPT5MYYnOIOUkml7umxRyX+bUPDIzyjUvCn0IzTSJ1dJDiaJT6ZIm9i6WkQmcZMZ
         G5JRGJ75Cf3n9UHvTNrNLLR+CPgWLQ/qlBTTdYMSe89YaPBPswlSl3dgkY6BXiulLLtl
         DGOR/FY+AW9KrSuMGMrCRp/+2tv4OGA00Y3NDktDrrJNyiCt4xQC2TBQEnHZ4onTuNyN
         K2G6fJ0GgnIyrvvRj1JMCuqjDsEZ+cv3zfT2KSVoUTuzKkntZhnPu70zs9mSdfAOYgbF
         CvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108444; x=1793713244;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cmJ3ORsIxQD7hxXHTCa9FQqAcA+W84WyAcv7aLQ0frg=;
        b=yZDVaHf6rWoGwc3FjTmi/IX8qM9GSUguqvgCS0z0CKErO+I62bPth1jKjH5+oTHuDy
         813XXeDQoAqs2ENUDejYdeDJx5BQ5skxlXEd/rFUVZB+RwPtgINJ1b1kMK1zjigVd+n1
         3Gl+4Byyxq6sohZvaABxWalKLyiOaB+3+INzoNz8iNz0ZeJHIb3EGsdrkCUBBFavoiqH
         5WJmXx/Vu+KEM3ObA2gncTq9/KKCrq2EEryQvmLfe5JwrYL8Xq6Q/jNvtx8Ep+DjvonF
         I/QkK1FZ/ZjbIISMSTWw1562HIOwEdOyrl+HAzYgM/PCus+XffxdCpDJ8R7RF96dGh0R
         Pj9A==
X-Forwarded-Encrypted: i=1; AKwUvBznFuGzwlxQZj1pW5cgRmUMULnyS2QO3kYpRbZeiKl8IyVKLhkyT51qEdMsxN7E7Gh9L9U=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0tfQpeXn5LLjO3jvLJWrJ0I+BQHU7O+Dpd04Hce6yu9tAQbJ/
	/06arxeGBo57MdNEx3fzjObY4CtiaKLX5zwQupKVsAT57938ZIUYBBFF
X-Gm-Gg: AYBFou24zig+m2DuwZW/jwynpemO82IBBS2THMMf8Rc6ibDFolmOOU16vqXVlAYsXTE
	XnHb/h1LV8i58byUtRiJIetE8ET9ZQ+mkbdY0qlwUtE458OyT7XDEFndU95IIbBxTPj0hPAAHDm
	vfc+3KBE0NngNlyy2+M3Pc07J3mCM3gmFE3mUi0WrH4edTQ9QoX4IJB+npfZYIE88pC1IutOVXM
	8PwzsUHe9bflUahgplcQCWIWyDjmTqQSzNbX0HmobzwJAx+Au4047rpD+W6D3m0GqxFP8M0bMln
	u0ZusnssBHsR2g5Gk9x3eQSZhud9iREJucEsq3bhFh85bDAtHXvioT1I9xnzns2wPwkNx9k++mr
	tx6wYt1Ybme8jWwm4Y6Plffo2lIFTgnCXwjdQ78JFsZwcfb6TNCf41kYBmhhV1omgAs6CyaF+3G
	RW37U/sODaugrT+p+aAUZ5qsrW8xnQokZgheRclSYaUihm/vorJLnX13/vS3SoSoqyW5ULahk8L
	Y6c2mf+91qXAXHIfP+0WjH2upmVcMMCoWuaKkGu+S7ytTqURxkhTlGYZjwVWgOFwM0N9akYaRFY
	K8zaQxGZq/zApXq43DiqJpKOM5GJfXUrZwwoTVazk2H1uomTPnYlXLgaqy1m/OojPhM27BWIZmg
	udvR1ktS8k5YY56xp5bxOAjQuSJQKitZkqwxjKIRumvIjpk7TYp0=
X-Received: by 2002:a05:620a:c4d:b0:93e:c12c:4408 with SMTP id af79cd13be357-940ef995984mr1581323385a.68.1793108444104;
        Tue, 27 Oct 2026 06:40:44 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b03e:6cb9:e8f7:7afe:bb4c:405d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a912d5sm979333885a.40.2026.10.27.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:40:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <xmqq1p9cv6tp.fsf@gitster.g>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Date: Tue, 27 Oct 2026 09:40:32 -0400
Message-Id: <C1614059-9903-4F95-8570-90EC5DEFAE8F@gmail.com>
References: <xmqq1p9cv6tp.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 26 oct. 2026 =C3=A0 11:07, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFHarald Nordgren <haraldnordgren@gmail.com> writes:
>=20
>>> It would certainly be nice to avoid creating lots of entries in the
>>> branch reflog when cherry-picking. I'm not sure what users would make of=

>>> us switching to a detached HEAD as some people seem to find it
>>> confusing; if we do decide to do that we should make sure we update "git=

>>> status" to explain what's happening. I'm more relaxed about changing
>>> "git am", but like you I normally detach HEAD first so maybe I'm not the=

>>> best person to ask about that.
>> I think that the fact that all of us have our tricks to work around
>> things is indicative of a real problem.
>> We should attack the root cause and simplify git so that even us would
>> prefer vanilla git.
>=20
> I do use and prefer vanilla Git as it was designed to work, though.

But you also workaround limitations in am by detaching ;)
which I think was Harald=E2=80=99s bigger point: let=E2=80=99s eliminate the=
 need for such.=20=
