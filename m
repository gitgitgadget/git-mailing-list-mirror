Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D112D3A72
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701603; cv=none; b=NPe85rcixi9/FaGmAWrV2cVBAuXUngsYM53iJSeIwXUAlWhqnXH6kdaab3HCSaSn9PFztgrtCmt1LgogxgAA5xwIed5dcESw85rh3JpH6NbfzlwzDQUiTe9HFfUVc4jhXVSvOA9PDkxyo2uaeooxXAZB+ds3N29QXqctuTJSoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701603; c=relaxed/simple;
	bh=KQwe0/QLQ5ZueE8S6zk7ebk1CkxAlLTUAJrAj4qnNio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/Ly7vman0NRM/XQQJrrFNYkpn415YC/VRQQVlKDPUNdgxB9unSw6BdxvxEIEsqVSN+k3K2emTcp15ZSQ03odaHMxLsGAnDSOZdPCbiQgwACn905PsDxQKRDCl3AOfeB5N2UkWiaVz9NsD7aKaWovdzqgsPKCr1yAQD4uzXfpN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7caeeef9629so47787285a.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 11:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701600; x=1751306400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgEjGZoJZrqa2rHMKv7rQMrpVJEHtN2HB9iBeiXW3Lc=;
        b=UVMA7h4S2phhhdC/aAdbA9LfmVAa9nS8JqX8oc0KMKvTwB1peYsTr5EkfXyTybtqtl
         meBu2ZxVd/izKQ8w4e+R0fJd/cI7x9I/510f+Qd959iW55YZ+hBU559peDDOmq1nv7M5
         QVwyog2j+G1HOwopFjvlba8NvzdCxXodXV/wLvdFsf38WRbwn1yCbYwA4Z6lLNddAFp5
         rUTyezjOtnI3HLs/x8XgMM9W73Ijue46sD6CtpBVeO7fA3h2PugGXRXlgQUPY6yb6e0e
         0yVF9JFFdmVGcZiirB7t1jFcJQMQ1CekfuRRKED6pM3NOSw2TkvHEOKlQZ08RB1I8zzY
         bdRQ==
X-Gm-Message-State: AOJu0Yy7S8ARjK13OHycP6+uwWe3iUKrr5EpZ17cK/zVSrGBSX4ond11
	wwHJ5C9LgIzAXt8xJRud0wkBHFEFFnZaQKXrRAXvm9VXQCtjw/a6lUZBuhXcx9Dk3ytRPHeAYJL
	7+wlLdmRIrGXGDq6snvB+ajADCEFQ8YUulA==
X-Gm-Gg: ASbGncsWugK251+QOIvQFzRAKNIyahj3f2CCUc+GgviJY/aI3FjDSzyoHsjAJ6seoMT
	+rAf+nZRn+ZGXguwnyUaAD8N1nPrBl1QbATO0V/oDYfcS130uxQWa7GzkZ1jAExKKh8uD8JxPJl
	TNlUKpMPDItj2QvL3H2o2S+Y8cSjzc58O/sRImvJeqql0Q5F0OtA2z94kAUJ3eGDY3kcXYHjosC
	3Qf
X-Google-Smtp-Source: AGHT+IFjyZd2zg0K4rr05GcOjJ8XP+FTI2flyZLLlAsjOB5WDA82V/50F5/krNo5HbbBm7/DzrAuL5QOa785kqsWLYo=
X-Received: by 2002:a05:620a:7089:b0:7d3:c69e:267 with SMTP id
 af79cd13be357-7d3f9923fbfmr720083085a.12.1750701599654; Mon, 23 Jun 2025
 10:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623105516.GA654296@coredump.intra.peff.net> <20250623105542.GA654412@coredump.intra.peff.net>
In-Reply-To: <20250623105542.GA654412@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Jun 2025 13:59:48 -0400
X-Gm-Features: Ac12FXw8CIpErE6LQISiOAucn3bZILQDAoWYFELB8L1cHVZBFqXmkIfPZ-xkQX4
Message-ID: <CAPig+cSLJ57+ZU1TreHajAqbQwBD7TRUt3bxRDTcHCjS88xmLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] t7422: replace confusing printf with echo
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:57=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> While looping over a counter "i", we do:
>
>   printf "[submodule \"sm-$i\"]\npath =3D recursive-submodule-path-$i\n" =
"$i"
>
> So we are passing "$i" as an argument to be filled in, but there is no
> "%" placeholder in the format string, which is a bit confusing to read.
>
> We could switch both instances of "$i" to "%d" (and pass $i twice). But
> that makes the line even longer. Let's just keep interpolating the value
> in the string, and drop the confusing extra "$i" argument.
>
> And since we are not using any printf specifiers at all, it becomes
> clear that we can swap it out for echo. We do use a "\n" in the middle
> of the string, but breaking this into two separate echo statements
> actually makes it easier to read.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
> @@ -180,7 +180,8 @@ test_expect_success !MINGW 'git submodule status --re=
cursive propagates SIGPIPE'
> -                       printf "[submodule \"sm-$i\"]\npath =3D recursive=
-submodule-path-$i\n" "$i" ||
> +                       echo "[submodule \"sm-$i\"]" &&
> +                       echo "path =3D recursive-submodule-path-$i" ||

This looks obviously correct and, as the commit message says, is
almost certainly easier to read, but I was more than a little
surprised to see the patch since I thought this code had been fixed
previously[*] and had some discussion around it.

[*] https://lore.kernel.org/git/20250403144852.19153-1-sn03.general@gmail.c=
om/
