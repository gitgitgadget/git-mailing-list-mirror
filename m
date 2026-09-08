Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA354A7C6
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874536; cv=none; b=HSsCBZYKuxpuKlN6dHfhWN0cKFJO6Ys1RX7vkAS1AkREJzLeRs6zc92vjah771zIzZnoVfjOtP2qF3lqLYmcX0SrWWJkQczwHQajBnXTSQzCjYyHoAiWihfDkl7efQN0bTx7BD/GDvKYzJTvd/EK3j1JTFsgPDtV+a1bTXE5QJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874536; c=relaxed/simple;
	bh=svACNULgle+d+cOxEPd+WWfYC2gp1XHDcsHN1wrbpvA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=fpMr6k3lleWL0uo54cklxe/w3ZUV4d9P3XmP+g7JcFtzGTHwI602bl6Nz21/kkYTwcSquyIUNu1SAcq1SzG2HG9jXuozcF0veV/nlDZUQr4Q+7cpx47VaSpTRZA7m5XHdCWECaZl7G6ElJQdEliOHL4LZZhbx7ezlzVez87GqIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx/eliv1; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx/eliv1"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-87005a0e052so50058867b3.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788874515; x=1789479315; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALrgPkTPV1nApdUlAgPoR6IlqwX4M1aiadaZY6uYgdg=;
        b=mx/eliv1xU0hHKvbUBhpXJVRkTKoEEaqQcuC0eb/nzwaLIas4umDi7d+HR/hmsYjsN
         iniBHygsb/4wI/gp+R/YsdK+eNssSahm2zH69oQreZZ19m39lIVj1vKn+2qefApon2Yv
         qc1oXy5H3MntyRDbVzDNekqIopwJUwaX0SWexnmVwLD9IkIRpbayjlaGicmCB8wtq3sO
         EdvJKkYlLvvAIqaOo9YDwRW1TVsZPIJGrl4DGP/h3gTa+YX2gnmWoKWEAckjpUovFInn
         9y5caMHWWiHTYZpw38dHmIBAendHQUAt589m1rFn9/pZhHKdXyMa+axVi4TUnJolHmo3
         10GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874515; x=1789479315;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALrgPkTPV1nApdUlAgPoR6IlqwX4M1aiadaZY6uYgdg=;
        b=Twnmgt61xRhYWkO73+UbnTNhfXGIc02M4iTXNmWdfozygyBnF8udiIiP6rwSORaNSC
         j7Kki55yqsafMnqtZVVm1dP45VnzmThih5WkVp8vPLLIsWq/8N6AtChng7YMbuYxbi4o
         z5+i9g1Ot8dGO3bONw+2dWulNX9y68/WM9epdXiPGUSnxhuLZwh3DOI1Cf6JYvnF+wqb
         JZaWNM0Xr8CgN23ZYLAM9DcIX75WN1/RDfaOqHwtDqRZdKCV8q/Obr36f29eIZKP6byP
         PbvYap8NnOxIrEorKFohNpsZxaZv7XBZHcz8nvGVUfYbWKzFWz66ZiGZxNHsAULNo0vm
         h81g==
X-Gm-Message-State: AFuF++nwzluVmnnxFs5J903mnw9Q8rpTz0E8b3ZDLeQntK5MjU1EsxaZ
	jcmh/kk72WkaagpJUmUFu57yn4ZiFXmGh89NyOa780Ej+wmjEn1wArTx2AU9eg==
X-Gm-Gg: AYBFou1rQat/DpdgWxYcHUqjsqxAW8V3exocgIAxl0Vgqps2h7W33YCrzqY8vUP7Hwu
	wLxZ3nEgXPFnjeM5C/1MoATm8Gp4Rc0lUbjyRX6AZ0CkRokawWR5SdG9P1jZAe1DHRQ3LeCx9ob
	BOYHRmdLQWKe1lojnzsvhLv0YOKJ/weXm8ynNunR+VK2+9bAkfCdzIolrRdjy9A7Nl9mkXwGc1s
	9hZoMp2/qa+c9Tp7mV1f6+odSjeL5YGvISv5f4ljbshvcaByHyGgltG778ASEv/h2ADZkXSNtPz
	wkRjvKPHdxDz9jZKgT8GoQTQG+bOHM84tqz2uG8tSPMTswXsdYXE2JDItWamWdAnPErJUo8F630
	DHNO0+UgghPz4Vhv6Kg9CHtQbQmrUQoCFWV8JM7+O8mh58ecNmr93gKSa/hHdZScIrtImQb3njA
	BfoktxJFp2D1qI5tLCACBuIVyltzJpwHvay+x77kmOihK/P7R94c6xUrMSqxGyUTy1ad1HZGAgs
	05mwOWhNfp+DpR75EOzSYy38WsC2VHtnbNo4Yj3MJ92Ay9+awrtS9sMlhgMw808o1U6jrt23ok2
	5b5irRie/dhxoQSVc019KcN98Cf4XtvP4ZCewg==
X-Received: by 2002:a05:690c:a744:b0:873:5c6b:a30e with SMTP id 00721157ae682-8735c6ba6c6mr58268087b3.60.1788874515439;
        Tue, 08 Sep 2026 06:35:15 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:1c52:19a0:db94:1863])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87143ca6ddesm91094377b3.2.2026.09.08.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:35:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] advice: use global config for default branch name
Date: Tue, 8 Sep 2026 09:35:04 -0400
Message-Id: <90671DEB-7A41-47DA-B865-AB963AEC11D1@gmail.com>
References: <20260907125610.23458-1-ub4nal@mail.ru>
Cc: git@vger.kernel.org, Vsevolod Myalitsin <ub4nal@mail.ru>
In-Reply-To: <20260907125610.23458-1-ub4nal@mail.ru>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
X-Mailer: iPhone Mail (23D8133)


> Le 7 sept. 2026 =C3=A0 09:02, Vsevolod Myalitsin <ub4nal@mail.ru> a =C3=A9=
crit :
>=20
> =EF=BB=BFThe advice for configuring the default branch name
> suggests disabling it with "git config set
> advice.defaultBranchName false". This setting is
> useless because it neither affects the current
> repository nor newly created repositories.

Makes sense.

> Suggest using "git config --global" instead.

I think we should probably say =E2=80=9Cgit config set --global =E2=80=A6=E2=
=80=9D
using the modern forms, no?

> Signed-off-by: Vsevolod Myalitsin <ub4nal@mail.ru>
> ---
> advice.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/advice.c b/advice.c
> index 63bf8b0c5f..64ca4613b4 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -96,7 +96,7 @@ static struct {
>=20
> static const char turn_off_instructions[] =3D
> N_("\n"
> -   "Disable this message with \"git config set advice.%s false\"");
> +   "Disable this message with \"git config %s advice.%s false\"");
>=20
> static void vadvise(const char *advice, int display_instructions,
>            const char *key, va_list params)
> @@ -107,7 +107,8 @@ static void vadvise(const char *advice, int display_in=
structions,
>    strbuf_vaddf(&buf, advice, params);
>=20
>    if (display_instructions)
> -        strbuf_addf(&buf, turn_off_instructions, key);
> +        strbuf_addf(&buf, turn_off_instructions,
> +            strcmp(key, "defaultBranchName") ? "set" : "--global", key);

This would be hard to extend later for other advice options that also make m=
ore sense at the global level. Perhaps extract a little helper is_global(key=
)?

Thanks=
