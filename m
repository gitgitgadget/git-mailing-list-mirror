Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794386061;
	b=D/OcW3FUCL/4dyVuaRk4yL42V35GHGYRC5w6O4d+bOdVBRYQvTSSmsIMl5ODYayaxnhS
	 x4k1QCrQKc6RDgBi8vKnKhgLQZ9wGunbMIsrNpWP/3RZraa8BLTkQ+O14IAitv7bEixI7
	 G/605TQECebnEpNLFahgMPkYVfWZ8NzkSw0BdqG/V5xgbq+XPysIp91uLdjmkIgGjyI//
	 qDFREiB15lITX9nl503xlfgxkJ/+locQscdeed6JdWnAM9S3qpsTltZyilqWZgh33J/8t
	 TCqeI5qTRLwhSJpwx36aBGO7XCQWGvF/xXao2LWpsK4cn1+XkCw5YICYjx6Q5xBPgog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vHIS78yE5gTRKRK/z1CvmlF/WHZDpKfbDCxxryIvhmM=;
	b=uE2d44XMvAWA1hOw1PtZx6w/+fHhXVJ9dWhj4klWq+Ue/HEbXKKpYPR9FmPakRY/0Ylj
	 9PjPld/1SBbHBhM7XCIqLPk5aB595CiYAN9Mezsm18yfQyXyOeSNjuUE8e/99y52Bum9m
	 00YkPs5JZMIJoaHR/cGv/MLoVkiVHmsgKpczw1kA6ROCHtL2ldDj/ZBwwtQAo+ndu7Eny
	 HEbq55+1Ak1/J4q+ZBWlardaD8mWLkx//WW4z0axgNI6C57AzIS3WF155A571Qf5WCO5J
	 JfTAIIVjx+zoSMp5pzfGHUIzH6yOq2V51Wnhz3Ugs8dExUEzQnSal3KTXp/WsAIdX5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cNpRE0IO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249B606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D249B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cNpRE0IO
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ec396c93dso35079716d6.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 00:34:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794386060; cv=none;
        d=google.com; s=arc-20260327;
        b=NmXeex6qZiNDRhEPXWMtZoitN6BpDqlVhU7BjaWEtTttDiznX5wHq6XWDr9pBihpeO
         tWkgi7POnkRzyvShCI3tZ5sRe7B8la/ndNmtbk698mt1PZ3UByoN0/LDIxZk5SC6Xalo
         m8bbi3a5D7r5+i8hlD1Lc/ZN9bNM1s1vGnIfMJjoBOyZxU/s4s4B6+XT9mn3SWQNbMWe
         gAq8H/erQSn1siYwb3iN13tz/yQvNNT/uQKAmbOalF6Ve8gS7UOwtYoNx1i78QKMan6m
         kxHzQtJkhqtgsNYBenm/MhGTVqdIVoYky0n1TcoQX8GCeiHI0n3nPKX7FkJcBtlbaF3f
         9IDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vHIS78yE5gTRKRK/z1CvmlF/WHZDpKfbDCxxryIvhmM=;
        fh=W4xMjUQjIIRyvlfDoZUwD/Lc93NINz84HSyNdn/iquM=;
        b=BvMg6kE+LlamrxnHQ44uEk+gqJjOglR80v31JKmfV1juRvFt3t4VbK5Jcw4+2rGeiO
         BxPJFYHoEpjef3rjzO+C2I11lO6RJuzyzYfxmXKYhbja9JXSyNNrZNDUo2CxI+sr0m4R
         8HLlTCvXDpCOPfvrQFlR8j+DEiewO2sPL10Luu2n4/vCJ1fE1EKIcH5mNLfA1o07DZ+e
         GvUgTnUXYcVbYPrDGEcaYvZ2GjAzC5dnBN9AUJuPXAlICWme7AflUHfBPnZVv2ZSyIco
         egNWh6pHHMYdiG7WpU3McqgK9oYdYmS/k123RyZLs+VBlEJS05ijHXnNPURFxln6vpCR
         1sZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794386060; x=1794990860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vHIS78yE5gTRKRK/z1CvmlF/WHZDpKfbDCxxryIvhmM=;
        b=cNpRE0IOkgGltX33LOMVqF7k2Y8zpCyhQr61tqJxGHORvOIX3V/rvSlx7yLuE6iLQ+
         Uwc4jn8DgopcB1vkTA9bpgddHDVbf6kQRaXiBy1LiDa0uAMZWZ42GDPr4furhGTJ+ico
         PABv2U1AdDmsU6WP0rcMi/VChzmkck0eLR2s2XLL/s/xXSqIMSwuuMc3xNN9ug1tY7hR
         xxbSq05miokma3QGMkHV77hcyOG+FzAOeFoYbVOkMfECJnjofDolXqNilEPHb2ojk862
         2v2RO6oaiNy5XyhNeVjKGFhBpm5G2L3NZqBlIOU4CswyfZNkrgYWVc5jYzQCnqDMoTwx
         ERDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794386060; x=1794990860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHIS78yE5gTRKRK/z1CvmlF/WHZDpKfbDCxxryIvhmM=;
        b=gLiS+eQEG0WjycnVBSXk2II7f21dgRf0eggUMOl4sCilBF3+NqOkDjNAb5ILcgiu8b
         f8sBL+pKTEzreCkDQv5/VaQCMJEPfOeAoR7wXadWeBLNkiuzmPKOqY7H5CyDAitPwC1F
         qab1WzX65K8MVqDEW0h/8fOy1X1s/J1ohJrvoF5pf5ay559tiRzeXhAm4mYpqxckJTV4
         oYPmkMRScyHBoSUhJlVHRyH2ULI4uuswzU5SCQiq00MvCaQWT0RZ7wcCsYXfIVf1IwQX
         k1iPUBIwHj9N/UXGVHi9jIpPjSd9ZNX7fG7B7fHZRdgGonG3YCBiXOQWP9l1P0jSIT9g
         Lx0g==
