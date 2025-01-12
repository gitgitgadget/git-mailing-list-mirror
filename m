Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF1154456
	for <git@vger.kernel.org>; Sun, 12 Jan 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669633; cv=none; b=rHR8g3QVgRuQwFY09rM+0eX/fx8LkDMGQGyvH8Y5caWDi+4taHOECN7S6C/6AzV4MX4LUUI5yCFpzP3CmhRG6CLco5O7Ngm8Yq4RKB1HdfsTIcpNFZaPVNfoJuweUwot/EFk72vUvNcQiZmsC2ZKsemNT/aCwiLxQH7pa9NP/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669633; c=relaxed/simple;
	bh=XxmbqBIxaNSqYdOBzV24MpY6UHO0V+V1FvsXX1dDFAI=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:To:
	 References:In-reply-to; b=nKqSo1aMG3z+79fhdSsdB0ohhwj0VKi+K+gK2JmlqKjf2ycxWucRxIv2AV4KBQ89GiTlRHSZt4TTLbHJ2UCfTRTCQG2GM7mdDadSWSowgWUk10xwJCTiUpIUciJI0/2QMMNrsXIf2vh4elhJ3flutqmjUqiIhzFKkOMs3Xatws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=DcqQS5wa; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="DcqQS5wa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=T8mmwZq/xIHNv+vyWK8GWKda0vxWYyIidq8we4jEcA4=;
 b=DcqQS5waHOotKYOdB75k7FNEn9FAWqfKt07j2jJoGvXfmnxIL1VQqvCKhA4/IDTf1YhStFHm56co
   d37pKA9mg3FBOcTp8TYQGoCPzIb41T1nMI+YavsF4CtCCTHLw/unE+lv6WIku3NWQoxkpNPidBy0
   35p5PDR1eBvZEleryKi4wTHvVtho94RHtsPtKcJ73zlAkNxK8lzPMBwLv5FUAUk3mjYLfKjHYLH+
   1SUtswDukOU+HYYNa+Ufu5Hcy8dkA4vi6YOwa1Zl7r2tsbx0h1KmWTPnDbTbK0NOOcCdkPBpCytb
   aiMEskdIJCN1FH8Q54CR8AYStBQGxdZfOYsQ4g==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SPY00BDKUMI1B50@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 12 Jan 2025 08:08:42 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 12 Jan 2025 09:07:45 +0100
Message-id: <D6ZXVILR1D36.3W0QVQCVE1P2J@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: Git 2.48. Changed behavior of the git fetch
To: "Danila Manturov" <danila.manturov@jetbrains.com>, <git@vger.kernel.org>
References: <CAM6buW5KSDGHD7txroqVa0TN_Ou_eV-LocMy06cPy0ZGDQmY9A@mail.gmail.com>
In-reply-to:
 <CAM6buW5KSDGHD7txroqVa0TN_Ou_eV-LocMy06cPy0ZGDQmY9A@mail.gmail.com>
Reporting-Meta:
 AAFOaSMv0RCnYaH7rh4YpcjE++qYPX1K3xHlswdh9z4srQekjHcibjeeBgCGhrFx
 WAS4ZCRi5Gbk85zZvfe8cWtbagwZ6bI5tOyVwigHggChDELk7rzXDp7pp5PZCt6G
 PpTA16A52q2y8/AvjipEbgPeEDs2M2FTckcLEVDQZOhTYNyhtO1parjbDB+EhNN6
 tNgCr2bBJ+tberdQ37pTJ/Paikwffb+0II04oor+zJ9+QGv0vbJsPTlcXtIO69Js
 Qahme0KrCH+3mbO+byMysIbMbRFiSrE2viajIBtVZGl74b2Dbi4LgqZjvMeGGC75
 KRB8ZEF5TcpNfGlQaLnUFQsPkiBYmOJ+ikJ0KtXUFRMvDsQhSWF7z2mDeTqZPobE
 8MKdmnnV7yjFh0PyO5IKAeD49JJRbXqOv0Pdp3gKGOsplZIfSMmaudMYNsFy79Uf
 +oSNYH71MJmAba2cvnxHwQBBBV2Gj5vLUSmSAeL9u6FwCagq+pB/DTU=


On Thu Jan 09, 2025 at 12:49, Danila Manturov <danila.manturov@jetbrains.co=
m> wrote:
> Hello. I work in TeamCity and we have tests of our git integration
> running with the latest master of the git repository. Some tests
> started to fail since
> https://github.com/git/git/commit/5f212684abb66c9604e745a2296af8c4bb99961=
c
> I noticed that tags are not fetched with shallow clones. I published
> the test repository to GitHub and reproduced it with commands, the
> result is different for 2.47.1 and 2.48.rc0
>
> git init
> git remote add origin git@github.com:manturovDan/repo_for_shallow_fetch.g=
it
> git fetch --progress --depth=3D1 --recurse-submodules=3Dno origin
> +fd1eb9776b5fad5cc433586f7933811c6853917d:refs/remotes/origin/main
> git tag | cat
>
> RESULT:
> tag1 (git version 2.47.1)
> <empty> (git version 2.48.0.rc0.38.gff795a5c5e)
>
> the repository log:
> * commit fd1eb9776b5fad5cc433586f7933811c6853917d (tag: tag1, main)
> | Author: Victory Petrenko <vbedrosova@gmail.com>
> | Date:   Wed Feb 3 13:05:03 2021 +0100
> |
> |     recent commit
> |
> * commit 64195c330d99c467a142f682bc23d4de3a68551d
> | Author: Victory Petrenko <vbedrosova@gmail.com>
> | Date:   Wed Feb 3 13:04:44 2021 +0100
> |
> |     change
> |
> * commit a1d6299597f8d6f6d8316577c46cc8fffd657d5e (tag: tag2)
>   Author: Victory Petrenko <vbedrosova@gmail.com>
>   Date:   Wed Feb 3 13:04:17 2021 +0100
>
>       initial commit

This should already be fixed by

6c915c3f85 (fetch: do not ask for HEAD unnecessarily, 2024-12-06)

	[snip]
    Incidentally, because the unconditional request to list "HEAD"
    affected the number of ref-prefixes requested in the ls-remote
    request, this affected how the requests for tags are added to the
    same ls-remote request, breaking "git fetch --tags $URL" performed
    against a URL that is not configured as a remote.

so using 2.48 should be ok.

Best,
Bence

