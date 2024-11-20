Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0E16F831
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093156; cv=none; b=riZ9Z28/icAwoq/KEbLukHhVy8z0oZaAEUTS+F6QpLmfJ2kBL1r8i5/Mn7EhfjZyBUG0StBdNbf0v2skBaEnNtrNpNbZ/05PwrP5+T6X3ek/8iME4TNeuBs8UVws5JyROublzErqINqiLJ46j/0rZFo7HGYsSzGicofcJZzJPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093156; c=relaxed/simple;
	bh=gbr9NVTeUnF0KG6pehROX8N+UC++Ar/wcfbnNv25YQw=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=hjqocHkt8l8ut6bzn/dUkezAiF97KbUBymuNQ87lwAKQ9vS6VE4EbzPlIMFhMfAdL1oh5mxl3pX/bgcYFF2yROOz3qzi1bf8AiT2PFCrLk6CfzIkiDeuIAPfgqw9fc+CDzU9r+EWVlSvN80Tb0yhLSVRWvSL8JY8TzJ/PSWSgPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=JLphxE0o; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="JLphxE0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=vK4kjbP2G1jjFijk/Yt37rs7Fq+WuOlr/UlRGYr59jg=;
 b=JLphxE0opxpSquGbWyYfr7YVIZ0APQsyZbbayQ7DgbSuWqnt6yVMN9S++rUvvpaLzA3xYUndrj2G
   eU0CYab13nBawGdjSP1WbHUfPKIdouUUcR1HdCiqfp6K7MNBkJejbWaAg8894TIK0arQde0o63Ki
   uHMOXtH2MVtRaEAZkMAZx5eqrDP94dB6Kg0ycOw4qn7teSdJrUVePeqzOfz0UjErUDXkcWkW15UQ
   ObXRQVjJP+u9LA/7+nSfLpY2gKwg//y3e6DnA0im0LMWPrpKcJIXYDhtWiXe/wWSggS6joQnILK4
   LenyDx/7u/8c7oVuhoHbRL8Z8R7ZGJQ5ezHIUQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN8008LCRMJSC40@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 20 Nov 2024 08:59:07 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 20 Nov 2024 09:58:40 +0100
Message-id: <D5QVRMGNDJ3A.4INI8UF7PDW5@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: git remote set-head automatically
Cc: "Jeff King" <peff@peff.net>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Caleb Cushing" <xenoterracide@gmail.com>
References:
 <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>
 <20241116033616.GB1782794@coredump.intra.peff.net>
 <D5NOZMMISX44.2PTTMY57J5EM6@ferdinandy.com>
 <CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
 <xmqqv7wiaeku.fsf@gitster.g>
In-reply-to: <xmqqv7wiaeku.fsf@gitster.g>
Reporting-Meta:
 AAFAfpGlHpcjsEZMOCjplN9vdkH87NDdStaWHoAA9Cg15D4kLN2l9wH1OCez3h/D
 PGxwiP6OgBa/HqqmxjeAY1ewOuVKI2jMby8O+srruQoYXViAlG+GkMQBdxHxIdVC
 dB+cC5tp3CKKaivfnVSnoXCxrB61YpgbQPb3XShrQwN+HK4YFNLdFzcGqmC9FeiJ
 g9X4t7vkj5S8zgSOE0ZJ6lMaxSwhjNlcKTxZJNIuIDmetLwjkO8mOuOgCSdWL+JX
 OkCulTyBS2aG/fo3UH46TiLuIxzyEqmjWk1J46DfleoVm/Zl0KX93lZ4MEEaceyS
 1/J8ootWeSzLtsDrjWvGS1TntvZtKu7KSb+YbiE58M8V/JR03+p2E2JZfsmHz9+t
 7obvS1Y5NRRCX/6hCJXQ8nETr3xjmu/o0utL2c53M2FpLVgA46pA0tfe25drCOb7
 E/AvrqVeKO06IkZHe45jSCdJ7K+AK4EBImpnAibfHjJQ8Q+s8PwSjdjI

On Wed Nov 20, 2024 at 02:17, Junio C Hamano <gitster@pobox.com> wrote:
> Caleb Cushing <xenoterracide@gmail.com> writes:
>
>> sounds great. I think I realized why I didn't have it. It's not done
>> by `git remote add <origin> https://...`  my experiment was `git
>> remote rm origin` and then `git remote add origin ... ; git fetch
>> --all --prune` I think I also tried without the prune option. git
>> version 2.46.1
>
> Yes, "git fetch" does not notice a missing remotes/$name/HEAD and
> does not automatically create it.
>
> This is being worked on in a separate thread.
>
> Doing it unconditionally may hurt some existing users (including me)
> who see more than one primarily interesting branches in a single
> remote and want to force themselves to be more explicit, though.
> For us, leaving remotes/$name/HEAD missing (e.g. by "git clone"
> followed by "git update-ref --no-deref -d refs/remotes/origin/HEAD")
> is a way to allow ourselves to say things like
>
>     $ git checkout -b mytopic origin/maint
>     $ git rebase origin/master mytopic
>
> but not
>
>     $ git checkout --detach origin
>
> because the last one is ambiguous between the two branches of
> primary interest.

You learn every day :) I had no idea that the remote's name works this way.

Thanks!

>
> But hopefully they have trained their fingers not to say "origin" by
> now ;-) So changing "git fetch" to auto-fill remotes/origin/HEAD to
> whatever branch the remote is pointing at at the time of running
> would be good enough for an initial enhanced version, even though we
> might need to further improve on by allowing folks to opt out of the
> feature.

