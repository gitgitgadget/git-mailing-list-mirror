Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14768175A94
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772313389; cv=pass; b=DZtpPWAD9wxxxg+WzrnuXYUwXjL786c1AzMyVtbJ3g9rcEFJxcvAPgxWm6hlLtE49k0DO8PeFfkaeeJOVK99tfb860iO9Jw8mGjW9XsDuTAq0BNEbevkMrxF+frQDq2ZQZTHe4IrwmvvfLUGhgvxzT66+3iq0ieGWDYqjz0Jt7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772313389; c=relaxed/simple;
	bh=in+Jve12mWFcB6L1hpc5+LmPDerjT1FYODpmYZPLJ4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4q9nfJpNFbKaLGoe61/AaxZWaPL8zlrdZvfeX4jt7swhuk+ZjW3b7+RYqj4D3DO8AJWawCh9oyv0PppUe+FIy0JE1Ocb3tEblX5FBYJcrICQss0QLbNJ9havS3XsRTGgnWHgh6tArc+IctplMxVYLVAVflYPXgNcYUWRfLdJV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4dIAOP9; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4dIAOP9"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3562e858da5so1373402a91.2
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 13:16:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772313387; cv=none;
        d=google.com; s=arc-20240605;
        b=VQHj5TOdXCog/Zv+3nD/SUeWB3vuZTHweF192/16lOSIdmb33n4gurCX1R7H7LJceL
         pf+r7jplNYnRJI1lCbmMIwZKJupSVD+CZruG33iNqL5fXJzRM+9Piey2Jt1ACIeeFV98
         +t/doj3J0GK2AEiI7v6U0/Sq0Ntrwhfv/rvXFPe1yMgiJZ6/LkTU4rCDAiZt8gNEI9Q7
         Bg7mUoepARpr8LaDcVqcODi8VKGF073vFZP+FQFf/1/D6/eU/s6WBSXnYWG8hDdXPd16
         5z34UKmg06VgVtnlQoT6dp654bEGlIC2FsOR4v8k/95ire9NN/vVqufsKkv3sIfAiF5s
         gVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BgzqOVph4tlr8xEAE9i1HZIDv247FIn94q3R38Dq6mE=;
        fh=+6L8SzXcTOAeBxNT1VAt9d49Q4rxErvypDR+0XIfKzw=;
        b=ZqfbfLH1Wx5QoeT3abuS3h/nro48dqGguOno+ZsjDSrWp+4T/hY27xtVbvKLPVw8lB
         8lTMxunYRvlv+ANq4/gOfFBD+cskwK+0Y7ib6cbqV6DXUtnMx0ACtPPecsxkcaEHLtbA
         oP8zLvnZTEdQxGGFnScOGFVkbCT4kCNvDmfwTmhlQhEDcRM0cUc0Qs5pTlYHFM78PGAb
         ZdkTVGnkkjDwxiEgrpwhTXRA23BCFQSZt5O5h6JmoSr2AZDxwU2XcrtEaASSSyBwzTZ9
         SR3Sb6E+T+Ht8X9m+emhYK/fALbqf+R5MK+UUG2RtuB7asL4fwVbA1nZ+gkfK92T9enC
         iN7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772313387; x=1772918187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgzqOVph4tlr8xEAE9i1HZIDv247FIn94q3R38Dq6mE=;
        b=a4dIAOP9dyOoQObYvdMGFiLgTZykGMGb/rqRjphxx321DikJtXpY6zUFPK7hRFsG90
         87CEqGphVvV8/jZCXwM5mlg192/Rsanji0aJGk7z6X1lKtwdPbtKVx3OlQogfUzXpHpL
         mh1/rKP3fqobd6XONwzk2jGjkst8QzYQfATCDWpw5pTvJBkcteXjt+SRoQ1fuNH6oekg
         AK0b7t0BbT3iItMyThF6e2DZsfyR2ELuPqU/Eyz2lGkexn/YHRvkTGp2jCte42vGcUQ0
         3BAitkSHfVQsiumVWV6Ohv72gs3z6cs/Zub9noaTrY5pPadwPVl7N1sk645MtpD+Bl0i
         VX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772313387; x=1772918187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BgzqOVph4tlr8xEAE9i1HZIDv247FIn94q3R38Dq6mE=;
        b=B5rcK0UHZ+dXYX+OvG3qWzi6rFecdL9k/fzVERTqSv0rgTo0IgtzaKT1suEKGsKhCd
         DJBDiiZ770YkNHZYeLlqch9Kf32PirElUpGivLJhjTgoVHNESlRjGri9bU/FJr27RuKe
         BVhzCbl9PhHM3BOK/8iPo/Gvrs74JAJoLykAqe1KVBzaW2mSe4m7n7HFChVybE1EGRpB
         Sgxc904qTAabEgH8GOeK/HR9LwSiQqJ5u5a2MQyX5z543hFwIYC346vPJwusJIqOxYxd
         j4GLaXeFculp0/yzjD9Ng9/N5igQKAdfyNDdBTcFkieninwGsX+O1tjNu8gotf5/V73z
         JbZQ==
