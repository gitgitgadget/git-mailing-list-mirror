Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108E1C330C
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530767; cv=none; b=qCm+ahk88j/+0fuEBi9bzX4nJEtavZuI2xKCRexmDiB3SmNUao+okN1hAWGlA5SSbTO62CiJJ+jEMsi7lYBY6ZrVEAWWoebPpXi6zrP0EAuNFn51uzV1ga4HO3q3rBCfNzWRyVwzvXXXQgZ8Fz7qYXPABxzubr6MYQmxemnSQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530767; c=relaxed/simple;
	bh=U6f4Cgd8k9EUMzGX3nJYZyBbUEovsCIEabMY6apUezw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+Ijw4yHQ0xmHR8Fk2M6qzvQMNwcTQg/TSQSkbtwr1Y8v9y//GvbWFrLXRyDiWcG8WV8WTnxVWnJiP424E/nwdVyZZQ/XQJSPv4WBV0ciu0sIMTvRh8ieV3OcHf3DvpM+nu7c1B1DgQNipCz+uy4vlhJDD/OCl5DTQJ07nfkZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmqCzRP5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmqCzRP5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43152b79d25so45658625e9.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729530764; x=1730135564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6imdJ8BySrDzxH24zhpt8IW4BhShbScn3HuNE+AqjBM=;
        b=XmqCzRP5uMS9FWb7xsSoQZKmnROOEQqXHRFcq06XPPqS25GCedXwu544NRjjTrP8SG
         cZDpF1BJUzc/UmJidUYXiF8f/5L7Q9ZPuD+GBLJ5JQ1N4yaWD+9oqCbM5Jc5YAUT1aDg
         4og1XDPOebu/Iy8O+fnCCeO5typQWqjDbm0twVPo48KHPeWic9uLXrrOEESf3/QjaFoC
         iqG7Az6qg9/neCztPU7I5AfQ8DjZCAPyN/Y1NYrqqDJjSnoirZO4SN6H3INMo94PqvDk
         ydjO+NHbZxQEzIrALufvlakPWNBagT6LMgUMgd/Zpr4VmTZZEfhETIumymHSry4HlHqz
         C/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530764; x=1730135564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6imdJ8BySrDzxH24zhpt8IW4BhShbScn3HuNE+AqjBM=;
        b=HW8Vfyc+t1t2GMF/UB4LGWjG1DCd6ToSJFaY/PZ/u/1fa/34piqQjhXLCkRtl/4KZE
         6gXLq/8YgShrhZ+tP5iPesYCtfxag9PmDf/u2d74Hk78lWZ1ZqC7hr2Ilp5bCyHTnSRZ
         h/PojDl6W8xx7y52/QMQ922M9bNqVS07zB0QpDJMX0Wd4w7rBej6XnCRZrlu9VIdqjf+
         37IEzxMj/xTfjbRBvSG2vtb+d60vSTVq9vw3IksuVon3UXyFhw6uYSsUXZM9XB+KFs27
         F/5GAt2+d9/GJQKqGSl8PiT/iIE+Y/5mf1FAufiJIc7imI1EeDHc4hnUyZnENxWJjLpQ
         9kRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiKwbRpelarQ2izwgqm8Qpvhdj/gnZjhCpmhNfpU/nTJrNBve0iy7KfHQ83gNAl4su+p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAmMi1U3hbZmDLh3AaIovkNrlp06pOiAzTU67j5GbsHmvpHY6u
	wvSNobYE24WpnAkcACwlReLOAE7IcSsFI0OOvq5vBM3D8/PYKU+ebYe8KNUW3xwSp6C9z3AofsU
	LcrUFrHaYX2mYj/enbmRuArnvyhQ=
X-Google-Smtp-Source: AGHT+IEVvKKqprxvpnkwCG33MIONCWjQO3VCcybrUEb32GIh+0NEDjNgyhvWSjpAoyqXTZBtzn7Hdt/FT2jUP2TpfE4=
X-Received: by 2002:a05:600c:3b9b:b0:42c:b037:5f9d with SMTP id
 5b1f17b1804b1-43161636f67mr94952925e9.3.1729530763616; Mon, 21 Oct 2024
 10:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com>
 <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com> <ZxaG67wuvjOXc5kr@nand.local>
In-Reply-To: <ZxaG67wuvjOXc5kr@nand.local>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 21 Oct 2024 18:12:34 +0100
Message-ID: <CADYq+fYERH=9_ZXq4JiwjE2_piP93u2=-9ii63SCA0r9p2==Ag@mail.gmail.com>
Subject: Re: [PATCH v3] notes: teach the -e option to edit messages in editor
To: Taylor Blau <me@ttaylorr.com>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 5:53=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Mon, Oct 21, 2024 at 02:38:15PM +0000, Samuel Adekunle Abraham via Git=
GitGadget wrote:
> > From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> >
> > Notes can be added to a commit using:
> >       - "-m" to provide a message on the command line.
> >       - -C to copy a note from a blob object.
> >       - -F to read the note from a file.
> > When these options are used, Git does not open an editor,
> > it simply takes the content provided via these options and
> > attaches it to the commit as a note.
> >
> > Improve flexibility to fine-tune the note before finalizing it
> > by allowing the messages to be prefilled in the editor and edited
> > after the messages have been provided through -[mF].
> >
> > Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
>
> Nicely described, this commit message is looking good. Let's take a look
> at the patch below...
>
> > diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> > index 99137fb2357..2827f592c66 100755
> > --- a/t/t3301-notes.sh
> > +++ b/t/t3301-notes.sh
> > @@ -1567,4 +1567,75 @@ test_expect_success 'empty notes do not invoke t=
he editor' '
> >       git notes remove HEAD
> >  '
> >
> > +test_expect_success 'git notes add with -m/-F invokes editor with -e' =
'
> > +     test_commit 19th &&
> > +     MSG=3D"Edited notes message" git notes add -m "Initial notes mess=
age" -e &&
> > +     echo "Edited notes message" >expect &&
>
> Very nice use of the fake_editor script here.
>
> It is a little cumbersome to repeat the same message in MSG=3D and when
> populating the 'expect' file. Perhaps instead this could be written as:
>
>     echo "edited notes message" >expect &&
>     MSG=3D"$(cat expect)" git notes -add -m "initial" -e

Concise! :-). Thank you very much Taylor.
>
> > +     git notes show >actual &&
> > +     test_cmp expect actual &&
> > +     git notes remove HEAD &&
> > +
> > +     # Add a note using -F and edit it
> > +     echo "Note from file" >note_file &&
> > +     MSG=3D"Edited note from file" git notes add -F note_file -e &&
> > +     echo "Edited note from file" >expect &&
>
> Same "note" here. ;-).
>
> > +     git notes show >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git notes append with -m/-F invokes the editor wi=
th -e' '
> > +     test_commit 20th &&
> > +     git notes add -m "Initial note message" &&
> > +     MSG=3D"Appended edited note message" git notes append -m "New app=
ended note" -e &&
>
> It's fine to use shorter values for -m and $MSG here. I think "appended"
> and "edited" would be fine for each, respectively.
>
Okay. Noted
> Besides applying those suggestions throughout the patch's new tests
> (including the ones that I didn't explicitly comment on here), I think
> that this should be looking good after another round. Thanks for working
> on it.
Thank you very much,
Abraham Samuel
>
> Thanks,
> Taylor
