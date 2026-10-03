Received: from mail-pz2-f36.google.com (mail-pz2-f36.google.com [74.125.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB033998
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791035131; cv=pass; b=Z/0P3NCiPWt7zVdSf2ev/APLLg8KfXjQACF2wvUnu7SHHenVK0b5Zwk44fiFdu8V3zAbQRpzexxcSta/TPhX1W2T3a9DmOmMnffzOetShCveUtaOHYMjWsjKVsLjeMxyRqyhxkoLxsvbJQnVUTnIoCtd/ZLVQCaRvzfFF99cx9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791035131; c=relaxed/simple;
	bh=ZoZQeoZVDEqT3DJtc5p9/b387qIXusvV5rfQD7t/bXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/EG4CA5BEmoL2ynXBb3H4Ll1wC9ytBWRqEIIrMnyPK7w2EMqw5JqlWiG5naAK8IXTKhx2ceNhjzIR3b7SKE9fefFLa/myvao69L4Yq4EwX/2laiYvR1p/evp0HmEInmG42zlYV7tvcJ8j7BY6nor79u3TlKNMT/ZQ2QADpe0bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwyMy6La; arc=pass smtp.client-ip=74.125.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwyMy6La"
Received: by mail-pz2-f36.google.com with SMTP id d2e1a72fcca58-88a9f57bd42so113586b3a.1
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 06:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791035130; cv=none;
        d=google.com; s=arc-20260327;
        b=leTrXsu/yJHjIVo7yXMeS3acDQ61UxVDvw6K2bjZA1z67R5U43Htt/hvxJRY9por2O
         QekYPZEUTpLGb22o69qyEgXsbjQhTmdM3LTiGOBSXk70MLiEeQfaAsvmSj6B5oIhdOpt
         N8hT/k+KflPpWsQBOvMaoK6QdWy4KKElM7H7VsGUTUDo6qO56MyD4r953JxKBias/rxQ
         gwzgruntD022DXjEI//YESR43DLYmgCS8W6J4L4g6XeLsxEAGo+UnALPnp1d81FUtx0w
         ZNNLVnfXrEM05M8Arw/9Wi4ft4MIM4GfbEUma0ObkuZaQ5G/WKJ7mSC0GMVU2veriF/I
         IDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pWJy8sDp4gZ2y541jijo9eoOQyNZKlt+8Vn4NB0/Ss=;
        fh=P8ovN1b06OxxEc3fDOCFiy1b5qnKmrjdZyZ14XGhz4s=;
        b=U4IIds80IAmKtK/lunrZ4g+hfWvIy2xxMOezDSvGAMuHQjkjZ7iSC26MSG8wUMgFCB
         3FJTNfbyp+4DPDQEcYhTTrTg+wrjsldLc9uXNLdFCKOdWjkxSFH0sPebRlnd0P+Fvk5u
         6zLkEWuM/A7Au/UPjRR+kzI58ihMLiwvpNn0cAVlE6L4k73Xobj3ym2RppDZmREJ1Hf5
         gfKfrBrNLLe1FSBlRNJC8/q27O6luNeopxvgHJdQBNaaNglQfJb1VLWy1WbTbocf/t5P
         RQavE+dZyOZLZDWW5JLW5BZpXVmcYxdA6npMqzQstquQDrwcscplkkrwd3oOIdwoKjIr
         dGkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791035130; x=1791639930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pWJy8sDp4gZ2y541jijo9eoOQyNZKlt+8Vn4NB0/Ss=;
        b=fwyMy6Lav0gmWrB6NA/IsGfP2a9FMtj2tdJJqYuWr35mnvivSdxMjJNtOI5Y2/fKCz
         NSTuUB/sFYUJei7R7jrtz3VKMaFjzCXXRU9URKfjH0VrZ5/Nu2zS7f9s9coZg5aHx+5X
         3JkS0Yoero71yHuNaMhHqW6EdFVONaPQwI8wS+hrrM6CzrNzQviSZryWYIZ9Mk2SDAtc
         iVJI4L9iQAi5lnPzqHpvjxnClaj8Tep8h+f1x8GonKAcIkgIRZq5fc3dg2uaBm9Fun+G
         0iimgSN1Szt7BiiSWpEIrHiQ3FbYvH/O7hOmFBfu2AFb9AoJ8hRARZQUy+jajDyJfKh6
         prJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791035130; x=1791639930;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pWJy8sDp4gZ2y541jijo9eoOQyNZKlt+8Vn4NB0/Ss=;
        b=GlgEtqRjHXkIfWRuv2luekMYKVYdAsPRY7ff0UX/mL6660tbYb4mGnJIB4MnmWquKI
         xrSXoEHwKujAOmymN+6CJOyQ1mEB95FrvGHha/UiOPlqcTLQgWasPBcMS/dGNHGWnkOH
         VqtQX31nktNFnGbbcPhTt7ehmENJeoloyjS89D6GWIB7q8VNsfA4zgy8S2zFba/niNsU
         3hH/uPFXKviuS3temsf6DiKaExfRGfO9tCLCJbBjuCdF/JHnlYt+CZuexbZDjaUCwyHm
         eh0o0zU/c3s6XQvHAtTuD6LB+vcVF11lwqUoku6l/6okQjkokb7fkp7swipoWbWUoudz
         gBgw==
X-Gm-Message-State: AFuF++lzPnITJ8xf53KLffYlODyCKcbK0Ks716D9/2A/mm8tFK+c7XAY
	4FI2hdmle3CMWbURAObb70MDy5VUZJe93ualExlZSMZWgtFmStL60s1MFxVTNb76+1/zhiv+ZuC
	pbFD8ZAiP3nJInqEi6yU7Z7cLTZmFGCg=
X-Gm-Gg: AYBFou3G2dj0c+YmrfX2Bmsy25cx7UvDe+cBT48tDT/puEEUWapqgey88SRktdPX3Ra
	f2Bun/EMmQi+0r1nSoMD6nnhmSmx0TepXFsnykGFg51aC831pnIU4ZLwXqw9Ier2LotauReY5bH
	bBRgR5K1cKlzFYtrvKCw+l9wOwPVi/Ot/JTd2OXiYrrwRQCEOhr05VlcHFDYTe/GMJjNlCWbPbS
	0rFFWSdzJ1LX0+0TqFcrp6zfVhR+37j7B5J/ezJy3zQrSaXkQEW80Ht+2F6JO6Z+gCYGi+n6Wrk
	vDx8HNl90zt/suzF4I7gCTpxGGhOTGXkIOLVUf9NT4vP6DB1ypss88QivSJHGDkgWv08ykmKN4W
	DerPHjbuAku+HaPdNZYZtzzx2xH+fxkah+LK++PFerTKBgAmlsS71qXrGDtlW8P6TpvhsKXig+i
	cINLZ+V2EU498+OTNfw/+IXi2+w+C8NQ==
X-Received: by 2002:a05:6a00:138f:b0:878:3538:8f7d with SMTP id
 d2e1a72fcca58-88af6373f02mr5173231b3a.43.1791035129714; Sat, 03 Oct 2026
 06:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <asDTWsH-RuIJOyne@debian>
In-Reply-To: <asDTWsH-RuIJOyne@debian>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 3 Oct 2026 09:45:17 -0400
X-Gm-Features: AclHuK_Jnd8zG93tbRLK7C9E7qI8k-ugMwewXm_YZi6C8JAyI1ZN3lVLipDiL9A
Message-ID: <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>
Subject: Re: git-visualize(1) plumbing equivalent
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:13=E2=80=AFAM Alejandro Colomar <alx@kernel.org> w=
rote:
>
> Hi!
>
> I have this code, which I use to loop in a script using git-bisect(1):
>
>         while
>                 git bisect visualize --oneline \
>                 | wc -l \
>                 | xargs -I{} test {} -gt 1;
>         do
>                 if
>                         git rebase $gropts BISECT_HEAD >/dev/null 2>/dev/=
null;
>                         test $? -eq 0;

Aside: this "test $? -eq 0" is a bit redundant, no? "if cmd" in shell
works by checking whether "cmd" exits 0 or not.

>                 then
>                         echo 'Rebase: success';
>                         git bisect good BISECT_HEAD;
>                 else
>                         echo 'Rebase: conflict';
>                         git rebase --abort >/dev/null;
>                         git bisect bad BISECT_HEAD;
>                 fi;
>         done;
>
> (
> I know this resembles "git rebase run", but I'm avoiding it, because
> passing all of that as a command is non-trivial (and I'd like to avoid
> having to write a separate script to pass its name to "git bisect run").
> )
>
> Having read the documentation for git-bisect(1), visualize reads several
> environment variables, and thus this code doesn't seem robust.  What
> would be the plumbing version of the while-loop condition?
>
>                 git bisect visualize --oneline \
>                 | wc -l \
>                 | xargs -I{} test {} -gt 1;
>
> The goal is to know whether git-bisect(1) has found a commit yet or not,
> to stop looping.

I think you are probably looking for the (size of the) set of commits
between bisect/bad and all the bisect/good-* refs. So you might need
to "git refs list" the good ones, and feed those as negated refs
alongside bisect/bad to rev-list?

In the general case, that wouldn't account for skipped commits as I
understand it, where multiple commits are left at the end of the
bisect, but in your script it doesn't look like you skip any.

--=20
D. Ben Knoble
