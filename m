Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA91F9F5C
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899860; cv=none; b=XJYSVOGJjQX+N+kktf4AZ5sRbO1zp+V6tGsGF8wNG9M4O0/ZKIg9vHTH8Mbsdxo1ElU06gB+tcRpoUG6NDGlx9kNnwAPtOZupwky36EDApRDOZYGUYQPgWBO04lEYIeHAl9fW/TQoCPBt7UYiXjmGrgE9vknOBVEGgYJYp6hXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899860; c=relaxed/simple;
	bh=wtVoxFuGbRz1Ix9I6yoJmTegTbzZ56F/14GpisQEhMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqgdLjQjje0RZwWk/o1GpbRQZDUo6Bgq7eMBQ4AzQnypeIGL1Rg+VgZh+AwFWe+9HRzTDezOzp+2fX0OH2tyCnoDd8lZ2hM3QhGgft6Giyagd2g1S0RbV18Av3tBAcEEPHu2RcNR1+8RPTpR3nEBO4kYTpHoB8V6W8G5EZ1yFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e4231ae149so9113296d6.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899858; x=1740504658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxpkUho6PLSxCV6nbpH6Gb/YL0d2G+mEzGN95u/h/dk=;
        b=I9zy+sPGTbR/cYGWBJoIoJIlFSMJ7NJ4vJVroATwYIetUIjJdYi+aFzdbDacxHWrtK
         i7yWY5W+PiGh5g+26M4EphRwqlEMumzfkAZQxS/QNT1UAi7VuXNTmop0vqSFNGOdZ3kl
         8QhEQQMpBTQAwKvRPaoyxcFJtEZGwWkjqJvotmHvnqC5X4RUx4zb6KCQ2PM6K3cglye9
         ofHr5hqh7IxC+A5wFSMZqNsiEd4MIq3r2okppUa9Mr7OPQYDQd9De30nzxzWgzu4NxAx
         V1L+2h+aqxLfPAejrn/l9GPegftxW+o4WxXsdgaPdEuzWRXQ/a54fwH2Nr1+1zB+BU+W
         MthQ==
X-Gm-Message-State: AOJu0YxoFZ32w6dbTCjxQC9LVDhLg4Mlus4xdG/LE7RMzHzrhAH6jqHj
	0TWpP1W40055G1bk8ydzDHY/55ZNmPvS/9gkkYFfms0dyTnoYWX/AO+BGoWQmSEhyXOBYRc5YVk
	J/yGZY9JYYJA04Y3vaJIp2S1ft8A=
X-Gm-Gg: ASbGncsdqxYAkh050BrHlL9sJFL3XglksmwScs/bvcmk0AtEbsVnWHzeYGsZhe9LsSK
	M7qPwvBfbzmJcTSCN0mbnoJx4wWbhkUA7rkcybrrLERQFW0usIh0sH85K/IZVEgQH52KzfwRCTp
	nM/d/+xbrgyD4djq0can2673Kni/G57g==
X-Google-Smtp-Source: AGHT+IGlDPGjEuSakK2YjAAAfDffgEkgUH9TQHYrv84Btc6n/LGYkJd7MZ5MqZC7DhTCMHekO89E0vjmH7RFlIbJMGw=
X-Received: by 2002:a05:6214:f2d:b0:6e1:8300:54dd with SMTP id
 6a1803df08f44-6e66cc970f7mr79827266d6.3.1739899857827; Tue, 18 Feb 2025
 09:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211114611.9334-1-dhar61595@gmail.com> <20250218153537.16320-1-dhar61595@gmail.com>
In-Reply-To: <20250218153537.16320-1-dhar61595@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 18 Feb 2025 12:30:47 -0500
X-Gm-Features: AWEUYZmgl5_9uv3XQE2obB2-i_CREXhO75pXx0j7_4ioH2wbylcBnzRsT9c1xnQ
Message-ID: <CAPig+cStFE7r2-Kd-js_VHjuF5LGp+0Kniez61i1-Lus=gyVHQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] [PATCH v2 0/1] [GSOC 2025] [Newbie] userdiff: add
 built-in pattern for shell scripts
To: Moumita <dhar61595@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Atharva Raykar <raykar.ath@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 10:36=E2=80=AFAM Moumita <dhar61595@gmail.com> wrot=
e:
> The modifications that I made were -
> "^[ \t]*([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\([ \t]*\\)[ \t]*"  - so that is a=
llows foo() and foo ( ).
> "^[ \t]*([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\([ \t]*\\)[ \t]*(\\{|\\(|\\[\\[)"=
 - so that it recognises {, (, or [[ as function bodies

Regarding this last point, for completeness, I had meant to respond to
j6t's review of your patch by saying that, according to POSIX, a
function body can be any compound command, which means the body does
not need to be encased in braces. For instance, this works:

    $ foo() echo nothing
    $ foo
    nothing
    $

That said, I doubt that this usage is common, thus is probably not
worth worrying about.
