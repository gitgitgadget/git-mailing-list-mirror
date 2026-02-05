Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C013AA2F
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296078; cv=pass; b=Y13PHL8+xtIcww26wIVp297vwT4NeW6HmCe/cuyk/jCGFMivwrFmFRQni/11LEJjl/xZ8fXdyVcGlDUvL61DGns/DCK9Sq4+E5InRn+ZHn9Y8885Mi8djEglkvxX58rzt/b2R6/JU2wQKqIR+ce4yMOwojdx+hEXBD6pTKiiC7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296078; c=relaxed/simple;
	bh=u/N7xGODLjwoj7+sqimDbs0sqFzBAmzc1jAxW6Z5GV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HF3HEBRSPJZlJiPjjQhAXy8qce7VSCZw7DbKSskgL5vCJMIix0mPKW8xAyFlKIlOPk4nub9cnbFW59yOdcI4shmD48sl9Gc4XiOeW0vFJF5YuPY0NWqI7ZPlvZ3eSDq9SC6ikyy8Trcw3ajVFw8kv/5aRJ/tpIZKkh9bfeBsSao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8G/i/ux; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8G/i/ux"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794baacdefcso8741907b3.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 04:54:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770296077; cv=none;
        d=google.com; s=arc-20240605;
        b=WiK4nlTMn21w/TB2jAngbvl9FyVsp+DdI+g3cxtFKzIcvFEjaAlBu/zXZwsKw0pEsb
         6AQVX/F+vcCyNIXMVGVSVqDTZEkOLyFqB4RjPgPgXKz9IBIy+50K94rlo/7CwbP6DOAC
         fh/2M00beyGPDyzHSpViCdxTDkm4c/6lCVnnVCc9YBLE+UkeOr7n0mGXH5p/4pqJkbOm
         GC0y7dfyLVcmP0mjDzOVL4IopUQFtZaBCJISKWCdkqTvVyBm9rf9Mc0WqwkJg3W5cE5E
         CuFc2JWscb2iqLHotF62hCEQW7cc6VYU4CbpAwJpuqVlUB8icWqx7w6pbF0vBjJQYq73
         YGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/N7xGODLjwoj7+sqimDbs0sqFzBAmzc1jAxW6Z5GV8=;
        fh=u/AKkPSKr62WRLaaEwgBlrPD63ce8K0sdqW3APwTNmU=;
        b=RCR/shcaIWnVCa6SO4BhG6UwpC+SOsh14tdNLACIVnuZqOnrauWujEmiX22d2dhApI
         0PESj/kixgwgywpr+JI0jyEJsovskG5kI5ASsbEcRFekYSDrT5PDjtBy99hPIux8FzKa
         Q93gC3cQVKsT1b9KXjGk7Wi8w/WJX4cZ+sD8CfA+zSIxBwYkImdv5VNvgQZ9KA2d6lUW
         DDGSjfuUgjngbfVu1incKkfGkhPiWN4VgfYDb3M3xczQzSoryHBrbJqrBYPjAd8TWNoh
         YEmYN2HDMR7+9TzzDE1dVUi5D1LRviN9O2HINKzGtQR4jvKgVaU27A69vhcFCG0Rr6/X
         vu1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770296077; x=1770900877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/N7xGODLjwoj7+sqimDbs0sqFzBAmzc1jAxW6Z5GV8=;
        b=b8G/i/uxigKdNDVbJxxMP/EqJcIyGDD6BbLY1HoTpYFwEvrxSWyxeIuf+yCtn6hJ9i
         Y+uQAm+ehQmRPGBrePFHsOMbPhGmQf89Un1l0Xw77d7PVoheC9nrOiIV+NA1QA2Vvdjn
         lX+Jg7u2JTDukUWPxmPPvUIZKLaLnw7YN8IhwTyz74bEdcbT0az8YBd6XGWBNOBxU9ir
         ax8dOAfKlXfxt3tTtyE4QoDlSjQc7KPN3/K9PpCXtbjpgtIrYiz9AT9CDNXCOUQI/kRb
         cytzxuwOsagrfA4qwtikUHlCVcfvcqlrj/feuFG4T34HlbkAkrcXYe/GmYBt2TUbKeyO
         QgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296077; x=1770900877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u/N7xGODLjwoj7+sqimDbs0sqFzBAmzc1jAxW6Z5GV8=;
        b=I1Zn0QtM/WQqWaw/20XhGrPNl7Bym/RcracT5rhc39aBebVtIhPH5GAWd8r8lLnghz
         nmRotjvu/XSJ9hG2kRDT9WlUy0aKT6U701w/YdpDKBfY1yHtzg0OxAyPechYsmVvN9rl
         zzShAGAUsoC5f+kDlz7AtOBgmyGE9gw8+2gSuaH3wGlNFcGIL+X2Nzr2pnyodPJTZGdt
         ZQkdWM25kUmhcEVbGsDvz8zM+mbduh8SsDn4JYhbZG4OEdmtuhwyb+1oQTV1+cU3wWrJ
         hTPa1SEmElecJ0HdaTeIR8wsqpvfxHjsV+hOGY2R8P/D1gbOwrPZEvPOZNiS6uqs/36i
         UhAA==