X-Gm-Message-State: AOJu0YwugW+efGbtYqEEVt9VJgS4uVDAe5FQ0c+8rsPnHR0b074HvxPc
	aOnbDHIiyGGs5AQG5Vu1Dwi6oaqf42Q0kqylrknQKzAHV4trCSMP8Co0uWL6APYQRK3U/Ng7mj4
	VpIRLj7MqoDcSXW/Y7fsLQqAxsHhi4dI=
X-Gm-Gg: ATEYQzzxVu8VsLXcfS8kqtSDAe2zTK1VBY/GR99X8RSxhSnhW8gcHCerBGED98G+48v
	WB5ZFTj5vdCmjugMTcijgS9TsFylEqDD3gflDS/MO5ybFXDH0XkJKK2ps7e8GM3Zh/TXltp6N3J
	fUn0vzOXsXqcsutX5ZY5kZlvfLsg7Fnafq0l8tdPlWXiLu9At0Lm6U+GXakZHtL8dXqJw5GuXIe
	J6gJM3uYiRCVpmVzO8KKzM7imC+1PvB4MFVgtQk3k25MaAyPf47IUd5z4XICGez+a9GaLpJ2lXJ
	0x7DU1kDcfkETEQyAei27Z4Br44Yi0tYf//NszGvv597PU/Vhk1TePTnuvdVHz/4YIvAay7EndB
	XlOUqqGlLPn76ggpr2CkxVw7loBI=
X-Received: by 2002:a17:90b:578e:b0:34e:63c1:4a08 with SMTP id
 98e67ed59e1d1-35965c9c9admr5295807a91.20.1772313387293; Sat, 28 Feb 2026
 13:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com> <20260228112210.270273-1-shreyanshpaliwalcmsmn@gmail.com>
