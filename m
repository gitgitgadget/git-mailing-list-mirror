Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2C376
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070063; cv=none; b=gUssS20koqKtgyE3p+7VM0Go5BVDC89SXMzL9SI2VIB9jkXmD2Js8zvZ4YpclvB86fRIC0A6+rboRu8w8rdBQUMOtm7xUbVwe5rKsj5tpOxHIZAFsWX2X8zJSOIa/YgYbiC0STljCoTW7oKmR/C/thuhDmQGFIPi35v1N4QLKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070063; c=relaxed/simple;
	bh=TjVoGQjeRxpfhXPPYjFEtLlIeL8QVNDSl93wLr7TJBM=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=gcnt2+pBFX2J0Hf6Rz3SsGU+ZmEaAnxP6KGOFWIGQSbPqJGPAe4yyQ7UR5jboYKRu9Jr/mCee1gfscdcgkHo2Pcpkw7sBmpr7VeF170/hKE+2h9QELSM86RI70BeWM1E8nzKezor0+/PLPvghfIcp3yrOKpgrjSGNYWMjzRKpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KauNyTIL; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KauNyTIL"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-690ae5ce241so7713976d6.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 18:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711070060; x=1711674860; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ac1jm35jT8uBiGblg6AZhEeDacXjnGL8fIOrfm5DGX4=;
        b=KauNyTILfGvekANw4K5QgOPb0hNPuggr5ISINxK5jljg/JS5bInsPVyGebzt4WGerR
         66A5pLIYTLE3WMT+Wi4DASJUlC8ZN1nd0HAbzpe5xNij2gv/zgk3x1thqg/oo1bTFkkn
         J7iEAxIMPco7tgQI+iHDII1NeNiK6DihK3IReQ6MnMiQyQ7Oh3UhskMs1ImvVL0UXkOX
         OFfD96IezKHtSstSeJmkUr2Dl9Xon16yIyhuymfeHomWalSaxGM62q6g9Srh9okEfkdv
         1QSQ/BhzO4WtYwgglRbB7BiSkJpw70w/CPYgXnIiysFOpy2rW+QZnelrInlZb1KST9iL
         JHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711070060; x=1711674860;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac1jm35jT8uBiGblg6AZhEeDacXjnGL8fIOrfm5DGX4=;
        b=mHLEsBwER66D/Bsd8Yi2wfHxaYUKxgZDPOBXQDg/hm4bkcV+yT8d+EDdqvkptaKJIn
         mgRamC9oxYFwqpUUKirE38pb5QDGscQylLfZhF3h9rxI+CXtde9kJajpytkaiMHLu4an
         y1o0fKXbZYRjWGoVPyWcJfxirDaRIsMDe18ZjM/XZMvkOapycDkFyUmo4tzrmFccb41u
         ej3wC4fgDs83ikSGJQoWJm+MvlSn16F4muAS6jffXXbMt6wORgiJ27aWpGeKmChqHhq0
         /BmXOoP9f1TDvfV9OdkOj97YjXNXih+37YksDTVaPKHOL2FBKO+Nr+ZnteLAH9VsUklS
         oX6g==
X-Gm-Message-State: AOJu0YymhkmcTm5tBKGOtvdVSap+T63F0XsEZcF6IElgYbCs4hzjC8AD
	o1LKph8+p3inD9eNbcaG3wGLOhGWGHHTpsbVMnvlZu6CIjHCkEx5PkToHYWm
X-Google-Smtp-Source: AGHT+IHxRRDiRZdDh7jyc6/r/WcmTDJZx0i/N1DMTtk9Gcs0BpEbGV0clQxwrdhjBME6jN4zvAg4jw==
X-Received: by 2002:a05:6214:19c9:b0:690:cff7:bdd2 with SMTP id j9-20020a05621419c900b00690cff7bdd2mr971446qvc.47.1711070060366;
        Thu, 21 Mar 2024 18:14:20 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id f1-20020a0562141d2100b00690bf9548aasm517939qvd.108.2024.03.21.18.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 18:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqqwmpvbufw.fsf@gitster.g>
Cc: <git@vger.kernel.org>
Subject: Re: A note from the maintainer
Message-ID: <17bef1274bfb2614.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Fri, 22 Mar 2024 01:14:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



> "Brian Lyles" <brianmlyles@gmail.com> writes:
>=20
>>> I actually meant what I wrote.
>>>=20
>>> It is possible that the reason why your patch did not receive any
>>> response was because it was uninspiring, looked useless, and did not
>>> deserve anybody's attention.  But it is also possible that it was
>>> lost in the noise.
>>> ...
>> Thanks for the clarification. I do still think that a change in the
>> wording and tone of this section could help make the project appear more
>> friendly to new contributors. Phrases like "totally uninteresting",
>> "uninspiring", "looked useless", and "did not deserve anybody's
>> attention" are all fairly harsh sounding, even if sometimes true.
>=20
> You completely lost me.  How much harsh words are used before "But
> it is also possible" would not make the project sound less friendly
> at all.
>=20
> Let me try again.
>=20
> You see your patch was sent but did not receive any reaction.  You
> might start thinking: "hmm, perhaps my patch was so horrible" and
> you might think all the bad and harsh things about the quality of
> your patch.
>=20
> But do not let such thought stop you from pinging the thread again,
> because the quality of your patch may not at all be the reason why
> you did not receive any reaction.  It could be just people were
> swamped and your patch fell into cracks, and there was nothing wrong
> with it.

Ah, okay -- I think I am better understanding the intent vs. how I
(mis)interpreted it initially. My initial interpretation was more along
the lines of "there are two possibilities: Either it was uninteresting,
or it got missed". This re-phrasing reads more as "don't assume it was
uninteresting, it may have simply been missed". Both true, but the
latter reads better in my opinion.

Thank you for clarifying. I will let you decide if some updated wording
is warranted in future notes from the maintainer, or if I simply
interpreted things in a way that you do not think others would.

--=20
Thank you,
Brian Lyles
