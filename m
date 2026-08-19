Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B5233944
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176901; cv=pass; b=t+VvomkWQsEQ6goLDlq71WNk2x89BOBmGpJzmkjz9Tr9gCLOe6zEUvO9ahFD6ErW8y9HnbcZREdBXU54ZkhH6O03HjQbRcmvCsux/aYYUel0j/dpJXpj/LfGGAHJ0Jsz76dKkM8KZGV95lJyfiQmsjx76oOtvMY7do0pGXaOCCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176901; c=relaxed/simple;
	bh=axQswXozZmLsUeoCdqTHqPseGZuzOO4J8XeZQIcoWvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+PVXYHpGzo+YC+5r2CpZy6bOQpuo3xtfmfj6KlO+gyAyjk21ailmi0eHMfgpvNBcxVUS7kcaZkyjzBtChJQ2V9ovHF2e1LbdwcVNy7z4TexjSAIp8fJsOXb6IP+GpofFlxc7a/441Gcf6/KI7a/DDLHVtrq3rVfns+xLF1rOSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWLku6QI; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWLku6QI"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c0cea8883so2898371cf.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 15:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787176899; cv=none;
        d=google.com; s=arc-20260327;
        b=gqxVc1J5IxN5JBsr8f7GIxBiRR06eXoebEm4xprC2IFyCn3Y9QNOiI3QySDPDqGRVV
         Key1yWEa9Q0RHcxnZ7VQaiGS5bZ4s0JOEsnJOOa2Ka2YzG0J84ij2xkQqc3xiEchEem8
         7EEfA57CvXj6NpMbvXPGmOoxd8L6SU2qFquvvt7pQLC34CZAIqyy3WnzAGQn4dmQUOvY
         pHI2f5/AwW/LtnJFQMQc5xu+DIk/O0kSrTDMPNFJog6LB404Z3IWow8HQofhFq/WinL4
         jc9y/1n2lTQC6VhdXgXHHxf8eW3XAHmrYhQkepzHRW1S5eHHfojLoKRllbfJqRsWPzJN
         JN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8qoq/ObL1re1X4fWUpSSk0tRsGToxkQfuu3kPL0T8AY=;
        fh=0oc6VvDwKUk6qEk60XqXbHYmY2uQ+b5A3T4hwVO51bc=;
        b=X0gLF13iI4dAs09evVE3ZArYn3+A9tQ3qCcEqfNH+TLE5FdZ7xYFvcpvQZtEccYr9Q
         ozBH8qe9vVIJi98KYwVoSI7OWD6AUnTRufv8z/Um5R+HH0HHYlmyjcZ8+bkgZRykjkOD
         u6hjNNnO3bPrJhMhdqlivG5VuesJ2PKRxWxbjKWCdH/JAuPEaJgdqX2UF6oxIRsnwVfE
         BKlMVowKaiVqR209XF0BZ/k5xJ5+74ha+enbHf8L5v4aecfnIKqQGf9PoWW5vwCDhVkf
         cD8zuTBk3z0Qc7MaETcOhJTKzK03/lHJ+/U8blyTy7dVBxzMtSnn9MMb6FM0VZGrDF1S
         J3uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787176899; x=1787781699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8qoq/ObL1re1X4fWUpSSk0tRsGToxkQfuu3kPL0T8AY=;
        b=GWLku6QIOf4Zo2/ecWrEg6qRX1uC1t917/mLSa75xFab9sEqejqIQV9kX/FQjP2fMt
         vAIgydbvvt2H76HTpcnZuK66tAo4hdC86zet3FZfEkIgYj6sQ8sCDmHx7PBIDa/mV29p
         gBl0X0mENjr4qJw6Uqbfj08qnqGYfEOGo/ZbuvFWen5bejy2nyxY2l+DBt/AjIC+XQKO
         qD8bb14qMMcxGAAza0KSAdeQwnXX1GF2YaGjKV6l05XQVGD6WFDaZkNqsAu2EItSpi1o
         HaTkDhPLU06reMoSkJy2SDntO61PEFYq5EpYo6ld4vWB8tierVfZ4Y5vbS1uzfOF2/ij
         J6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787176899; x=1787781699;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qoq/ObL1re1X4fWUpSSk0tRsGToxkQfuu3kPL0T8AY=;
        b=TKXK0Ixdth1dqseJHN5vM34qdjF8bbgr0g2yoyxF+7gCUXiBITIvHpVDxCr0ZVzECr
         7OcHtLwtxyhpDFHKklvgAWn3iL07AhXnlBWV8DxidAdohpEmBolr1flkkbPD6jstgp/O
         kSFKlH9THJK52xe3Od3jOpsNTEM5kxiegg+00YH52HIRg7q8meuigoQgthtmAP16aLCK
         wei5sXhHA92DSF849YljZ4x3YaXg8yp7u9114bfYKJ/jZsgDYhC7lDdCdWeZRI0gaX9R
         9vCKHR0oQBXFtf5QL6849QmYF3lTHwDL1EbYs98i5aKHpVhj4PzeZmHTDxTVBRd+s/hO
         MiOg==
