Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D718B492
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728255814; cv=none; b=laLrAvMPNPE2996YOMJHUnqdJnwPE+jjTGVmDYgoIOONYfLUrsMFrCdbeiXb+QNWylzrys94QOYbFfR034Qbjz+lrKPGXnnCYYokKikl7Ro/FxwQ0yxrDKJUpeuljtupVdn784ECr3yduKMeEh8ESC9BLFbSb4ghtCN3ktHi1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728255814; c=relaxed/simple;
	bh=M+HHLreCuXGEjOigVTkft7niKaAdyGbeeUBWy8XMmu8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmRjfK93yjSBEvJRoT/OG3QLnk7YQaU8fqoDYU5G+SgURGpaBJrb3jvUe0SdZSPsGsJ9xW0hxwul2+2YeD5kKGW8y4OqNxW1+zkhvb6FgukoMlbffb9LAFImF+CmPrKHRjJEr2QDTUjQqxIF7dq68BOxYH21zzSmc2XcoXlG26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VVPNhuZO; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VVPNhuZO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728255809; x=1728515009;
	bh=aaTuCh1g3+2lOGwHNSnN9sjPHM9GfNcVg39sKRsJpyo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VVPNhuZOZQD9QObniU2JRRXJxTIpLtJ1K+xizNsx6io1WlLVco66xHkObkkoV+ZWr
	 yB7ERVOwzli+/VgLAzdUto7WmGeCgbf3idaxm37CyYKTnmKQe+aDhERqvLym1C9TvX
	 lnUmMOvSCCyaVeGIIaIWxlhbWzHIHTBrBgk8XlETFQ1pQhIG32a8cjaEDqRaw/iORG
	 WdBePULnhviSDixRnwtfetl6X6SnchXeJ4oQoHB5BP+rfge4Y93v0yRmGaC8YSq2DO
	 f4kHRmD24ClN4AwitbNOo8SP4Y+wvqDWytXTyRGN4J9H+4d7dxIsD1NfB79FX6LCLW
	 k8CVPDXZts03w==
Date: Sun, 06 Oct 2024 23:03:24 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] worktree: prevent null pointer dereference
Message-ID: <VKrLGkXtD_CWHlQJRx_JqPn9sFsjKL88fRnGvA2UcV_gvQxyv8kmIx9M6BkPRfAx9paB7KrjkL9XAE8P2P2EPJnciBN4F6LAAc176NzLh6U=@pm.me>
In-Reply-To: <CAPig+cSdVVy4huueVQpiO_Gvn4SAXAiQj-uVnuScgfOOFJ6h0g@mail.gmail.com>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-5-cdwhite3@pm.me> <CAPig+cSdVVy4huueVQpiO_Gvn4SAXAiQj-uVnuScgfOOFJ6h0g@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 1b77c5e0f292e8306b857021a3587b2c915eb08e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------4904e439ece330f860713ffec7abbcb50535348919459c2751ec022e5f825f04"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------4904e439ece330f860713ffec7abbcb50535348919459c2751ec022e5f825f04
Content-Type: multipart/mixed;boundary=---------------------ce9e80bc394998233536e49834330482

-----------------------ce9e80bc394998233536e49834330482
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 06:24, Eric Sunshine <sunshine@sunshineco.=
com> wrote: =


> Critical questions: It is not clear why this patch is needed,
> especially coming at the end of the series. Is there some code in a
> patch earlier in the series which might call free_worktrees() with
> NULL? If so, then this patch should come before that patch. If not,
> then why do we need this patch at all?

When I was working through different solution for the 3rd patch, I
encountered this issue and this was the fix for that (granted, I
could've handled this on the caller side). It turned out that I had
to go a different direction and this was no longer needed, but I
figured it wouldn't hurt to leave this in which is why it's the
last patch. However, I can just drop this if you want.

> Devil's advocate question: Why is it the responsibility of
> free_worktrees() to check this condition as opposed to being the
> caller's responsibility?

Sometimes it's cleaner to write a check once on the callee side
instead of all callers having to duplicate the same check. This
also follows the same pattern as free_worktree():

```
void free_worktree(struct worktree *worktree)
{
	if (!worktree)
		return;
```


> The commit message should explain the need for this patch and answer
> these questions, not just say what change is being made.

Will do (unless we decide to drop this).

> Although it's true that this project has recently started allowing
> declaration of the variable in the `for` statement, that change is
> unrelated to the stated purpose in the commit message. True, it's a
> minor thing in this case, but it causes a hiccup for reviewers when
> unrelated changes are piggybacked like this with the "real" change
> since it adds noise which obscures what the reviewer should really be
> focusing on.

I didn't change this originally, but then the build process threw errors
that I had code before declarations (because I placed the if condition at
the start of the function). I could've moved the if condition past the
declaration, but it seemed weird to need to declare a variable if the
function is just going to immediately return due to a NULL pointer.

If we decide to keep this patch then I can keep the separate declaration.
-----------------------ce9e80bc394998233536e49834330482--

--------4904e439ece330f860713ffec7abbcb50535348919459c2751ec022e5f825f04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAxctCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADBygf+LA0b5xcu0XJlni9BUiqHEs69kMimP064UAgqEz3lOOQ9xJzu
W9NOlOHwpAo/UW0ZwCN/M7Ew3FAlAjM8v8kTBlyvnoY+OsGzJK36RLz/P4Um
9NgpkKzWJ4B5vXdPruyxBklpyVg274iE8A02fpOv6cp4Buwpn33+G/9Ttk5J
gKVyvFFErf8xJOrRCV19nY9OCTEhPhYRLudsJC9Y2dk/xYlsZUsuPpKRvA1z
PpTMbAy/qKiqWzSNGzHqw1WvHZYVdBa0rD5grRpRRczd3e54HWmKTcy5MoeM
NeJRu+6MMaAjlC96FLA7Qgpb1UObDZbzCjaIe5hjUQyXjSi+B/LJuA==
=smRe
-----END PGP SIGNATURE-----


--------4904e439ece330f860713ffec7abbcb50535348919459c2751ec022e5f825f04--