X-Forwarded-Encrypted: i=1; AJvYcCWxg4u26tFVAAkJBmzqIjAvPR7Q6K18lymowkFqw1OKS+2mEDgOruImHINg44VansEFPCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ZsUXE7V0CK20lXQmUmMfHlHNcyBQWOgIi3ckZjFWNQeYH4cV
	aytP8MuI/NPerist/P76yyzv+iW5GMmi5gEXVGrZciD7NRxIKrL/w7GbdPYHI4uamr7qXBrpSaE
	dNbnnN1qJ5v52JW9IlSpjSbl4WOHpnh0=
X-Gm-Gg: AZuq6aIaxs/S4s88eUxu1sCdRUUHp+eH78/cnyWqkRwHJFq2zW1VfcUk3/LoGl3AdUr
	FuQ/vGZN+aBByeXkmVHgA9ab17yIZ/lfX7gJoW0wI9AcratXB58LzM9Kh2qRh18lxshgDv8LBJp
	VbUp5vHrEc1kzFbT+xNvSr7gBNSkKXgUQybVOvNeb9s3XjFxtLH0khWF5PdIjooUgUJw6ELb7tB
	L9JYWgQujHXjXx2RhVaLKX2QyjKors55+FtWDuH8TO3tQOAAWz3v1CI6mEZufT5pbFAOvTpwOd+
	pRLYmX+jypGujiEk1/QF2DVZiiIgtunQk/GjQrjmA0DPdU5TT08bhih9g5N02UsOoY+C1dk=
X-Received: by 2002:a05:690c:90:b0:794:d5b9:bb33 with SMTP id
 00721157ae682-794fe699563mr129852397b3.29.1770296077336; Thu, 05 Feb 2026
 04:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
 <0207CD38-C811-499D-AFA6-131B0CA825CD@gmail.com>
In-Reply-To: <0207CD38-C811-499D-AFA6-131B0CA825CD@gmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Thu, 5 Feb 2026 20:54:26 +0800
X-Gm-Features: AZwV_QjtbA9qShzHEC7_BZCKYpRjaxRdTSpKICzFbbmjcRm5SCPP5Eib2jOHD-k
Message-ID: <CANYiYbGVs=L-tiDJfrLhDb1O2n9Xv16qCoV_OJjTe_hbWAo1EA@mail.gmail.com>
Subject: Re: [RFC] Introducing AI Agents to Git Localization
To: Yi-Jyun Pan <pan93412@gmail.com>
Cc: Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Jordi Mas <jmas@softcatala.org>, 
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>, 
	Phillip Szelat <phillip.szelat@gmail.com>, =?UTF-8?Q?S=C3=A9bastien_Helleu?= <flashcode@flashtux.org>, 
	insolor <insolor@gmail.com>, Kateryna Golovanova <kate@kgthreads.com>, 
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>, 
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>, 
	Ray Chen <oldsharp@gmail.com>, =?UTF-8?B?5L6d5LqR?= <lilydjwg@gmail.com>, 
	Fangyi Zhou <me@fangyi.io>, Franklin Weng <franklin@goodhorse.idv.tw>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 7:47=E2=80=AFPM Yi-Jyun Pan <pan93412@gmail.com> wro=
te:
>
> Hi Jiang Xin,
>
> Not going to focus on if we should use AI or not; just share some best pr=
actices
> and opinions for writing content for AI agents.
>
> For the "Technical guidelines for AI tools" section, I would recommend pl=
acing this
> section in AGENTS.md (https://agents.md/), which is an open standard for =
guidelines
> for AI agents to reference, so we leave the main README file clear and co=
ncise.
> AI will also refer to them without explicitly mentioning it (@po/README.m=
d).

The best AI coding tools have their own memory files, such as
"CLAUDE.md", ".cursorrules", and "GEMINI.md". I tried using
"po/AGENTS.md", but it does not automatically provide context. Many
capabilities are already documented in "po/README.md", including how
to generate po/git.pot, how to update "po/XX.po" files, and how to
create location-less PO files. Therefore, I have added the additional
AI-related capabilities to "po/README.md".

> I hope my agent can assist me with some tedious preparation tasks, so I w=
ould like to
> suggest a few useful use cases that would be fantastic if you could docum=
ent the best
> practices of these use cases in AGENTS.md:
>
> 1. Allow agents to update the base and translation by executing "make po-=
update PO_FILE=3Dpo/XX.po=E2=80=9D.
> 2. Based on point (1), I can instruct my agent to retain the previous str=
ings for fuzzy strings translation (msgmerge --previous, custom arguments).
> 3. When I complete the translation, it can also run =E2=80=9Cmsgcat=E2=80=
=9D to create a location-less file.

This change includes a commit that defines a filter for PO files in
.gitattributes, so contributors (including AI coding tools) no longer
need to worry about submitting location-less PO files.
