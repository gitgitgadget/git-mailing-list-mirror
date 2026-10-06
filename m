Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE2370ADF
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287280; cv=pass; b=o0MNHLndJpFlWtN3foUNpT6R27XoP7IXvWUStQb1VHjoFvKfOsqbaSbB70GTEmhGIiIse8BMCzlfGnDdqh0wBLlcaV4Z4MDf95vr3AntFy93F9eC94KnoRzuM/4uwTiABkvEtqEFeEfer12BBpvrkc18+CJ933PsQ8wkP6N3f4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287280; c=relaxed/simple;
	bh=iIO324KDH/dHEIl4pXsOOfa+VCyE1zviFivT28SZZ4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyRYgVvMJhg140fHiNun3eGcwVXn3rDLbpjZ2kRoV/tiTC5k2OQE+QZdpNV7fRo2Axn1sgvIeISZLNq94ZAYMBhhjsXOcN5ZrbGz28mqew8dKX/+pLOnQ2hY0IjDfW+pY+y+rl7trcGDolQCaD2OOIxGCM7jUJzeYDYctE9U7/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvbDjqFg; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvbDjqFg"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1438d9363fbso766995c88.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 04:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791287278; cv=none;
        d=google.com; s=arc-20260327;
        b=k+j5SCKT30g4AOOSBa5xt+bLXx9eHnJDRclidDJX38zROuSo6kLdjLWsBAbAFwUnKO
         p7IpuTuj8f1BSH6yyS+oHA8sZQQrNg5kYcfNqeF3TCso9c5e29zu4DWKkxd8yJv6U4UU
         8p9YMmRrdxSecQlWvFFFbpBrXKOC+j4AC+B2bkJzI8Qvnhk3rqepxtTyyCPiZzfVQLGF
         YwSAkySiGGJ8w5QjG5T/TwGvqPBDPlxNhfXfX/dvkAV96cKI7skL622NwG6GNoFApgWW
         l4peVsVoI80oLLlKnyrXJo8NCRJsO7NCh85VuZqdkxC/5dZZEjel89iJQy1TiIHn+ap1
         1BGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iIO324KDH/dHEIl4pXsOOfa+VCyE1zviFivT28SZZ4Q=;
        fh=JXGMLNtPAui4mFNW3Wh1EqCGPedQ221v0W7YN7wEIgA=;
        b=F4SYYtDbqzhziH/qRHYA4N1SFzPktFUl6QiQXjmme++ABBkx8aiFx1uYeu/TztT0PS
         PJGWuIdopgK5N0TR5cs8Xu4bVnxXw0klbTbyAD4nPPPBFDIwUyqZm142BAhci1SMenbd
         buE59jGqrY/OIasYERnaebqISEZCQ3w8A946yAiiG76ZqwKEJT3Gwjye1AcSsoKbY9sB
         CKSJa2UyOE7jobEN4JJdqcqNny0NrMbM/s7zfy2HnvbcCAd47frSkumQ7QDWCNUrUP7i
         2jvSe6IfoSUKKkytslideGaykhQKoq7TJx8B9oTEHPqB8mzls9mi1Sr9M6kcfed3qhld
         nEbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791287278; x=1791892078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iIO324KDH/dHEIl4pXsOOfa+VCyE1zviFivT28SZZ4Q=;
        b=XvbDjqFg2zeQo1OnirEQm4c32LhCiMPAcZMOZgvcjq/J4YKaMapEdMlDStGG1iypMw
         tkGiEEgazcu+nEbIMobvtB2ME9ZaQtzU3Udnf6yCj4wGzGZ4DW2T7vBUNXYXBq2if2bt
         9/nIzQeqyLzXNAxDRIqFK8ADmlgER50ovxpnd4uSjZHZ9WbdrPJltQT+KkIz5FH4axWr
         wAuwK/XPub6VOd5gFcdk51XSzDtxvSCjykJHqT1uKalj+mfwzhs8GW3lWAheDUYRheut
         wTXhnbYAnH8TeZv35epxQIMJz5Rwu+NwRm/outry6v0kIzM7OWRfRHdTGOJAGEGdXOoO
         BJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287278; x=1791892078;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iIO324KDH/dHEIl4pXsOOfa+VCyE1zviFivT28SZZ4Q=;
        b=0Y+z6IOrtTdIZPlNWhLVxpDHdCzQ2XjFWtKGyn2RrCwzEol6Qfc3PYc/X17wp0stc1
         GCYcx+WljVJIm9DaLVeka6FjZHNUeEQCGW0TVeUUiL9G5V8hmW1p4ZHkiBWmftZqFMTE
         KiOL7s5FOYx8Wc6mS5XanKv3+fJKC/wjKE10E2aEPrkk+Zg2glj8iFk+KfyqGdj87hne
         ZXhUXkdURnzRpAatbNeiP/OYS1Wgf77x+np2k9DjBdk1HUOQ/ARroEZSUHcUN08N9JjT
         yIt3y+PbED7q19iQ12YkDZM+1GB7SaBeXYQ4VRiZN1YoInLve0dviPVfBHtyjNRmPZgk
         5X0Q==
