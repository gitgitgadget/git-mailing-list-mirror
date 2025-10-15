Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6F2147F9
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536757; cv=pass; b=bi6Csj18MKWjKntLPsIoqfat0Lv46iNmot7jPtC+4tw3jgRz6iVE3VQIC6qZUKewmgn591icw1KHohcj98Gr7NulN85eUuyCZjoLbjqxo5ALIrqsgwgTPmCInqtS0y6v8AjPybZ5H4sFn+d16XpJKyBEXnI30LVThR8iYkLF2tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536757; c=relaxed/simple;
	bh=0U6pRe81WkhBW5QVIDZUhsm21eFiXhkySczHjcRbMH0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=t4p91JlP/VEPUJRE03ZTYyKP3zGZGcfM8OTOdX/jXKsV4f7hFmEL7T24ZIAwn+ZrW6iZQcFHMqoEKCdt3AKfNf6HhpLhlYoo1IgcAl3rAullQUgv49TOQkecPppqALJCnxkIvhJ8noVWfQWr9ZyqRE8uDksY8kYI/AxZS2QbWYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=m90ngLpN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="m90ngLpN"
ARC-Seal: i=1; a=rsa-sha256; t=1760536743; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Pcqq91pJroSVyhNW0S/59XY0CbnLfnvEMmn7rPDzkMvqvK9WqSXNZyPXStfbpNt8/cUigeFQgKUj6K9DsPWfOrgoPA/gFDVHyJnwhfP5SANewwAzyErdC0sT4XiVFEWe6osV8gQiqN9SP2eTVZqwl0zOSjORzkVyWqrTJJaToEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760536743; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vRrBwLwoEvtsvugL/aysyroHe1UC2mbmZC8/J7A1pmg=; 
	b=FlPzoCHwkL6pZcKiq5Cd/aVlZeFnxq9ixzoWqKPf9CS8azrZ610yVqX21296Va8HM0IsKeLPxdFxi4S4Kg+SJQCylscA6gChK+qzHPwziMzQy6YmvkDTZzTyt4C5cGq/h5XWcQ3TviZ7JIiL9Eswi5lmcXG3HkX8fiN1N7upWCc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760536743;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vRrBwLwoEvtsvugL/aysyroHe1UC2mbmZC8/J7A1pmg=;
	b=m90ngLpNBqjKFXWRt92AzlhNiVCqlPETM+lNYyogNVshbdkgQ0/vNKtMheQCpmT1
	6zHaoUZQgh0VRgs0vHKKge8ANOgiYzXxvKdUZuhwRrq4Y3HwOalSzRvj7kcvAtm0qQt
	Ft+twLb04jqDPsUYlfMSPjlhUyAWjWwjIIcNA6zQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1760536739965713.0565476904227; Wed, 15 Oct 2025 06:58:59 -0700 (PDT)
Date: Wed, 15 Oct 2025 21:58:59 +0800
From: Li Chen <me@linux.beauty>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>, "git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Message-ID: <199e82ac06b.22809060320824.5985600477588171363@linux.beauty>
In-Reply-To: <4eb06e60-e088-462b-9f1b-ca800af39b94@app.fastmail.com>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-18-me@linux.beauty> <4eb06e60-e088-462b-9f1b-ca800af39b94@app.fastmail.com>
Subject: Re: [PATCH v4 17/29] tests: t3440: create expect files at point of
 use
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Kristoffer,

Thanks for the review suggestions! I'll address them in the next version.

 ---- On Wed, 15 Oct 2025 04:41:33 +0800  Kristoffer Haugsbakk <kristofferh=
augsbakk@fastmail.com> wrote ---=20
 > Now you start to change the test suite/file that you created for this
 > series.  There shouldn=E2=80=99t be a need to do a test file-only patch/=
commit
 > for a fresh series.
 >=20
 > I saw in one of your patches that you removed `--keep-empty` from a test
 > because =E2=80=9Cthat is the default=E2=80=9D.  I also saw Phillip=E2=80=
=99s comment somewhere
 > that said the same thing.
 >=20
 > The goal with maturing series is not to add patches on top in each round
 > (if that=E2=80=99s what you are doing).  It is to recreate them as if th=
e series
 > was perfectly written to begin with; if one patch introduces
 > `--trailers` and a test file, then there should be no need with
 > follow-up patches that improve the test file style, refactors it, and
 > so on.

Thanks for the tip. I split the changes into separate commits to ease revie=
w,
 as Phillip suggested in https://lore.kernel.org/git/d4c9f082-52be-48d9-b81=
7-fcb8a72e1bd7@gmail.com/.

It seems I may have overdone it? If so, I'll try for a better balance in th=
e next version.

Li=E2=80=8B

