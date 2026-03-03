Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3003563D7
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563407; cv=pass; b=QQUcq7zAmefSLvcLqc9Tqfmyv69FkMwUjNkROkOrCqh5Nyve4QuI3MUbXSdUkAKwRSWm2yToXS6XS8wbwP+TqLOswhwTj4+NXU110+iDBjdj/FbrmjtWiT2Qg8Y8IAcBzT9E+2lp1obmK8BUT9wFxDhpglujXPOkcCHMGn9UYBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563407; c=relaxed/simple;
	bh=VeB1pctx1T3RVgZThPzSDIi+9s6PfKNccaZWwpaXRO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p63HhOrueZ/n/rQaCKrSwjt+3Zj4o4Tx1CLBxUcVkUMhMa7oAN2mPO0UldqRetUY3ctuzwddf2G1a+/gZkIovyzHkPIUE9hXZt7QYnD8YDCe1dKZcRG9T6hvjlsZ+3+78J0aBDLOPnFiIoRA1ozFUUhoVh+lvhfqbmV2Og9iYEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJvxnXqr; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJvxnXqr"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82728e5680cso3309233b3a.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 10:43:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772563404; cv=none;
        d=google.com; s=arc-20240605;
        b=ITxVF8bfR5UyZv4+nn2mKQFg8Dff7zrBq3B9nYM8oMpbnGHmsC3dfGpUb9rRYCxpkH
         WW1a9gpoRm3Q4anwtYJmImSH8CKOr1toJphPr02dHDaxP6ArRUuzWVTBnop7jseFUKts
         35KKBm0NXwp8gKw7kZzGJuWyXqArgc+wUW/3M/xRp5P5t3WJL+K1gkofMWDULLFRMWlT
         vhlqF7xEt80wpIK3JuwUZ5DSMqU+n4V3HCVm4q7uqJ9wRvflQ6tt9mWAvY3wZfUBEfaN
         p400jIWNBR2GRgcvuvwfIMRslkrWEFlbkI5jC17/K0a5+qe4AO18wo3QYngKo6URR+0s
         aTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2819OTVP39Dj0dHEzzm3b3epsDVRvVb2TOUkNekw1lM=;
        fh=7C13Yara6diLW3o1hgquesR7ciM/ftgxAeePVQ59NFA=;
        b=WtGgm86mKommnbmc8WGTyI+YoGYAKrJhcil2FGAXXaksU7njqBmK+D5bJtp8W6X1jr
         pIVTEbAHv0i8TGQ0RGmC7ytS4wxGdhaRwLflLdV+24Vdb34vfSeElazPPq85Jt5GgZNv
         wT1alUlIGIQnX6ygm9ofYoYUDIFn9J3yV0xUJ3dseSx7VyvSspPXSuW4Rq+m1rxR6+xZ
         fVYF4sPprXxipvvrFjLhtSKU1SQVi/nPZE3X57UpeFNJZ8DS8rVtJoFEasYpmHH2TdCR
         ovxwi0VFLE0TznaycwSCbG+shYCrMfwTJC2kEPwukS5E8iY/VEvqP9Lz6BMRcgN+jhWS
         4TVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772563404; x=1773168204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2819OTVP39Dj0dHEzzm3b3epsDVRvVb2TOUkNekw1lM=;
        b=nJvxnXqryfda3bzHieT5MNcfbM03WfwFYQc+rhEuKOGVrOcagCWvtYCsPEdDb15N3e
         SMMYAY9+VeKeC0qWH6nEp1mi/F0qOYw77ck9OqDQQku5D1jp07SFsOn6WUUQkXX/xPac
         vKoNhg7i9usKEoTslmdxbEr+iZyXDpePsayQgywsCmt7+J3MIuC1agwaV+I96DQziEtn
         hwP+eAHbEAalVIVMTEJE/Nl9EmRvbyE2sQVgpZ/xnR5spAHHG1HjE+Qf9Ibcxt/j1gNi
         M+xlURMQw7xcxD93hiLs/Q1PBsDM271DxG2j1s8uJclcrgwlSVKeHBH2ZEyC8HEZAVTo
         5m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563404; x=1773168204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2819OTVP39Dj0dHEzzm3b3epsDVRvVb2TOUkNekw1lM=;
        b=U8OLSyMBYOU15nq2B0Jt4l+lOpxWAVg1iPpElVxK3bgP5T2Vk6AboRDzejmexjDCsc
         GcKy7TTsRMtVbrMflr+ZVpuMnmkLvRYz6BxiBKVwalD2nlt05rsYz//cdb6i0AkXjANU
         mxctM+EJcRSHO+CqZ4rAH8bCSANTMkrwX+ROVAyVYIvL5K+9tTyihQwpatk1x4uXxW0t
         O8uqJNiZXbEgtAXHh/pSPK4BLOqGavVlkfGI1XMsue+KGmaZjiOzz33QBTJpjnPzPlTP
         MmYBh3pvHfM5+pXjNHWOUbKQn2WV57zkZ7lZSAHZWfKMjgLRTMzovteYo/koIdBhRNbn
         lKGA==