X-Forwarded-Encrypted: i=1; AL+hErHn/D+xvPv1ArW2K0G7uhneRvd7VKIS6j2ekh2932jjDfaGUOETFAAOO7M8A75VAt0Ji58=@vger.kernel.org
X-Gm-Message-State: APuU4Z81FxqbW+JH5w4ok2jjaVUpwSISd2Xr++8jZ5XiCziqfI+tHiZK
	Z9qYBex7mfZnRPitm3FuOE6i7MGsVFZhtG8pwSqxmKJOHEvCGhmSGCY6Ibo7PJIcvZ1FJbYC1Ih
	Q/pXJexpvDnIFrI6g6a+e3BjfDJ6w6mMT3bwq
X-Gm-Gg: AYBFou2ZOAaCu0I+KjVo/PA0H0UiV0GWFYp/DaspdtRFQ0esFJjPaa9RVNCuT9wv5cp
	i0u3MUXKeIK484WSG4bktNoh/EWKgEqJtVd2FpvQRf8e5Czv0pD4rqboXPRy0pAllK3VHzwfDxV
	nktTIfELXRbA4otDnC5Kzobp5RuIiLzrHysB2RfBicI4bUus2UBQV2OxXLMGh/BCXe68mX0NXQ0
	m2OYrK99elOtP8zOnCBI5wtKQaSOyb8Qb19EOOgLMns6ts1sJciKggepmdSAhF0HKwCcB8L3a9p
	orjAbt5NqGyhH62tPlKmLRF6GODPggiBWzasb6UhtkXN79NlBHrdt6RA9CA3zd72sTHbPsMivxO
	8RAkhuNq2ShcI4WG4opnq7oAiAJLVvPfDg5VyyqrbZtvq9LNWA2N9BS9/Z97BJzxfpTfgWUZrFJ
	iI28Nk0Q6U9dsXC6kGibsrbspLoQnqxUcZIZEJzWZIvIHJphnf3//i6OWg
X-Received: by 2002:a05:6214:2506:b0:91e:a251:26b6 with SMTP id
 6a1803df08f44-91f040befd7mr29145776d6.30.1794386059671; Wed, 11 Nov 2026
 00:34:19 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
 <pull.2305.v3.git.1794335969.gitgitgadget@gmail.com> <398b54f00a1278f22fef456384c6c4ebd1a1f576.1794335969.git.gitgitgadget@gmail.com>
 <xmqqse18pgin.fsf@gitster.g>
