Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765147;
	b=Krd/YFCl0v0J48GNVoU76ibWrAHoGpYYUqkYChU0HBQv0T5yO0i2giUNbYRXmNqdWImY
	 8YVMh1idtggTM6gqYuBrB5JYnAnqbvbarKIWlZvsmQF1FrlzNl1B7IxwVoY4GqRgecuom
	 l4mHejf9SHItkYr5j+orEtXQkGu7+RwGNYdkDvmcdKvOlrik7Xq56a8chB1rVjZoJji19
	 t/0RiPVdu/k+EXcxUtkNqtcpX4REdrgpd2GjS57jDHpgesmjmHJS0VYz/CYVcqvBcNC5B
	 2KyHfXjp4ZYfnayjpTrRJt8z0ULTvO9TWz0jkDrGzsTJ1ZMJ8lg/C1SR4PYtj3RZ+WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=CqRvDLq2Ua0UtDfry81X1GoStQuhFe+hYDoxIkiFHdA=;
	b=P1LiNbN6JBQXN7xnXFWWIF2xh6ULVIDGNHFvSMsnzf3naaHndWecdF+FMKkby17Pre5E
	 7oKo12hDHYWYEdB3FD5/9QYXLAoKJgOEKylgzN76/chdRMHaAx82f8QAy5CJ5H7YeMcDI
	 h8ttCIYUo5OoNhVgjOKu0fgbovu9chNDFlKHeJ51Cg5khxjMOAnLdsID5YbQhh7WnoI56
	 lsW7CsKvywpuzixAFOT7aBJuahtMGi2PD0iOG+7HCwnMydajxmEJBqN19jVBoFiJh3V9D
	 6Z5KYs+fXiGp18GnKm99tjWLBkaPXvsAZo5dBp29OVgd+NHJWaBKLhvp82UP90qp3Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OsL3dbuc;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AAD606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1AAD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OsL3dbuc
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-675676afc3cso1124684d50.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792765146; x=1793369946; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CqRvDLq2Ua0UtDfry81X1GoStQuhFe+hYDoxIkiFHdA=;
        b=OsL3dbuco7Vgpr64NHlIX1hv8pLdpgGtWivoYQKPXXYle8sBFuRZgeITmDXbWLlceW
         xQ7MMETAdbvvyWdqkl+duQKXmSYDRDNinUKXCV0fpkisESln4oFq4ucxd7EcAGjBTNs3
         u0sX5DeE5Jbp14IOAz6+ZoXex+sEjGaPrNZXhFVncVyZShx3zITUa5CpGfrkZYMJXpG8
         qyewTd3p/SXbNVRJMlVkCWLk8cL4Kfhiu4SYIdPUlUNSt4vHmLGu1a9ymiL0FH1R0Uwn
         I6Hf5kjptwpuLoLhavbpN04MNzRhGRYVDR3iq9W6j4GW7pbfi+DrR6J4sDErTJzTsrXY
         A+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765146; x=1793369946;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqRvDLq2Ua0UtDfry81X1GoStQuhFe+hYDoxIkiFHdA=;
        b=0UY5cAAih1pXgfALl37py/LaHHdmiUMvz41mRtCp2al3cfVAujfxeHZn+uJwCxEtjc
         W3GfXP+yADQsWYWNZmXpYo0i7Ej/crRCMeynD4x3xW/nDNuzTgxxDPb4elutcR48iEri
         X5d2j4MEzXEg5Q4F6vzFU0O3BidTZrTtIFdzizenrj4xvbja5bX6bryBEDg2/skUPfcy
         qBzpi7klMxWNWAVkbOnCZk/MmT1GO42wk11uN4905tKYGliba26u7SFzj0gL6foOTjvO
         Zl06+Bvwb/F4jZQpJtWAPghscZ9saXoGaXkEASNltrFDHGWFeg4spfZiQqLl488aKSOc
         akhg==
X-Gm-Message-State: AFq9FYKqNEIf/lo/g0T7ywoVVM44WEyQcdNDXh0Z3zNWieS/sucO6A4F
	v8i9egUP3doX4A2iyPrtj9dmPTpyRQrcOujOk+sD8QNKozuzzmeij9lb
X-Gm-Gg: AYBFou0bnS12DjvuaVlnBhzi/Ks612pPkODL5Bgh9Rc88UDxHHsHcZCU7d59MuxUdsq
	o1x6UslSE5gxEsSoRevQtXpRGMZX546g5KE5oyv7TzcXm5JLlJM2TXWlCdekgBRuOP4ieYv290x
	BSxWTLnQyAgRfDr/cYlK9it0Cn87gWXRtUQC6oRJvIHUpnW9FzFttptOQjBcIZ/rd545Ndq8c7/
	Bc3EKqk1olDhE78Qprrdx5NUFGCb8/3A1MTHk5h3EhyMVydwLcfqAkKSOkQjnCm34a9hPoqbTk2
	sIulW0u6IOM+BVbJjDgqP3hx9Ej7qj30KgaUS7+gO4VyTVgMI3vKKXMWQkn3DKpuH2lL3bZTerG
	MeVcM16l/TMvP7KmQ0D4zoBCQrhdlTWwraVQozwHfEhReNLoeUt4fIdO0tAw8VMckysUdda1YJ0
	f+nYwBakDQ4liO9xzuJ5O6HvrKX9p4jNNCe0NfMIsay+PXduVcaNP06W4RZQCx3JRMUVgF9iue8
	nLlSs4vyBgkG9kEzh/GbADN9P3w0Y9CDQtyQ3X557abqMEt4eNW7vrPZ3Xtj3dHMcrBB/B6MJQK
	6/TCYlyefVw5SEvxX0Vp3aZyaTiKpo3ZWULtJIJw96qG4xMxH6En4zfrdwNwpB237LLyefOJm3f
	JG9RkfD4GgEwnd26PuSiuSRc9sA==