X-Gm-Message-State: AOJu0Yxlmw1yGMFE7o6E/QT7XbYEzCq314oeQTp54CVcFq+YJ6zDzaG+
	zVO1FX6KUw7h1xCVCxOc1DC/e3/MGhaHWMpjQNNs8F0/4Utnnbj3fXmQwfOg8VMrKC+sWwtda01
	CH/8h5omuxWzyxfGVWu184X4A8nWi19k09g==
X-Gm-Gg: ATEYQzxSnLf37Dt6iPXDUHM6zjJlOEw1syRTFzJ7GDP1jjN+WOdI3CR7cwtqYQGLMYh
	T+6QjoMTdrAZ+9PIYpZPcVdzvOcmRd2r7jHOU/gBSYCqtq961Wa1KSXQHFvNhLonXiJKJbPTJRl
	sQ5XUfe2hYYELGmxaJtjq9UhPcVq89ze6uPD/4nyZfTQFYimS8mbsOtBqBJz8PJnUbjDsH8h8w5
	XROjvLrIT5BK1yw4aHyH5JGw3bd1zBuZ8/k6YQrDrsAJtohYNR1gVaoMKIB039290t9LQWOmLdY
	qLmD5WQswL0ZEAnIVoROIeNjsSvnXvF1I2yDor04RzB7euV26qWmRgiYL+EcTNZ8NlVZ7S6jEwB
	uvuiCywYxDLYHLojx9DR1/u8Jwb4=
X-Received: by 2002:a17:90b:584e:b0:354:a332:1a61 with SMTP id
 98e67ed59e1d1-35965c276bfmr12053201a91.5.1772563403893; Tue, 03 Mar 2026
 10:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im> <20260302-pks-history-split-v1-7-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-7-444fc987a324@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 3 Mar 2026 13:43:12 -0500
X-Gm-Features: AaiRm52bHZzFoBRVQqhh6y9jDWutPmbX0jRsZairt8bXS1HckhV5mqDm8tNVnr0
Message-ID: <CALnO6CC5FB29bHPtyKD=L5EWxTCLx3K2qd+wGySdck7tCvvs_w@mail.gmail.com>
Subject: Re: [PATCH 7/8] builtin/history: split out extended function to
 create commits
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 7:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> In the next commit we're about to introduce a new command that splits up
> a commit into two. Most of the logic will be shared with rewording
> commits, except that we also need to have control over the parents and
> the old/new trees.
>
> Extract a new function `commit_tree_with_edited_message_ext()` to
> prepare for this commit.

