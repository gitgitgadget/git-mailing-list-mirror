Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0C1A8F97
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915573; cv=pass; b=dIbQP4u9RRDdb4MQ/okt6plvsgAzBI133mOw9jTghF5kPAp7scmnFVxD8p1N44KacRPWPi+IDuKlZJd69i4il9e09uxqlNFSDAzKYC5W103WI32BRimwwgKfXmBbG9+4qyouoHMZ+MLLeN4F9tq7h2D1y4x4twHOUam1IwAfyIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915573; c=relaxed/simple;
	bh=efjIxXVUslGypiP8iLnxCfOnypWrdrghjIl3IPBu/+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFdXvVMf3yzQnnekBtq0mlM6ZglFeECcbPaXXeYplAWKQEP9T9tlwSJLURynxw5boWG0zsai0NRjSaLJda/KgazlS46dHLuDEIyPF+YsOav+0Acy6JhQXQwKggZMvDOkcn0bH3I73UW/DCsSFIJL1WxeodrWYVTwKRYrPpUSTTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfaZmbK4; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfaZmbK4"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6608c1a4215so4863332d50.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780915571; cv=none;
        d=google.com; s=arc-20240605;
        b=d0sjhF5F78NEva5bnw2RqWdoqlfFJaEKVvORkED/nQIQYD84tWiGLG0VoRu3spoZuV
         4pe78NAGngPNPadG4IDSUCE68D8Gh+ckDF1GidOTErhUPoA1SO67jNQzHPHIyyS14Gwp
         X34c4a1oDdcGt+QPbpDPAl8oxOnJ7NKo4uGVyR9xq/NlDngS4TeAK20mL9pf9UUrUZTG
         Gy3mLbMTOyFmxD8HUnjRoGnDAcJqFWCbCwu7YVkKey22jC7lU0SPj8Gly8eOQIV2Wua6
         E1eGpXAPaNtyJEewNip4oUDGhNPlYsQkhXSFtBhlesySj8akOTQE1j6u4jf1F9dL8Xt3
         gy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZAAu3oYY+hyolDZUKtNOh/LhgfU+6Mnc6/D2+2PQXC4=;
        fh=VCjcCoJq7R8xNj3e1ntUBnKE45cB+lDpV06/bP9wycA=;
        b=cCmPsGHeG8TbCIcPQdCjKoaySMa9F8BWSd40s8kPP+mN3RExEbKBcjPEJfLBrIGR24
         eJkelipi67YL90EesOuYXQfGsvk+HLBOE9plNjqkr7KqJfQDMrMuebvhneBsRcRv8AJx
         z7lk2fOEtOFdxpcasutp4M5V4dmoIrtCkWTKhENffAME/ML3/7zj6bjWSw5759nP73FZ
         zAlsSg0+3JCbjcSjbaQHhCij99oHlFESF3Q4VzERLB+nhFSBNUagke51Y4lpM2fQiDQ0
         xhdD0Vj23TUGnyc0b4gbacJP/roVOATA71d5NvHdp6enowsyfj3Js7PJEb5K4CDG7DbK
         ZpHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780915571; x=1781520371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAAu3oYY+hyolDZUKtNOh/LhgfU+6Mnc6/D2+2PQXC4=;
        b=AfaZmbK4czcKcXbfanlJeIVYsPZj3+/n9UA0cCxJWfeJy5robHvdSF3RJBdzhJH68P
         Yp0shJmoNPurEFLLPx8AnPznwufu/P8c5C8iweyDVOpdPjy+VpHjZE0UvAuqNLJqmipc
         O5Opv7NsYM9vn62DyG9uQK2G9/DMMV+K99laTHjtypLgJukzihnZeJH3YhzyeGSmaK9U
         bKpCuoU+hI1FtCr98i1SO979uU3qNbD/3d1C6t0dnkWyc5Hn1i9rEn9OTUEEBkmHTi0P
         9NmgGopsDqF3ujMIxpRYfsGnLyluHC+jh0ja1O0Sa9bM4RvndMmxslXo1LSM57Mhjv3J
         P73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915571; x=1781520371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZAAu3oYY+hyolDZUKtNOh/LhgfU+6Mnc6/D2+2PQXC4=;
        b=Zah/KZ/o9W4Sq+4t/N53AKfBXctCkorVydF65R4RLeeD6fQN8v9R/bfpCNrBGE1CLa
         BwBkLU9wg9sz8kMIjFCeBbmJrQfoWb5CTGq0o0nUdnnArcofRNSOG0J5OGGuDXwmNpab
         lkoMebthctgIsv1P7ENRr/KpUuA3xztaN8eWurJrQUJdXiEUSi7mOMfnzxjWkab51lFm
         g1A0D/uGFI5cyzpo+bZqMwVlgur/WHFXRx0BHbo0H5aDqHjlpHwkxRKwldpNrFMtRQkG
         rwvYEbm9XikBDA1p54a8zdIpyB8ia66BN7l3sHur96I3qQsFbwsw6bU5osWDetVhM6en
         Woiw==
X-Gm-Message-State: AOJu0YyD/alVGts2U5sZhHWToetVqtZE983+A9cjhQp3NKi3u1iyRSqF
	tcN6C5rCNgCE9e4kiCHEQc1ASHwBLV4PQOas3KTtwiZxDNaDuuE51X96um2IehpkXzjJAGkI3b2
	wSv08zVlwHIA3HQWpoddwC0GXfK5G+oPpkcQ6kXk=
