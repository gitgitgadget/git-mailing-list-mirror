Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E583E7BAD
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600438; cv=pass; b=JewJue6W+wJw+ZF2TGIB24Roj0sA2qzbnU+VNxnZSKtdi0AgcU+QQ5qv2Sno+SrHyjxPLpBQ2d4LUa6pwJ7w1sgWAr0M5awaWWDupdheWEuk4a4ViSmS6LxQGhemo2xxefAQ6CdKqYoufn79xhkk22BPqtgaJTdFLaArAWrrGrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600438; c=relaxed/simple;
	bh=aImkuTtgtQ0LSG8jvCIMsyWj5K8Tnw81rG6/Q1T9BrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+qcqclwrMMTFi+NBWXEfsB3ui/emEIDQQGg/bx1I7vHkshJbX378YeZ+XA6dSpK5c3ADXFoVEaahBccoXOkXcGHOPBQu5yW4sfsKf265yeHEYWKAnsb5XKMg9V94RtjDwhBtGfqOKHC1AuBfyopSIzOWqjtTpwX/DtqTdWoEwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQPP0Jp9; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQPP0Jp9"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a147688bso2161690a91.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790600437; cv=none;
        d=google.com; s=arc-20260327;
        b=GqnFowOUoSLtu10Yh4STKq6LnyBoT96U1Te4nonUQtXleP4mHpB59exJmZhrq96H5Z
         6LPtb5AM2sNUogNzDA/cC5ZTkpOxc33gmrV/SDGSUAP9WPOK3BebtR8jfQv+iW/h7wem
         nhur/uqZHk/Quy6913nxwbPi4CrpxSSG3h7+kE1ABYVVqtnFh39gNiktVyAOzQtN1B9T
         /6Qk6d2hsK2rGc5fqr/8DFEFLQQJu4LHI7/ET1LXlBKjD1qtmQrRO0pHBlNkKoF5n4kP
         vlgG9To3ltodWhwyObFIGvQVBp+HU19uVgj1LoZtvQBYxeY8zv+ylnh6azkzV3OaXzLx
         TD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qpfRHqiaXCB391mwlbaRNrcJdiAMTuBdv519Fy4FNxc=;
        fh=j31ckz8DMvxVeBuAyrMWt95mG6mcZEKr1nZr/SW8v+g=;
        b=o4wtpmJhkIFWtr/1aE19AqsXJUc9EMa2DoXeZRJnGNCZTwFcXBHvqfBKtYjKEoIzgq
         P4K21T8RRrpcNviR8VN9as064CaeAUBqHlT1qLRCk5YDaI25NMK2CVSFqwirT+Oc3Vqx
         ujzo3kpAWTBn/LXRqNroh/TVdcApDdHCpBVVb9MMM63eOMMYjj5+uBTaVakFWGe2h3aC
         rCz/5e9aJNvGajs/VbnJHAH8LGBY3RIvAL0RM4hAAtKYQXC/NGDIA9QslO9sACEaSSas
         YS7qyBIZX8zttZmBvBF/oX+bNp7sn68SoHKypQ0a0e2OtBOfB/pRjxHGVmNC0ZhsrqsE
         Q9Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790600437; x=1791205237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qpfRHqiaXCB391mwlbaRNrcJdiAMTuBdv519Fy4FNxc=;
        b=mQPP0Jp9JAWT3VQub6PBnwpsa95R0xlDnSydnnARmVpWSDkmklMtomeEUKcIntdt6C
         wiTKOVYZail0IyJQZjXzDsb/itMG/04kJ3CeL36U+j3EMt45jpqT1tkGsDvyPTG0Ypju
         P8xVzad0Wd1IwDleGilICsdK6ukLvIY6JP/gwEc+TL8t2blL8Ne5zvJv1ivtsbMUGHu5
         Bd/J1clRy4+MAzsZawnJGdf7/3upW4SGyntAJTi1OtyStvpXa0mCWQKrL5GV8DAoxdQd
         LZdFxi8IBsiTHDd8uVAR7352WMnmM/A3RFrHjHsxXB5Hkup64Os8IsSmzhOt1Rqvb/DX
         jyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600437; x=1791205237;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qpfRHqiaXCB391mwlbaRNrcJdiAMTuBdv519Fy4FNxc=;
        b=cKfSVY0latsFSQ1uWOIvVAZtsJETRLCOUY8KtQuAZ6UPT90GkwbOFWfWnSxMLS0f93
         epnsFxSEGtDSck7tCWDauyYKX2fuo73Xc4Q+jrKCPoJGZ5jpFbTNQjqemY7UonJwQhLT
         GED3ysFh0/w2dDj1dgICzsLxZClOlR6Hm8YRcyeFDVDt9iNkw3gBURtyi1JcPtxMSAXJ
         4Ggaqx73Gpby06qr8wx0TMV70dsHROE088fc2X1fM83cM5OUlDvs5QPXLZ8m4bdFhSmT
         DqIULvynjxT6isgD0kDbxsErJNz4cEuin36C1CfJwsO1ChKXamKCikn6czCjpO3arWru
         hF5g==
