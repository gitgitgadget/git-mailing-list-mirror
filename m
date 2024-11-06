Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6B2F50
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730869680; cv=none; b=O9+b9KlnKyW9u6rGhzjnMZv6VB6CKXhnn0vSnNn4dwj+6I34StP2YVHtgI0LtKTbDSq5ZJ0tI2KIuHrtWFYefyXLeoauHHrwXuGXTnqfzwiDEVWZT5yvhYlfwd5qujN3e7hAebKC5taRZ6DUBMGO8HYWfzbVU9Mne1Feec+hp4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730869680; c=relaxed/simple;
	bh=2WRMrueMQRoOcXusYtic+X5iA03dwNcM81AU2YEe9Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAmQGPU1s6El6jdqrAF6ZEGVZclUqhFch+aRoZ5+tdSb3Kms7zmoWA8W8QWRySMPejRg0ap7oHWLA8tAC7ATK2BlEvVOuZr4Wfeb/O8euzwua4uxjqaWtAa75VZeqxv1hTJn0msrA6jg+u5LK+TyIWIrwPC+aAI/cKFV+ds5D9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsLf8mUy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsLf8mUy"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso4209291f8f.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 21:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730869677; x=1731474477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU+j3LXZ6CLvvmSX2mx6dnbVRGGn4goHidKQlwsZnlI=;
        b=JsLf8mUyj+vhGbJCVkNfrFzAV38+SQA+LtJA/fRlgHvDHlrvkTGeQScaCJyXcrNtDs
         ZL7vcQgKDCXQdnsP9hhkOnCUyyorQZRxRR2kMTIs6dqiJGhqAFR0FKcSobwdz1u/zFSN
         DWbCc4GBR7BAsEMXWtU+LE9Gw9A8pFzbm5jCq97ng9dCt1H1cR1BPHFB9grL0psN+GmH
         6ygiPeVcWYmU8g5KYbEzGN4O9k+6sbhI9fwKZB0od0LdgqJZ02W7pW7tg5x6pqyWzs2b
         XFviPIm/lrXw+BkweycsPQzaRktfMNC4CZD2nZzJky6kS81R5yLVkEZ2pFYF7UBi1C+9
         n4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730869677; x=1731474477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AU+j3LXZ6CLvvmSX2mx6dnbVRGGn4goHidKQlwsZnlI=;
        b=jfh6qfaX05ZfwZFXJIwcGijPzsaOgXoIwJ/MLTqo30v9+oQ8ERSJlRRnsZqL0mo6oQ
         aYgpPwzG+qUvHch9E8Vf/Rtox0NcmZX0JuSacJ2gCKph7aWJo0ezMHqcMtWppdDnLyY9
         yYfXqu2yzYSqhC2OBDRIjfQIVl6RgvXsg8IbkCLYr6DpW0orxP+qEDwsWbUIkITMJRu1
         W1nM+gFwiDqEq02IJY60iqq6qb+IbC8wd2Zd1dXTxI7Lzl4AAdJZHIpQ/jR6N5EoRZ3i
         Jt/XgM9+9Ff/JVFFauDalvmyXjE4qgFCC9XFyPcZu44C1WH/uEtM8K+gtw0Ncgvr/iyI
         gfnA==
X-Gm-Message-State: AOJu0YywKm3MF5KPHujvVWRJm9kVvWxKcOW2788cfV24jp5ZOwMxWpah
	EKUAiIqQqZJWGSC7hy6QXdU2+lkPn/dom1zRQV1lLGhR4LsGeYgEDELhUJHDMJtVMtP/o8DnDqu
	A/PoajDwZWJA4j+KHpAiFNmD2WuS6mQjfxlQzNw==
X-Google-Smtp-Source: AGHT+IGAtFyQ27EQplxb1n8E3ZR+tLHa+GrxIK2TTVi1VbheYsqYagJo73L5Djs+nToYhL3I++hC6/2njbZkgKcyEoY=
X-Received: by 2002:adf:f305:0:b0:37c:cdb6:6a9e with SMTP id
 ffacd0b85a97d-380610f2ed0mr26741243f8f.9.1730869676643; Tue, 05 Nov 2024
 21:07:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH1CY-=FtMTSisCmcz7ovciPomXYBogjNCmqO1mEjN9H6zEfgQ@mail.gmail.com>
 <xmqqses5qis5.fsf@gitster.g>
In-Reply-To: <xmqqses5qis5.fsf@gitster.g>
From: =?UTF-8?B?5Y+25b+X5pmf?= <yzs981130@gmail.com>
Date: Wed, 6 Nov 2024 13:07:45 +0800
Message-ID: <CAH1CY-kD1MhuuVW8UqkJeiFZkgv2zDBXb1u6q3DLNbUs4R6zXg@mail.gmail.com>
Subject: Re: [Question] How to force relative path output when using `git
 status --porcelain=2 -z`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thank you for the quick response! That is exactly what I have encountered.

I understand that it is highly probable that the result of `git status
--porcelain=3D2` is unexpected, and it may not be fixed due to
consistency.

Thanks a lot!


Junio C Hamano <gitster@pobox.com> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=B8=89 08:59=E5=86=99=E9=81=93=EF=BC=9A
>
> =E5=8F=B6=E5=BF=97=E6=99=9F <yzs981130@gmail.com> writes:
>
> > I am experiencing a problem when parsing the results of `git status`.
> > My primary goal is to parse the output of `git status`
> > programmatically, so I am trying to parse the result of `git status
> > --porcelain=3D2 -z`.
>
> Interesting finding.  Here is what I tried in my working tree, where
> I have a few cruft files left at the top, and ran these commands
> inside the 't/' subdirectory:
>
>     $ git status --porcelain=3D1
>     ?? +ps8-v2-reftable-iterator-reuse
>     ?? :runme.sh
>     : git t/master; git status --porcelain=3D2
>     ? ../+ps8-v2-reftable-iterator-reuse
>     ? ../:runme.sh
>     : git t/master; git status --porcelain=3D1 -z | tr '\0' '\n'
>     ?? +ps8-v2-reftable-iterator-reuse
>     ?? :runme.sh
>     : git t/master; git status --porcelain=3D2 -z | tr '\0' '\n'
>     ? +ps8-v2-reftable-iterator-reuse
>     ? :runme.sh
>
> I haven't dug into the history to see if these inconsistencies in
> behaviour are deliberate, but I somehow suspect that the output from
> "--porcelain=3D2" without "-z" is mistaken.  As the porcelain output
> is designed to be machine parseable with or without "-z" (and the
> reader of the output, the implementation of a Porcelain command, is
> responsible for turning it into relative if it prefers), it would be
> a mistake to turn relative output on based on the lack of "-z".
>
> Not that we can "fix" the output from "--porcelain=3D2" at this point.
> To changge them to uniformly show absolute (or relative for that
> matter), we'd need "--porcelain=3D3" to preserve these inconsistency
> output because it is very certain that existing users and scripts
> already rely on it.
>
> Thanks.



--=20


=E5=BF=97=E6=99=9F =E5=8F=B6
yezhisheng.com.cn
