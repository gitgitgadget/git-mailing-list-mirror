Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795726638;
	b=G2e0IX1rPMO1Xl9mjilc6mp6g8ZgZLhBRpGrZlTWicQy20V9g1XnImrdEWCHKJm2Ws4Z
	 KqS9/uGKT9SKE6R4tra2mgYQAuXEutEohOPpYYfvRpi9Ans5B3bsfyMlf5AlI8G1bw25w
	 erlQFYQKS97PV1A/M6Dfu+m69f8x5ma/ManSiVN1lDHVBgwjmShTfkJvI06XNgahXTA/8
	 Qxakfl8bQg1HJQdu4g425GLENfb+vYYVtST49FbBrnxsggHhMMTTg5VsF5ylBXS+QjEKK
	 HBYCSVhIUWok4VFmQWh0vy5kawOEQmRSdg6MF3sCmhMz4TA92sJVuZNr3dWl4wA8xfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=4A10ShFx8OYy7UoPsGItwbG+ErsvMMLmVUzSrm1bv6g=;
	b=5hwyfdoWjgikbl7DibACKCFxhdSYNLhstz79MG5SoRPXhsuaxdR3qKQcU5yn2etJf8Q1
	 vibdcdg8FyQFfjgrXAydFkJ87GaWpxO6aE7+wKwm7r/rt6VzLTJJuQAy3C4D5WwMzRCNx
	 OWCOzu7ewxdmRNwMKwEEAhqoM5JOYbNHUgVzamHJsxYGLr7oyrg+ZKJUxPbtpmc1iFX9T
	 3cKKL9KXyGbrtdp/qkOZqlcmTTY32dCny3HzXvJsMGCkyPKHzSjhwfJplI0Gt2PzCW79W
	 Q912vgkCrSqOidgl8VmwIkWsbHootxRMXUYlt/QOatagGPfDBXzy7U8/tVoy07lanlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VsyFgMx4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4EE606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 20:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D4EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VsyFgMx4
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso64782917b3.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 12:57:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795726637; cv=none;
        d=google.com; s=arc-20260327;
        b=SS8icoPU1UNaifxZjXltfsnYM9+L6pqMkpw9rAJ3hYi9mper0kfy6b+czMhh1bHH5f
         j1fVbBFntH0DjROtXWRrImU2MVtVhxkWH3qESnpw8s9QZKNv0b55LuXICgRo5cgEfmZN
         fxFRscqUEvBYPjdoD40ixufizUsyNwpKEWtsdCRAlCVcdJ6AVs2EbJPwTVLZnxt7SDtr
         xiuNySix/C/HmDL1omH9b8kcpdLRMaifrb5Hr5SwQs3l6bHErVPDef1ES4igN1U00/Bq
         A5Vk1H5pHGpWkd8D6vowRLpek8l/0vrgZT+0Tt6oNuqAx1VxrcdE34z2TrhvrufRdUHQ
         NAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4A10ShFx8OYy7UoPsGItwbG+ErsvMMLmVUzSrm1bv6g=;
        fh=zEQd+5l/OBjEyzF6GIR9zxz6BTrbCyvCTKJbHzWgHEc=;
        b=gPzdVW4i/XyDAVXJKYIlFzmy2BYHLjRU66ekMtlOt9RxNqEnioCDlrPsQccoAZyCNh
         O83581rJqoxXFdDoBr47Iv9REBYu7E6pWXVNZho2cl7sdLniDESN2DJ8t2+lh6mx9vYH
         qyhwjQTQs8PtILmJYQbH2GfFV7ZGb+dbeDXdpG7GvwSB6cEqIUZ1ORuBAqN4jvlr2XA0
         tAS5/vfNzPOoR5BPofACqBUOWCwykd6FmON8FG0vj2Crs9B/no+0//RjbPz32j6aKUpQ
         Wr0Tt+Ow9bFnJGmQvJed3vV3XZB9xtFe+CNSLMhQG5Rrm2bEDg71BM1NTLkmXsJNL6Aw
         VbqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795726637; x=1796331437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4A10ShFx8OYy7UoPsGItwbG+ErsvMMLmVUzSrm1bv6g=;
        b=VsyFgMx4TEOyPHwKUbrOnSuDa+zXXwYHWh43LlgaCVmUXs3aM4ffouaAg+UfB+5Q33
         aMs+eXnnlzMF2hEjvsy8Rb+oxfS4RTFLONZcCq/bObgD+kKTeEQr8SD87bdnZQvykUIx
         GIL0t2gsBhqEBLnmknn1LLs4XgpO9N2xzkKh0Xm+0mWBR5HtDvLwWSYyVRHXLqel+Awx
         TGMuOf7yUDViFLqGoeW7ZxYJr6LtotdVhy2wyriDcqwl74zHpGE0LVbqgTPhOnH6SIq+
         t/2fKok5fdE4JMB+GNFpWkarbHBd/cr80RTYzjNSt+a8waBAcXaUR3fiLRDtyhYlK5Me
         IyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795726637; x=1796331437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4A10ShFx8OYy7UoPsGItwbG+ErsvMMLmVUzSrm1bv6g=;
        b=CCQ+1/t0kJK1rlD1F4u6soPt64KkOZtKp3JndfKvKJ7o9tGTjA85hJdhcyBUm12PBb
         wCqwlzThe+uMeH9EFlUbDldzxF9TRUWB+7ezGeWUx245YTBufcOL5gZGI5rBI71qxMpR
         Cha2KK56JcCyBzNSx68FMmMhwR8d0pryMglqJ1tbDvQdxSUAc8uS4r4X1mRECIEsl17d
         IoZivDwbuC/7ihbl5H5KDLeb+Bn1rTIspE0zdgk+KcXH1O/Ij7FNjM9v/liRzkGN9Pwu
         0YwuAktHybe13+kCBgb1Fi9eX5qzP/BuJwQ8od83U8dRD0uX7XiCeqFLXMJ9jDQrHixs
         oomA==