X-Received: by 2002:a05:690e:809:10b0:67a:74d:e16b with SMTP id 956f58d0204a3-67a35b2672fmr1120118d50.17.1792765145793;
        Fri, 23 Oct 2026 07:19:05 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9d17:3000:1d:477:fbde:1358])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a34045843sm1346969d50.18.2026.10.23.07.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:19:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 0/6] [doc] Add new page on merge conflicts
Date: Fri, 23 Oct 2026 10:18:54 -0400
Message-Id: <254688CB-AD21-4283-AE19-F1061C90C6B3@gmail.com>
References: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, Jeff King <peff@peff.net>,
 Julia Evans <julia@jvns.ca>
In-Reply-To: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)

> Le 23 oct. 2026 =C3=A0 10:04, Julia Evans via GitGitGadget <gitgitgadget@g=
mail.com> a =C3=A9crit :
>=20
> =EF=BB=BFHandling merge conflicts is difficult, and currently Git's guidan=
ce on merge
> conflicts isn't giving users the information they need to navigate the
> process. As usual, the process I used to write this was to collect comment=
s
> from Git users on the existing documentation, and then address those issue=
s.
> I listed the specific issues we're aiming to solve in the first commit
> message in the series.
>=20
> This patch series introduces a new manual page, gitmergeconflicts, which
> explains the process of explaining a merge conflict with examples. It also=

> links to that new page from the commands which can cause merge conflicts,
> instead of trying to reexplain the process every time.
>=20
> Changed in v2:
>=20
> * Explain what a merge conflict is (thanks to Junio & Ben)
> * rewrite the "ours" vs "theirs" section (thanks to Patrick for the
>   comments)
> * add git log --merge (thanks to Ben)
> * Leave most of the content of git cherry-pick as-is, to make this patch
>   set smaller (thanks to Junio)
> * remove the SYNOPSIS since hopefully that won't be required anymore by th=
e
>   time this is merged
> * Fix a typo in git revert (s/reverted conflict/reverted commit/)
> * 's/the the/the/' (thanks to Patrick)
> * s/[doc] Thing/doc: thing/ in commit messages (thanks to Tuomas)'
> * squash the commit fixing the linter error (thanks to Junio)
> * list reviewers in Reviewed-by
>=20
> Changed in v3:
>=20
> Thanks to all the comments from Junio.
>=20
> * Add signoff from Marie
> * In "For example, here's a merge conflict where both sides edited a list
>   of", add a little more detail about how to interpret the merge conflict
> * When we introduce a merge mention "semantic merge conflicts"
> * Say "... and any other command that does a merge" when listing commands
>   that can cause merge conflicts.
> * Reviewed-by is not the right thing, use Helped-by
> * Adjust phrasing in git revert and git cherry-pick man pages
> * Reference the "ours" section in "git show :2:filename shows the "ours""
> * "there's one file left with conflicts in it: fruits.py" isn't precise
>   enough, instead say "the conflicts in fruits.py haven't been marked as
>   resolved"
> * Delete the explanation of zdiff3 and add a brief warning instead. Don't
>   be too prescriptive, we should tell people what the issue is (ambiguity)=

>   instead of trying to impose our opinion.
> * Explain ||||||| when we add diff3
> * Fix example in "EXAMPLE OF RESOLVING A MERGE CONFLICT" to make it
>   consistent with the other examples
> * Replace "configuration option" with "configuration variable"
> * Mention --skip instead of saying "the most common ways", which is
>   ambiguous
> * Add a pointer to the extended AUTO_MERGE sentence
>=20
> Changed in v4:
>=20
> changes to the content:
>=20
> * use Junio's much better example for diff3
> * clarify in the commit message why we're not mentioning git apply: to
>   avoid dealing with patches (thanks to Junio)
> * adjust the wording around "multi-step operation like a rebase" (thanks t=
o
>   Junio)
> * Say "see git-config for more" in the description of zdiff3. Like Patrick=

>   said the explanation of zdiff3 is not really satisfiying, but I don't
>   know how to write a satisfying explanation, and it's better to have a
>   short and obviously unsatisfying explanation than a long unsatisfying
>   one. Added a note in the commit message that perhaps this should be
>   improved in the future. (from Patrick's comment)
>=20
> changes cleaning things up:
>=20
> * add periods at the ends of various sentences in an attempt to be more
>   consistent (thanks to Junio & Patrick)
> * Adjust the formatting around the [NOTE] to make the CI whitespace check
>   pass
> * Replace a couple of instances of "code" with "lines" (thanks to Junio)
> * Fix Ben's email address (thanks to Ben)
> * Remove the double signoff (thanks to Ben).
> * Make the cherry-pick commit message more accurate (thanks to Patrick)
>=20
> Thanks to Lobo, Adam Svahn, Louis Vanier, David Turner, Ben Zanin, Salih,
> and about 12 others who gave feedback on both the original git merge man
> page, as well as the proposed improvements.

I=E2=80=99m happy with this version based on the range-diff, and
I suspect we are reaching the point of diminishing returns.=20=
