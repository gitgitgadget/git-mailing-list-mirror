Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF483DA7CF
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037492; cv=pass; b=Ftog7+5C+2OwDG3OY9cMaiplQmDbw1PRmMzU9E4SKAItQsq/yC6TSobDW512dYIgpYTf10hdtxHDN4Id0FmugsNLVTFgFCo8rqLzB3DL3xz+sK/nZD46/Gfk3kTrZSPspPS5AM3rZsbOAeRznSl6l3QPYhQX3fwxGKrp/zDmhZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037492; c=relaxed/simple;
	bh=YsaTkwOfEsxLulaC//7fORhLyEyzmVSBquJ/frWVHKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zj23uLHBnX8ntl9v4yWoFN/eDgN/u8FZeh/1a2Qgek3uh6ctFCDQPzog4Mc2hY7IEw3gD5cosIF/0tPHIVQiKLYNYhgHnZZWOYDUQrFk3qDEBx7j3aJOimLGyTKQgjbNsngpJTNAU0xQEXnjt1B++B2ByqIz5QNja9O99iKfL9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYASAyAk; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYASAyAk"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82735a41920so102522b3a.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 08:38:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772037489; cv=none;
        d=google.com; s=arc-20240605;
        b=bdq9yCZmAGQ03Aw2DfGPvATiRp2lqw7n+Alt4xwEuCmT5VmLmv+wBUrb9wWrtTS+as
         b0afzRgyBm6lq83TrAyAw1H/DzV/hGUHD7AN8LROYUyD3uy8Es1bmKTBRSx3U20c1m7a
         rTjoXZ79KTmXPnNgqEqLS4o7deaT58nApM/5DpN0gklgfR0B8dKcYmzFgb5PPApKXZ3I
         LuKRRen+0VeiF8JZH5QRjk1zeeFvbwjHtp5/T7DFtvZKjrnZmHDhGmvJfHxXfdV4TkTa
         ZnteE54sxJJmCsyXYutDKBFCWxtw4hrmOqrH1dItRQmYEzzhyhZ4mJ1rc3DmbsvkkAJh
         Auvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TFZEj5T+oX6KlID3khVHZS6SxXNpNuyzaKCG0A04eUw=;
        fh=+6L8SzXcTOAeBxNT1VAt9d49Q4rxErvypDR+0XIfKzw=;
        b=BTNkIVmdXbCfSW7qF5HrEJgBOC9mwnYGnPHbG/A3DwqafefRzr2WGwBJzSoMXvKDkZ
         pBDc3SCLi1irkuBZ7NNB6wTPr8rGbd2ZbOsOSuoF+8xcVR6a5ENyKRTiTk+OCGITllER
         pyIINU/5FQYxhX0qdM4o12s/w0srytRNGp5ApL/YO8HsOVoAfzzbrOdzIWtVOAnLx+e1
         qOxZ+9mY8LUoXcOwFSUiDiwPtr4FjkCf0EQ5rrhl30HhRDhueXKoNsRh0N7cptqNdIfX
         1zh0m0mVu582jqwF17TmCWuXSUR75cHqnTkQ8Dpd4/W5U6tZJc9sMe6FiqtHvnobqu1S
         5bKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772037489; x=1772642289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFZEj5T+oX6KlID3khVHZS6SxXNpNuyzaKCG0A04eUw=;
        b=bYASAyAkOOdbniGI7Oovw8MQ8tnvbMjif7uiLM8ppVP/eEri+cs1aq0vlF77kGlwnD
         DWGA7WNAx/oeGPdYDBGyHDxJyBKOurgyvMvsJqbO5zQkLOcx1EwmqAor8zu5XLjHbVsf
         5CN0bWiS/B4ZKKp9ibS+G48OvSwiQPd1Y4xShy/EI2574aW8NO0zIY6og+AJLAe77wgc
         29oLBCN0iF+H+oxq9TyzBKD/JCfGDd4Djj/Xytf8gBIu9i52OexwOxg7NgYXi5u4QDk5
         n46YvbZyAeyu6KtprWA0Vth/pkfC87Evyeqc4etrV9hepJXzyJG8Zf0buE0KIRRjVj6I
         BCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772037489; x=1772642289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TFZEj5T+oX6KlID3khVHZS6SxXNpNuyzaKCG0A04eUw=;
        b=hIeah/flhc91L2VamdxU8z8bWruBajW6IAohj0WriiInINHoqXoOrIaCVBkZyFDaJJ
         eX6uaiADzpV7D9RcQL+0CjKVVOjiKe/FV2B665Tfl61+EH1doFsakj11VoS6DuZRsI4F
         oKwnEx8JLQzuDIiUz07FFgzjrKItkI83WEYWwpz/C+W7cLOq2gvqF4g2SF9WLuJb1YXa
         JiIsKZoWNBLPT6SxDGigRbEYKTjVo1CWzpBIXLGe2+k1cqu7ogH442EZQ2IIw4Lbdvh5
         4orDH3q4ameqNU838OWauF6/q/SMmNgGcLS0bvGL/sjj98jYfKyWVHynSgMG7l4P9EDj
         FFMQ==
