Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4605513C80A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450959; cv=none; b=us6R2/YMwq/yJMXNl5ZVuOtRIJyIwNeoDoh4SW9qMk0TSMivmkxeYTtziB6+LJ9q/TsclV8Bq/sWO9/23MgaVP69WwJf07z6V198Mv9eAT3cbt/EU42Urgtio5B4qnmaY5pVnPYzk8IBdJczISzMcTy4meFLCDhKO3IcQSgnDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450959; c=relaxed/simple;
	bh=uFCNcKJHQ6/MUbeDXIPNWmLmbBac+bMuB7tg/paPjDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8gyw7UyXm5niCTxmdgLD3add+browUkhPy+To7FDeSiskssM2jlyQT+d5VctGwJNJESPafzcnv0JbuO7EbqishbOxzI5xeXr7pK1v0Xsg19jgVpzt2PGqDrQJ7Y2dAxMxTdpZw5ugNLHqKi9XCSL9s6l4jltIHt66XAItuYAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a2424ecb8so5247017b3.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 14:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450956; x=1718055756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3VFihwi5i6+98TvfKFeU82BXMGaLD4cTjo0wYv0glA=;
        b=tSup7vZOp3DSS0dTxTLvkPKX5tI2fXV4C5bzdvTYnfjI3FVe+mbKgnZ/jf6LXn84h3
         wgLNDuFxpcxZSje1wBpKYzEjCrTHSvT/U/yoPgRPf+K39D18qzQN2YvbqHjsYwNFlfaA
         d5KwVVm0HywsuG4injxBzbZ6DkUJtPMq6JhVMVYseiz38vjX9GvzCwsa1j/eMSEFb061
         lXLrvbWmoQeOuY+Mpmp8rSJW9N7kbiNLCSjwlevA51GzYhelCoWqNO5ZkVK2pcTjm+lA
         nl1ix5XoJB+CyK6x2Cw3OHz3fBj9HOJTwpDDTAmiud3gzpiHShP461nVLYswCNCsv0qy
         jjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgzWEFeXmhNHBdBndh0XT8WtmwAmkMpOELYau5zL4k6zOAv0S9gXIHn5DXYGzkSkgHmwRYfKABGaGHJAWhLHJhrWEM
X-Gm-Message-State: AOJu0YzPa/AQaUQpXHbtGrwfA8D4CFSZcqxlqtNqASzRtH14u13T2Fsm
	gNlXmtyc5emfcd/qdb6Yv7eDbf/1opY23Vpv0Fm36KeU+YpeXtk8RMv/FxQwToUvvOT4xdtziao
	vQ3/TZN7xHBuUBg8RBPapf1dB6fHM5LZV
X-Google-Smtp-Source: AGHT+IGkUHBTzxNigRF4vCcWHZVtibAqUKX4vqv/JOaan4BJ2YdIJMfgZXdcQEqDTpAKvVxhfnGOPJ2aJGsV6+iRR3M=
X-Received: by 2002:a81:830c:0:b0:627:dd68:7278 with SMTP id
 00721157ae682-62c796edc0amr100747427b3.19.1717450956284; Mon, 03 Jun 2024
 14:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq8qzl3mhg.fsf@gitster.g> <20240603200539.1473345-1-gitster@pobox.com>
 <20240603200539.1473345-3-gitster@pobox.com> <aa9ff9a4-d504-45c7-8b4e-9744bf0b93aa@gmail.com>
In-Reply-To: <aa9ff9a4-d504-45c7-8b4e-9744bf0b93aa@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 3 Jun 2024 17:42:25 -0400
Message-ID: <CAPig+cQGtgaz3czkg+Faj+CL_-TD0BdbEc1hg6eJuq_yZmvg9w@mail.gmail.com>
Subject: Re: [PATCH 2/3] ls-remote: introduce --branches and deprecate --heads
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 5:30=E2=80=AFPM Rub=C3=A9n Justo <rjusto@gmail.com> =
wrote:
> On Mon, Jun 03, 2024 at 01:05:38PM -0700, Junio C Hamano wrote:
> > +     if (unset) {
> > +             warning(_("'--no-heads' is deprecated; use '--no-branches=
' instead"));
>
> I wonder if this would be better:
>
>         warning(_("'%s' is deprecated; use '%s' instead"), '--no-heads', =
'--no-branches');

Unless there is a concrete plan to free up --heads to mean something
else in the future, I wonder why we need to warn about this at all,
especially since retaining the deprecated --heads alias in perpetuity
is effectively zero-cost for the Git maintainers, whereas adding this
warning potentially punishes users by making them do extra work for no
obvious reason.