In-Reply-To: <xmqqse18pgin.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Wed, 11 Nov 2026 14:04:07 +0530
X-Gm-Features: AclHuK-WWwAcnD7yi66y5SN3N779SvxiZTvWuyjyT_hCXY-q8qOjY9bz-d3oGwc
Message-ID: <CABh_KWj31AHp9qvWxOEAN_T9xUkkP0b_P+0BxxU4ZNNeMOmNjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] archive: remove USE_THE_REPOSITORY_VARIABLE from
 archival modules
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 2:10=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> > Refactor archive-tar.c, archive-zip.c, archive.c, and supporting files
> > to clean up archiver initialization functions and header dependencies.
> >
> > Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> > ---
> >  archive-tar.c     | 5 ++---
> >  builtin/archive.c | 1 +
> >  2 files changed, 3 insertions(+), 3 deletions(-)
>
> Where is the change to archive-zip.c the proposed log message
> advertises?
>
> The proposed log message claims that it refactors and cleans up, but
> the patch looks like a totally incoherent and unexplained mess.  All
> the places I note "What is this change about?" are unexplained
> changes whose value is dubious.
>
> > diff --git a/archive-tar.c b/archive-tar.c
> > index a1c66024d4..642a3ddfc3 100644
> > --- a/archive-tar.c
> > +++ b/archive-tar.c
> > @@ -3,7 +3,6 @@
> >   */
> >
> >  #define USE_THE_REPOSITORY_VARIABLE
> > -
> >  #include "git-compat-util.h"
> >  #include "config.h"
> >  #include "gettext.h"
>
> What is this change about?
>
> > @@ -337,7 +336,7 @@ static void write_global_extended_header(struct arc=
hiver_args *args)
> >       if (oid)
> >               strbuf_append_ext_header(&ext_header, "comment",
> >                                        oid_to_hex(oid),
> > -                                      the_hash_algo->hexsz);
> > +                                      args->repo->hash_algo->hexsz);
> >       if (args->time > USTAR_MAX_MTIME) {
> >               strbuf_append_ext_header_uint(&ext_header, "mtime",
> >                                             args->time);
>
> Here, the args->repo which was relayed by archive.c:write_archive()
> is used.  This function, when called by builtin/archive.c, passes
> the repo it obtained from git.c's dispatcher; when it is called by
> builtin/upload-archive.c, it uses the_repository (which is fine).
>
> This hunk looks like a good change.
>
> > @@ -529,13 +528,13 @@ static struct archiver tar_archiver =3D {
> >  void init_tar_archiver(void)
> >  {
> >       int i;
> > +     repo_config(the_repository, git_tar_config, NULL);
> >       register_archiver(&tar_archiver);
> >
> >       tar_filter_config("tar.tgz.command", internal_gzip_command, NULL)=
;
> >       tar_filter_config("tar.tgz.remote", "true", NULL);
> >       tar_filter_config("tar.tar.gz.command", internal_gzip_command, NU=
LL);
> >       tar_filter_config("tar.tar.gz.remote", "true", NULL);
> > -     repo_config(the_repository, git_tar_config, NULL);
> >       for (i =3D 0; i < nr_tar_filters; i++) {
> >               /* omit any filters that never had a command configured *=
/
> >               if (tar_filters[i]->filter_command)
>
> What is this change about?  Earlier, we first declared the built-in
> default configurations and then read from the configuration files.
> Now you read the configuration files, and then overwrite the values
> the configuration files specified with our built-in default?
>
> > diff --git a/builtin/archive.c b/builtin/archive.c
> > index 3c1288a123..8b7d56f8cb 100644
> > --- a/builtin/archive.c
> > +++ b/builtin/archive.c
> > @@ -2,6 +2,7 @@
> >   * Copyright (c) 2006 Franck Bui-Huu
> >   * Copyright (c) 2006 Rene Scharfe
> >   */
> > +#define USE_THE_REPOSITORY_VARIABLE
> >  #include "builtin.h"
> >  #include "archive.h"
> >  #include "gettext.h"
>
> What is this change about?

Hi Junio,

Thank you for the guidance on the configuration initialization order.

I have updated the patch series locally to address your feedback:
1. Restored the correct initialization order in init_tar_archiver()
within archive-tar.c so built-in defaults are assigned first, followed
by repo_config() to allow user/repository configurations to take
precedence.
2. Cleaned up the branch history to drop an accidental submodule
commit, keeping the PR isolated exclusively to the archive refactor.
3. Re-ran the test suite (t5000-tar-tree.sh and
t5004-archive-corner-cases.sh), and all tests now pass successfully
(90/90 on tar-tree).

Best regards,
Srujith A Poojary