X-Gm-Message-State: APuU4Z8pEGNpRqxmAGFDcQ3Ngo/LNclj3o48rU8evU6kk1PdprKFyU/i
	r7L+Rx+iH+6dz+Cewx3rp6+5DTFqgHcu9O+0QzrgFzTnlJvqV83KZNYeSFrMuwB/Ii0vIVLo392
	aW9IpGG9dxmkYa/hvAUIMU7cDi4zchnI=
X-Gm-Gg: AZFdTZfTXb7wJZPSYuYl/FsmvMZveXpP3XpMK2evaZlh3Seb0ShQNibfNE4ZHvvRIAO
	fZ/hA0+5qVirysOfUkrKHTk6p2od+SoCFABxCWI/pJ41IkfHJUm92LQIrcqBt2xrr7vQ2LX5cbQ
	4byKJ5SqwOYkVsiK+XOt+g9aQx2XVZZHfA11A4TDAGtv2JAqtdc70BwhlwG+mCWc6QmDQBdS8Nt
	eDA+uc68VVO+tDT+Qf8ElW10DGrFjy8r3eJgMNejLueXYeX+QRTnJnmL9n//IU7j/NURQAo+FVv
	AI98cMRIQtWDTXP6MkEx/3vuxNcPdGYX0MZHHIo3bkddTHgs/FBDUM/CuCHtlpSoWERz6Z9zZ1I
	aGin3CE//IaR7UzgMGogNBWfZ80dJvUiYItN6660cAmZo3uBDAs1UzDB+Dbp8nuLQ/jI3UODhEb
	JaFFOoFjBI4DAssuVrjL7bc1PECAk4i2UlMWVg4QItK6eHhyuiMa/3kkSomvtktHcaoq1EbIWoW
	tD1gBHGowY+feSB2kI+qCJwdgjJSaCZC75TMEmv
X-Received: by 2002:a05:690c:e255:10b0:8b5:6584:ae8e with SMTP id
 00721157ae682-8b56584b1a7mr24300397b3.6.1795726637255; Thu, 26 Nov 2026
 12:57:17 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
 <20261125220214.35881-1-okhuomonajayi54@gmail.com> <20261125220214.35881-4-okhuomonajayi54@gmail.com>
 <xmqq4id4s1od.fsf@gitster.g>
