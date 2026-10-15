Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E4545297
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083534; cv=pass; b=EohBUQbYcYHf+gbt+GOQNe6RhHtAnunxqNzIyj5HLuBgSYsfBrRLv77Cy/RG8h3xQwoHw4Qf528VQVYLWCvyD3EXiJn0zysKtINVLXM8oZaAvTN7LUl5VxCgvGJ0hoGngvqAzL99Vp6l+EWDTOedPM3Wsgg03FRgNaX84EPlor4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083534; c=relaxed/simple;
	bh=BhI5PjxSrBwZO9rVMkHOHZ26PO8FebxSbirFVBSGqyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwBc4x44e2YCucg/QWdiAsAc1tLXuaAL8l3dVhGNdLhmEvdJHM+zL2wSfOjP+XEI5H2olFbj3HYvSUaOJNC7t8Fs7/ecU7lGj6ikYE+wkbooP4fv9IVctNklsfyW+o0NKnAjVKXq27vV24Vxf/WM0aOn0SL1BRNd1aFeu6yct6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5DcNq9K; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5DcNq9K"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-89f1318195fso198367b3a.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 09:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792083519; cv=none;
        d=google.com; s=arc-20260327;
        b=naa+CeOn16WusecNp1AroJECbkzh2hHrgZ6514z3uTNda4KbhcG8ck7lEe1KC9eigt
         2u3Gc1KB8iOX3WP+2H3cRkgSwYx1UtRu4Z2W2ww8+y20QZddkK8lndjtCBybggVqsbSC
         yjb1ETbxtza79Pd8fmeQynhCJ9+vUhL5YJGLIE8ezZL3Cv6pk+W2n33DQTQo3rcy9ljg
         v18EDk8tRTSfbyJ4Ez/nImeDLbIXgFvXAInzAN/626de07PgAskdl3gZ+5CBsNtnpmxB
         vFvGIrnhEfI0FA3ZQxO5FW57KTWm72+mrfozjotKFQ+LR/PprfZdGp2orv0JQ7ZvmG2F
         HvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BhI5PjxSrBwZO9rVMkHOHZ26PO8FebxSbirFVBSGqyU=;
        fh=ymJUag3ISH8fZwtPBhPGB9YKYgbQk8BAV1Ye61WeRQo=;
        b=F7Gt9HavTNHeiZgZ8UaN097GwD8epvgnPLdnG9V+aUolZll4gyQez4PX5XgH5qBAF4
         YPklMbDweMc8N4FMzJxXzTI2EwnW9EAjYOfT4LRBa2rX0zknqDePjNwSUP7SbpuitDJb
         E+O89cJWChXVORVVdDZOqt4U40wDuHy1OkRRCsP4lv2U8EJZWiKSunsr0UDuCxv/rHuV
         MFrv1ZDnjh/ysM+705qAwnjogRDHHh9rGEs8diSxe8raFVq0nLVlvr6wxrsan5y9TgAA
         G13vsZkwqKuFKXzHOrW3rvGwXf27DtNzqQUZ8Ym2VrWHTE+wykN3iu0s7WWzGyEOlMVb
         b+GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792083519; x=1792688319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BhI5PjxSrBwZO9rVMkHOHZ26PO8FebxSbirFVBSGqyU=;
        b=R5DcNq9KZX205srXy78IYInbnL5UAwN9yGIW/xx5dOMijymQVoXp6UiRYpts4INhvE
         b2xwI3CeJWxAkOh1zJelfrI2cae10sA9G6Q47I+kTMc9LtZQnH5sdrWs1iuQqxBAQhoE
         vsTukKmzH0eVWhjm2tFKyKXDFbwVyBo5auBpDsOCRIKjZas9GKxb7k3LsGyckjsLPa9o
         dapv2KKCYFBInJblVzPqfoUZbvRAZFCYDQS1JYrBh5vVxvvqrIK7hT1u0TO+j+BKB8Pc
         v6AkqUxJxLUqDlvG8n8Gnn2a36vxlucY2g0YYkGnyiqhlfk12VcQkt/0OH9k5Wz39PTA
         rXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083519; x=1792688319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BhI5PjxSrBwZO9rVMkHOHZ26PO8FebxSbirFVBSGqyU=;
        b=CQJzI2S7fdgo9D62+zwNY9xZ5hSL2bwu9rRaTjdX14ABQcdiqowHBgWRhyQTHPkxtN
         qyM6uSF+ZwdKp6Lsadzj9iAwY7BTLG5+M2Cipqpr4XuMWcpji4Yn9dy+qZkNdI78/Rv3
         FWWNPx4VcuKnfsWSjGYfRwZqYyyzFgGvQfwAh8uo0vt8xgQqtCVh8HYiQPU6wddPWKVi
         e/a2ftQiHz9t3e/ngXk5vsOcTo59CS39A5r+pNNF4LdypT8dUEETOvgQXkHpjixwr28/
         KAy6FpHYF+2Dr/c3oKfs57Mcyxed1wk3EZ4Xocf1EqWKUaOf7mCsdx8cHMoQ3+A2+/58
         jq/g==