X-Gm-Gg: Acq92OEf3SqZnAVcH6dEJaa/DPurH3h+sHmfQkCerDlpqafb/0KS55GEeV1OOW49Vkm
	c3NFBaWDtuGzYfxZbHpfTQnlkIPBF4JBqIWhHcvxAKH7RWqXBMGv71Gfug1lBxqsjPlsAm2s1Qt
	Ycc0/ws+gi5C9VshZfrIgj/uZBa7uBGDFvyd2bTH9jnnwMbt5f0eiwiSvJEVlYKQzmKPExTFgkD
	wcfYzIx4Q1K7qYxUBBUV0av4Las6AcEG2IdvfdYf3XzSksBfGh0BvmZVwlygr3nRj6t5qqVe1gb
	kbt9750rX1IeSNCCb0Q/BwPSLqeSsBtd4AiG6kjlL65k8q5C2HTXGIaAqgJwj5AhIV6HBQpKwhI
	mWQozJKIpThEBs+o+PTqPN/3JfrHrHY47rv5AXAkHs71OlEZp5gd8C6mqvPlC+oTn9xEzrZIZ+I
	7aa5y5FMpNF/iK
X-Received: by 2002:a05:690e:1183:b0:651:bd7e:c04c with SMTP id
 956f58d0204a3-6610a6ddf47mr8975041d50.21.1780915570662; Mon, 08 Jun 2026
 03:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260607-ps-history-reword-v1-2-ba43a3cbb81b@gmail.com> <aiaLyQvo8kqfv4js@pks.im>
In-Reply-To: <aiaLyQvo8kqfv4js@pks.im>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 8 Jun 2026 12:45:59 +0200
X-Gm-Features: AVVi8CfpTYQvzZK1370xb_VsOgTqOcOOXorL3f9Ww-pVSqOhRwvE17vhFttuwLc
Message-ID: <CAN5EUNT-21_RMuhRJwdk-vNbZmU=vNxBJEuG9mdaA_3spxwODQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] builtin/history: print feedback after successful reword
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 8 jun 2026 a las 11:30, Patrick Steinhardt (<ps@pks.im>) escribi=C3=
=B3:
>
> On Sun, Jun 07, 2026 at 10:07:21PM +0200, Pablo Sabater wrote:
> > Unlike `git commit --amend` and `git rebase -i`, `git history reword`
> > doesn't print anything, this makes it feel empty for a porcelain comman=
d
> > and hard to tell if the command did anything without using other
> > commands like `git log <commit>` to check if the reword was done.
> >
> > Print a message on successful rewords so the user has feedback about it=
.
>
> I dunno about this one. My take here is that a command should be silent
> unless it has something to say, for example when it couldn't honor the
> user's request [1].

But neither `git commit --amend` nor `git rebase -i` follow this rule
of silence.
>
> > diff --git a/builtin/history.c b/builtin/history.c
> > index 51a22a9a1c..0f1ba3b531 100644
> > --- a/builtin/history.c
> > +++ b/builtin/history.c
> > @@ -739,6 +739,10 @@ static int cmd_history_reword(int argc,
> >               goto out;
> >       }
> >
> > +     fprintf(stderr, _("Successfully reworded commit %s to %s\n"),
> > +             repo_find_unique_abbrev(repo, &original->object.oid, DEFA=
ULT_ABBREV),
> > +             repo_find_unique_abbrev(repo, &rewritten->object.oid, DEF=
AULT_ABBREV));
> > +
>
> Seeing the implementation also raises a couple of questions:
>
>   - Why do we mention the rewritten commit, only? Shouldn't we also
>     print the changed HEAD?

Because `git history reword <commit>` is for a single commit. After
the reword the hash changes and the original hash is no longer useful
to check the rewritten message. If I want to see how it is now:

  $ git history reword aabb
  $ git log aabb <- I can't check how it is now because this is the old one

So to check the new one I have to search the new hash. Imagine if it's
the first of 20 long commit messages, I have to git log --oneline, get
the hash and then git log new_hash, which IMO is unnecessary when git
history reword can output the new hash.

>
>   - Why don't we print any of the other rewritten branches?

Haven't thought of that, it's nice that it does modify all branches, I
just assumed that the most relevant is the current branch new commit
hash. The other rewritten branches have the same commit message, just
different hashes.

>
>   - What makes "git history reword" so special as compared to for
>     example "git history fixup" or "git history split" so that it needs
>     a message while the others don't?

Nothing, I just wanted this specifically for reword and sent this very
simple as an RFC to discuss the idea, I could extend this where it
fits.

>
> It might make sense to maybe introduce a verbose mode where we do print
> such information. But if so, we should have good answers to the above
> questions and implement this in a way that makes sense for the other
> subcommands, too, so that we can apply the same principle to all of
> them.

I like the verbose mode idea but I still think that on non-verbose
something should be printed, on verbose it could be printed
additionally all the rewritten commits (though it could get very
noisy), the changed HEAD, etc.

>
> Thanks!
>
> Patrick
>
> [1]: https://www.linfo.org/rule_of_silence.html

--
Pablo
