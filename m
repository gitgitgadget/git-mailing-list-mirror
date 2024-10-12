Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49243196D80
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728744173; cv=none; b=o3Wpn4sYCfBDw9pkQ46vJLiTzH5YWZ1M29mOQTk4pA1Mt3I5YQjd/ewKt+KKGYIouEa7E7Sw/sylMEqySg1XyH0gzyvD9a4D+1O1RTXgz5DWPgLR1YweMBCybJIYOkEsciShQ16I+Mx2jl2EvfhowOZ6qRYsrFLo+O4BQm2ngxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728744173; c=relaxed/simple;
	bh=R+baMk45voL0Iylu5yPjfcsUhEDL0QtFPVOiU5YtYGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOKrffM4+lWRiwj/pjSOWbN53jM8KwynKQwoTEZu4AFgnh8aAbIFMbrGl0vekNr+XvhE+8uFD3441lgaJmmT9WirXjb+DTCkvzse7BbXI8i1pLVDla22jeVQ+ujFcVf/txyM9Pk9AdNbZsjkjz7aPEON2ky7Z+eEi6JGSQv9Ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e28ff55468dso3039619276.2
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 07:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728744171; x=1729348971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+baMk45voL0Iylu5yPjfcsUhEDL0QtFPVOiU5YtYGE=;
        b=RS22BkxaeXeR8w1FZZWf5icCrvmhJiBFGxQzWDzznGN7hPiX5QE5UyhnPYBO6zdhgO
         zVt6gpdRquldia465M+wJDT7DYb6sWT/flipBmAAwjO3ZC/pFSgOyOloJdCY4+AIevJ3
         IU8Vj9p0v/Gc6o+Ey91N6eJXEqVj7Jy80snrthRh/KfoiaDtepVvBhFJ7BWZEeY3OLQA
         BkvN4UEAczIbNF69glBPw7HL+uI/qIbG2GkpGZDV7No6IVmnyaBWR+9oujXYo3Rf9AHZ
         MaVK2iN3Jvz2EamSoyYDlDi458KRTYCuZ321McpELRtqXyHZV866CRgtwIhHFaYuwkGm
         kA0Q==
X-Gm-Message-State: AOJu0YxnlOHcqx9RJnE/BvQ8sbQ0W1giXLKCny3eTqzy5t1CFUNrVPS7
	qdmusdyRUJdus+47VW1OexWzJSf/LQ0WaEWaj0YXrNJiXt/gHuqEpu+0n9lync8/DXsyqPyolfP
	LwD0EIroaXgmcT3v6JLkHSw53Xc2LHQ==
X-Google-Smtp-Source: AGHT+IEI/jHzgPzaFmrMhUbJLPhq0kQFuc/3gf/FY6eMru6hJvS3oU5+pCV8QqzpzjGXlS8GkjxGXOt7fbfMTQ+ZDqo=
X-Received: by 2002:a05:6902:1105:b0:e29:9ab:d39d with SMTP id
 3f1490d57ef6-e2919da0e7amr5314807276.24.1728744171239; Sat, 12 Oct 2024
 07:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <ZwoxHYD-e4qo7OyW@pks.im> <CAOO-Oz0+sOpF6YQHSu0ytCO5TL+Anpr1k_9vQx6hebr624WjMA@mail.gmail.com>
In-Reply-To: <CAOO-Oz0+sOpF6YQHSu0ytCO5TL+Anpr1k_9vQx6hebr624WjMA@mail.gmail.com>
From: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date: Sat, 12 Oct 2024 10:42:35 -0400
Message-ID: <CAOO-Oz3fTJDC8W6mF-bawn=+9-=s2hLiMDP=16C5DVYgw7cb_A@mail.gmail.com>
Subject: Re: git no longer builds on SunOS 5.10, a report
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 10:34=E2=80=AFAM Alejandro R. Sede=C3=B1o <asedeno@=
mit.edu>
wrote and gmail mangled:
> diff --git a/Makefile b/Makefile
> index 2dde1fd2b8..87c1f9e220 100644
> --- a/Makefile
> +++ b/Makefile
<snip>

resent as a whole patch via git send-email, since that was just sad.

-Alejandro
