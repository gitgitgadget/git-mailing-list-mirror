Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047833C1AD
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116180; cv=pass; b=jAIhIYvbLQmf1UY+nnri7Tr5HabIeNPeSjXkjSQcNzs7mXQ/kD6GR6MUMC3jXz59nXCDa33u0B7RZhAiC4n+4qDj4Tstn8959Y8vwu4PrTMJJi4HCaTmSHYNfJ3lkE6l0mXH/vTGNMpkGJQ7TJGaUEa5yY6vCple3ngSXn6Yg4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116180; c=relaxed/simple;
	bh=jIffu+JSRhF7fDKfzRKKi2R93Rhh3yjnWX75gkT0sPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tsnq/130Op+K1gdka4RvRHeZlIcnknuPKufhK8vjGtORExN/dybl2qNQh8Y9sZHHkKniO1mvIwb+xFdx/ZAIp9H/KpF21T6ZUar29XNJKEiRHzoiItkKvtoRVeoS+buVn1c0mBHg8pH/lfqwSY/SIFU0xQuUfoMMUWnT7kXQLVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brotZDt+; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brotZDt+"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6aea94f96c4so1610959eaf.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786116178; cv=none;
        d=google.com; s=arc-20260327;
        b=hHhatfcSEPkGuAlwuhGfp4AadHKURQNJdtVpeDAJkcJ79fYjDPPF78sUSvP8reSNVt
         imVL+Qt3cSJwlvhosSfNH3PWEiRAvKpeoEFTTj/Ua14Dd1Oshk9D9XjdhEsmTV+RJppo
         rv5EoPDJoDhY7U1f21Qt2qHMaCTNhOpn56MNaj/9RKpjbsksSmjct7OUmbDndDOsEjeh
         wdoJSiUYPLTmMaHhOTItChgc+eMOSAFoNLc9xacSskJgaPxXeHOkJtgnUt2jfstrVUJO
         EcLkaUjtcLpnTOr4xSIAYmjNTSjaXpbYUn9p63J4JZMU2JCbkxHfiV7xroWoZhA/JhOv
         q9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J5tPdHGuTnavBGBpDauYuI3WvWV/VHhAYPO3soBaDHY=;
        fh=K+nwAsTgvJIY4kMWVokCW6lJIm9qzCyizIjWP69oThQ=;
        b=YFmIBmXE0eRf7ZgyHY5uJbNOPm+ZeacyozWfa0XEQdUY+podyqehBAOnMDXuPVAwdd
         EOXDg0erHoCCBNbMYVgVuTfbeC9D5dkiL9yx++cKItDO9+QvOBsrzQDegOSJBh2+Clzo
         6+7prjVlIOiuY21neRKZE8MdVQkAB5PnWsY39oQMSachcbzOjh89pRJxFyTQPZ8yPY4H
         8NWAQ9aWou4cJtkDzqRFWcpGV27v23ej62IUq4zac2lOfD710wqN4E2pagaiBLpk7flc
         LZl7Z+BkdQ+HkY0LgDlRpoA5ecEIrW2bQ+ETcItRhXBtZN95yhMZssg6h/gUer3XdprC
         pKMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786116178; x=1786720978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J5tPdHGuTnavBGBpDauYuI3WvWV/VHhAYPO3soBaDHY=;
        b=brotZDt+b7SNMrYCPWHK5UIVOvHxcrBSHzpYC64T7pPC9jtQGZygRK0QjCqX8aX92+
         W1NeLEKz8+4K3RK2l8aVNs8A9qTf//doTtAoBovv0+JCK2wM+5feFw638Hw17WRE+2M7
         kEhVFxaQjLQ+Mt6QqC9kvvoYWpWqC2t6Q6dRlDcLf9NPwl8MDh1aToxhnxYaOnmcsZhc
         8Xpph5raSIsRsk3AEGN1d2tFw5ZHYzhpnQs5HtVVVORfBjclecZBeSukl0pfUnWiRD/U
         3D9b1sP88K0rt1XvRZiA1VMBXHQytJRf6j/s1fkgqt4SQSOn0VM3klgW9sHzVsczog9d
         SHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116178; x=1786720978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5tPdHGuTnavBGBpDauYuI3WvWV/VHhAYPO3soBaDHY=;
        b=d/gS3i1/sT90rIQGxacuPPmrCgGBZCHzHJyTNjQ35R+LhZVHfd0lR3aUDukmLSpdHS
         7YEqpNht+hTyYugbI04+GswYUXBJva55UeB+9csKQnAPs2nUYXEVXRvVUmqzFUP0ip2v
         cPhPDGm+mAVopgZJ7370MkRg5CCl1WVHIXtkcSvZqG428DECrhinqYCWb99a0hSJhm1+
         0UIkrs9LvuWQlbud9iTDLJIXTSXXi9LSe2Apw3RDgODCvwUW4FlOTGERoh0jr4xZaupz
         g5NHJzMogESaIa+uLOLEHZMUS5cv8fY8ql3hq6s/ndB77PpOLxohF7OUGq/vivv5+9Zu
         Lpkg==
X-Gm-Message-State: AOJu0YyN3reP8mfNjG4QAtGJWD9N9sHpVkqDHW2H4sXBbGBdDYKBbqYz
	GvTa1G2gDN/clhrK9cQMIy2WBGPLhneJwjfmqgGS5Re5HiTpRQsPyBT/7arGSwQczRML+Krit9L
	N2t6UWnBAfpXen07qYujVGUaq5FmMGww=
