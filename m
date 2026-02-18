Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF711EBFF7
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771387630; cv=pass; b=MY+5biDF4r4IhujUZxpkhkGGb0i3H7HtmdSeONzz2ZGyh6M9tULDcRcBOcsb9RV57XOe0X8Cm8SUsdaAd0KA30qQ6D0GTxTedkLanhEbAJ5FxKonbiTAr6vhE5R0Y+C+s5s3UzPo6rsZtHRf4hWjvd21M1eExs7kwlDk1DLy56o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771387630; c=relaxed/simple;
	bh=jl+g8w2EUvVTBvDPROoRyoWA9nVwv3IBteA4mbE2ywo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kbsu9pMpURTQEilUWtMEOU2LqJ2Xeey1FmIhZeoSTX5fHhPQMZhWvR5hodaMiS2rfvg+MXu1HbQ/51tbaVj1ockV6PcvKD0RcE7NAQE9hTNUFo7umWPnKmeKbkJ9C3Nfj0RwURacP6XcPmj3F3q1JexT1wzwkxSAN2tOHs7nZmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=PjbPcKlO; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="PjbPcKlO"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso4907546eec.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 20:07:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771387628; cv=none;
        d=google.com; s=arc-20240605;
        b=GrweIhMSr0079Skm1luWOBrJrLSa66X0sU1+9PePkSL1t/Wd6URTN63At1KO4HyGYd
         4T4fSYQsgUfbT0NvHIn4mxLJ81LeKHiEEPPfMEz98pT6ECb5M/yYTsk/D1YAFdDAOf3M
         Ju2GbmlK9bTITOSuUA0sDcQG5mdmwgK48ufpTDmM8S2Tx2mRovoPxWA0vuGlxUby+Gqn
         0ApAWrD4bwERllLuK4YYKvhYPDRYEF2SLamE1J8hqZgH5eLrf0XX3A+whUkpD9gpwShR
         j9jqkK6GftnBxAfgSaJLAvBctK9sbZjKpO1q9XN/6/ZfUs0YQuXHr0dcX2OrDbdRIAlv
         1a6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9xfCq6mMPg22hAQIIurFI8ghooPxETLa83TkZjsbz3g=;
        fh=iDClqoaIPRHbR8/ozFFAGxD11OAKPShwGeUKfCFZ5NY=;
        b=K8XlBBv/pcDse+aKGyzSEAYIwT1BgLp1Ja2kwkitkjgyfv66IwlHyGtyFk8IPgkL/3
         7Ojgg/+xKh2Fb94glHPSAVEudqUnMnbxEM2ww5ffn69viBbnHu/ToPnyFBCrHxszqMkV
         7G3QvC8vF3X+vYR/9cWIWofeRrpv7fzbyzKB/19oiiBrg/ypCIq1vsEWzx/MjV9S5eOs
         Fv49kRNglN5AukCjU/XALp2sZZE6MF0RwF14ZltqoAza2wf4Vb3kU7mqeBz+N8+iAcxt
         reBv0c98AYHO4QdEhZVwA8LyfWLfRgPOZUSP8kSm1Ekjzn04FYpFoYPHjvvOjXsbtlu0
         SStw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1771387628; x=1771992428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xfCq6mMPg22hAQIIurFI8ghooPxETLa83TkZjsbz3g=;
        b=PjbPcKlOO7YO3zflBINRNGitmkT963hmkc/liqrb3TC4btbPmdY+8PsH0mZ1ks8bmz
         H7/tspOETDjw5Kqz1jhCXXEjPwOFQ1Mm/C0kxSy+/314mp9L3xBwlEsydSO/cy/ZGkwx
         LJKP0om0EdobJx7r7sYmYycoO2Kuoewg00szF/6CQ4LP25JN6B0bdKqMeWeAuQW2+l9H
         kI/ZCLziULXk4RF3QIR0162CYvinxGg6gAaSM6d3Va3gTDIGo7uj9X4x1GH1IPZWGxqJ
         dE8NkO94YoaEkkU2+2z5Foi3VDyaXtsYeMzvdvofvUUitnIpCmpW6etvNnoVHg+HCPsD
         oU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771387628; x=1771992428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9xfCq6mMPg22hAQIIurFI8ghooPxETLa83TkZjsbz3g=;
        b=ZM+wjglIze5HTkOoEi6VGIOrgOuWc+b+HuUmjhp5tEosfOeesqyWxvyhB+ko7MnqBh
         QcGC1L+mu7ecp5Gn4+DMP2GQCPgeFuMeFI5h8a5sBz/nDkWA3F0RQuQ/uEvKjnImocXs
         I9YAZFjmYA+fgAUdpG/mtcXak3jGiYQDaNfVLCOI1jPjLKJoqRcTxubpGD6BrYasm+st
         GRMpzMpvpuv8MxuB2xYDb3GkJ4YFaCBiABmLMfW0KNHJxffQ4HctDHI4eQeNbiZYfpk9
         Myj1ytDe6a45kGz1kEhVGXC4ZUJS9kCPr1PHp8ZTyf+3sDJRaw0gaLroUZ7eiAzm0dMs
         A47A==
