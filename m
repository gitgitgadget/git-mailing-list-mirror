Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692671DE4FB
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753541535; cv=none; b=Kgokq6JzRma3u7HT4G0Amm5xwIfRPVvHfKQBfMHS88zk1/s8gOjJe11Ah3NyQ/3Tjz8Z7lPNNiKDFI0+YoKAoWaYS40VgHTIgZbM8CdNiqyz/hCIXkM+UiLVNn08xJYhSEhWJA81i8lnlxssKNn11cj2xshege/BMoHg0Z1Yx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753541535; c=relaxed/simple;
	bh=IXDPYcLRaAed9+Wig6D2+lWLjE2tvKKmblLo8j4T3XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9w+VHJXHrp8XaKKIGw2R23DgjE5X/WX9+YOklcNiaphbJf+8m97yfqwsiFXWQD5WH0Govq/Iqs9o0TORHseZMeoXxcAlcRe4uhVfp/YjzWL/3O7j4ehIbX81j3p+0ZRSTeeXthzd6nPx0WL0xj7Hy95gtmfv7Yz/JkCuchvmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpQTJ42h; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpQTJ42h"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so646860166b.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753541532; x=1754146332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Z3aiiPn1ysU1MfRifH9NqV7w6Dyvdz0qRA/6TlQaf0=;
        b=YpQTJ42hmQ3sQFz29fsmfk/dT+G2LqXAEx2vyb60KV7exChRwwfslXu9bJTpTXnUA3
         AAKC5QQ0PKO9AAjr8arxnr2BzT6fKZ9PvUoysh0tYGaGHlH8Huv33p+Tr/dyjdVFyjJV
         E8Zi4mPgvWL8xTZh2BjpVU94/h3hVLn0lNyVQuixUcW5DcRXMjj75r203MqVO6dwKrNA
         wEIwl5b6zT7+PMuMA8UPLW5ZA8OMSCkfA7xQnCVzLCZlzsJ37sAXoabkoErYwvpCLrC7
         qKGbnGgZZ+gpmHPszPATNGHY0Vn/UYkIVyzn/CgVgwBKiFES6IEKsQ4qx2rzWALPvUn0
         Dizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753541532; x=1754146332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z3aiiPn1ysU1MfRifH9NqV7w6Dyvdz0qRA/6TlQaf0=;
        b=BRnZR/YNBHjPPMLwRxBSpnENYvBeoL5hrfkac80HJCQ6sc9IPkD48LOyG6E/hyU+Q+
         pm99iGEqh+BOGJbH9i8APt7RJIcFNnBhj6cbwzxnaDdWmbAijYrjzNCW8WA7bwyBYyUU
         3goz0Vd94H3dJ7fRh8F/RobygcWnZRyQDHU0H+E6TCu5HBr7pXJXrrVcyFR4N065u+g4
         vGMQM+WFgb2aVXklqroFUlyhx1qg53GFshjDR4w79j6md4aGPXpUnuUPzUtQySucvUNd
         2EAFBOUJCtWpLTTKaFk9BCnm+76vTrUQxwNFT95ZIq+7SMV7LYin/dySUzQlSQTRDHnP
         9kNg==
X-Gm-Message-State: AOJu0Yzoo2FlSQdvOS7numwvp8r3SvoI313nMBX4Y0+xa4T3rQyuyB9Y
	mfbn0oHy1et7wHfnZBph1KENXqC6/VCTCB+er31URN7c8cdq3yFE+QjciOzJ3BJYjlD0ZahfahO
	gBm0kp6wAX3JvBUiokvDDAOYMiAyzlu8xUL3e
