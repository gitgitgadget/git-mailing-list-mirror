Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD38912C499
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541412; cv=none; b=p1HkU+JM8YvzbKm3V6dmSyW55ECj8sm2qMSgAoGI3XhMgMH3nGEUOlVuiTsaA5yWk54GaiLGUUV9r06pLBm7pZNdBIDq/uUBwffUl74RZsq9kK+lNVUUaLcd0UE7RB9UFdAhudq/f92OzB0z2THR9m0DABZbroA2aFNn6JMaQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541412; c=relaxed/simple;
	bh=obegvUoCud/C5JsY2AGdQCzvHkPj3c/2k6V34bgiO9w=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=KhrS2EzZP2/Nzd265IGIcXl3wl3bzTz+XpLyu/YDVl1w0TcMUHEAoMy9n4AobHBKnoqE12ziwlmy7OnreRst51VVcBHLM+5jQEsfD56KgUFTanykw2CEgdx9IyeHTZ9HjHnNe/tBA3r4gs5YjLY2IwP0N01TcW6+JlEEOdb06vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=PN6d/P8Y; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="PN6d/P8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=ptDTDOnUk/LlPvC0msVqo0qAP/wJse58WQfs1KehRxI=;
 b=PN6d/P8YFu7dWk0QELr1ReBy5VIuyGK/9u5YipC8fqX0EbvnVE/57dHMkbyxvBquupmDttVufHQE
   0Rk9LiTyq5ln1gP8K2zIyUlF9d1VSWG67NMuQV2bjtiCa7Ylm1hjFwx5yyZoM3P1/8+HIhvkA2W1
   EqdXQIbPTrH/gOMuTV3qTvIS1wbV8F85ORIyEs+CQLv96gPnPiwDyesXpwYVoOVXUSvgDYsUqsMH
   nOB8xgsa8RjDeRwDzZ7VLV1eZsWimFe6KPjK9vNM5ENpa3RIZP6rN6QMXFSMBEHyn/P+p3CzFo/q
   z3ADc83WGUDdGqw0VNqGY7CIxnaPoWlwVPoAKw==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLQ001EV2OQ7I70@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 20:10:02 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 21 Oct 2024 22:09:38 +0200
Message-id: <D51R90BTHJMY.1C1XY5P4CHTWG@ferdinandy.com>
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
 <20241021191441.GD1219228@coredump.intra.peff.net>
In-reply-to: <20241021191441.GD1219228@coredump.intra.peff.net>
Reporting-Meta:
 AAEnPGpg7kOVOZ4tMYtz5EM84CBz9HqcVKzXcMjURRbySG/ilfbnoQDh0RCIG0XD
 zNeu6MNdJX7p4SDQOrOizhKDK69c4TwfQAqPbDlKUvkcXzmEDOwP9FtOBXeGWajJ
 cr6TdZY2BcS6w9Eb9L0poT7rtqbjFsxgrzswa5mXuHliqnnFTwf9VuN3cX1/tq5R
 ux9V4ISKHPkPTdImeY9cmc3XYbJwDRwJU4LbCDcy/N/EIt4Fm9cE3meTkNfGZtU3
 x/AJ/cw86F6OR0CV+0T1jDiUfqrt0OANbOJV4hkp4BIbdi200DSfUFhFMtyaLVhI
 ohduA8CUrsT1YtOhxtJmWdJJgSCFaXymkB87folS7DHvqgR67nmX2iCdkqqEvU4i
 F0c8hCh+NJ6CwEFedhHgYWLBjDTfZxDfhSKH9eAlYPJ3z2c7hLUhxIjGZXTXyAnO
 LS2sUTOZlzYwBWiKFNXNMFVfir7p/8wO9d4HpR25KJZSUQ9wgqTIYDc=


On Mon Oct 21, 2024 at 21:14, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 20, 2024 at 11:42:38PM +0200, Bence Ferdinandy wrote:
>
>> I basically use it for two things:
>>=20
>> - variations of `git log remote/HEAD..` for which I currently have an al=
ias
>>   with "origin" hardcoded. E.g. I'm on a feature branch I'm reviewing an=
d
>>   I want to know what commits are new compared to origin/(master|main|tr=
unk),
>>   but I use HEAD, because I never know (and don't really want to pay att=
ention
>>   to) what project uses what. And although "origin" is usually ok, but n=
ot
>>   always if there are forks in play, so @{upstreamhead} would make it ag=
nostic
>>   to the remote's name.
>
> I'm a little skeptical that this is useful. If a local branch has a
> particular remote branch configured as its upstream, then shouldn't your
> search for new commits be against that configured upstream branch, not
> whatever that remote's HEAD happens to be?
>
> In many cases, of course, I'd expect that HEAD to also be the upstream
> branch. But then you could just use @{upstream}.
>
> And in some cases, you really want to compare against a known base
> point, regardless of the configured upstream. But then you should use
> the full name of that base point, rather than the remote half of the
> upstream config.
>
> It sounds more like a band-aid for scripts that are expected to be used
> across repos that may use other names for what is effectively "origin".
> In which case I question whether we really want new lookup syntax,
> versus having those scripts learn to query the remote name.
>
> E.g., I think you could do:
>
>   upstream=3D$(git rev-parse --symbolic-full-name @{upstream})
>   git log ${upstream%/*}/HEAD..

That particular one will break if you have something like
refs/remotes/origin/foo/bar, but I get your point.

>
> And possibly we could make it easier to just grab the remote name with a
> single command.

As I was running this patch through my head yesterday I sort of distilled m=
y
argument in favour to "writing remote agnostic scripts are unnecessarily
complicated", but I do agree, that if there were a git command that could
return the remote for a branch without any extra scripting hacks would easi=
ly
get you the same result, and may even be useful elsewhere.

I'm not sure where this would be the best. Maybe:=20
	git branch --show-current-remote
?

Thanks for the feedback!

Best,
Bence

--=20
bence.ferdinandy.com