X-Forwarded-Encrypted: i=1; AJvYcCVfru2nNClDglVyppVwtW63Je0SluYSxCfJpEiA+pXhqJ62o0Uce4F5P6eIkWmM2XUn8NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEagjct/jwdQw5a/eUiaMVN4xNAj7Vu+RnqqNNoKPITTjTGDSc
	gwxc9QE4OzGOqxQAAO0SULyUqhiqdgE4G5HpP/lK8RXlSplpmBnHEeVPrNPEsLAvyvCXXXntt9e
	tR3rt6oEeKHWj9YZ7AhDFyYLVvmBGtZHHSWc1GnIC4U1S0WqfJfgLpBYv23hiQwlO3Aae29OFVC
	bY8r5HwN0O98/5NlJ57VJz/Q0IK65IKr8t2I0p+CQyuqA7kPiLbXr/7yudoGH0NmkhKliC2Kg9K
	4pWVjrCBfE7A8xNk1x7qbDnoGdOJ/bssutiriuLO8tcp+7hCEIltTa/HCnh+Lhx1TcfNczBIH7a
	WTNz8Jx8H39ngwg=
X-Gm-Gg: AZuq6aLmvKIaDm97bxq8TnGonDcaKnNXk5j+5PCzOjjpibo3cRvSbYZHegN9f9y9X5K
	Sl0Z/fs7NBRK7IXqtw4ra7y8Zd3/FCeJR+wGf15HMFL4riO4cDSKKBKp02EoCAehOYqqvckORC+
	Ox3s29XRJojnyIe3E3G6XvIxIK05QsZb/OndSVlQ4g8LTyN0X8I+KXRavD8ZjIw1deZ9/AtP7WS
	Gv0yjU463xtjgY7fkuX8vi3r5XG6Rj1V2WDJr62wohj4+lc17PvPmN2NdhXNK2/JSSnhUvfxlX9
	lfquRI58
X-Received: by 2002:a05:7300:a18b:b0:2ba:7b0b:e207 with SMTP id
 5a478bee46e88-2bac97ad35bmr5275384eec.23.1771387628121; Tue, 17 Feb 2026
 20:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
 <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com> <xmqqms1fwasx.fsf@gitster.g>
 <CAOTNsDz0ZtdsM8Z2NW0WBMGs8xyWz5ROS6pf8DKQAx26LU4xRA@mail.gmail.com>
 <CALnO6CARu8HSYh9=z6FAF=84q1qA4Oan7_DLMbcK+1rth8B7cA@mail.gmail.com>
 <CAOTNsDwMeszCC6wunkkx_vhKYx9OvRWXB4VxedypOTQJ6Qs2sA@mail.gmail.com>
 <CALnO6CCYorpEzmZwLrb7O-ucKLTOCLp6zXxZr0Qv73tOBqKKig@mail.gmail.com>
 <CALnO6CCys8hDtSe4=gFjaz7x410TH-7LFGRs0UU5e7XCSWuOQQ@mail.gmail.com>
 <CAOTNsDySo-t-qS5+_bm1Z+c_zRKcrS62vVtxURf9bBax0h8DAQ@mail.gmail.com> <CALnO6CAC3Vpdt34fZ0PLjmZOPazU3hDJiPnZy9reoyJJg-zU3A@mail.gmail.com>
