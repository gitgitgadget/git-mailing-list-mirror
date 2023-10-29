Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4FF33D1
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="han63LE2"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF72CC
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:17:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50797cf5b69so4697674e87.2
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560241; x=1699165041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiyG8ofev7H9NZy5G2OHhT0BDt7GLmTST4nasqdsS3s=;
        b=han63LE2i27ZE6MfVsBoxOaJlC8fuieAOEej3DCS5CmMXrp/ywT8awjh3KPu9m1D7n
         x/hDkd3hxKZQS4EDcmKP/it1yxewW5sXz+HXbTNTdG9QUoS/h46piwX9DJo7HgMJBs87
         VcTkkJjxHMxfP2D48r0cHUeAVIuOdqqCUn6VLng/bLmqxGK9j/Y49EwgcVHgD24Ty0R2
         Bghv2mNoNjcM9WdOu95Ab632KYTXHlydvOGv8iRuCLGa/VFt0O5kVrm9SXxQ2UMu/6FK
         RLgBh4f8HdcitgG72f478FE389+Coc7B+S5n47pgdgbjX4yVLKwCoVbYoa4EILFW/wcE
         TtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560241; x=1699165041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiyG8ofev7H9NZy5G2OHhT0BDt7GLmTST4nasqdsS3s=;
        b=Nx8pw7fY+Mfwo5Y4Mwpe3U+NZVl9BEIlzo6eMs5UAtRu+epeTSXdeVW+QQp59eGPyH
         21QfpnUDXPYJDCIVQtDi3bc8Cofwdg1Cb0e+HDnfQ9+Eiuki/18x+Lzgzq3UBOojqF1F
         4wHXxnx8P94h15X0Z5Mz78JCv9y+sFh/n1VqahzqmA+p4XKbrkCMCshOI1aPiWWKGTTy
         MhYBq+3z++QBYYnrZVHWxKT8v6GpWF0c4mQ5Uu3WIXg1h51FIJRWGrh7FSCexKs1/shO
         OCfpD9xGQAE/op6Q3/enjSeYr6XgCcBvQTZpXMtFVp5eV/+jYx3grhelWigaQ8LBNZT4
         RRZA==
X-Gm-Message-State: AOJu0Yx5CyPHPEvD3rjtxohAxWff287FK27gmsmKsCzABGgZGb/wy5CR
	Tm8SsEncmoljBB3PoKwGku6aKbDGlwxp6Eb8Cxo=
X-Google-Smtp-Source: AGHT+IGh/er43NYxh9q8rzLt3yQjVqoQOnJIGypyBu2wv5KwbnfJ85cWNkAnZjYOWNdHcmRTZ9RCu10MXp76ZvhEBNA=
X-Received: by 2002:a05:6512:3a8b:b0:509:1207:5e9a with SMTP id
 q11-20020a0565123a8b00b0050912075e9amr2202207lfu.42.1698560241517; Sat, 28
 Oct 2023 23:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net> <20231024195655.2413191-2-sandals@crustytoothpaste.net>
In-Reply-To: <20231024195655.2413191-2-sandals@crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 28 Oct 2023 23:17:09 -0700
Message-ID: <CABPp-BG9Y6aZ+TWdkL4QE9e12fu3n61V16G6DLtawEDe=g9F4w@mail.gmail.com>
Subject: Re: [PATCH 1/1] merge-file: add an option to process object IDs
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Overall, looks good.  Just a couple questions...

On Tue, Oct 24, 2023 at 12:58=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> From: "brian m. carlson" <bk2204@github.com>
>
[...]
> --- a/Documentation/git-merge-file.txt
> +++ b/Documentation/git-merge-file.txt
> @@ -12,6 +12,9 @@ SYNOPSIS
>  'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
>         [--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-si=
ze=3D<n>]
>         [--[no-]diff3] <current-file> <base-file> <other-file>
> +'git merge-file' --object-id [-L <current-name> [-L <base-name> [-L <oth=
er-name>]]]
> +       [--ours|--theirs|--union] [-q|--quiet] [--marker-size=3D<n>]
> +       [--[no-]diff3] <current-oid> <base-oid> <other-oid>

Why was the `[-p|--stdout]` option removed in the second synopsis?
Elsewhere you explicitly call it out as a possibility to be used with
--object-id.

Also, why the extra synopsis instead of just adding a `[--object-id]`
option to the previous one?

[...]
> @@ -80,12 +88,21 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
>
>                 fname =3D prefix_filename(prefix, argv[i]);
>
> -               if (read_mmfile(mmf, fname))
> +               if (object_id) {
> +                       if (repo_get_oid(the_repository, argv[i], &oid))
> +                               ret =3D -1;
> +                       else if (!oideq(&oid, the_hash_algo->empty_blob))
> +                               read_mmblob(mmf, &oid);
> +                       else
> +                               read_mmfile(mmf, "/dev/null");

Does "/dev/null" have any portability considerations?  (I really don't
know; just curious.)
