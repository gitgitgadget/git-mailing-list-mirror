Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD02494F0
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155227; cv=none; b=fanG5DW+hIpitBG/thfnAxz4UATGwSmvlALIYnK0eRyBI7PNEneJZq4mgHg0gdNN94iwBSPGO3UyLyIzUwT9uDkla1bVKiQl3u8siaX1Qh3rPYD42xU49QlfOzTjnaiBeVa0XmDC+hQsOTD/rO+F8h3UkTug2sfGrSkC/el9Sm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155227; c=relaxed/simple;
	bh=grPEyOzS36UQQH0M4qUUPbVigbwe6012nD9qR7hNO6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JD7UPENyFwpa8HLdqmSroIrNsp2MqM5tUUjT+ovd3KgpruLPufMbVTJNiSbzVcNXMmAn446Mzj1ac+zG1NTHvGlW3DaPd+CuQvBzny/h0xpxGcBjNuKErQmdwL0qfcWHUBi5FPzh2Q+vbmHtwUgdeQu9ejUa9u+J4I4DhGLtJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWxncdYw; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWxncdYw"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-596ba07504dso1707342e87.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 06:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766155223; x=1766760023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBKoA0ihCH9ol1NV+nOJSrMA7Le858XalDBa8mBEWlc=;
        b=GWxncdYw+oxbv8mromyR/b6+EBOftrM9hq035hy6cAIPiEUkNeC0U5szMN1uu242Bt
         hezS0srmidK7z35DLRcX4CKa/ixeCW7ILh6kEwdFuMFxm3gISYx76LLQdMPcOqC/A2F+
         3oR7Pupmh075HpTn1nbgB+b/xPQYBWht0MgrvyV8wBh+aO3SsgSqZkz8KrzID6INHK4a
         XCOI87vHMwU/+BdhB5TS4aWugxh7MmLRYO4VTinVSku9xJqGhWwxLebVcYmKpPMBcxQk
         G4T1Zw0nYSCryL8bKYy7llMNDuV4F52bLlSTi4mVHwoTKxF11h4Q6vqMwjjHTDv74wE+
         M2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766155223; x=1766760023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBKoA0ihCH9ol1NV+nOJSrMA7Le858XalDBa8mBEWlc=;
        b=odE3xuLLvT+vE4IRbF4J+jHftLqFwF5loSaHmKAF0ZSeX/6M3q27446I/zZxuyecpe
         gR3sQV1FzILn4KMD4djNW2SWAWA6oVHFl8eIcqhB2ddLNlYM4JhYURBukSXqOAUiN7QM
         uWP2v8osCpKL9T5bpyJjIIcYpIQxPvXjhnUbFMMfiTBDtDu2hNU7EeGsUqk4dqclX9BW
         sAQ6TTkrn8u7oEYT1zVxAX3hO+9m8iWsuzmJ0cznUNjI0/vv/PDXACbkGZv0hGCkI9WJ
         B/g5YnKZc05wu4NEmbvVEotUMBfCVr3bp1XfA4mQcowjQqOeGetl8cYHhVPnEx56jGdM
         z5+A==
X-Forwarded-Encrypted: i=1; AJvYcCVIwDvCdzgXk5k/68OvDD1TbZrcBwRtkDA726FyBLCymlwOQzWEnbDZaAKKci9PP7IKTzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBWyQfnj3+zg/dK3VOH3kU9krcv2e0GXUjHEyAYnRdmt2dKKk
	lxg9vBk8/mR2dgJ+8vgH0oIwro7pbuihOONWyFe3IIxRa2U7rrP1agaksy9QTjXaaxNizEiw702
	Wst2IdHDY2Hn5BmePX4mjil8B+6zEChg=
X-Gm-Gg: AY/fxX7CZRQT0pAN/OFsO7R1owX5gvLFLy3NTwlgZM2h0hHp93qs8ZI4kftdcmEVmc/
	Mz8MPhZnQ7CAgt7JIAFFGEn808jFLYKqzwAgtViTZwvn7irEgdPPiFYb2QshwR/12pjJ50OcdlU
	NzvV89C0RcYwoU4EetI7VtDD2Bkq3XalNZiAaJ04N4x1osGahrF94mguLKTH2d2r/oID+h/RR4F
	S3SHMnboGfklVYYfG23iH1+WbG7PxlfAzZraqF9cJEzzf1A5CvOp7gmcvonmuILSSXznXg6
X-Google-Smtp-Source: AGHT+IHDtmop3URoAsXRrKrNc8ipfSLxV7LFYwQQGZYo1mnU+n3HVH0H+NVeX4rI4VJzOdtwpEdQD9ZgzsO+vYll0N8=
X-Received: by 2002:a05:6512:ba2:b0:59a:1240:dee2 with SMTP id
 2adb3069b0e04-59a17d77452mr1216137e87.12.1766155223257; Fri, 19 Dec 2025
 06:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <035238d7-f98a-4072-a363-9a57650abb95@gmail.com>
 <20251219114602.96489-1-haraldnordgren@gmail.com> <f141e335-9729-4f09-86b2-12a39f24837a@gmail.com>
In-Reply-To: <f141e335-9729-4f09-86b2-12a39f24837a@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 19 Dec 2025 06:40:10 -0800
X-Gm-Features: AQt7F2rEUo4G22u7I2QXI9ZEETf4KWx1zGjm20dZlS4wV3ekI0SpeyRFrw4DsHw
Message-ID: <CAPx1GvdNQbHY0avQ_Gt4bkLiuNHPW80E0v1vxrwyQYDD=zpc0g@mail.gmail.com>
Subject: Re: [PATCH] diff: add --no-indicators option
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren <haraldnordgren@gmail.com>, collin.funk1@gmail.com, git@vger.kernel.org, 
	gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:27=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> If you want to restore some lines from a previous version of the file
> then it would be worth trying out "git restore -p" as Ben suggested. If
> there is some other use for this then it would be helpful to understand
> a bit more about it. I'm struggling to see why it would be useful to be
> able to copy and paste a mixture of insertions and deletions without the
> '+' and '-' indicators. ...

As someone who makes a lot of tpyos and hsa text that
gets duplicaged because of copypasta duplicaged because
of copypasta errors and on on (ahem), my personal preference
tends towards:

    $ git show <rev1>:<path>  > file.oldver
    $ git show <rev2>:<path>  > file.newver
    $ vim file file.oldver file.newver

and then cut/paste old or new parts in the editor,
rather than with a mouse that doesn't always get
the proper edge points.  The ability to "git show"
specific versions of files is the key here.

(The patch modes of git add/restore are good for
small things.)

Chris