In-Reply-To: <CALnO6CAC3Vpdt34fZ0PLjmZOPazU3hDJiPnZy9reoyJJg-zU3A@mail.gmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 18 Feb 2026 13:06:56 +0900
X-Gm-Features: AaiRm53j1v8_8leo-yzV4cO6EwXMfWBNDKCqKG4A8pa0I3mWxg97O_Jps-OPirM
Message-ID: <CAOTNsDwVHNF72A7uobRhArqPzEseuhz_fnt49Si6=gR9Xb_KMQ@mail.gmail.com>
Subject: Re: [PATCH v2] osxkeychain: define build targets in the top-level Makefile.
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 6:54=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Tue, Feb 17, 2026 at 1:05=E2=80=AFPM Koji Nakamaru <koji.nakamaru@gree=
.net> wrote:
> >
> > On Tue, Feb 17, 2026 at 10:12=E2=80=AFPM D. Ben Knoble <ben.knoble@gmai=
l.com> wrote:
> > >
> > > On Tue, Feb 17, 2026 at 8:10=E2=80=AFAM D. Ben Knoble <ben.knoble@gma=
il.com> wrote:
> > > >
> > > > On Mon, Feb 16, 2026 at 8:09=E2=80=AFPM Koji Nakamaru <koji.nakamar=
u@gree.net> wrote:
> > > > >
> > > > > On Tue, Feb 17, 2026 at 8:45=E2=80=AFAM D. Ben Knoble <ben.knoble=
@gmail.com> wrote:
> > > > > > ...
> > > > > >
> > > > > > Homebrew picked this patch on top of 2.53.0, and on a recent bu=
ild on
> > > > > > older macOS I needed to
> > > > > >
> > > > > >     mkdir contrib/credential/osxkeychain/.depend
> > > > > >
> > > > > > in order to make their build work, since otherwise:
> > > > > >
> > > > > >     error: error opening
> > > > > > 'contrib/credential/osxkeychain/.depend/git-credential-osxkeych=
ain.o.d':
> > > > > > No such file or directory
> > > > > >     1 error generated.
> > > > > >     make[1]: ***
> > > > > > [contrib/credential/osxkeychain/git-credential-osxkeychain.o] E=
rror 1
> > > > >
> > > > > I tried to reproduce this using the current Homebrew formula for =
git [1]
> > > > > on macOS 15.7.4 and 14.8.4 (both relatively newer) with the follo=
wing
> > > > > steps:
> > > > >
> > > > >   brew tap --force homebrew/core
> > > > >   cd "$(brew --repository homebrew/core)"
> > > > >   git checkout -B main origin/main
> > > > >   git pull
> > > > >   HOMEBREW_NO_INSTALL_FROM_API=3D1 brew reinstall --build-from-so=
urce git
> > > > >
> > > > > In my environment, the build finished successfully. The patch doe=
sn't
> > > > > seem to trigger any issues during a local "make" either. How exac=
tly are
> > > > > you performing your build?
> > > > >
> > > > > [1] https://github.com/Homebrew/homebrew-core/blob/9ec3da0dcd3ccd=
1cd4d892a71377b251770212d7/Formula/g/git.rb
> > > >
> > > > macOS 12.7.6 ;) hence tier 3 Homebrew support + all packages build
> > > > from source. So just
> > > >
> > > >     brew upgrade git
> > > >
> > > > built 2.53.0 + patches from source. "brew --version" says I have
> > > > "Homebrew 5.0.14-59-g45db1ce"; it doesn't print a homebrew-core lin=
e,
> > > > so I'm not sure off-hand if that includes the core tap version or n=
ot
> > > > anymore.
> > >
> > > To rule out differing versions, I also diff'd the Homebrew formula
> > > from GitHub against "brew edit git", and the only difference is the
> > > bottle stanza on GitHub.
> > >
> > > > I ended up having to use `brew upgrade --debug git`, fix the build
> > > > error ("mkdir =E2=80=A6") and manually perform a few steps when it =
arose, etc.
> >
> > Thank you for the details. The current Makefile rule performs the
> > following to generate dependency files
> >
> >   contrib/credential/osxkeychain/git-credential-osxkeychain.o:
> > contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
> >           $(QUIET_CC)$(CC) -o $@ -c $(dep_args) $(compdb_args)
> > $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
> >
> > where the compiler implicitly creates
> > contrib/credential/osxkeychain/.depend/ if it doesn't exist. This
> > behavior seems to be supported at least since Apple clang 15.0.0.
>
> Aha! I have clang 13. That probably explains it.
>
> > The
> > following should work for older versions of clang that might not suppor=
t
> > this behavior.
> >
> >   contrib/credential/osxkeychain/git-credential-osxkeychain.o:
> > contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
> >           @mkdir -p contrib/credential/osxkeychain/.depend
> >           $(QUIET_CC)$(CC) -o $@ -c $(dep_args) $(compdb_args)
> > $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
> >
> > Can you try this modification in your environment? You can confirm
> > whether this works as below.
> >
> >   git clone https://github.com/git/git.git
> >   cd git
> >   git checkout v2.53.0
> >   curl https://raw.githubusercontent.com/Homebrew/homebrew-core/46d746f=
92167fd0559af22f4ccb79c9ff35fbe33/Patches/git/2.53.0-osxkeychain-top-level-=
makefile.patch
> > | patch
>
> Using git-am worked (patch doesn't apply it)
>
> >   # The next should fail in your environment.
> >   make contrib/credential/osxkeychain/git-credential-osxkeychain
>
> Fails as stated.
>
> >   # Please edit Makefile as described and try again. This should
> >   # succeed.
> >   make contrib/credential/osxkeychain/git-credential-osxkeychain
>
> With the (now obvious!) proposal, indeed succeeds.
>
> Thanks!

Thank you for testing the modification. I'll submit an updated patch
later and also submit it to homebrew (for the current 2.53.0).

--
Koji Nakamaru