In-Reply-To: <20260228112210.270273-1-shreyanshpaliwalcmsmn@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 28 Feb 2026 16:16:16 -0500
X-Gm-Features: AaiRm515LFWvaPjna_6ACFqtPAIfWQ_7xE3usUf9sEzYkBHhdAv-r6p7kKqtbhw
Message-ID: <CALnO6CD0jvtaTpvNHQvvpDUVXZmzp9cq9oiuDMyX2BPt0ibFYw@mail.gmail.com>
Subject: Re: [PATCH v4] send-email: validate charset name in 8bit encoding prompt
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 6:22=E2=80=AFAM Shreyansh Paliwal
<shreyanshpaliwalcmsmn@gmail.com> wrote:
>
> When a non-ASCII character is detected in the body or subject of the emai=
l
> the user is prompted with,
>
>         Which 8bit encoding should I declare [UTF-8]? foo
>
> After this the input string is validated by the regex, based on the fact
> that the charset string will be minimum 4 characters [1]. If the string i=
s
> more than 4 letters the email is sent, if not then a second prompt to
> confirm is asked to the user,
>
>         Are you sure you want to use <foo> [y/N]? y
>
> This relies on a length based regex heuristic check to validate the user
> input, and can allow clearly invalid charset names to pass if the input i=
s
> greater than 4 characters.
>
> Add a semantic validation of the charset name using the
> Encode::find_encoding() which is a bundled module of perl. If the encodin=
g
> is not recognized, warn the user and ask for confirmation before proceedi=
ng.
> After this validation the lenght based validation becomes redundant and a=
lso
> breaks flow, so change the regex of valid input to any non blank string.
>
> Make the encoding warning logic specific to the 8bit prompt, also add a
> unique confirmation prompt which  reduces the load on ask(), and improves
> maintainability.
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
>         Declare which 8bit encoding to use [default: UTF-8]? foobar
>         <foobar> does not appear to be a valid charset name. Use it anywa=
y [y/N]?
>
> [1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c89=
36fb8b
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
> Changes in v4:
>  - removed the confirm_ask() helper and changes to ask().
>  - make a new warning/confirmation prompt specific to the 8bit encoding f=
low.
>
>  git-send-email.perl   | 25 ++++++++++++++++++++++---
>  t/t9001-send-email.sh |  2 +-
>  2 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index cd4b316ddc..3186104709 100755
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
> @@ -1044,9 +1045,27 @@ sub file_declares_8bit_cte {
>         foreach my $f (sort keys %broken_encoding) {
>                 print "    $f\n";
>         }
> -       $auto_8bit_encoding =3D ask(__("Which 8bit encoding should I decl=
are [UTF-8]? "),
> -                                 valid_re =3D> qr/.{4}/, confirm_only =
=3D> 1,
> -                                 default =3D> "UTF-8");
> +       while (1) {
> +               my $encoding =3D ask(
> +                       __("Declare which 8bit encoding to use [default: =
UTF-8]? "),
> +                       valid_re =3D> qr/^\S+$/,
> +                       default  =3D> "UTF-8");
> +               next unless defined $encoding;
> +               if (find_encoding($encoding)) {
> +                       $auto_8bit_encoding =3D $encoding;
> +                       last;
> +               }
> +               my $yesno =3D ask(
> +                       sprintf(
> +                       __("'%s' does not appear to be a valid charset na=
me. Use it anyway [y/N]? "),
> +                       $encoding),
> +                       valid_re =3D> qr/^(?:y|n)/i,
> +                       default =3D> "n");
> +               if (defined $yesno && $yesno =3D~ /^y/i) {
> +                       $auto_8bit_encoding =3D $encoding;
> +                       last;
> +               }
> +       }
>  }
>
>  if (!$force) {
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
> Range-diff against v3:
> 1:  748bb03a00 ! 1:  37e17eac68 send-email: validate charset name in 8bit=
 encoding prompt
>     @@ Commit message
>          validation the lenght based validation becomes redundant and als=
o breaks
>          flow, so change the regex of valid input to any non blank string=
.
>
>     -    Introduce a dedicated helper for confirmation handling that can =
be reused
>     -    both by ask() and the custom 8bit prompt flow. This makes the en=
coding
>     -    warning logic specific to the 8bit prompt, reduces the load on a=
sk(), and
>     -    improves maintainability.
>     +    Make the encoding warning logic specific to the 8bit prompt, als=
o add a
>     +    unique confirmation prompt which  reduces the load on ask(), and=
 improves
>     +    maintainability.
>
>          Additionally, the wording of the first prompt can confuse the us=
er if not
>          read properly or under any default assumptions for a yes/no prom=
pt. Change
>     @@ Commit message
>          The intended flow is,
>
>                  Declare which 8bit encoding to use [default: UTF-8]? foo=
bar
>     -            warning: 'foobar' does not appear to be a valid charset =
name.
>     -            Are you sure you want to use <foobar> [y/N]?
>     +            <foobar> does not appear to be a valid charset name. Use=
 it anyway [y/N]?
>
>          [1]- https://github.com/git/git/commit/852a15d748034eec87adbee73=
a72689c8936fb8b
>
>     @@ git-send-email.perl
>
>       Getopt::Long::Configure qw/ pass_through /;
>
>     -@@ git-send-email.perl: sub get_patch_subject {
>     -   }
>     - }
>     -
>     -+sub confirm_ask {
>     -+  my ($resp) =3D @_;
>     -+  my $term =3D term();
>     -+  return 0
>     -+          unless defined $term->IN and defined fileno($term->IN) an=
d
>     -+                 defined $term->OUT and defined fileno($term->OUT);
>     -+  my $yesno =3D $term->readline(
>     -+          # TRANSLATORS: please keep [y/N] as is.
>     -+          sprintf(__("Are you sure you want to use <%s> [y/N]? "), =
$resp));
>     -+  return defined $yesno && $yesno =3D~ /y/i;
>     -+}
>     -+
>     - sub ask {
>     -   my ($prompt, %arg) =3D @_;
>     -   my $valid_re =3D $arg{valid_re};
>     -@@ git-send-email.perl: sub ask {
>     -                   return $resp;
>     -           }
>     -           if ($confirm_only) {
>     --                  my $yesno =3D $term->readline(
>     --                          # TRANSLATORS: please keep [y/N] as is.
>     --                          sprintf(__("Are you sure you want to use =
<%s> [y/N]? "), $resp));
>     --                  if (defined $yesno && $yesno =3D~ /y/i) {
>     -+                  if (confirm_ask($resp)) {
>     -                           return $resp;
>     -                   }
>     -           }
>      @@ git-send-email.perl: sub file_declares_8bit_cte {
>         foreach my $f (sort keys %broken_encoding) {
>                 print "    $f\n";
>     @@ git-send-email.perl: sub file_declares_8bit_cte {
>      -  $auto_8bit_encoding =3D ask(__("Which 8bit encoding should I decl=
are [UTF-8]? "),
>      -                            valid_re =3D> qr/.{4}/, confirm_only =
=3D> 1,
>      -                            default =3D> "UTF-8");
>     -+  while(1) {
>     -+          my $encoding =3D ask(__("Declare which 8bit encoding to u=
se [default: UTF-8]? "),
>     -+          valid_re =3D> qr/^\S+$/,
>     -+          default  =3D> "UTF-8");
>     ++  while (1) {
>     ++          my $encoding =3D ask(
>     ++                  __("Declare which 8bit encoding to use [default: =
UTF-8]? "),
>     ++                  valid_re =3D> qr/^\S+$/,
>     ++                  default  =3D> "UTF-8");
>      +          next unless defined $encoding;
>      +          if (find_encoding($encoding)) {
>      +                  $auto_8bit_encoding =3D $encoding;
>      +                  last;
>      +          }
>     -+          printf STDERR __("warning: '%s' does not appear to be a v=
alid charset name.\n"), $encoding;
>     -+          if (confirm_ask($encoding)) {
>     ++          my $yesno =3D ask(
>     ++                  sprintf(
>     ++                  __("'%s' does not appear to be a valid charset na=
me. Use it anyway [y/N]? "),
>     ++                  $encoding),
>     ++                  valid_re =3D> qr/^(?:y|n)/i,
>     ++                  default =3D> "n");
>     ++          if (defined $yesno && $yesno =3D~ /^y/i) {
>      +                  $auto_8bit_encoding =3D $encoding;
>      +                  last;
>      +          }
> --
> 2.53.0.155.g748bb03a00.dirty

This version looks nice to my eyes. Thanks!

--=20
D. Ben Knoble
