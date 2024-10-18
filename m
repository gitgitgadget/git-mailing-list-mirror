Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F4187876
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729290854; cv=none; b=Zz3MUCS+/zexhFa84P8jaJi4QryF3c+YWvf9aOntbUB3mGXepeHVYNwFuUeKl/Gzb3c3Z4sEvkbXCTIrjSrERJmExvyVwE6K2opBL2EWXqb1pMhxSBCBsaC21G3MYPHHiQQqz597gJHe/sBegTa5UbrnM8kOKvUzVxzof/ND3rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729290854; c=relaxed/simple;
	bh=liN3KZMLxZvHbdDrugA4PnkJC9iGBJF2aKL1nlaMvvs=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=BBqRUYndeL7JLud7e5KNkaV/6jDzxJnmd5Rg22EOi+Jvki+NiJ+/SIimwJ5PuXlINR0qkFRH7yug3GZnJ/TLzbDa+xIDkUUa/YZ++UnLoCOdQrIVgAaSPiQnJx6O1SqMiTW/XqajmY7NKJr+8Ewr21xMh5q674no8Lg/ylVlzTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Vk8tPqwY; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Vk8tPqwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=mqXUrU/aLb2quuacvb8rNfYptiVlIljRiGvinELgn4Y=;
 b=Vk8tPqwYdy0rFwr91Fc64MOBghmopHPhNzCOylA0bChMi0nwJBZb5+jhNdzvkL7Cb/v1SVn+9uS1
   GJ1HIskqLm7X95LkPZwKN5C/IOLjQGzlr/5rrdGP2/CeY2AoyfXt1g5tEBHewrLfKIm36vHT+zXw
   7cjccYVRROU+NXkIrIP71HjRhBJhpMlTTYc3K7Oube0mRH7xHFZ2PNS2cmCHtB85XKEuNLI+IiK/
   3OwfOk04fk8+bNKVgzd7hrStHgRVIqydga/EHTwAPjMBM7E0xdK0/4v+XjlO8S7v7ASxepmm7UVf
   NwHVBySk/UKldtX4VGvxiXkwpfoAvYk79Bmbsg==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLK00F1XPCTU2A0@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 18 Oct 2024 22:34:05 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sat, 19 Oct 2024 00:32:17 +0200
Message-id: <D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com>
To: <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: CI behaving differently from local tests
Cc: "Taylor Blau" <me@ttaylorr.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>
References: <D4YDINQ682QL.N0FD2J9C1O22@ferdinandy.com>
In-reply-to: <D4YDINQ682QL.N0FD2J9C1O22@ferdinandy.com>
Reporting-Meta:
 AAE5R1CsOIZUV9vGsrRIjie7LSMXbFBGeKiwp0La8I85+6GmMIjp/Myt0SH5pONg
 DgPjvAsL2A1ieoQXWIFsQprY7EXCCZgC9Pq1YB0KClrjdQkSqKlYWBbF21ko0Kfw
 R0KQQGYtzzoXELV6yHmdesBo7eTULt/tr5tm4eDnAjGQcT0O/QfEqvKC/Yt74rUS
 tPBlmRPJwbr8g6C+kj/S3TWYxCnYqfCM60hTpb7OzKwIrhEvqkBub4eMO7dP1112
 /VF5t/KM8nEm9S+lpXUV7M8xiQMGA1q0YTVuONawidf+3fvvrfSHhVHWJDiwvOxB
 chO+BnZzgqMwNLeUf+iNLPzNK34kz6AjQ5/S3sIfC/pHpKZJWZPKR8ZnY6dXO3Rh
 m/CACEUGFfDxgODiG6FDNpPZZRZLECN49Rv9ldn76T8pi+IAiAqufPGNC/LEaPIs
 qCZQy4IrAKUO0EDIY33lb01hNjMo1Apkl7kkUsnT79UOz4B8ddoi/X5l


