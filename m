Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4830A2D
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191795; cv=none; b=j/hXiUx+hBGAN3ujHPkPmnY9cFmJgZnaLEvkbZ/S4lmNLUVW3RLxufZXsP/2NtqPLPa2IOQaolmQ0QWeYucUNCjJ3cOhxyEWY1JJYavpJJfEPytW3C071WUA9sE7NodIwffld8kdXLTq+H2daDUz/1gJKwGxSoMsOYSC49wGAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191795; c=relaxed/simple;
	bh=FXmZa8qL7h3OWGncFsVytg/f9Cuomtkw8FLyHvXVZLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAtaGEmOC8uF1+fkZ30WKPYlnQ+g3mEon0no1tKsPSR5FCRspGHkyWAecjPS216b/t6A/iLrtEoxpV+Kk7MusYdyEdS2sLHEY6HBvwvHMQ/I2+8EheojkE4LbmFHDh60Vw/illTZ/f6UlVq2q5HlVZj8HvBMz3JCZcKJF5YiRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb3a412136so5290126d6.1
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 22:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728191792; x=1728796592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq5wl4SG7BUhGe+Ocb63IADID6I6eWRdlYkmdR7+/nc=;
        b=TgndkUE11dmWufWbgWiMfpbSBA666iYp+iCXJobxWG1Bwq3MO8g7xsmDg+lUIur1Oj
         bRbQsDqU5Q+BpPk3Cp0Bh8K+m3uxmQ0rOnlrk3x2rvoqKbwrR+I8Cfyf3nnO2Igmg9jS
         FbFxGej+akmHxEl9Fv03WJSsHjiuiI8oKIHZtEDidLsmQKgJfeYatEl5QqvjSLq/xnT0
         SQXlmUZTJ1bTgM3TVaQMTlLpDShUYX3uBB9ClvDp0QX68RZyM6RNyKeupVziRnhgvlO3
         TMMVTQJ1uCSS46WvzoZWrZTWyXi/QlbMvINdUt95gErOQr8QpjvWG1QL2/eRnL2m6yUu
         oZ4g==
X-Gm-Message-State: AOJu0YwVtayPpNxOIkwujP4/gCI+O0HTgy9dcpUdDV0ApYOdJBm18ERt
	Jr0YkpJoTOEEDF7KDYhoSfjcxFG2vfYwoHcyH+H1FXkozzC05qbTsx2C+MrfusZEkkfO0U9nKSX
	s1i0dfi5jULNHjITi1XUFMDLDZWbqNw==
X-Google-Smtp-Source: AGHT+IGHjEvgrEdmp5XTVi3F5O+ErUfipe/sryw/1/dHnctvPwGgk4BR7hiMYK7fZM1Zi8Qt7CgctvnCJLvRNPMbCro=
X-Received: by 2002:a05:6214:5011:b0:6c3:662f:8e09 with SMTP id
 6a1803df08f44-6cb9a4f34b0mr61300566d6.9.1728191792557; Sat, 05 Oct 2024
 22:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com>
 <zKUnWY8u1SJNeS4oLK85znjacgYJJeN8HefenwaJ9B9Q1YrQAumpAxWos4svaawkTfQZ_HaS3yp6WrOQQI7yt3ZO0UMCfkM0lJDDnMD-Lno=@pm.me>
 <CAPig+cT6LALKjEappB7QkB7oc88NyMcr40T_qJGL2mPA77K7XQ@mail.gmail.com>
In-Reply-To: <CAPig+cT6LALKjEappB7QkB7oc88NyMcr40T_qJGL2mPA77K7XQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 01:16:21 -0400
Message-ID: <CAPig+cT7CEnb6cQmAOMbD82wxkg=7T0MMW=QNUSPU62a0rEGLA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:14=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
> I noticed the whitespace-damage just by visual inspection as I quickly
> scanned my eyes over the patches. For instance, in patch [1/4], I see:
>
>     + struct strbuf backlink =3D STRBUF_INIT;
>        struct strbuf gitd
>     ir =3D STRBUF_INIT;
>
> The "gitdir" variable got split.

Maybe "whitespace-damaged" was the wrong terminology. They are
incorrectly wrapped/line-split.
