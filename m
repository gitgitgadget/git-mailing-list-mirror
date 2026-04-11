Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358B302756
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775933353; cv=none; b=XrMWOfUbokKHiULoHzRDf5Ln6q3wdEyqFHCgmYG86fQPArkXj3/QAV7/nBUhCiz3ksAG7mlxeSK0x99kmwn91+NjblskdE4g9Tusu9wp5L6XvXmqPwFwT28ey0MMqm9KdX4RiIxYhD/6ijwXQMsUCA+3ds5Y3eAPNUup1va/UYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775933353; c=relaxed/simple;
	bh=q42rV4zGDVLltFfFjNMS3+W3TX7c4cavHy6LjNsVPZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgMfkiIDi+5mbFyLQG35qoV4b2BhQOC9x9R+5YfDI9xjGKJmbmYSM19CUXrynt4t+9O3JDMH8aUH80VIYNiPqSBog30z+zn9wfSu9zKl/b1AdtoZulKI06qWrUl96ofBZnVkjnhF1dseZT7/w6YfXPXKGZNUPqdQ7CUUxcwph48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=GN0KNpNW; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=aOthKYSf; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="GN0KNpNW";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="aOthKYSf"
DKIM-Signature: a=rsa-sha256; b=GN0KNpNWgiBLzOvehsNeYKe2fle3vgHwkrovraVNgyiMcnL1Bvg7uVwEzKi7KMAugk+uAmhwG9TAlC0pnDWh8uMeIiWJ0U1tMjpZSKapVNT22+4AY+Zj2vJ7sT2E7QGhYjhEMCnO9MZKCLTOoTbJaNELUKZ06xRc094sVhKq5UtZNlWZv8lY6z+3SlALvAI7Q+lC6WsNfc0sNaYg1j5avSRZYAiTHMFQIAuAsO1/UZ88nFUnXWzKCTVNO/RbRrJDjsezETJ+hDoq7nQ9ln+62tcE8rYAB4vqq6OyuBpR3ADjQd8IqLPZEF7semMeam/pgJ2cwTjhGUjDdmLDOzAvGg==; s=purelymail3; d=malon.dev; v=1; bh=q42rV4zGDVLltFfFjNMS3+W3TX7c4cavHy6LjNsVPZ8=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=aOthKYSfKlhoxlRtTdeH6PKOpjyNRzUvHHauvQq06uOu1WBtEJGezTURANUSZNTl7VUMGWfP+O76gkqB19T+a4A8Y9A7oF8YxdWgmQbkPHPnIoCGgOARP7J/segLI/g6ncdjlbmDLkVzBN2IqwnKObobnpqGat1E1CQggXb8T8Xq9GxoyBvWoHIXaunNeQNjONTCON5IKIO9ITT9wKg//wmS7YdXRJqLPEnVfGbZa4BmHdSVmT6oqUNWKnTa/UGNJu6ca+IDJlzlltZt4ztBMXBIBY0m3+NVSLY4bWhHucu3trtLNnthOr94w78gX6BDU67M/vpKjc3UexCNDG5DJg==; s=purelymail3; d=purelymail.com; v=1; bh=q42rV4zGDVLltFfFjNMS3+W3TX7c4cavHy6LjNsVPZ8=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1210464474;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 11 Apr 2026 18:49:10 +0000 (UTC)
Message-ID: <a20d7433-2297-4ad9-a68e-302443f1f941@malon.dev>
Date: Sun, 12 Apr 2026 02:49:05 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v5 5/6] t7703: test for promisor file content after
 geometric repack
Content-Language: en-US
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>, Elijah Newren <newren@gmail.com>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <ab307e68feb9f84898dba748ef1f4598b07fc0e2.1775861047.git.lorenzo.pegorari2002@gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <ab307e68feb9f84898dba748ef1f4598b07fc0e2.1775861047.git.lorenzo.pegorari2002@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/11/26 06:56, LorenzoPegorari wrote:
> Add test that checks if the content of ".promisor" files are correctly
> copied inside the ".promisor" files created by a geometric repack.
>=20
> Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> ---
>   t/t7703-repack-geometric.sh | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>=20
> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> index 04d5d8fc33..a8e3e6ae3f 100755
> --- a/t/t7703-repack-geometric.sh
> +++ b/t/t7703-repack-geometric.sh
> @@ -541,4 +541,37 @@ test_expect_success 'geometric repack works with pro=
misor packs' '
>   =09)
>   '
>  =20
> +test_expect_success 'check .promisor file content after geometric repack=
' '
> +=09test_when_finished rm -rf prom_test &&
> +=09git init prom_test &&
> +=09path=3Dprom_test/.git/objects/pack &&
> +
> +=09(
> +=09=09# Create 2 packs with 3 objs each, and manually create .promisor f=
iles
> +=09=09test_commit_bulk -C prom_test --start=3D1 1 &&  # 3 objects

---

> +=09=09prom1=3D$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&

This approach seems a bit fragile.

- Perhaps you=E2=80=99ve heard the saying which goes like "never parse the=
=20
output of ls". In a nutshell, the output of this command is not=20
standardised;

- *.pack? This may produce multiple lines of output, which I don=E2=80=99t =
think=20
is what we want.

- $path instead of "$path", which cannot correctly handle spacing in=20
directory names;

- sed s command matches the "first" string it meets. We can=E2=80=99t guara=
ntee=20
that the '.pack' part won=E2=80=99t appear in users=E2=80=99 path names, ca=
n we?

(Fun fact: There are approximately 8,000 people in the United States=20
with the surname 'Pack'. Source: 2010 Census ; - )


> +=09=09oid1=3D$(git -C prom_test rev-parse HEAD) &&
> +=09=09echo "$oid1 ref1" >"$prom1" &&
> +=09=09test_commit_bulk -C prom_test --start=3D2 1 &&  # 3 objects
> +=09=09prom2=3D$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom1|d")=
 &&
> +=09=09oid2=3D$(git -C prom_test rev-parse HEAD) &&
> +=09=09echo "$oid2 ref2" >"$prom2" &&
> +
> +=09=09# Create 1 pack with 12 objs, and manually create .promisor file
> +=09=09test_commit_bulk -C prom_test --start=3D3 4 &&  # 12 objects
> +=09=09prom3=3D$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom1|d; =
\|$prom2|d") &&
> +=09=09oid3=3D$(git -C prom_test rev-parse HEAD) &&
> +=09=09echo "$oid3 ref3" >"$prom3" &&
> +
> +=09=09# Geometric repack, and check if correct
> +=09=09git -C prom_test repack --geometric 2 -d &&
> +=09=09prom=3D$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom3|d") =
&&
> +=09=09# $prom should have repacked only the first 2 small packs, so it s=
hould only
> +=09=09# contain the following: "$oid1 ref1 <time>" & "$oid2 ref2 <time>"
> +=09=09test_grep "$oid1 ref1 " "$prom" &&
> +=09=09test_grep "$oid2 ref2 " "$prom" &&
> +=09=09test_grep ! "$oid3 ref3" "$prom"
> +=09)
> +'
> +
>   test_done

Thanks, yuchen
