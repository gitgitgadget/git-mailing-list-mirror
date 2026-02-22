Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC74B665
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771772441; cv=pass; b=GODUjMKcs6Zm5ZSlbU3rctzZmbr2GvXg0f3dcy/jLhrkOljd2FPd49/8VgUkuoiF65z05AVl3DaP6mCM7x6FebH6MkzKMYZ1vT4Rc8S+0u6uxiN+AMUCCTWJUm31JkYi4k5SbURRCmAsYa/GDUWwzRrjKfrtTyahuvo0yy7RhKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771772441; c=relaxed/simple;
	bh=cXqI+m/bcSwnGI+IivRwKsRsE+zrBwCfj/6w2/St+2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbQ63KAcCRB5FNXC75wVSYQPzVrAftxibzoq76gJdOIhRUcshtlypTji02xiXfmA5bEXdQ1ZYtseB2IJoOZa+yqiZj35mZKo1PEWA62O5E0I/mBmZQouIMM1mpAukSQsyRMT7x5vY2ELDJkBY+dgFx3ZLxU8mYM/Xo67PftincY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF7GbDIl; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF7GbDIl"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6e1f417918so896530a12.3
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 07:00:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771772440; cv=none;
        d=google.com; s=arc-20240605;
        b=NH1yAkPuCkV0PodoL89zF2sJZOlzWNLzBZSRzH32A0WIl/SGqZinRWQg0M/CHNHeh6
         oDjGZvMvqA+HpzB/Rgb6EnyMcbniVjXthtrXLi5uED1qI5TWRrDMZJn7LxR0AtCLdoZJ
         ArcmZ4BPhp0llA51CnC19AGY5ZMKK8H/oDPWsqXfmSzDfWrZHsTVBeC87jR5BOwhSy2g
         4wbMtRlBXMdoOsOUGoG9NZxAlkbva2le+0HmdKKErMqm7+NZT2raOuJLdi98VVP2gYcd
         8jyySKavALUkAPNmb1TE+/v/T9QV+EOYUHLaCY6u9Xff/C6R6UAMVpkTtm/0lMOMk508
         kFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MzSRAQBw/DFol1AWaOSNdMyvaeZ9SQXk7BDVA8elBY4=;
        fh=Vj8sMiGJa70dxN26W2KAbr81eWeOJ+XDSKy0FiVmpyQ=;
        b=Dkfy5x1Dd3dm+IVXKFVAHoi/6xfwNYTD3NY1xdXAHKtZr5+rc+3+/eDLZzTpji24VC
         BiCFRYFh/Kmx6Uzdt35KC+Eqj8wB8pRPuY3iB4AWYFPD7caqpCfukgKxF5RH8zCzdHDn
         E16vbvkVQIE7N+aMLe6i6hebdyC3rRidUsb0aCN9xGI676+iluN2iLRcLjE852niceM7
         AaXg5ltBRafrSYTyMXPmT4RZXqGXaIFHMYOlxGkewPnoACCNmcnaVEx029WNNle8dcgj
         NCd1+hbjekRAVzYKh7T6CHQroIXnzp9Gu30rZ6X0f8o/LeyjntqfocgSYL7m+sWwLnzh
         86vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771772440; x=1772377240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzSRAQBw/DFol1AWaOSNdMyvaeZ9SQXk7BDVA8elBY4=;
        b=cF7GbDIlfkwSyUhfUMMPlmU31JW9kVLunupDy+nRMtw/XyuJNdfyndDc7niIAAcYzX
         HAsalwtM0h3AypJuOPjWqoxaooMA9xmT6CRS62tWTez2IxIwDMouqZwyrjrUOPX64E7s
         GlIH6MpjKl0ZT5INqfSCZk5CnDvh9zaC7RhSeKOeoVFba5ynHloR1yKP3lgscVTGNQB7
         z+bUn2EuYa6unXoIbc0f31tSOhfAQ3Rq3QMKCwTcXf8N4Z/eUL2BWTpPdezVlp3HZCmj
         RfaQY9NhYjHPmOPJpeemiPCkBGbC2HZSZvdQVAJ9pKpHyGpI2oULDq3eGa3U0VghHAHA
         YtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771772440; x=1772377240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MzSRAQBw/DFol1AWaOSNdMyvaeZ9SQXk7BDVA8elBY4=;
        b=lBGsti3r0hleU6clS57ByOtdk6u/44J7O2Uge20eXvOUZNP2i0VSwu/z8udCKHQd2+
         kgADY2/GDguUXvRj0/0nowq8/1WO41JDB4Nsrm3n+5mGL8vxd0gehFQ2tgcy0Dx2Krb6
         nEmJDnJE0BiGXgoiNXcGD8KXPxdQzym+Lm8hpd1F8hHDgD9wgLtbEpJoKzJxZR7Il/hg
         /hpopS8vsnjG1P/9IMaIMWXGJ54pcQmOxoRNk0z5WY6YYRQ+/dow682Uui+Jj2L39Ba0
         9RyrLdynpa6/TR5q325IapsvGF5SKmLX6XO3e0jhxdz18xN3WaD+4o71QasSHrAel7nP
         r1yQ==
X-Gm-Message-State: AOJu0YxeB5FRdjsYR/n2DIWzwk0FObjwzQP0lnl+sCI0dhnDkiLe4IBO
	TVqXjuqWOW0UjP/1rW1gsNiyXAWTy2/A6We/xnxu8fiLehrEHHNyvjh1fJwVPGA6QiABSa2CVM4
	SGjw7Sxukb0fSwSvewQLqtC2pNoYrwjs=