X-Gm-Gg: ASbGnctx9gC6U9tAs0vg9eEj4OW43rCUcMPJCojNr5NxX5/yFN5jzoUsW6x1UgudLki
	1rYaAlyXlllGfFTx/713ydgpk09UcyM5qgLe8gbMbKnrnkqKLsdDf8eiC55y61Cf3AVdAKF4wE3
	Nwi5StOSgee3h3L1VkUnVcNvLN5BClGGEtYbvyTh34Z3td57bml3LB3sBxWhNw5HvcQoTGIyeJn
	xjVZR10gjLQrBw5yYxlxKWGceSUiLJU7kY7AxkeHw==
X-Google-Smtp-Source: AGHT+IHOyhcPgBxnpCmD7w95uaVbprdBUnyJN4/m/eHBSQ1jvg4PXQEAlYWAsVAxrpbv/ylCW7fw7zcDyUZzLamvBqY=
X-Received: by 2002:a17:906:fe0c:b0:ad8:adf3:7d6d with SMTP id
 a640c23a62f3a-af61e533d5amr602352466b.21.1753541531569; Sat, 26 Jul 2025
 07:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com> <CALnO6CCFXfPDZKzx1SBufwzkBJchZr0XYigo_8AQ_U=MuJa7xg@mail.gmail.com>
In-Reply-To: <CALnO6CCFXfPDZKzx1SBufwzkBJchZr0XYigo_8AQ_U=MuJa7xg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Jul 2025 10:52:00 -0400
X-Gm-Features: Ac12FXzV4oIVShB-D5F8LDLn3o6IL8cTuuSJ-jzGWmLsiXSMzttqXvFvfqQ3IO0
Message-ID: <CALnO6CCxTQYnVmdjeDnCyr=9i9S-uP9QbF9X0dUTfeJ4mcX4ig@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 10:37=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
>
> On Mon, Jul 21, 2025 at 7:55=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> >
> > Replace manual `-h` tests with a loop over all subcommands using
> > `git --list-cmds=3Dmain`. This ensures consistent coverage of `-h`
> > behavior outside a repo and future-proofs the test by covering
> > new commands automatically.
> >
> > Known exceptions are skipped or marked as expected failures.
> >
> > Suggested-by: Patrick Steinhardt <ps@pks.im>
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> >  t/t1517-outside-repo.sh | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> > index 6824581317..9fcebb7d94 100755
> > --- a/t/t1517-outside-repo.sh
> > +++ b/t/t1517-outside-repo.sh
> > @@ -110,8 +110,29 @@ test_expect_success LIBCURL 'remote-http outside r=
epository' '
> >  test_expect_success 'update-server-info does not crash with -h' '
> >         test_expect_code 129 git update-server-info -h >usage &&
> >         test_grep "[Uu]sage: git update-server-info " usage &&
> > -       test_expect_code 129 nongit git update-server-info -h >usage &&
> > -       test_grep "[Uu]sage: git update-server-info " usage
> >  '
> >
> > +for cmd in $(git --list-cmds=3Dmain)
> > +do
> > +       cmd=3D${cmd%.*} # strip .sh, .perl, etc.
> > +       case "$cmd" in
> > +       archimport | cvsexportcommit | cvsimport | cvsserver | daemon |=
 \
> > +       difftool--helper | filter-branch | fsck-objects | get-tar-commi=
t-id | \
> > +       http-backend | http-fetch | http-push | init-db | instaweb.sh |=
 \
> > +       merge-octopus | merge-one-file | merge-resolve | mergetool | \
> > +       mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remot=
e-ftps | \
> > +       remote-http | remote-https | replay | request-pull | send-email=
 | \
> > +       sh-i18n--envsubst | shell | show | stage | submodule | svn | \
> > +       upload-archive--writer | upload-pack | web--browse | whatchange=
d)
>
> Sorry, one more thing: I spot-checked a few of these, and it seems the
> main issue that causes failures is the exit code; they seem to work
> with "-h" outside a repo. Out of scope for this series, but something
> worth tidying up as #leftoverbits ?

It turns out a few pass for me right now: quiltimport and request-pull
both work just fine.

--=20
D. Ben Knoble
