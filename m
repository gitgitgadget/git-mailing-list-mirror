Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C82638A0
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719756; cv=pass; b=fehmJbTX9q2Uj6L+L0ipGEJB5ge/hOW/LkitEAat3VwBehk83M2lWPoEh1MD1QUSRbv2DUMBRKi0SSKr8MrlQflVpCIa/99JMWxyivG9rnZ12u6K63M1pEJsdaovIQaM0HVRphspUeGEWpJ3H6uTaZl34bvaLM3IeuMtBtUg4wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719756; c=relaxed/simple;
	bh=CCDNZebGSINZONqYwq0XrA9Z7wm8nzv/iZHAix222Z8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qRMui/7z86k3FeuO2l9Jyb2sKKpNlxx5HEHxKrAh8kIOZCbAJJEoBZ1lbydMaqjk2zmsWzzO6jzogOM5fMcIsQiOM1IhBAylncl1yBpnYIQxgXmjoh7NkxWDYwk+u/f82gqesnKLyhh1yYNMKRBht4ut93VPkXRf5cmBTq+cw08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=b6O0rQCO; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="b6O0rQCO"
ARC-Seal: i=1; a=rsa-sha256; t=1746719745; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QHIF7wdmkC/XnyHccyeot1hZMaY/zgpKfCsxR+Hpl5OpilTyVvFIvyfOmbS3MMc5Yr7k2YbeYtBGx7yrlMcp3Zrc7t4XRThhnbaFJ4C3V0U4eH3AIIERuaeXp03AjleRLiez2UvjH/P0HS9SiQoAxf73JcYtOXoNo1zk+QBzBjM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746719745; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HL0dyD28+uyQkJ4CMLCxPnv3tVmgT5FjzvaRrhdFTuo=; 
	b=GTzwGaqGPjkgAfXoPNTjVUXJX9/oM2opckRydEy1fl86meHEQug6f9PR1dNiNmNSjI8SZyEkbjtGHDrtn0r0uWQyGAa0CSptVi1+kZHvGO6v3kpGXlZOYmkIGKjjN4K3M8s7gxavK5TD4GlpCU8oHOcX9j9D9J9ewDUB/yDWJLo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746719745;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HL0dyD28+uyQkJ4CMLCxPnv3tVmgT5FjzvaRrhdFTuo=;
	b=b6O0rQCO7XEeo7M8ykC8z7G0tj4MnqJfPSai8gIXadl5Kbp9b4mOcTeKa/7qnQxK
	EG8FY8wck4DO1CebSRle9TjK2kFqD8TPEAgagwVIRlfzvFnk9X+e7Zx9UN3g4Fs0yoD
	uyPo0RsSrLK7yhyKqwe1orw2iyK3GpRcAvn0iXEg=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1746719740824308.1335905431928; Thu, 8 May 2025 08:55:40 -0700 (PDT)
Date: Thu, 08 May 2025 23:55:40 +0800
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>
Cc: "git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-ID: <196b09c1324.fba686d21234508.1995945025408421751@linux.beauty>
In-Reply-To: <951d3343-fe97-4e7e-bb73-1c569ff10ee6@gmail.com>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
 <196a5ad7fff.c587c495188189.5980390754046003962@linux.beauty> <951d3343-fe97-4e7e-bb73-1c569ff10ee6@gmail.com>
Subject: Re: [RFC PATCH 2/2] rebase: support --trailer
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

Hi Phillip,

 ---- On Thu, 08 May 2025 22:17:17 +0800  Phillip Wood <phillip.wood123@gma=
il.com> wrote ---=20
 > Hi Li
 >=20
 > On 06/05/2025 13:58, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > Implement a new `--trailer <text>` option for `git rebase`
 > > (support merge backend only now), which appends arbitrary
 > > trailer lines to each rebased commit message. Reject early
 > > if used with the apply backend (git am) since it lacks
 > > message=E2=80=91filter/trailer hook. Automatically set REBASE_FORCE wh=
en
 > > any trailer is supplied.
 >=20
 > I think this is a reasonable idea but unfortunately I think the trailer=
=20
 > API needs improving so that the implementation
 >=20
 > (a) Checks the trailers given on the command-line before the user edits=
=20
 > the todo list. That way we reject invalid trailers and exit before the=
=20
 > user has spent any effort editing the todo list.
 >=20
 > (b) Does not fork another process to add the trailers. Without this the=
=20
 > performance is going to suffer. Hopefully it wont be too difficult to=20
 > modify the existing code to take a struct strbuf and a list of trailers=
=20
 > to append to it.
 >=20
 > (c) Only adds the trailers on the commandline. I'm a bit confused by the=
=20
 > various trailer config options - the man page reads to me like "git=20
 > interpret-trailers" can add missing trailers that are configured but not=
=20
 > passed on the commandline.
 >=20
 > The changes to the trailer api should be made in one or more preparatory=
=20
 > commits before adding support for --trailer to "git rebase"

Thanks a lot for the detailed feedback and for outlining the gaps in the
current trailer API =E2=80=93 it really helps me see the next steps more
clearly.

I have one questions:

Who should take the API work?

I=E2=80=99m very happy to roll up my sleeves and prototype the improvements
you described (reject invalid trailers up=E2=80=91front, add an in=E2=80=91=
process API
that works on a struct strbuf, and ensure only the CLI=E2=80=91supplied
trailers are added). That would give me a chance to contribute a bit
more deeply to Git. Of course, if you already have something in mind
and would rather drive that part yourself, I=E2=80=99m equally happy to wai=
t
and re=E2=80=91base my series on top of it. Please let me know which you
prefer.

 > I've left some comments on the changes to builtin/rebase.c and the=20
 > tests, I've skipped the changes to sequencer.c for now as they'll have=
=20
 > to be updated to avoid forking "git interpret-trailers"

Thanks for all your great reviews!

I'll address all your reviews in next version.
=20