X-Gm-Message-State: AOJu0YwUm23GD18YdY+7kAEVdl9UsTiQgkarm1aRW117aO/mRoZHHIFJ
	+BHwbSvl1NItBsQejroelL7mMU90l1bGKqy3c0hfw1iYmiiHFg3PhnLIrPi+Y7U2rpDcXThq08h
	gNt5ETdbob5GURPgS3L8dAepVHKHgBhU=
X-Gm-Gg: AR+sD11iKCCUQSUzHcGrdMsBLiak9Zb6xWAaOhj1KZH7EECuT2iPRGw5yLo8Bbjdnni
	AZdm5r6x5hNFuTljJJdlHS5YAL3ryUvOqbppbu/uI+B2c4ebK59/kccanGrBR+7PpwpXa9jp7Uo
	X/wPb4dvxiqTyQ79w+a38FGLzkiSjURdN6M/gzxqHNRy1/3NMlfAS0pPyuu9h/F4gYY8C0/bJKj
	SYsgk3ICyY+7a5wTXVBtVO4/TEKacyHhKYwSxvSG/9eH+9gB4x+RIkPRukoMUVO1I+nqgKCFnV0
	ZBIWeRyp8Nxl0ONA7pIDc6x0sses3cgMq9PRHjAn/+eZ6P+ozBHT4hxQlTsVU0nXV/ofqtZutDe
	+Oe+eNpxojyoDqQ9OvKKfUFesphFrWi/e0k4=
X-Received: by 2002:a05:622a:1cc9:b0:52d:9ab4:7775 with SMTP id
 d75a77b69052e-52de36e0794mr25908311cf.21.1787176898767; Wed, 19 Aug 2026
 15:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2192.git.1785852032626.gitgitgadget@gmail.com> <pull.2192.v2.git.1785932208004.gitgitgadget@gmail.com>
In-Reply-To: <pull.2192.v2.git.1785932208004.gitgitgadget@gmail.com>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Thu, 20 Aug 2026 07:01:27 +0900
X-Gm-Features: AcwNN1UUvFH8QeW4fBSaoLjvsAQb__gzUDZCeZIvaBK9ZrZ8JT7Frt4AzDiWmB8
Message-ID: <CAF5D8-tbUqLyxhj7pqDmsHJqnN_Pg4QV0C2CcGL6XEqay_BG-A@mail.gmail.com>
Subject: Re: [PATCH v2] worktree add: shouldn't dwim if -b or -B is given
To: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Abel <jacobabel@nullpo.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:16=E2=80=AFPM Yoichi NAKAYAMA via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 654d27c3e1..cc46c1b415 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -898,16 +898,18 @@ static int add(int ac, const char **av, const char =
*prefix,
>                 /* DWIM: Infer --orphan when repo has no refs. */
>                 opts.orphan =3D (!s) && dwim_orphan(&opts, !!opt_track, 1=
);
>         } else if (ac =3D=3D 2) {
> -               struct object_id oid;
> -               struct commit *commit;
> -               char *remote;
> -
> -               commit =3D lookup_commit_reference_by_name(branch);
> -               if (!commit) {
> -                       remote =3D unique_tracking_name(branch, &oid, NUL=
L);
> -                       if (remote) {
> -                               new_branch =3D branch;
> -                               branch =3D new_branch_to_free =3D remote;
> +               if (!new_branch) {
> +                       struct object_id oid;
> +                       struct commit *commit;
> +                       char *remote;
> +
> +                       commit =3D lookup_commit_reference_by_name(branch=
);
> +                       if (!commit) {
> +                               remote =3D unique_tracking_name(branch, &=
oid, NULL);
> +                               if (remote) {
> +                                       new_branch =3D branch;
> +                                       branch =3D new_branch_to_free =3D=
 remote;
> +                               }
>                         }
>                 }

To reduce nesting and match the style of the preceding conditions, I'd
like to revise this part as follows:
(I'll use the commit message modified by Junio with 'log --pretty=3Dreferen=
ce')

> } else if (ac < 2 && new_branch) {
>     ...
> } else if (ac < 2) {
>     ...
> } else if (ac =3D=3D 2 && new_branch) {
>     if (!strcmp(branch, "HEAD"))
>         can_use_local_refs(&opts);
> } else if (ac =3D 2) {
>     ...

Thanks,
--=20
Yoichi NAKAYAMA