In-Reply-To: <xmqq4id4s1od.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 26 Nov 2026 21:57:06 +0100
X-Gm-Features: Aa3M54r9P3LV8JpYn5CM5Y1bmuooP-2w-ctRhtHtu8nkKyVWA8-0yf_r0hPvbfg
Message-ID: <CAFpMFfCb-S_RdOo-bzKY2i8T-tZWfVGy4FzQeX=3S6E1Ks6s4Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] notes: use the tree's repository when reading notes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> "A, B, and C do not check for NULL, and D, E, and F do." [...] step
> back a bit and give a wider picture [...]

Thanks, that's much clearer. I'll rewrite it along those lines for the
next round: the wider picture first, then the entry points versus the
leaf helpers, with copy_note() as the exception.

Thanks for writing it out.



On Thu, Nov 26, 2026 at 4:37=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > note_tree_find(), add_non_note(), load_subtree(), remove_note()
> > and format_note() already have the notes tree, but still read
> > objects and hash algorithms from the_repository.
> >
> > Read them from t->repo, the repository stored on the tree.
> >
> > note_tree_find(), add_non_note() and load_subtree() do not check
> > for a NULL tree themselves. add_note(), remove_note() and
> > get_note() replace a NULL tree with the default notes tree and
> > assert that it is initialized before those helpers run.
> > format_note() does the same NULL swap, and initializes the tree
> > if it is not already. load_subtree() is also reached when a
> > lookup unpacks a subtree, which is still after that check.
> > copy_note() is the one public function that does not do this;
> > the next patch adds the guard.
>
> "A, B, and C do not check for NULL, and D, E, and F do." may not be
> stating any lies, but such a description gives a very disorganized
> feeling, as readers are not directly told where you are going with
> it.  Make it clear where the entry points are, who calls leaf
> helpers that do not use notes_tree_or_default(), and state that
> these callers themselves use notes_tree_or_default() to cope with a
> NULL tree.  Before going there, step back a bit and give a wider
> picture, i.e., have you done enough to make sure readers understand
> why notes_tree_or_default() matters in the first place?
>
>     In the previous step, we added a '.repo' member to a notes tree
>     object so that you can tell which repository object you are
>     working with.  The notes tree objects are passed around in
>     various call chains, but many functions like note_tree_find() do
>     not pay attention to '.repo' and instead use hardcoded
>     the_repository.
>
>     There is a catch in the existing API contract around notes tree
>     objects.  Passing NULL in place of a notes tree object is
>     allowed, and tells the API to "use the default notes tree
>     object".  Which means a few things.
>
>     - An existing call chain may pass notes tree 't' around, but it
>       may be NULL.  You cannot blindly dereference 't->repo'.
>
>     - High-level API entry points like add_note() may receive NULL
>       in their 't' parameter, but they replace NULL with a pointer
>       to the default notes tree object by calling
>       notes_tree_or_default() upon entry, so after that, the use of
>       't->repo' is (almost) always safe.
>
>     - Helper functions that are only called from these API entry
>       point functions may not check the NULL-ness of 't', but rely
>       entirely on their callers to have turned NULL into the default
>       notes tree object.
>
>     Now, X, Y, and Z, as we saw in patch [1/6], are the high-level
>     entry points that guarantee their notes tree pointer always
>     points at a valid notes tree.  A, B, and C are helper functions
>     that can be reached only from X, Y, and Z.  We can replace all
>     uses of the_repository in these functions with '.repo' safely.
>
>     There are some cases where such a replacement is not sufficient.
>     For example, copy_note(), even though it takes a notes tree
>     object, does not use 't' itself, so it does not bother calling
>     notes_tree_or_default() to ensure that 't' is a valid notes tree
>     object.  In order to replace its reference to the_repository
>     with '.repo', we would need to do such and such things, which
>     will be done in later steps.
>
> or something like that, perhaps.