X-Gm-Gg: AR+sD12fh3JTCwxHip7BMufJYlk6WR86x5TTcC7Ze3PQt1IPMPHIXg/Q9UZukyp687G
	O6DdNVH1Fc3LM50YNn/9yi2BDH2tRcQVzG34kdi2Ovj2rwfV+dNP2mBa+P2S9j6YXgtWn/aPN7O
	MHKViE0rEgMKtv6djYeTpYUeMMlPwFmXpFe7nRRrGAojgxvLV/+Vbggg4A4PhmWA5H2W6bpqZEx
	X1tm3JRFbbXL2lTyEzqBK/OjIXAkhLQ35tnKnH1HNEIepoVKO2uXc7RwboN5HNE0CcLOVIkU9p+
	5FGRg56GTsjg0PIfKcPltiqAQWEN/G0yR+7nqE4YNr+nNQpiJI1mSHi0BWTYLrYR8rg12qUZ2IU
	mwGmkODem2R0D3C9r+npdUFmFQe7H/bSG3F+X74YaAB7kHNabs4hg+Zr0ElGHq9s=
X-Received: by 2002:a05:6820:810:b0:6ac:9756:c70c with SMTP id
 006d021491bc7-6ae96ec7b08mr9830984eaf.20.1786116177789; Fri, 07 Aug 2026
 08:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcxw010me.fsf@gitster.g> <20260807013830.698340-1-gitster@pobox.com>
 <20260807013830.698340-3-gitster@pobox.com> <CABPp-BEAtpT208afwSNoBbR-Nowss8OsLsL8ynETuBfN_xvWag@mail.gmail.com>
 <xmqqldaiezgd.fsf@gitster.g>
In-Reply-To: <xmqqldaiezgd.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Aug 2026 08:22:45 -0700
X-Gm-Features: AUfX_mwaidn_srK4YmTzJ3e-8j_FdXlHTEFt8jIGToi7JF_01c_x0KcmAoZUesw
Message-ID: <CABPp-BFmrqdEP1AQx1mB50LX1q63c9cgMeOsVeUZfzgLUA9wLg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] completion: complete tracked paths for 'git diff'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
	Britton Leo Kerin <britton.kerin@gmail.com>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 8:13=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Aug 6, 2026 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >>
> >> When completing arguments for 'git diff', _git_diff() delegates to
> >> __git_complete_revlist_file(), which only completes revision
> >> references.  This is good [*], as mixing both revisions and paths in a
> >> single list for the user to pick from is simply too confusing.
> >>
> >> If no reference matches, or if '--' is given, however, _git_diff()
> >> leaves COMPREPLY empty.  Bash then falls back to default filename
> >> completion in $PWD.  This fails when 'git -C <path>' is used because
> >> $PWD is not the target repository.
> >>
> >> Update _git_diff() to use __git_complete_index_file() when '--' is
> >> present, or when revision reference completion yields no matching
> >> candidates, so that tracked paths are offered as candidates.
> >>
> >> This changes behavior even in the case where '-C <there>' is not
> >> used.  The new behavior omits untracked paths from suggestions when
> >> no revs match the prefix but matching tracked paths exist, which is
> >> more useful in the context of 'git diff'.
> >
> > I'm looking forward to using this.  :-)
> >
> > [...]
> >> diff --git a/contrib/completion/git-completion.bash b/contrib/completi=
on/git-completion.bash
> >> index ccd3b2a372..845fd19f70 100644
> >> --- a/contrib/completion/git-completion.bash
> >> +++ b/contrib/completion/git-completion.bash
> >> @@ -1981,6 +1981,10 @@ _git_diff ()
> >>                 esac
> >>                 __git_complete_revlist_file
> >>         fi
> >> +
> >> +       if [ ${#COMPREPLY[@]} -eq 0 ]; then
> >> +               __git_complete_index_file
> >> +       fi
> >>  }
> >
> > Curious; __git_complete_index_file() is documented as "requires 1
> > argument", but you pass none here.  As far as I can tell, it works
> > anyway, but feels like an accident:
> >
> > 1.   __git_complete_index_file CALLS
> >       __git_index_files "$1" ...
> >       (Here, "$1" =3D=3D "")
> > 2.   __git_index_files "$1" ... CALLS
> >       __git_ls_files_helper "$root" "$1" ...
> >       (Here, "$1" =3D=3D "", again)
> > 3.   __git_ls_files_helper "$root" "$1" CALLS
> >       __git -C "$1" -c core.quotePath=3Dfalse ls-files
> > --exclude-standard $2 -- ...
> >       (Note that $2 is unquoted, and since it's empty, it disappears)
> >
> > It seems like it'd be better to pass an explicit "" to
> > __git_complete_index_file than to implicitly get it.
>
> OK.  It feels a bit strange as an API for the function to insist
> taking one and only one option, which forces the caller to do
>
>         __git_complete_index_file "--cached --others --directory"
>
> when the intention clearly is "we take zero or more options that we
> pass to ls-files", which would have been more obvious if the above
> were written as three separate parameters, but I'll do as Romans in
> the (hopefully small and final) reroll.
>
> Thanks.

Yeah, I don't disagree.  I would be equally happy with an update to
the __git_complete_index_file function to change the comment and
explain what the first argument, if given, means (making it clear that
no arguments are okay); but without either that or having your new
caller pass an argument, the inconsistency between the documentation
and this new caller felt like an issue someone might trip over in the
future.