On Thu Oct 17, 2024 at 22:45, Bence Ferdinandy <bence@ferdinandy.com> wrote=
:
> Hi,
>
> I'm looking at why the set-head series (cf.:
> https://lore.kernel.org/git/20241014225431.1394565-1-bence@ferdinandy.com=
/)
> breaks the CI. The problem stems from the local test repositories being s=
et up
> differently from that of the CI.
>
> I ran both the CI and a local test on current master with the following p=
atch
> applied on top, i.e. I print all remote refs and intentionally break the =
test
> so that the result is easy to get from the CI:
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 532035933f..d625a3a8b6 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -724,8 +724,11 @@ test_expect_success 'update' '
>  		cd one &&
>  		git remote add drosophila ../two &&
>  		git remote add apis ../mirror &&
> +		git ls-remote drosophila &&
> +		git ls-remote apis &&
>  		git remote update &&
>  		git branch -r >output &&
> +		echo "force error" >output &&
>  		test_cmp expect output
>  	)
>  '
>
> The CI gives the following output:
> https://github.com/ferdinandyb/git/actions/runs/11392309625/job/316981052=
87
>
>
>     + git ls-remote drosophila
>     9d34b142e42f6b3dbab46dd4b9bc515e0ab16101       HEAD
>     9d34b142e42f6b3dbab46dd4b9bc515e0ab16101       refs/heads/another
>     9d34b142e42f6b3dbab46dd4b9bc515e0ab16101       refs/heads/main
>     2ce9c504874e3f0ce77f83c0bb0b1024c7a6387f       refs/heads/side
>     + git ls-remote apis
>     6329a3ca5268a0b28a1dc29b602e8b72a0bc1b37       HEAD
>     6329a3ca5268a0b28a1dc29b602e8b72a0bc1b37       refs/heads/main
>     2ce9c504874e3f0ce77f83c0bb0b1024c7a6387f       refs/heads/side
>
>
> While from ./t5505-remote.sh -v I get:
>
>     9d34b142e42f6b3dbab46dd4b9bc515e0ab16101        HEAD
>     9d34b142e42f6b3dbab46dd4b9bc515e0ab16101        refs/heads/another
>     9d34b142e42f6b3dbab46dd4b9bc515e0ab16101        refs/heads/main
>     2ce9c504874e3f0ce77f83c0bb0b1024c7a6387f        refs/heads/side
>     6329a3ca5268a0b28a1dc29b602e8b72a0bc1b37        refs/heads/main
>     2ce9c504874e3f0ce77f83c0bb0b1024c7a6387f        refs/heads/side
>
> Since `git remote update` here is essentially running `git fetch --multip=
le --all`,
> with the set-head series applied we're attempting to set HEAD for both
> remotes. Obviously, this fails locally and succeeds in the CI, which is
> actually the patch series behaving as intended, but obviously a drift bet=
ween
> the local and the CI testing environments.
>
> I'm probably too tired right now, but I don't see how or what could make =
the
> mirror repo be different depending on having it locally or in the CI ... =
At
> least I know it's definitely not my patch series :) Does anyone have an i=
dea
> what to try and look into?
>
> I guess ideally the fix for this would be added to the beginning of the s=
eries
> so we can continue with both local and CI tests working. (Although it cou=
ld be
> marked as a know breakage as well, not so elegant).
>
> Thanks,
> Bence

I found the issue. It comes down to the CI running with

export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain

while this not being set in ./t5505-remote.sh.

Now the bandaid here is adding this to t5505, but it may not be the solutio=
n.
The problem essentially is that `git remote add --mirror -f origin [somerep=
o]`
does not update HEAD in a bare repository.

Consider the following:
	git config --global init.defaultBranch mypreference
	mkdir one
	cd one
	git init -b notmypreference
	git commit -m "initial commit" --allow-empty
	cd ..
	mkdir mirror
	cd mirror
	git init --bare
	git remote add --mirror -f origin ../one
	cat HEAD

You'll see HEAD is ref: refs/heads/mypreference.

Continuing
	cd ..
	mkdir r_one
	cd r_one
	git init
	git remote add origin ../mirror
	git ls-remote

We arrive at a single reference pointing to refs/heads/notmypreference.

If we do the same exercise, but instead setting up repo "one" with `git ini=
t -b mypreference`=20
running ls-remote "r_one" will actually also yield a HEAD reference.

I'm not sure if it should or not, so for now I'll just make sure that
./t5505-remote.sh uses "main" as the default branch.

Best,
Bence

--=20
bence.ferdinandy.com

