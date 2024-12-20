Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1990F4430
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734656934; cv=none; b=ZNYXUQUmpvdvlZd3BbrbT5JGQsK2SZcUYfJaZ95kkpt7t3KtqAwIiAvOzTZSUBFvWTiJ2LjXnHfqymC0EFsl0QSfVA3eu/IBtHhQINsxhYzCIX1ZhItE1fABbboVfy0KILxMasAmasG5e1Xxd3A/vetfkDpjieyZti1KLlUCfVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734656934; c=relaxed/simple;
	bh=ORxYkkzDC/tdB8BU7+sTsTmhQnFegWfskAunKOMRsb4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHsDktDHQREFBawjfgymz6gp0AjNd0EEVqjNXxC1vyvHmSFkPkoJQfCDTuPrbq7TzSh7srPfmn0vcWd+QAePe0gFHFf5xTxluaLLSERRTt71ywiVtu/SBgZak5+DA2/g7kw5hbyGXgz/ONXFwl1PAJZH50IH/085uWBQVtjRsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=iLGMcaL/; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="iLGMcaL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734656923; x=1734916123;
	bh=ORxYkkzDC/tdB8BU7+sTsTmhQnFegWfskAunKOMRsb4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=iLGMcaL/fGat9znf0K4/WQ3mggtkzM2qiGcYUmo+ApceLZ0onTi8m9q8SHZxVD/+V
	 hsrKiOpYv+o+pxcvW73dwEjiQ1aPOq+tA3DbspSB6X0kSCODmxbBqLAg4zPZS5FgiJ
	 /xYQkQB7dzAVaknaLZGy6NgR7EUfL25xy8R6xpEqo3UcuOg+qoiU0j2SiZvTW8nKnu
	 MZwC1P3mpRGDISYF0cyuatouY416VC65fkuoN+F/7owQh6ZabKxi8HRhpyXTFYEnKi
	 5haqXC3cubYDDzhodzSFHwtlB+sEcxjIqdTWIflJYLDMKuI/LuJykfXt2Cqs3tWwfO
	 K62G4ur6VR8tQ==
Date: Fri, 20 Dec 2024 01:08:38 +0000
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Git Mailing List <git@vger.kernel.org>, Git l10n discussion group <git-l10n@googlegroups.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: OK to submit l10n PR with signed commits?
Message-ID: <D6G4K1DJJUUG.1G5TT36LYI435@pm.me>
In-Reply-To: <f0b52b6f-339f-4641-8c15-7bd93b03b24e@app.fastmail.com>
References: <D6FUAW0WHD9P.EKNH75JAR157@pm.me> <f0b52b6f-339f-4641-8c15-7bd93b03b24e@app.fastmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 78d7ac9560d21b3fda1190f4ec7c1a28c12afb4a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Dec 19, 2024 at 11:27 AM CST, Kristoffer Haugsbakk wrote:
> On Thu, Dec 19, 2024, at 18:06, Caleb White wrote:
>> On Wed Dec 18, 2024 at 4:08 AM CST, Bagas Sanjaya wrote:
>>> So I'm interested in GPG-sign my commits (that is, ``git commit -S``) f=
or l10n
>>> pull request (which I should submit in this cycle). Is it OK to do that=
?
>>> Drawbacks?
>>
>> The GPG signature is lost when emailing patches---so unless the PR is
>> actually being merged directly (and not using GGG) then it doesn't
>> matter.
>
> The i10n project takes PRs on GitHub. That project is then later merged i=
nto
> Junio=E2=80=99s tree. That=E2=80=99s how it=E2=80=99s relevant.

Ah, good to know! However, I don't see any downsides to signing your
commits. I have git configured to always sign my commits and tags
automatically.

Best,

Caleb

