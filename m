Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E823A564
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019825; cv=pass; b=WBMzSjv/mEgd/h3cdYh4PxWBGwp2JFl92eunGBD7hAkhIqULijav8iAGeUH3cnxSS5IwjAnDs68PaJYh/lmxf92cVebdbeVMfPTwVye2Haj6cldOTs7Bp7uR8WnNrTiabykSOYWOfwGZ0afIVVTQ13XyuWNChkA1Jz+dKTL2bJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019825; c=relaxed/simple;
	bh=IKfkXFKUdupA9rx3+57cnk71MrB/6a9kSyZ/FYRb7W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLxppiLicMPzuVBqAFfzjD+gDH6i6GlUEBe7hQRH3EtBwC0eq0qS095YFUnAGkk82W077aECmR83PfiCJWOh29c2R54T9VRI5qmIQxzqMh9ZfnHKW81joppZlmHvZmCBWsOq299Jc55SfCOk2ZpS5HUmkS2tktmuIvpFw2n8yWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSB+dyQx; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSB+dyQx"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7982c3b7da9so22407757b3.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 08:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774019823; cv=none;
        d=google.com; s=arc-20240605;
        b=XO+7dzi3xx8xQBM3eECx0Mf+JYJz+bRR9CFS6zHusSJiiM6C2RnGULjFwO0NXUCKs5
         1Q3Q6yKl68VCeSYuSNRtIOC4hhNlHvAegVzU4yUkOzDuo5UkQdzgmHlR4Nxh5Ap/16j8
         HgvowNfd+EaN9pa/J5QcHADcUaZMC9QnTaytAL4WjNu9IfxxX3OvofCOxFkkb7pvpB7q
         6L1HkLP5Bo+tFWUXbNAt3Ski/GQaFFGW9Ph5aLCGfe7olnDLghzD4EImfFxPTEGipUAx
         VCJtW4TTgOOSIfH5Sc8EPVXIeqoHjDOejcPblOIdeCXGvMf/7Oi9VCz9YoaH0HaSPi+D
         b8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LRMaYEI25PSHTAH+HdFLjOrt9/5Fl33/J0f8/RpcbRk=;
        fh=xnVSpgC+AJnRn/KTWgL3MxMcE1jIXQsfpDynzktMQtc=;
        b=Go9VobJBDZEQDZJKtIpbuWjjGrF4fdG/0GnGPy74YXipHSZ8KurkikJKU2GqZ/oHG/
         CT07fzFJiycxZyvYqPUyMS98C2LvpSNGbL4EJKzPvqH3YNBuROQ8UHdjAEB5kKO5A5cQ
         HtvMY0vU2y5PHLBImyJ3xrWqyPNc6TbFhH9RT0doIocXVtFqZ5mijBYgnCcJkdkTx9xb
         WaSQi4hGaMvtf/H+DO2hzGnJHJBG4lKtmY1dvJvkPULHhToGI21taDV5iEfiFAC32TTq
         gB8+BxlvRB3X2BHiIDn1fKlTl8YH6DZRqzIalpk4E3m/tFMNNBkzqxry3LuSK0Mau81x
         AgFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774019823; x=1774624623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRMaYEI25PSHTAH+HdFLjOrt9/5Fl33/J0f8/RpcbRk=;
        b=HSB+dyQxJ89MKlLV4HwajPHdNpocFtTQ5p5pf/+4hw0M8oVNuRBnPoNwgcWwo2S0JG
         MSQTgtgWPDBKvx5Bf9U1g5BHtx4LKA0REX9j002VoxaI+ElcWZzg00apnnOVOZ42JI5h
         u+uKRkKVzB/K4wQbdOkhR388cwQryTcmJIEuAeHDvVJqmdd3NRMk6s+h6QgOYxtNhy2Z
         oyl4KSvax0YrjotovgpPHS9cpbIYmFDQixZf4TaMluWfl5OT568fUb7jVOf0wMlHKyDC
         3N1UzIWAyU3D70fcV71luhovvYnXEs54lnTx8Lbp+4JWmemVyXarAMZavStKrOnIGxcw
         Im3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774019823; x=1774624623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LRMaYEI25PSHTAH+HdFLjOrt9/5Fl33/J0f8/RpcbRk=;
        b=DBah6G5aUJEgDpsYKrJj1/9aTU8wtwIMUvS6ImcOVKNp1X6xRNDr1P085wQav6qytu
         EYRZ2QeBxpxmerb+a5jSK7lqe6L+cyaqan9ydZRBj7Aai2Phy5fwLJ7lRp9G2YjxWxfC
         ibZDywwlUIkNfGmIRHEDmtH8sYAn+0+vc244sr3Y8GJ+y2HoKV8JkgPahE2iMPOfjYAE
         RRLYcOKkaK+yxNgSPylPhTOlWTA8vdcpKMK+Zos4E5yhyChJ+PMZSC05eXSOaMyJe9me
         8ZYclrNQk0zo3T5ZuzrPcGjHqkFn8XxJT/EAq4rvrYLYWy+EUmJ5JuNYC/qSpEVLlGB8
         YpMQ==