X-Gm-Message-State: AFq9FYIqsFanTbHZyep0L9/nwhRYVpCAU2h6RYSlbRr9SokFAXC0SZSF
	irAcZZZp+kYgBErrsprrKn7pHGwF5dQVuqwehIhOF3eonF2u4w6mutkAszMsXvKlPQ+jeY67a27
	m8D06+WzvR1IAPd2GNJrl/6XckhI3QSDVBN9P
X-Gm-Gg: AYBFou1gutgrv1dKB+tB+LUou7k+qRQ+qq22tHjYZBGZk49KZh+KsoMk4RFaSjvbims
	zTuii0imSsuPFlIkn5Kb7yLVblMdZCQWzSl4o5HSXn//HbvwaGu8j3CPv/c0RhDU/ZO8SeJBnDp
	5Ml92ihL5AKZbV26JpXkYDyD7gbx23uHXJBUixdI7RUQyxgii98+GfJUbZIIbEYQFfUh/iHjtqo
	wj+h+ZPazJqWg3YZXO6ahdOcKY6dujDcCSVAgopp3R7uQM4ddaHakfxOJkHHMXOLSAa9H4mij/Q
	hZLYSyUkqYayzir613DKQuRU6IAqBbVL0g/q5JqVbYyq5mHbLVfaeEOWvl/M6ZDDeh/udkwwJrC
	Htn9S5f850m+qz9xo3fTIhFTU0c92osnLOPry2yVU+6PBVPDioKwxr4zKktdHCyi1loxzes3JdZ
	tQQL80HBHqKe9j+UVtMgXAM3hJB0gRwQ==
X-Received: by 2002:a05:6a00:c0d4:10b0:898:22b4:c8c8 with SMTP id
 d2e1a72fcca58-89822b4d12dmr10889436b3a.2.1792083519101; Thu, 15 Oct 2026
 09:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI0PR05MB12991467F7BD29308AE8D5F4ED09C2@VI0PR05MB12991.eurprd05.prod.outlook.com>
In-Reply-To: <VI0PR05MB12991467F7BD29308AE8D5F4ED09C2@VI0PR05MB12991.eurprd05.prod.outlook.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 15 Oct 2026 12:58:27 -0400
X-Gm-Features: AclHuK-vQaEE4frQX3htXqIieiWqOY7wCl2u0-_COzOj07WfPo7gK39yUiKmDik
Message-ID: <CALnO6CAoVsrp7UFSZLjTtYm3x6rzML72-3hUE9dtGorVb4JLyQ@mail.gmail.com>
Subject: Re: git help user-manual looks for incorrect filename
To: John Wilson <jwilso3@ed.ac.uk>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John

On Thu, Oct 15, 2026 at 3:50=E2=80=AFAM John Wilson <jwilso3@ed.ac.uk> wrot=
e:
>
> Hi,
>
> I would like to raise this issue, as suggested when I erroneously posted =
on the git-for-windows repo (https://github.com/git-for-windows/git/issues/=
6466)
>
> ## Issue
>
> On Git for Windows git help user-manual looks for the wrong file.
> Git looks for gituser-manual.html, instead of user-manual.html.
>
> The Git User's Manual is installed as:
> `C:\Program Files\Git\mingw64\share\doc\git-doc\user-manual.html`
>
> However, git help user-manual fails with:
> `fatal: 'C:/Program Files/Git/mingw64/share/doc/git-doc/gituser-manual.ht=
ml': documentation file not found.`

I don't think "git help" actually knows about the user-manual,
surprisingly. It's not in the list of "git help --guides".

You can do something like "xdg-open $(git
--html-path)/user-manual.html" (macOS: open; Windows: ???), but that's
not very easy to discover.

You can of course also access versions of that manual on
https://git-scm.com/ and http://git.github.io/htmldocs/.

Still, I've been wondering for a while about extending "git help" to
access more of the documents installed in --html-path=E2=80=A6

[later]

Ok, in this specific case, "git help --guides" lists whatever it can
find from the compile-time built command-list.h with CAT_guide (so we
could make that generator create an entry for the user manual?). But
when it comes to actually opening a document, we process the command
line through cmd_to_page() which adds the "git" prefix as a fallback
path. So any document in "git --html-path" that doesn't start with
"git" has to be opened in the rather obtuse workaround way I mentioned
earlier.

Hm.

--=20
D. Ben Knoble