X-Gm-Message-State: AOJu0YwUUWRyr/76PypLb+tfgvRWvKk77RTuX7ddqCr9YnGZXEFo0itc
	fHBxiDMNh5f9enlnrEUro52Okv2il3OTH69rKBRgkoxe4ieY9rNO0vrIEdmQMlhGc3cmR/1dHih
	izj7a4c/n8U8kf2VSDQlSyqKiSHV3Defy/w==
X-Gm-Gg: ATEYQzx9qA+1x9HaJlT6A65LqcpD4E25GegWZVF4GtMSn4QtChhgn0qeOIGuEVn9mYB
	jD3ozjOYKhelsUUOSuuN4ZW2LjYOPIDyBoJbY4fDHFfUdIRTb+n+L7qpS59elTNcg7+tVDLrJM+
	tl4Q8UyVK77qD2tNTmYgtzOlsvCYu/DsCKMTZBJrF1UJxSvBXmlsO3PiReh9+MCGzyy807n5RZJ
	MOqQ0QYWd3odur710/E0vxjZOlIdcovP15lrsQ+ehC3mbJsOLgNRKi7Z/NgVvJOTmX1sK8dUyoM
	mAw2Ybxm149HEAHA124jhjigewY3iIbd9Ed8ZdQ/c3IYNMblTGl7VoIlZF4L9ouF1SX9etTIE7C
	Izu8W
X-Received: by 2002:a17:90b:4f89:b0:356:2fc5:30f5 with SMTP id
 98e67ed59e1d1-358ae7fc5b2mr12841303a91.13.1772037488862; Wed, 25 Feb 2026
 08:38:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com> <20260224213932.92364-1-shreyanshpaliwalcmsmn@gmail.com>
In-Reply-To: <20260224213932.92364-1-shreyanshpaliwalcmsmn@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 25 Feb 2026 11:37:57 -0500
X-Gm-Features: AaiRm52D9eM0HWSqS6XHBlOTFmY2wvZFSq7m3njzj84Fm-sTJdZ-4AP1nGSS7jQ
Message-ID: <CALnO6CDSJPnVi-1RUsr7tFMwa0_xTJkiQmzTL_b-BGq=6PSz0A@mail.gmail.com>
Subject: Re: [PATCH v2] send-email: validate charset name in 8bit encoding prompt
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 4:39=E2=80=AFPM Shreyansh Paliwal
<shreyanshpaliwalcmsmn@gmail.com> wrote:
>
> When a non-ASCII character is detected in the body or subject of the emai=
l
> the user is prompted with,
>
>   Which 8bit encoding should I declare [UTF-8]? foo
>
> After this the input string is validated by the regex, based on the fact
> that the charset string will be minimum 4 characters [1]. If the string i=
s
> more than 4 letters the email is sent, if not then a second prompt to
> confirm is asked to the user,
>
>   Are you sure you want to use <foo> [y/N]? y
>
> This relies on a length based regex heuristic check to validate the user
> input, and can allow clearly invalid charset names to pass if the input i=
s
> greater than 4 characters.
>
> Add a semantic validation of the charset name using the
> Encode::find_encoding() module of perl. If the encoding is not recognized=
,
> warn the user and ask for confirmation before proceeding. After this
> validation the lenght based validation becomes redundant and also breaks
> flow, so change the regex of valid input to any non blank string.
>
> Additionally, the wording of the first prompt can confuse the user if not
> read properly or under any default assumptions for a yes/no prompt. Chang=
e
> the wording to make it explicitly clear to the user that the prompt needs=
 a
