Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70806AB88
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUfhWfJN"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cd84c5442cso1300563a12.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703156894; x=1703761694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQGJBl74jrBAFbkGmP9jf7yGjp8IYxpiEAFfV6lVjys=;
        b=eUfhWfJNAUMXewg8rspxWybPwZkY9uRSdo7hgt0ZtZjxKnYT4+37ndHUde8fH6vfZ/
         1JSmD/4eas7+CGnHQLTyu7sGZMDYr5J3DPEkzHN0A2YZUIYf1yiNzQCeMQHt18lB1a+T
         UV6Hng1NJjgFYVPy0jM43dvm0I3NQtIzTeeWFwrBglNADOGhQkzrmY8xYxuAt1EyQrV4
         fBnkjHpOt7apl/Sic45GelvTeyXknNxao/RD4sQtX9SCmqljBcGssglpPIsUP5W7HCAj
         DwNnvWw+FaiT1u5nC4KDPAPsvQusX+gTrUPSFHuRGbO49QF1r8R5kJPrWgVuApNxDfAg
         +Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703156894; x=1703761694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQGJBl74jrBAFbkGmP9jf7yGjp8IYxpiEAFfV6lVjys=;
        b=f2dOS37NzG1jasETcmhYTenDdqrEBrzWlqhXjYr00fq2OQWFA1atYLjrBbKMJsOBtA
         K+GfEfrdKU4mLCntITpOaSzkwwfDVwE0OpGpJOm5S2m1/7IULCeV25gs7GvCxLBjFfvc
         CYOZ9lVC8BN3Sc1D5OAQBfdYa3JZeHtwAR+qKdq3lsOygbLdCw2XtAn47YqeY+MIPidZ
         xe7/Ktj44bVuEAG8Mmf2F9s/yI24u/wHV/YMCk6LHoatEeef2TthhlMEiVt4DsLdffGp
         n9Gb1SB4zjAYo6tyszmqwAwFnB2fCnRIvDJJbCTS8fzoFTiEH6/m9mrdBIdVCI0FQ+Cd
         dfEQ==
X-Gm-Message-State: AOJu0YxusC/NeXa66sGpinHuIQd+Ub2Fyg/2zgOAPvEliHjF0lbI3Kiw
	GqvDM9ZGYNOffvA3dNt5NEhYNqilx1pJHHsoOiw=
X-Google-Smtp-Source: AGHT+IFwRj7rlmAEg55sIubbl73i0/u6DO7mtq6u3XcCUWd88EphNfrk/qos0ziTg3OSMitaLD3RaKzuy41Iv2MhK9Q=
X-Received: by 2002:a17:90a:c092:b0:28b:e7fc:5060 with SMTP id
 o18-20020a17090ac09200b0028be7fc5060mr624043pjs.11.1703156893932; Thu, 21 Dec
 2023 03:08:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700549493.git.ps@pks.im>
In-Reply-To: <cover.1700549493.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 21 Dec 2023 12:08:02 +0100
Message-ID: <CAOw_e7ZJ1HRw1VkB0r65NWrd9DGrKpJ+FiAGUUpPQpXwZvDW-A@mail.gmail.com>
Subject: Re: [PATCH 0/8] reftable: small set of fixes
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 8:07=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> It's a bit unfortunate that we don't yet have good test coverage as
> there are no end-to-end tests, and most of the changes I did are not
> easily testable in unit tests. So until the reftable backend gets
..
>   reftable/stack: perform auto-compaction with transactional interface

you can test autocompaction more precisely using the stats
in reftable_compaction_stats. See
https://github.com/hanwen/reftable/blob/master/stack_test.go#L126
for an example.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
