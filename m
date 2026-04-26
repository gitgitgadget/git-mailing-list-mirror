Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7E17A31E
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 03:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777172529; cv=pass; b=lhltDgvp6lLBC9eF6f33ozdwWEbu0yZIbeUFzRpx4LFnWUp44IKxUNLmSJ1qD8EPXkhFMniQXk3dRoCO5NJe+SXS9Cnd2wggre3sSubRl69XxFjljmvk8GdT5NC35y//mgLxcBmjC1gxwg+/L6kqh9wXXykbl9m9rrgqhl5vvyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777172529; c=relaxed/simple;
	bh=ApRIEKlNiHuivT02ERQU4QNV9ZJrzmrQI9OLqfLLQvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/kSW/+oAEOBlpHsedRZNcNU9FzFPsviJ8k4C/2RSSzcG3a6wz79aE6xrjFyCFOEZKK//Q8pTOhsDKD82f7XU/l+srEmbd4AxvJ5LrGlFgw2LDyj32zSVtL/2lVurbgYj4jxiAJw2b5qb9gqZziF3oUOzkN0/zcZStsQzjgJwjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXlVp9bE; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXlVp9bE"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c19d23b19so11774485c88.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 20:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777172528; cv=none;
        d=google.com; s=arc-20240605;
        b=DdjNg7v3Lh/T9Jgi/PN0yWvdu5ClOxEp4CtMRx+hkpfKK0JkcpON0+usdB/pa1l1bA
         BvERp/BwQah2hrizmQpo8DgxD+h7Ia/KylxadrZi4rfwK9A8jBt0U587M4blYcrHywTF
         ILcY72lWxV8ETGCKBxYLx+E++0zskU5REFsLkHJ7pqKJu2R0dkgGGLFvyrWnuHmYi8s4
         VU8BmVde1TkAdWyyDdLY6HKl8tLjIg4jxvP+n+kOeocFvPJ18vUIESzefE+8u/4ef4dX
         K5I5sEwFrou5jUYyQE/g5Z91odlyj6toVMzwzf0pQ5or5W0SNgKWnnsXNcZ4JZOnpbSo
         ICUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXWNxvIPJEUJKKxuW1hH8QFxYoMb5PZLnA7Wj+wbYpk=;
        fh=UNNTgmlbZWUG5it7L+lDt6KbWebIeOPey7Ke9TLRXoc=;
        b=fsi7nDAXBWnRBxtFveDialrwBu+fN8KDJfnPV9zUdyBJ3L/uSC9mTMffqyxgrBx8Lp
         2irFQM4+uIWD0z3J/AHW9pxO+adsMaUSob4vxmOi346cNlkpYcYBlbMXYAnEL2wNXsPj
         hqz1hvoNt7ktQF8BaltIma8foH6Dj12vI2fi5X9yiiKhPcTOdr2/a/gzELcxMObbspTA
         jX+nFotts11DmGDggXV+Ow0ARGr2yp1r1NyCeSOpbn98y21+kJ5Risygs4dnj9l9Ztwp
         vTJUswZOdks4W3Q6vUgkXvYCa6Ob9SGsopMlw7y+lA9wG7zhLr2PWSUlPc51cxvRmKps
         3hyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777172528; x=1777777328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXWNxvIPJEUJKKxuW1hH8QFxYoMb5PZLnA7Wj+wbYpk=;
        b=dXlVp9bEB+9CmbAm/stPUHiJQtqdXMxwLnrDyBY/W+Po5daOCxcl4jcGFv44AkmFU1
         3pncEvqI0N4AfRDEgXGqmNC6bakWjszsrSYIVh1pmo+vKiVqjjcpNcDcMqTzW12urWXx
         VzjcW+8Aa9h9ppVdGFJaYxE4jGY3ldfghbU/UP/Xv15xyH12K1Pvt5gzcdoZWATgCi/o
         Gg4aWMe1eh98iMJhKP62vGumOcGVn5oMJT0F1qp/XDsZHEc6IOFyex78PtoZzHjaKFUa
         HYDeBpoiwC36+6/OTUqArwrTPtk2rYsCJawJykQ1IjgUx0QMUHrw3TbKUrpL2LPsiuv6
         qHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777172528; x=1777777328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXWNxvIPJEUJKKxuW1hH8QFxYoMb5PZLnA7Wj+wbYpk=;
        b=nUZeAQmfhXu6zgdU/n9rRh1ICFpVkeZ9tpt7wBOKC13BxymxLjzo6XPzSHeR2aMPZ2
         5/peWr/wbsDdWGCZ2sufhOdWfG+xBlX6V+DJLpTrT7rxNsnhAZ971dL28vNyOGQDaGW0
         2jRnykbb7DOPXAPL+h2f9gmY1QgbBwHDP+Ey+edaeTei3P7TenZgUMzJFQkCWcpbz+X3
         QlNAjIInJAvRB3R8iprERjc8doTqqqp81x+sZrqQX4ieRw564kFGoNqyAulrxM9UFlnw
         JavhlkIH9bQ0SqX6MAoqj2NzJ9F1ox3rEUhmtTS/yZ2yc1wuA/okyCkTYA1rD8YoG7HB
         7AoA==
