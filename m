Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988133CEA5
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426372; cv=pass; b=O5DtPJUeqnedU/Kslq7AcZT/iEG90lcdUORJ3y+DFeUOhzjfnvOZ5nxpxZysLg0XtZ9/7B/VDSo+mRLxAP76WiDTjtrwd8Bl8M89pv7t3+kRZmuF8Bxkv1wfEC3+s6kGN2Lvp27W40ARoT7qU0qZfhoX3Bc51n7j1KL5THgrrHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426372; c=relaxed/simple;
	bh=YnzUpfP0r5lo34HRarK12s+dVsou7CzSlSNACnTyZGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZk929n9QH4eJEpFGpU619/jnMhAmJHuXGD1pYLtM933yMJ4fRdGZwRAmxwPpNri+a6/bU8gqrFR9Ue2/E3+ONfyZ8CTR934p+qbuX2Q+ej9xdYDM/5NZaLh+wyL+ioiIwyPQb2f2SHXt6n8kInnMtK3ZndOgEGiIFEj99POrP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIt4tzA0; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIt4tzA0"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-88bd2b44f3aso1369170b3a.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 19:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791426370; cv=none;
        d=google.com; s=arc-20260327;
        b=I6MJQXsIag8z2qSSrz2ODQLO1bi5Npi2qRFPUnj2llKfCLcB0O7Q81JqktSNWGc0dj
         NVCzhDXoDXQrrtrimsp0Bt9Svf0Vsz8qkQ/6on9nWrfVsnknvlJjf+IiiSZf8VYWB1uV
         qyD3rS8Aid2p8gcfVg8UY+wPLT/P3nWEfW1zZ9DWk1Tv7sWwETlpv4CUcLnwyOVr+y/r
         dltFb8wqNSRbzaT36gmVwg5i0TLPlJAo4Qd82ZQaYPJLZVVWUln9W8ZgeTrir1solPqY
         K1yRAFMOERIhBJCBTdYI/gzefae/HPjJhnUaRY8GzbGlgwa8Fw6AdE3/RtQgjW3IpX9b
         JaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ex8hndpZeC8FePYn10CmkmXrK5a5gx4IGc6GJIaHCNI=;
        fh=xDJmRxaAEZkfDG+Qj6KmyzGnR5IjZJpjz0OZfaFTUw4=;
        b=Wp5MTyeXK5OpX/G5YUp54sCK//wJXCcgrF/4jECevMMCyEDoyvyH6BsxXDlZkOBILS
         rzSHRXXyA2jWllhvqYZwa4i8COF2tx44dNqc75HxDfiFyPeuP6qDXk5wGN3kSGRtEkGH
         WqyoAu3kwEO9nTtsuRhom7f+PTsatCBODYZZ6bwx7jD/liKqD6LrDPtbrDkciFHT4Ec/
         WvJptr6P52QOw5eFCnrpOdz0MK7RZSWkSjs452imWDqBoDT03BRguTDAPM+K/PrCLvKn
         9iiCzLTzhAvYncInDDPhki4pp/Y835V0SI7hIOhQBrXgL2rrrr4ZSNmX2kSb2dr1X62q
         UewA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791426370; x=1792031170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ex8hndpZeC8FePYn10CmkmXrK5a5gx4IGc6GJIaHCNI=;
        b=VIt4tzA08kHx740y7aZp4lS0PxeDVpixy5WtTav9ntKJZQxKudmOwZ+SYZxmItMpdU
         iCCdpJCXx52chwr1PjhU37EP4oxHsqPxYJUwl3+CiQhj+TLuyZpmSU1zA5UHQvV/kxlS
         kfmMuSwVlQCW9kvZXnGKpOdqQjO5MBltDgKyEA3PR2tRAB6aExFk0iFGeqjDcTxlZ76F
         985cGt7wt0Pe7BOfz7l72J2cc7liBwya23125Sw76gF9EzPPVr6WHjK0Z2YmRpokOJkx
         BJkGFot6+cWoedk3EEAvJ1dMv/KMNxB/UDHg6nQe9ab0t7cIv3hLhmpmW3UDkJTDEMM4
         piXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426370; x=1792031170;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ex8hndpZeC8FePYn10CmkmXrK5a5gx4IGc6GJIaHCNI=;
        b=qMz32Eev+0uSMPmB1SaB/CYqT8bp5awh9rD2V62NP7AkEcAtqyk92TuRRc8Bxns1rj
         Oeo5FDJ6h09KjC8QUYiqIGGIQdLF+lm3x2y+D/2vWfKqh/fLI2v+rhn5RvsThmigQVZB
         oscPB3Xg1eLPU/P1/XUFdCzz0wLg5uW4DQssFpRnXRloRal6KxA1OgfW+ccrzCjwAgVm
         +ps2TFrkcNp6f2VpQn/DhACG8Cvx2NWBPhEMzRg5zlxf+WryCvYC1cZpE9MMzgVIwDTT
         wp0k0i7anfs2TVwvUkUdeRwpxkaYkRrXyfjrA/r1IJzZAkW14pscIaHkoWxdgryDPz8b
         HA7g==