X-Gm-Gg: AZuq6aKoDtG3euB1G99TEf5ZtIBgeTQMH0ZF28exUuEtgZ8DMC/ct71/ELieyYgaLgH
	LgRyqWwI5QsRwSHUOxx/RI1saeRdI8g9TwhSKJ5kq2vxLLUPt92j78czl+zuo6D1POgno29kSE4
	Miy+5Aw3cE63w66GMyWAEC7VfuJPOEPnayfDongBoToooA9RerVJgvKiFTeV31xFuV7oUPmy2ED
	dDQWKzj19/SP2k8foUnnsPjUSQK0rfUoJkCM+aBU/mUViTS7ogZYGU382IN99gil05RQ9cChdjY
	sOeQifN1aZeoe5HjfSiTrKkhYprOz5TutF4c8MpTHmiB8UQB93/ZXzgsloeuz3aynh0bPsMf1kw
	ycXvY42YlJxw9jSth+x1Q4PO4iw==
X-Received: by 2002:a17:90b:48d1:b0:354:a60e:9bcb with SMTP id
 98e67ed59e1d1-358ae7be1fbmr3903387a91.5.1771772439847; Sun, 22 Feb 2026
 07:00:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldgmrom9.fsf@gitster.g> <20260222140737.1760413-1-shreyanshpaliwalcmsmn@gmail.com>
In-Reply-To: <20260222140737.1760413-1-shreyanshpaliwalcmsmn@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 22 Feb 2026 10:00:28 -0500
X-Gm-Features: AaiRm51ozRkbjUHTU1hSX70rpRa7FSWpf4_sUGtouruVTxw8KTcS7HhYmN5pZr4
Message-ID: <CALnO6CBhB+O-CBCw3f+2n5yaHO7Wk7-Adaa9_4shXZvciGpUPA@mail.gmail.com>
Subject: Re: [RFC] send-email: UTF-8 encoding in subject line
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 9:07=E2=80=AFAM Shreyansh Paliwal
<shreyanshpaliwalcmsmn@gmail.com> wrote:
>
> > > That makes sense, I tried it below.
> > > I also wondered whether, in addition to this, it might be helpful to =
warn on
> > > an invalid charset, and/or possibly fall back to UTF-8.
> >
> > Agreed on the first half of the statement, if we have an easy and
> > portable way to tell if a given random string names a valid charset.
> > I do not recommend to "fall back" to anything, if we are asking an
> > input from the user.
>
> Following up on this, I tried adding a warning when the provided charset
> does not appear to be valid. Current flow is,
>
>   Which 8bit encoding should I declare [UTF-8]? y
>   Are you sure you want to use <y> [y/N]? y
>
> With the additional check, it becomes,
>
>   Which 8bit encoding should I declare [default: UTF-8]? y
>   warning: 'y' does not appear to be a valid charset name.
>   Are you sure you want to use <y> [y/N]?
>
> This uses find_encoding() from Perl=E2=80=99s Encode module to detect any
> unrecognized charset names.
>
> Let me know what you think.
> Also, is there any new test that should be added for this change?
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>  git-send-email.perl | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index cd4b316ddc..e62fa259ba 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -23,6 +23,7 @@
>  use Git::LoadCPAN::Error qw(:try);
>  use Git;
>  use Git::I18N;
> +use Encode qw(find_encoding);
>
>  Getopt::Long::Configure qw/ pass_through /;
>
> @@ -1044,9 +1045,25 @@ sub file_declares_8bit_cte {
>         foreach my $f (sort keys %broken_encoding) {
>                 print "    $f\n";
>         }
> -       $auto_8bit_encoding =3D ask(__("Which 8bit encoding should I decl=
are [UTF-8]? "),
> -                                 valid_re =3D> qr/.{4}/, confirm_only =
=3D> 1,
> -                                 default =3D> "UTF-8");
> +       while (1) {
> +               my $encoding =3D ask(__("Which 8bit encoding should I dec=
lare [default: UTF-8]? "),
> +                       valid_re =3D> qr/^\S+$/,
> +                       default  =3D> "UTF-8");

Here we change things, right?

- The original validation is "at least 4 characters", the new
validation is "at least one non-blank." I'm not sure why we'd prefer
one or the other, frankly. The original goes to 852a15d748
(send-email: ask confirmation if given encoding name is very short,
2015-02-13), which is motivated by the same problem we're discussing
here!
- We get rid of confirm_only, since we're about to roll our own
confirmation below:

> +               next unless defined $encoding;
> +               if (find_encoding($encoding)) {
> +                       $auto_8bit_encoding =3D $encoding;
> +                       last;
> +               }
> +               printf STDERR __("warning: '%s' does not appear to be a v=
alid charset name.\n"), $encoding;
> +               my $yesno =3D ask(
> +                       sprintf(__("Are you sure you want to use <%s> [y/=
N]? "), $encoding),
> +                       valid_re =3D> qr/^(?:y|n)/i,
> +                       default  =3D> 'n');

=E2=80=A6which might want refactored a bit so it can stay close to the orig=
inal? idk.

> +               if (defined $yesno && $yesno =3D~ /^y/i) {
> +                       $auto_8bit_encoding =3D $encoding;
> +                       last;
> +               }
> +       }
>  }
>
>  if (!$force) {
> --
> 2.53.0



--=20
D. Ben Knoble