X-Gm-Message-State: AFuF++lmgHPMl4GpoEKSOgHR3D0Lr3cs9CwpvB5bj1iHc/95tFJQZ4af
	E1qpyPEJaa2E9DUJMMA57yne5mVLy0nv0F2gHiI4pIf7WsxNZ6PFLRvqcGN1ZYCHvwexlKJNQEi
	3sCrQtrYHfG5N4hLD0GGLxi7k5g8KJ6jN2QejjYeSqA==
X-Gm-Gg: AYBFou03YdR1lG1kmSlzUNO7nOmE/b6Roulx++bserawm8mq9ed/qi4q+0TT+7c30Yz
	ka8iAPwCYQqCkexUQyrnBOZiOxo2RI2W9i2tfcb0e1cx/CjBNNHv/yXsVs5NBFSE7pS5YQh/evs
	EwPjY9IovHjoGiQ8KGybUZVNRQ0EgP0PhhiIJMZ4ERkk/9Lku2w+WzPH9XibfgM6T/jnfjKuefi
	y5rpiBCzUNUG28+E2iiW3AlE5dpE93KDaXTCpOetMmnHKk/meFuVXI8qpR0LJ084/M8p2xwXDX4
	Y0D9UQuHkEnRnwcygEeFiEY+dmaRH/8FUaxwJlMWdyvxxYBH1VRNJSt6priNMw/uzR0Np6coGU0
	mMyHQLsnyZrm+3ztAoD+rDScmV+IcNORXfM8tMlqrpgiFsm2eTzZTMJAHCaXMU3ni74cWML+W6J
	iQ4iuOCVpw24ZIxn/7zC9WW/gfErglmEH/+7rpX0c=
X-Received: by 2002:a05:701b:2602:b0:144:eb3f:563a with SMTP id
 a92af1059eb24-15d2f291f14mr2915029c88.15.1791287277677; Tue, 06 Oct 2026
 04:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1aee1829-d7ad-47e2-b7d1-1a946bd59991@delpeuch.eu>
 <xmqq7bkel0i3.fsf@gitster.g> <33b3ab6d-b2cc-49c3-9a06-3c4070ede57e@delpeuch.eu>
 <97c58bb0-5030-4e66-b183-44db2ab216db@delpeuch.eu>
In-Reply-To: <97c58bb0-5030-4e66-b183-44db2ab216db@delpeuch.eu>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 Oct 2026 13:47:46 +0200
X-Gm-Features: AclHuK9Wh9NOfTh4iGES_pVWU7ZZlvPxeOXpd5U2zz2vVLAy4f6XgqSZRpX27h4
Message-ID: <CAP8UFD1yx_Z+TyxYP6GA3xKOq12Y5OWfEbiHOEhx9bVZwZ0egw@mail.gmail.com>
Subject: Re: Documenting the governance of the git project?
To: Antonin Delpeuch <antonin@delpeuch.eu>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonin,

On Tue, Oct 6, 2026 at 1:13=E2=80=AFPM Antonin Delpeuch <antonin@delpeuch.e=
u> wrote:
>
> Hi all,
>
> I am planning to go ahead with this project, unless anyone thinks it's a
> bad idea.
>
> My plan is to write an initial document based on the information I can
> find on my own, and then fill the gaps by asking questions about the
> points I couldn't figure out myself.
>
> It would be great if I don't have to bother Junio too much with those
> questions, so if you have a good grasp of the social structures in place
> in this project, I'd appreciate it a lot if you could let me know you're
> available to help.

If you write an initial document and send it to the list as a patch to
add that document to the Git code base, that would be a good start.

The people who will reply to your patch will be the people willing to
help. That's how it works here. Someone could tell you they are
willing to help but then for example get sick or have a vacation when
your first draft is ready, and cannot actually help. That's why it's
better if the process does not rely on people making such promises.

> My goal will be to write something that you are happy to include in the
> official documentation or website, but if that doesn't work out, I'll
> publish it externally (making its unofficial status clear, of course).

Sure, no worries. I think we are not perfect, but overall do a good
job at helping people who are willing to put some effort in useful
quality work. In this case, if it's not accepted in the code base, nor
on the git-scm.org website, maybe we will accept it on the Git
Developer Pages at https://git.github.io/ or as a "How the Git project
works" article in Git Rev News. Just trust the process and community
as a whole that you are going to describe in your document ;-)

Best,
Christian.