X-Gm-Message-State: AFuF++lM2wq5zvVR8Giyl8NjsS5uXnjUA5VBKr6+KhHJru5948awDnPb
	daILNSQ+6ERwVG7PcuK2C4OCECuivJVtItII7O1NUdDFj2erLuPNODbehIjgaWSBFSYilYp32sh
	XoCEW0l8aq/L1hRJxT3QZ6/SpqISZjpA=
X-Gm-Gg: AYBFou3W/Eek6jdbP8pyEO4uO+IWHvVtKIUVk+t6LZ+uYaMuEdm0AI9JVV+bqYV3W0k
	UGCMbjaPWTR3jMnom00yapkf8236UBeYZNwJAKWidVGqN6YF8IduGE761zUl3hkJUvuCRrT3+6I
	ZxxwtDsdJXz/rSxrGeX3VTzrHMvtr6tV4c/f7KMZ8G4iOsiVKLKlXpBBgbydXSa5twLTBGm4lFY
	sCmdueItJO9T8ki+uZSbCQu1lqzQrW+G0P9oK/8jHCbX4Z8aUWHF/gJ+RcJIV49NnttGLPIc22s
	ZALjBtTV38VHWIChahcPFdr1hxQunLT4FvvaqbgjArHGNRcmYS3n3ZDaLeb/g16AV4IkOWeXseA
	SKWzISixoR46zSczScp7QAXGMMhN0VWK7PYbl0cYBvtb0ZktMaz29diTMjawa3AQBabq7nWt/ug
	==
X-Received: by 2002:a05:6a00:a803:b0:878:6ee:671c with SMTP id
 d2e1a72fcca58-891b53cd034mr3156240b3a.30.1791426370281; Wed, 07 Oct 2026
 19:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACgTecOm+=vbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2CmXdJCxg@mail.gmail.com>
 <CALnO6CCmv7PmxW2HTfvD8i6-PCVqMWgasyU9PYhPLXGj1sz=Hg@mail.gmail.com>
In-Reply-To: <CALnO6CCmv7PmxW2HTfvD8i6-PCVqMWgasyU9PYhPLXGj1sz=Hg@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Thu, 8 Oct 2026 07:55:34 +0530
X-Gm-Features: AclHuK83uxrq9cF-hVQFlGQbyNsL7keFqDFuHiDlt6-o43ksgj0OLhsuuqx_q-s
Message-ID: <CAGWgyh9QTN8T=ZyvbEGA16acNw4KGLBeg1R4mt=E_nAGGU8APA@mail.gmail.com>
Subject: Re: [BUG] repack --drop-filtered --dry-run writes packs and honors -d
 in Git 2.56.0
To: Coy Geek <coygeek@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Coy,

On Thu, 8 Oct 2026 at 00:40, D. Ben Knoble <ben.knoble@gmail.com> wrote:
>
> Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com> who authored
> the --drop-filtered code.
Thanks Ben for the cc

> On Sun, Oct 4, 2026 at 7:47=E2=80=AFPM Coy Geek <coygeek@gmail.com> wrote=
:
> >
> > On Git 2.56.0, `git repack -a --filter=3Dblob:limit=3D1m --drop-filtere=
d
> > --dry-run` prints the candidate blob but also writes a new promisor
> > pack and its sidecar files. Adding explicit `-d` also removes the old
> > redundant packs and their sidecar files.
Thanks for the report and the reproducer.

The issue is that the --dry-run block in cmd_repack() prints the
candidates but does not stop there. it falls through to
repack_promisor_objects(), which writes the new promisor pack, and
with an explicit -d it also reaches existing_packs_remove_redundant(),
which deletes the old packs. the earlier
"if (!dry_run) delete_redundant =3D 1" only stops -d from being implied,
not from being given explicitly.

The fix is two lines in builtin/repack.c: at the end of the
"if (dry_run)" block, right after the loop that prints the candidate
object IDs, add

    ret =3D 0;
    goto cleanup;

so a dry run returns as soon as the candidates are listed, before any
pack is rebuilt or deleted.

I will also add a test to t/t7706-repack-drop-filtered.sh that runs the
dry run both without and with -d, and checks that the pack directory
is unchanged, the candidate is still printed, and the blob is still
present

I will send the patch shortly

Thanks,
Siddharth