X-Gm-Message-State: AOJu0Yxh4/eK10+ljQf12tEOmOrajBQ2U7PU+3uLFI7JdyqkL4pgPoT5
	ZAPCrN+llmomzvnaAQWg8OUBLy6F+EBgimUcA4csapGDqQS25IJdGW06TRmcfFqpXRVwAaHeojw
	bQGxOrl5PkLa5UsPCUSm8QgDyj2YGTMxHkVdK
X-Gm-Gg: ATEYQzytgwWmlYhkdnTzMR/WNlmdk/J68QNo1VcDeEPhvIVLv0PYz//iXoV0odpNbJ5
	9kCKCu9ZBXqsBlSXAAenTFlnBkhn6NHg6GqAVf3gLiXUQ4p0E2VOD61zfaXIyXfs9Cofo0ENF13
	sV/VUnVLZMjPLukSmuTaJQ+X97tB3+k0DHdd3SWcuNbrbSX2cayDLKWGPRDWt4o25BlCB9BV7ja
	in8o9wcfNBtGgVW3XrxIu+ggxB5Vqc4yz9KKf5rXr+/ELYmkD1NSIAG3I6qFjL4jE03FKd/jCUW
	Wpt2Adb37tQPBigi+sFR0AkyvKvW8u4Ap20IG8bEExIaFWtwLFVr5o4JUejJEraeaytxpUoanWb
	OPGPiT2J3cRr9u7F9QiWn3DBIM2s=
X-Received: by 2002:a05:690c:101:b0:79a:3b28:a727 with SMTP id
 00721157ae682-79a90ae8436mr35046657b3.27.1774019822969; Fri, 20 Mar 2026
 08:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320114823.3151961-1-ysinghcin@gmail.com>
In-Reply-To: <20260320114823.3151961-1-ysinghcin@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 20 Mar 2026 11:16:48 -0400
X-Gm-Features: AaiRm53gDzJVn_2_ugOpIjYusnb2Lowbfk4ERBmK84GxtYgWuY8S1mtuOhzX3KI
Message-ID: <CALnO6CDnwYaAPhp67kaYWtV48ULjWAR6ks1khVXmSs1oWUbRDQ@mail.gmail.com>
Subject: Re: [PATCH v1] path-walk: fix NULL pointer dereference in error message
To: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 7:50=E2=80=AFAM Yuvraj Singh Chauhan
<ysinghcin@gmail.com> wrote:
>
> When lookup_tree() or lookup_blob() cannot find a tree entry's object,
> 'o' is set to NULL via:
>
>     o =3D child ? &child->object : NULL;
>
> The subsequent null-check catches this correctly, but then dereferences
> 'o' to format the error message:
>
>     error(_("failed to find object %s"), oid_to_hex(&o->oid));
>
> This causes a segfault instead of the intended diagnostic output.
>
> Fix this by using &entry.oid instead. 'entry' is the struct name_entry
> populated by tree_entry() on each loop iteration and holds the OID of
> the failing lookup -- which is exactly what the error should report.
>
> This crash is reachable via git-backfill(1) when a tree entry's object
> is absent from the local object database.
>
> Signed-off-by: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
> ---
>  path-walk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/path-walk.c b/path-walk.c
> index 364e4cfa19..839582380c 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -171,7 +171,7 @@ static int add_tree_entries(struct path_walk_context =
*ctx,
>
>                 if (!o) {
>                         error(_("failed to find object %s"),
> -                             oid_to_hex(&o->oid));
> +                             oid_to_hex(&entry.oid));
>                         return -1;
>                 }
>
> --
> 2.53.0.582.gca1db8a0f7

Interesting find. I was hoping to see an easy way to reproduce hitting
this code, and after grepping around a bit I found a few places that
end up in this code (git-backfill and git-repo being the primary
callers of walk_objects_by_path), but on second glance I think "!o" is
current dead code.

When we compute "child" in either preceding branch using lookup_tree
or lookup_blob, we only return NULL if !quiet in the object_as_type
calls (assuming we hit the "else" case there, anyway). But quiet=3D=3D0 in
both callers along this path, so !quiet will be truthy and we'll
error() out there instead, never returning to add_tree_entries.

Since I didn't quickly come up with a reproduction, I can't quite
prove this, anyway. It's also possible my analysis is based on code
that has since changed (I happened to have a537e3e6e9 (Merge branch
'sp/send-email-validate-charset' into next, 2026-03-06) checked out at
the moment).

Still, fixing such obviously wrong dereference is good, but I wonder
if we should go further?

You mentioned git-backfill with a tree missing from the local odb; do
you have a short reproduction script or test-case?

--=20
D. Ben Knoble
