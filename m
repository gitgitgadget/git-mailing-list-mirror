Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03F161331
	for <git@vger.kernel.org>; Tue,  7 May 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096350; cv=none; b=BXVo7QwUqNGz+Noao6diBmFSYPZxo4IWPc+pT2eKGuPd2q/R+0hp/12XaQilGPhyzliOsaynWMQ9EV5laS/PTFhJJuPYlXyjT3VSQGyx/rpyVLZD9m/97R/L80YCnmTUYMW90KCOIfToTCo5CTdNoFkFUAk7nXk4AC8IaWJeUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096350; c=relaxed/simple;
	bh=kcG1YOJbiFfSh4TsW/AW4n8Hu+xZ/kRrdPt2HYrofE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPNSFpt9mdP4wVmuet457Fn9eTIs3QJhfdHW1V6kl46g52hT4M25D4rNYQAyy6ReYzrfQZ4vYvtote+JyUwqotVr9UU8gm5tYIGgwGUdrSr7aqUmt29HCfhxg8B/5ofzUU23Xi9h5FsZ569/DxKyeLrOW7pWyHuf/kchlp2+xtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCKqwQNW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCKqwQNW"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f71e4970bso3938550e87.2
        for <git@vger.kernel.org>; Tue, 07 May 2024 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715096347; x=1715701147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgZg+HHVvPrtbtqHAdFKnboKyinZieHx3i3qDB+Utbc=;
        b=ZCKqwQNWH0kXjEYx1Zdku4VnLVmHYiG5p+uYwTCP2oSscP+AXsNUmmlx5XBNXZ0m8a
         lNfxn2OFh9n/x8/Y/R5j5TWFg5OhDfNd82nxGxrLSaQb+GAZk+j9WL3/I7Sf6wXNbl6U
         zTb8qgWjNt3ve0QZEC9kLPIndkxZr6MLHOdkLlMB7QkMyhKP/SdQl5FvbMl5XUDktY1H
         zXMapw4tT0c+exdG/DPThrxpRUMdEGU8W7mdUHuqVc7/KIoG6PncBctxD0owhWr+4CTd
         4l3EAjHfbxOd1ltNQSdkLvU7c+D7stQZzfB/UgHgx4qPbrZ/n+QCryS9M1nL/focI/Kq
         gR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715096347; x=1715701147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgZg+HHVvPrtbtqHAdFKnboKyinZieHx3i3qDB+Utbc=;
        b=CPWYBgVvOj4+fzuyr94hHBD/Kue5Hfb/XbSagCmb9ZscWYDl/3TgYgJf3ael7LV469
         haktdXCzfJ6W91PzdyF8T6X6grJGxu6fXT8Z3C8QeXtbW6FU9ZsOqazaD9z4XTIY9D+O
         8ROdIDqj9aUV90vrDTF/wQ+EyhbzXmIkwb/vWt8EkbQzSR1tHxKQ5qzuMaurWkhE07TH
         R2fJhz1Vwy/g0B6cJmfmqF2XcEioyriihU1occjL3XgtlBLqsVyMcekXKwoc8dxsebGv
         9UTntFD01pehAWnYW+3LrZDKhkJENnkQ9eFrzDEbqAIPTT55WEBJjb9HInUYnBPQC5GF
         ORmA==
X-Gm-Message-State: AOJu0Yx4Zhs6r/I8osFKmvQjWF0gvFcjOrMX+ecsJUfJpluBvlzZ06h7
	w2fk/pSGQrNsC1wkM943L/MLGeX2qpZpHCWEjp/APHPrnPNFHpxEqOtOqNZE41qY642PkRsH+sD
	T7KJMWPWQ8UnMKuOOHkEI1PufeUI=
X-Google-Smtp-Source: AGHT+IFi8yMZ3HBOW2lqx23UXa1UfPNlNbYTRUYbnU3aEh0f03aQNi/XrdFKSDVJ8miejCPUSJII9ya0zcblcfnsAnQ=
X-Received: by 2002:a19:7505:0:b0:51d:a8ce:540 with SMTP id
 y5-20020a197505000000b0051da8ce0540mr9518974lfe.35.1715096346615; Tue, 07 May
 2024 08:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
 <pull.1723.v5.git.1714934950.gitgitgadget@gmail.com> <85f45a57f3529a90324ded07856fca610f7b5eda.1714934950.git.gitgitgadget@gmail.com>
In-Reply-To: <85f45a57f3529a90324ded07856fca610f7b5eda.1714934950.git.gitgitgadget@gmail.com>
From: John Passaro <john.a.passaro@gmail.com>
Date: Tue, 7 May 2024 11:38:29 -0400
Message-ID: <CAJdN7KhFtjWZfuGPsu2gWy7Dqth=PsVpA_d8923aNUqmQu8Phg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] builtin/commit: use ARGV macro to collect trailers
To: John Passaro via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 2:49=E2=80=AFPM John Passaro via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>

Thank you for queuing the patch series! Hopeful and excited that this
may go in a future release.

> From: John Passaro <john.a.passaro@gmail.com>
>
> Replace git-commit's callback for --trailer with the standard
> OPT_PASSTHRU_ARGV macro. The callback only adds its values to a strvec
> and sanity-checking that `unset` is always false; both of these are
> already implemented in the parse-option API.
>
> Signed-off-by: John Passaro <john.a.passaro@gmail.com>

Looking over the patch series I notice that I left a grammar error in
this description,
if the patch makes it to the "next" branch I hope you can amend the
message first,
as follows:

Replace git-commit's callback for --trailer with the standard
OPT_PASSTHRU_ARGV macro. The callback only adds its values to a strvec
and sanity-checks that `unset` is always false; both of these are
already implemented in the parse-option API.

> ---
>  builtin/commit.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6e1484446b0..5a3248370db 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -142,14 +142,6 @@ static struct strbuf message =3D STRBUF_INIT;
>
>  static enum wt_status_format status_format =3D STATUS_FORMAT_UNSPECIFIED=
;
>
> -static int opt_pass_trailer(const struct option *opt, const char *arg, i=
nt unset)
> -{
> -       BUG_ON_OPT_NEG(unset);
> -
> -       strvec_pushl(opt->value, "--trailer", arg, NULL);
> -       return 0;
> -}
> -
>  static int opt_parse_porcelain(const struct option *opt, const char *arg=
, int unset)
>  {
>         enum wt_status_format *value =3D (enum wt_status_format *)opt->va=
lue;
> @@ -1673,7 +1665,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
>                 OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword=
):]commit"), N_("use autosquash formatted message to fixup or amend/reword =
specified commit")),
>                 OPT_STRING(0, "squash", &squash_message, N_("commit"), N_=
("use autosquash formatted message to squash specified commit")),
>                 OPT_BOOL(0, "reset-author", &renew_authorship, N_("the co=
mmit is authored by me now (used with -C/-c/--amend)")),
> -               OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer")=
, N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
> +               OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("traile=
r"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
>                 OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-b=
y trailer")),
>                 OPT_FILENAME('t', "template", &template_file, N_("use spe=
cified template file")),
>                 OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commi=
t")),
> --
> gitgitgadget
>