> string input, UTF-8 being the default.
>
> The intended flow is,
>
>   Declare which 8bit encoding to use [default: UTF-8]? foobar
>   warning: 'foobar' does not appear to be a valid charset name.
>   Are you sure you want to use <foobar> [y/N]?
>
> [1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c89=
36fb8b
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
> Changes in v2:
>  - Added braces in if-else block.
>
>  git-send-email.perl   | 17 ++++++++++++++---
>  t/t9001-send-email.sh |  2 +-
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index cd4b316ddc..15387ac377 100755
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
> @@ -987,6 +988,7 @@ sub get_patch_subject {
>  sub ask {
>         my ($prompt, %arg) =3D @_;
>         my $valid_re =3D $arg{valid_re};
> +       my $warn_invalid =3D $arg{warn_invalid};
>         my $default =3D $arg{default};
>         my $confirm_only =3D $arg{confirm_only};
>         my $resp;
> @@ -1005,7 +1007,15 @@ sub ask {
>                         return $default;
>                 }
>                 if (!defined $valid_re or $resp =3D~ /$valid_re/) {
> -                       return $resp;
> +                       if ($warn_invalid) {
> +                               if (find_encoding($resp)) {
> +                                       return $resp;
> +                               } else {
> +                                       printf STDERR __("warning: '%s' d=
oes not appear to be a valid charset name.\n"), $resp;
> +                               }
> +                       } else {
> +                               return $resp;
> +                       }

I think this is asking "ask" to do too much, since only encoding
askers can use warn_invalid.

What I rather meant was to extract relevant helper procedures so that
open-coding ask around the encoding question would be easier to
maintain.

>                 }
>                 if ($confirm_only) {
>                         my $yesno =3D $term->readline(
> @@ -1044,8 +1054,9 @@ sub file_declares_8bit_cte {
>         foreach my $f (sort keys %broken_encoding) {
>                 print "    $f\n";
>         }
> -       $auto_8bit_encoding =3D ask(__("Which 8bit encoding should I decl=
are [UTF-8]? "),
> -                                 valid_re =3D> qr/.{4}/, confirm_only =
=3D> 1,
> +       $auto_8bit_encoding =3D ask(__("Declare which 8bit encoding to us=
e [default: UTF-8]? "),
> +                                 valid_re =3D> qr/^\S+$/, confirm_only =
=3D> 1,
> +                                 warn_invalid =3D> 1,
>                                   default =3D> "UTF-8");
>  }
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index e56e0c8d77..24f6c76aee 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1691,7 +1691,7 @@ test_expect_success $PREREQ 'asks about and fixes 8=
bit encodings' '
>                         email-using-8bit >stdout &&
>         grep "do not declare a Content-Transfer-Encoding" stdout &&
>         grep email-using-8bit stdout &&
> -       grep "Which 8bit encoding" stdout &&
> +       grep "Declare which 8bit encoding to use" stdout &&
>         grep -E "Content|MIME" msgtxt1 >actual &&
>         test_cmp content-type-decl actual
>  '
>
> Range-diff against v1:
> 1:  70fa4d2899 ! 1:  954c1dae9f send-email: validate charset name in 8bit=
 encoding prompt
>     @@ git-send-email.perl: sub ask {
>                 if (!defined $valid_re or $resp =3D~ /$valid_re/) {
>      -                  return $resp;
>      +                  if ($warn_invalid) {
>     -+                          if (find_encoding($resp))
>     ++                          if (find_encoding($resp)) {
>      +                                  return $resp;
>     -+                          else
>     ++                          } else {
>      +                                  printf STDERR __("warning: '%s' d=
oes not appear to be a valid charset name.\n"), $resp;
>     -+                  } else
>     ++                          }
>     ++                  } else {
>      +                          return $resp;
>     ++                  }
>                 }
>                 if ($confirm_only) {
>                         my $yesno =3D $term->readline(
> --
> 2.53.0



--=20
D. Ben Knoble