Curious=E2=80=94what's the "ext" suffix mean here. Extracted? External? (Ma=
ybe
I'll get a better clue in the next patch.)

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/history.c | 67 +++++++++++++++++++++++++++++++++----------------=
------
>  1 file changed, 40 insertions(+), 27 deletions(-)
>
> diff --git a/builtin/history.c b/builtin/history.c
> index 1cf6c668cf..80726ce14b 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -83,10 +83,13 @@ static int fill_commit_message(struct repository *rep=
o,
>         return 0;
>  }
>
> -static int commit_tree_with_edited_message(struct repository *repo,
> -                                          const char *action,
> -                                          struct commit *original,
> -                                          struct commit **out)
> +static int commit_tree_with_edited_message_ext(struct repository *repo,
> +                                              const char *action,
> +                                              struct commit *commit_with=
_message,
> +                                              const struct commit_list *=
parents,
> +                                              const struct object_id *ol=
d_tree,
> +                                              const struct object_id *ne=
w_tree,
> +                                              struct commit **out)
>  {
>         const char *exclude_gpgsig[] =3D {
>                 /* We reencode the message, so the encoding needs to be s=
tripped. */
> @@ -100,44 +103,27 @@ static int commit_tree_with_edited_message(struct r=
epository *repo,
>         struct commit_extra_header *original_extra_headers =3D NULL;
>         struct strbuf commit_message =3D STRBUF_INIT;
>         struct object_id rewritten_commit_oid;
> -       struct object_id original_tree_oid;
> -       struct object_id parent_tree_oid;
>         char *original_author =3D NULL;
> -       struct commit *parent;
>         size_t len;
>         int ret;
>
> -       original_tree_oid =3D repo_get_commit_tree(repo, original)->objec=
t.oid;
> -
> -       parent =3D original->parents ? original->parents->item : NULL;
> -       if (parent) {
> -               if (repo_parse_commit(repo, parent)) {
> -                       ret =3D error(_("unable to parse parent commit %s=
"),
> -                                   oid_to_hex(&parent->object.oid));
> -                       goto out;
> -               }
> -
> -               parent_tree_oid =3D repo_get_commit_tree(repo, parent)->o=
bject.oid;
> -       } else {
> -               oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
> -       }
> -
>         /* We retain authorship of the original commit. */
> -       original_message =3D repo_logmsg_reencode(repo, original, NULL, N=
ULL);
> +       original_message =3D repo_logmsg_reencode(repo, commit_with_messa=
ge, NULL, NULL);
>         ptr =3D find_commit_header(original_message, "author", &len);
>         if (ptr)
>                 original_author =3D xmemdupz(ptr, len);
>         find_commit_subject(original_message, &original_body);
>
> -       ret =3D fill_commit_message(repo, &parent_tree_oid, &original_tre=
e_oid,
> +       ret =3D fill_commit_message(repo, old_tree, new_tree,
>                                   original_body, action, &commit_message)=
;
>         if (ret < 0)
>                 goto out;
>
> -       original_extra_headers =3D read_commit_extra_headers(original, ex=
clude_gpgsig);
> +       original_extra_headers =3D read_commit_extra_headers(commit_with_=
message,
> +                                                          exclude_gpgsig=
);
>
> -       ret =3D commit_tree_extended(commit_message.buf, commit_message.l=
en, &original_tree_oid,
> -                                  original->parents, &rewritten_commit_o=
id, original_author,
> +       ret =3D commit_tree_extended(commit_message.buf, commit_message.l=
en, new_tree,
> +                                  parents, &rewritten_commit_oid, origin=
al_author,
>                                    NULL, NULL, original_extra_headers);
>         if (ret < 0)
>                 goto out;
> @@ -151,6 +137,33 @@ static int commit_tree_with_edited_message(struct re=
pository *repo,
>         return ret;
>  }
>
> +static int commit_tree_with_edited_message(struct repository *repo,
> +                                          const char *action,
> +                                          struct commit *original,
> +                                          struct commit **out)
> +{
> +       struct object_id parent_tree_oid;
> +       const struct object_id *tree_oid;
> +       struct commit *parent;
> +
> +       tree_oid =3D &repo_get_commit_tree(repo, original)->object.oid;
> +
> +       parent =3D original->parents ? original->parents->item : NULL;
> +       if (parent) {
> +               if (repo_parse_commit(repo, parent)) {
> +                       return error(_("unable to parse parent commit %s"=
),
> +                                    oid_to_hex(&parent->object.oid));
> +               }
> +
> +               parent_tree_oid =3D repo_get_commit_tree(repo, parent)->o=
bject.oid;
> +       } else {
> +               oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
> +       }
> +
> +       return commit_tree_with_edited_message_ext(repo, action, original=
, original->parents,
> +                                                  &parent_tree_oid, tree=
_oid, out);
> +}
> +
>  enum ref_action {
>         REF_ACTION_DEFAULT,
>         REF_ACTION_BRANCHES,
>
> --
> 2.53.0.697.g625c4fb2da.dirty
>
>


--=20
D. Ben Knoble