X-Gm-Message-State: AOJu0YxbRwVn/fJ/jhBiBBxuQdIJWJrbQeYm54uhXBejga5aJ0Ny8pgP
	zLVNtP9f2/RYSDMFXOa9luvqU4pVs3gcw29hL8BeWam3PpA2x/4vAHNO7De2BnX/O/LLVxmnZjc
	zSmyUBp0NgVrtD6onnPEDKIJsnAewA1diq23j
X-Gm-Gg: AeBDies5slIRBgsQ1QDgPGvMlugFlJzezKS4473hRbCfYO8021evVtWaXuohgDwSf1m
	7UJqEtZcpRFRPz9V4oswM7tAGi09F0ysL6XW6dg2Kh/+rIrJPLaAKZU7gRgsyLNPDRdBgnBRnDX
	kEjwQa5cOQetq3NxLIdN1oKeZsnKViypHh8z8OyGHCMDvaGX+AnXhd/MBQSg1qvk6dSB9c2436B
	vxntd3aH8PsP4WlofPq4LztLaKBZqEvEgH9QncDaySKZaf5R3HS/nyEcDXXdwW7lub/8FkA1Ehb
	pkv2xspU6IxWP34JRpDWHJvtgWKzMDB2vOn+N4b9csSF+LsZbX48llY5w1H4IPzmjvZEAwO45HV
	QlsQjylhLhXeV0pasWg==
X-Received: by 2002:a05:7022:50d:b0:12a:747e:5b5c with SMTP id
 a92af1059eb24-12c73fa3af3mr19619190c88.24.1777172527563; Sat, 25 Apr 2026
 20:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422182516.26667-1-beniamino@beniamino.eu> <20260422182516.26667-2-beniamino@beniamino.eu>
In-Reply-To: <20260422182516.26667-2-beniamino@beniamino.eu>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Sun, 26 Apr 2026 11:01:55 +0800
X-Gm-Features: AQROBzBGOtdWokbW2a3t9NZXHRtjxve8KSLJeMToxOkcZhSHo25ZOkKGZe282kc
Message-ID: <CANYiYbE1qTFYLEyhAR3SEyXozFnEMPxyj=3dAh-vmHkpXZnMpw@mail.gmail.com>
Subject: Re: [PATCH] l10n: it.po: fix italian usage messages alignment
To: Matteo Beniamino <beniamino@beniamino.eu>
Cc: git@vger.kernel.org, 
	Alessandro Menti <alessandro.menti@alessandromenti.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 2:25=E2=80=AFAM Matteo Beniamino <beniamino@beniami=
no.eu> wrote:
>
> Fixed a misalignment in the "usage:" and "   or:" lines in the italian
> help messages.
>
> Signed-off-by: Matteo Beniamino <beniamino@beniamino.eu>
> ---
>  po/it.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/it.po b/po/it.po
> index 20fd8bb28d..b5ccd8c731 100644
> --- a/po/it.po
> +++ b/po/it.po
> @@ -5400,7 +5400,7 @@ msgstr "uso: %s"
>  #: parse-options.c:915
>  #, c-format
>  msgid "   or: %s"
> -msgstr "  oppure: %s"
> +msgstr "  o: %s"

An example of the original English output for a command with multiple
usage lines:

    $ LC_ALL=3DC git checkout -h | head -2
    usage: git checkout [<options>] <branch>
       or: git checkout [<options>] [<branch>] -- <file>...

The current Italian translation does not achieve colon alignment:

    $ LC_ALL=3Dit  git checkout -h | head -2
    uso: git checkout [<opzioni>] <branch>
      oppure: git checkout [<opzioni>] [<branch>] -- <file>...

Your change fixes the alignment issue, producing the following output:

    $ LC_ALL=3Dit  git checkout -h | head -2
    uso: git checkout [<opzioni>] <branch>
      o: git checkout [<opzioni>] [<branch>] -- <file>...

Another possible alignment solution for the Italian output would be:

    $ LC_ALL=3Dit  git checkout -h | head -2
       uso: git checkout [<opzioni>] <branch>
    oppure: git checkout [<opzioni>] [<branch>] -- <file>...

Obviously, your solution is better, because for commands with only a
single usage line, such as "git clone -h", no leading spaces will be
shown =E2=80=94 i.e., it displays "uso: ..." instead of "   uso: ...".

Git localization follows a GitHub-based workflow; please refer to the
"po/README.md" file for details. This change can be submitted as a
Pull Request to the "git-l10n/git-po" repository, and will be merged
once the next Git localization window opens. If you have additional
changes to the Italian translation, please refer to the "po/TEAMS
file", contact the Italian localization leader Alessandro Menti, and
submit a pull request to his repository.

--
Jiang Xin
