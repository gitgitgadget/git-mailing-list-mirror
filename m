Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD70199934
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887661; cv=none; b=uk2fWAAX25gCY0GsYAhwwVMwJqv1cghpl2fIEIw2mQCDjOroQsDOZ9LFHhQqbyaNcqtE1A0jXqajWBNFXEDC3R/TRGJlPyX5/zPVBM0RJg9MPL6iOeK6xuvQrTNFXuKnmVkS8PHp4XmayaNOnJ9Lzu9tdEIp8+DduCuok7tSkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887661; c=relaxed/simple;
	bh=eMJZU8M6G/IUMHupR9xur+1BHlh3GTWvFnZk41p+nYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti+1wcziRlb5XVSPFib4XG0N1mj2BH40UzL+l6dhNAhTZgdwvT3naanjqaLzWr1cDKJhXPS30Zvq4kosTeihZi1UHtLBhmaaxeEWliU2wuBHC3zdz8y8bU9qbuGRCbM5BxW4EE1CSs0B6z4BSgdxQsefvLo2EriikkGHTS8r1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3EeLF94; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3EeLF94"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so2281253a12.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741887657; x=1742492457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEoHMSBIUerbCnOgE/4OLrzdpNaXsPOXoJJT5p6o15E=;
        b=G3EeLF94nX2SMeVj2VwRmZD9GU8y/4VjoNQbYjuwe+e4bBYYxxKMyYXVnMdcalCMyT
         JNGkR1zhLJ/66LBPI8nt2FDoddGE99AqhpwqbJZlmPyAuHtsvaUoO2rYVXgtVQh0rABX
         mwAFT5aKMzpfpK4uLU+kVeuW/0WUHkZ+qDOrAwgG+YbU5xMO/4Orxqu8XmWOmdahIXVn
         jYIzB6Z8evEL36Apsu4ac3grp9New4IJ1YKGwWNOZREY6LMca08EX6qhkJEJTEGOzWwR
         SjxVR7GSXRTeZyqMHXHYsn8HuFlqpVNxUZ/4nesnsLFRd9L0v9JB+4G6I1Y9zePOd9ix
         62aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887657; x=1742492457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEoHMSBIUerbCnOgE/4OLrzdpNaXsPOXoJJT5p6o15E=;
        b=r6qau69id8XK4ZesGrKr+bJ26WBTAkuMDxtu4PVfcr3z4ePaWTpXBg4/U+ItbaIU6I
         6KCAlU7TwI5ALTD9lyAe3KobhH3rQSduxK7rQTziKw536oB9PzahNZzL5DYIe9yyQqBw
         fGI90CraWpP/tePYhLOdPf8JBQg4LTxoLg1hkSO6lwEgFpLgViCdLszSU9/62y30SUeG
         j4hsWnszj2BCKZY1cQeZonh8n5b/08zQ7AJTnz8Qs4x0etAQV8Xp9DLwNRCmHm1MwIFl
         PuKuL3yZlCtvsq9yz0kEUAfVvezBdg+znehRKmrynDxtuwb7tEea5NTD3m57tB0x3/S1
         dzfw==
X-Forwarded-Encrypted: i=1; AJvYcCXd077TM/PhyaOf9i7GMZGJR//71NwPqlb9LeLfkmLeTLxi8RUimiTUaZcEE++/fNuCyME=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNWm8M9htGo+mhBf2+vCoEjONvnTv2FjpiMvrUs91aCfLxzhy
	JTVTifmhOG22SWPjHce40zt0albpthjCHEsQglAC5i108o1Jel2RiaqQZVkHRJ3GlNNqrXwHPnv
	xvnU5EUFkIQKb9UDs5FqpKkFXOCY=
X-Gm-Gg: ASbGncurhtdsqaukpakrYJPtHlLynO18zsHRmU9/qT4GCkaB6LQk2hzO8+a5ndFe8R7
	uqnP3JLKya404CyfVoqW4OsdX/5CZt2klUMgTF2AEDFahxPRaqQUbBXi1kV73NEdSUsjsBizALz
	CUdVHVbtzwIFlXJb5kxJ00/NcdkmD0SqtvlUD8A+kl9OwwhtimyabVy2w7ekIf
X-Google-Smtp-Source: AGHT+IGhpZ7ts6CH7HmjlHY1A5benpX9ZNPaQa59S1xOp1Q4dK+NQOirwLmjfc6G/rbgqzqmehOX0goTV0Z3rGqxpRQ=
X-Received: by 2002:a05:6402:42ca:b0:5e4:d2c2:b8e8 with SMTP id
 4fb4d7f45d1cf-5e814ee4a12mr3895436a12.16.1741887657360; Thu, 13 Mar 2025
 10:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com> <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
 <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com> <42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>
 <CALnO6CBDjQgc2TNaXbBWiUNqWV=RgrL2Ry-7HzRu3Ozuqazzvw@mail.gmail.com> <e06caa06-0176-4340-958e-4c43650b40e3@mandelberg.org>
In-Reply-To: <e06caa06-0176-4340-958e-4c43650b40e3@mandelberg.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 13 Mar 2025 13:40:45 -0400
X-Gm-Features: AQ5f1JomBY9WfvFKGLAXCG2kkjCAlHGluCUIpsDBHgbQOsBfLYmhVkvX-R5owlQ
Message-ID: <CALnO6CBurvi=gXzSdYDqSWDj9+R_uXY0rMZvz+dVKa+Bcfe=6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: David Mandelberg <david@mandelberg.org>
Cc: phillip.wood@dunelm.org.uk, 
	David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jacob Keller <jacob.keller@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:46=E2=80=AFPM David Mandelberg <david@mandelberg.o=
rg> wrote:
>
> Op 2025-03-06 om 15:24 schreef D. Ben Knoble:
> > I'm willing to manually test the patch if I can understand how to
> > reproduce the issue=E2=80=94it sounds like having a remote name with a =
slash
> > is sufficient?
>
> Yup. I was able to reproduce it with these commands:
>
> /tmp/tmp.zOjfmdMx1i$ git init foo
> Initialized empty Git repository in /tmp/tmp.zOjfmdMx1i/foo/.git/
> /tmp/tmp.zOjfmdMx1i$ cd foo
> /tmp/tmp.zOjfmdMx1i/foo$ git remote add with/slash /path/does/not/matter
> /tmp/tmp.zOjfmdMx1i/foo$ git commit -m 'test' --allow-empty
> [main (root-commit) 4b95a99] test
> /tmp/tmp.zOjfmdMx1i/foo$ git update-ref refs/remotes/with/slash/main 4b95=
a99
>
> Then type:
>
> git push with/slash :ma<Tab>

Thanks; in Zsh the results after :<Tab> are HEAD and main. After
:ma<Tab>, just main. The results with _no_ colon are HEAD, main,
with/slash/main. I think that's all the expected results?

My test procedure was to

git fetch <your PR tip>
mv /usr/local/share/zsh/site-functions/git-completion.bash{,.bak}
git show FETCH_HEAD:contrib/completion/git-completion.bash  >
/usr/local/share/zsh/site-functions/git-completion.bash
# adjust startup files to use `compinit -D` to avoid caches
<your test procedure>

--=20
D. Ben Knoble