X-Forwarded-Encrypted: i=1; AKwUvBwSMp5VQuuxBg+HO4HkGOtC3TAqSc/gFvY0E4dyYQjMjb4PEmTQrymDSVb7AIxJfTKioR4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEgp5CT8JemTJDridARqppderTg4ZAvnLV2sTdIMwKVfMZ9E+S
	JXz5YvzGV3dh+UZuWYo9G0RBiqlBSfM0WWu8Wtwm3W7afuNdWnFAWq7GeWjYT41NOyvHBhg0b+L
	I5sbr6n2lH6VKyxFZK7+Q5BrgxnD1ytk=
X-Gm-Gg: AYBFou1dqNhvAOPNbif7KlXPgA6fFQCA6gkHL5/mZ2efChPyx+aqNncQvHHrnpcg+Bd
	UVMEJkMwBizHQeXXRbJWfczAhXVgAXCiMxDKtt/Fr2l0+gSKwp3Pyuwwa8s6EfBnvgM/D4KpkxR
	AL55lEZJ0CJgV9ymNlLPN8UDCMNHuXvusy0WfBs5cWIakhbVZqqJDPmXc4A+yh2diXcfAGZfm85
	W1jbUrjAQtwqDCKmiVuIeuBHtB40Wd0pifVYyjkcVBPRVpEaJr61BR2J/vZ6HEWqhDl5Qor/ps0
	PPnR2VQMajY1RB82mvnh0XUlka/i04vgLCxCEz+6MEcKbWmDKodRJoRYq0v234C1GDAqvTG3Clh
	JgZeVYkZ7/H3pDK9tZsk51jXjJfr2aP8w69QdRtYD0p9CXzLlYsD6KQNwHXLMWQOBVu3GCI9m1L
	2K/c/Kpwo=
X-Received: by 2002:a17:90b:3a0e:b0:3a0:3a3e:f78d with SMTP id
 98e67ed59e1d1-3a099230a33mr11203127a91.47.1790600436671; Mon, 28 Sep 2026
 06:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
 <xmqqjyo6qz3z.fsf@gitster.g> <346c4209-9600-4302-817f-e8f6b364ce6a@gmail.com>
 <CALnO6CCXT1HHUwL8+eYGVL443nO0eoC7vhpoLvC3RXjp39XQYA@mail.gmail.com> <CALnO6CDOo35HAfqn_h2CUUdux9LeOkjM8OdFLkkS1nVexijUvw@mail.gmail.com>
In-Reply-To: <CALnO6CDOo35HAfqn_h2CUUdux9LeOkjM8OdFLkkS1nVexijUvw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 28 Sep 2026 09:00:24 -0400
X-Gm-Features: AclHuK84Rm79le9Gs-44i1yYaKlRogPC7Sh-r5Hj4OzBJKKm1ey5rwu3jWhqXyM
Message-ID: <CALnO6CAf491aNhqcb7K7YcNTSTNLAESmqeLwzEGk_S=ZsOjG9Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Thomas Bachem <mail@thomasbachem.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:33=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> Just leaving some breadcrumb notes=E2=80=A6
>
> On Mon, Sep 28, 2026 at 8:05=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.c=
om> wrote:
> >
> > On Mon, Sep 28, 2026 at 5:50=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> > >
> > > On 27/09/2026 20:21, Junio C Hamano wrote:
>
> From my local version of the branch, the following script points at
> 4f65642eb0 (Merge branch 'tb/rerere-lock-grace' into jch, 2026-09-27):

And within that topic, bisect points to 2d1fa0323f (rebase,
cherry-pick, revert: run auto maintenance when done, 2026-09-17) in
t5220.69 as Phillip said.

expecting success of 5520.69 '--rebase -f with rebased upstream':
test_when_finished "test_might_fail git rebase --abort" &&
git reset --hard to-rebase-orig &&
git pull --rebase -f me copy &&
echo "conflicting modification" >expect &&
test_cmp expect file &&
echo file >expect &&
test_cmp expect file2

++ test_when_finished 'test_might_fail git rebase --abort'
++ test 0 =3D 0
++ test_cleanup=3D$'{ test_might_fail git rebase --abort\n\t\t} || eval_ret=
=3D$?; :'
++ git reset --hard to-rebase-orig
HEAD is now at cb9bf26 to-rebase
++ git pull --rebase -f me copy
From .
 * branch            copy       -> FETCH_HEAD
Rebasing (1/4)
Auto-merging file
CONFLICT (content): Merge conflict in file
error: could not apply f29aa66... file
hint: Resolve all conflicts manually, mark them as resolved with
hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
hint: You can instead skip this commit: run "git rebase --skip".
hint: To abort and get back to the state before "git rebase", run "git
rebase --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Could not apply f29aa66... # file
error: last command exited with $?=3D1


--=20
D. Ben Knoble
