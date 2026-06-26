Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A643F44FC
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476118; cv=pass; b=VoJ/Vc+bTbjd4Q7Da0Ih54ltKTIHCCqGZnwnxZvAq5rgN2HzEBCVgydr+yNTlOtAc3kc2HuEL0td6a2H4YPuZv9ElAswEk0HxeafscUZM+EB/fMG4RhHdftfdqf4U7QS9O1OULqmVluw2kFBRGB+cO3jkhIyEs88ofb8zi9x1AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476118; c=relaxed/simple;
	bh=gbmZB6lFD7E1nN7ZjiroSRFnpKjC4rv2fw7MmWAeCAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJxQVTZD/VSZdBluy8r50Cth3wzwXLvtfvays4PXt+cAAWTdL50BBdY+bGQylQRfF6o4A52I67Xc1vAIX4gpAV7gybUED9nXgG3l7d4Nc80WfgeGGUiJo06qVH8IjFY6ce+Z8QBEd6S9rkpiqyPmH81nidgdAP8dxUE2kAwxxqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd5AQRpn; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd5AQRpn"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697de335c18so1525950a12.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 05:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782476115; cv=none;
        d=google.com; s=arc-20260327;
        b=hIkFo9/oLhZhxFNAjuu56Rmo1ZlWybeTJu+x1zShPR/5MbAFRU1HmEGvSXuU52nCjN
         zdTKzPx94iAMaw2sOwy1nuDbKwu+adDWe6PYe0KevH7KVu7AmCDk5lfo5eb5hob7l2H/
         iANvrzsVzPo12ljkTuE7mvS++q4OjI3Vq7lCNJcQyjXy6kIiDOk7VcFyQEKh44GTVyU1
         Xj+I7E9VD2CIuTdLVI/mk1ecbZwENJbgubfR1XJUlJosKgI/8FmJgy9aJJVVwzKiKFGS
         hC/bB6W4HP7Mjdfx7POQNoVPO5neSBvDF6T+kzc/1KBSah/lyNXdstUhdgSv19QdjYjI
         Q/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q7+p+NJtJr68EY+u3TdtAmE6d+mzobwVcf+WzHJKgwM=;
        fh=PF02c1ekjMEJb83S/4m57zgYrIx7lEmrn+OgHOwx11A=;
        b=bY2fmN1psOLiPd857Smd+mAo39Ht6uw9htIPG/Yrzs6W33MbZXSVCkePb8wKn2p3K9
         PLvDSmROqaSuLkq6XXmQYfcNjB4cK3bVXbm9TZXOKVRe9c3Dw/ZvdIf9Y7JqAV+mbB0t
         sQhqtOUtAyVAAmcb/dbfFAPZ2vSQXyOqurQVtHVtUqiilWcYSs1oa+FgWuYWm/1ZtXok
         nfE8WkAGzELD3JSIepJpKnPy/XPu9rMD9XcNEUV1xQz3SAbBECLhuvWjLlFoR7NgN8AK
         va+8qAHJ0zHwduNFS0tiwektWoztU+qr+ZVO+B3CQW58iO0J3KfQqvRHcA+c681rB9Gr
         SVNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782476115; x=1783080915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7+p+NJtJr68EY+u3TdtAmE6d+mzobwVcf+WzHJKgwM=;
        b=Gd5AQRpnNLOQCt9kt5V/veEz162xDyyz2oSEr0YbgGWvnv6oyZtlP4blwSBEtmWYxe
         +268sWZROcX9Hq1n1gJfmbU4Pry1nrwXB/n5GJGEZp1gOuzPNQvIq2izoOEGRQNyzBx6
         EAarMqg+ijZutgXn9EAWJQWgtLrYfPcNyT9HuglJ1CnBs4ptnDSYozQUuRC1ht2L8lBO
         YgGJwQTZCrjbiDdcT05C4fVO52oxryIXbG4OEf1NiXMyWAtEPIzmLQRXQ8EDPAMlf3Qx
         18c45eddWL1Z+R53BOkYX9f9Chcd0WKAFsjqalyg6nRqwl94wD1zeA+vvYRuzEIrQXXf
         p8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782476115; x=1783080915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7+p+NJtJr68EY+u3TdtAmE6d+mzobwVcf+WzHJKgwM=;
        b=VVE4uM07whGoGy/N3Ymf4qBUXtPM7WpJBTE8EGZ+h/i6Dw6Gq1EqK39bvDu59svMNC
         i5vAtcTmV/HJkcT7vQcYiWqlJj1rDgOZMEA+YuTl4n2fh8pt5GxaVo87zJr+2jgolKmF
         kB4S3vhYwpd+QRz3GnDZuYilIU9FbHC+lkGvwSuTIGVhPwvx5Q8W/nu4ZtEoSyxjflXm
         JIDE6v+MUmCT2NhdyHvhsMHkpkC3nUvx158ECSliXCZ7vlQTsYZofVbi5OVSCj0/yL3n
         fG2vsZMAr6XB1msMcygeGzK11gbmOgMweKzQCVx1ZaPqjGbssgR8swQVXrHQ4WyaHTeR
         X5AA==
X-Gm-Message-State: AOJu0YytidE2kvtKUoqLbmsRS+sqMeb/QVZmui7F8o3v4EoGAjsWqeDK
	Yvn1jWrufdqoobEAON1R2Ojl9iClZO4ug+W0R4nfk+iWZ9xVaoKNI9wFTEoR3gK6GHSD6dAdP6z
	/Fqucmccsq0yNtEIOJJN2XLFd9thmZkE=
X-Gm-Gg: AfdE7cl5onHsRwQeEnjhra7ldnjM7/DgSITurRSl/Sb1MCGQr1CD0K4NHqwBECpmjCK
	yGCqHaHb1nMs2V1LKUg5PZV5VBGxw/vtzMULTuWDb5zxQ8GZkSmczrUjYVINIBqa68e4uB3Gdhb
	PliJVU6L7xd/0+SbBjHoLaydx5zUqRZFkd8JGKk1Z7kl8qjkJZCFJgKWQ7ZTKznNquaCv+SnqK9
	d8C6B4/ScYKXvtvPciII1BZj4v3ttEInd8acn0Az6LkQEAwotWCH2Iww4lxs/78AalW2WjS5Pbd
	VNSYkE34WunjSy6FdXfGA7Z3p4CL4DzgLrlL4uhlQCBpEBNV9hQAoptHITsIwNf0Yq71dfn5TIK
	7VfNXUD3BJXU=
X-Received: by 2002:a05:6402:d0e:b0:697:d557:f9c5 with SMTP id
 4fb4d7f45d1cf-69810a44935mr1986817a12.3.1782476115281; Fri, 26 Jun 2026
 05:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com> <20260625-ps-eric-work-rebase-v14-5-09f7ffe21a53@gmail.com>
In-Reply-To: <20260625-ps-eric-work-rebase-v14-5-09f7ffe21a53@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Fri, 26 Jun 2026 17:44:49 +0530
X-Gm-Features: AVVi8Cci5M-PzGW_LoLhAv6QuSPcowuLo1VxoYNBfISoaI7mx2Zif72k7lozCoo
Message-ID: <CA+J6zkQtrKqQwZpR9hmyn9-uBt8RoUbv_H7g-2LnzRUDkrHY6A@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 05/13] fetch-pack: prepare function to be moved
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, eric.peijian@gmail.com, 
	gitster@pobox.com, jltobler@gmail.com, karthik.188@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jun 2026 at 17:43, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> `write_fetch_command_and_capabilities()` will be refactored and moved in
> subsequent commits where it will become a more general-purpose function,
> making it more accessible to additional commands in the future.
>
> To move `write_fetch_command_and_capabilities()` to `connect.c`, we
> previously need to adjust how `advertise_sid` is managed. Currently in
> `fetch_pack.c`, `advertise_sid` is a static variable, modified using
> `repo_config_get_bool()`.
>
> Initialize `advertise_sid` at the begining by directly using
> `repo_config_get_bool()`. This change is safe because:
>
> In the original `fetch-pack.c` code, there are only two places that write
> `advertise_sid`:
>
> 1. In function `do_fetch_pack()`:
>         if (!server_supports("session_id"))
>                advertise_sid = 0;
> 2. In function `fetch_pack_config()`:
>         repo_config_get_bool("transfer.advertisesid", &advertise_sid);
>
> About 1, since `do_fetch_pack()` is only relevant for protocol v1, this
> assignment can be ignored, as `write_fetch_command_and_capabilities()`
> is only used in v2.
>
> About 2, `repo_config_get_bool()` is from `config.h` and it's an
> out-of-box dependency of `connect.c`, so we can reuse it directly.

Nit: This only explains the `advertise_sid` change in this patch. We should
also add a few lines explaining the `hash_algo` change. Maybe something
like:

While at it, change `hash_algo`'s type to `hash_algo_by_name()`'s actual
return type (`unsigned int`) and make it `const`.



> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-pack.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f13951d154..ad07603755 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1380,6 +1380,9 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>                                                  const struct string_list *server_options)
>  {
>         const char *hash_name;
> +       int advertise_sid;
> +
> +       repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
>
>         ensure_server_supports_v2("fetch");
>         packet_buf_write(req_buf, "command=fetch");
> @@ -1395,7 +1398,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>         }
>
>         if (server_feature_v2("object-format", &hash_name)) {
> -               int hash_algo = hash_algo_by_name(hash_name);
> +               const unsigned int hash_algo = hash_algo_by_name(hash_name);
>                 if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
>                         die(_("mismatched algorithms: client %s; server %s"),
>                             the_hash_algo->name, hash_name);
>
> --
> 2.54.0
