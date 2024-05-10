Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856B1708AB
	for <git@vger.kernel.org>; Fri, 10 May 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353341; cv=pass; b=hTYYY9rDqSgppHX/r1+WPDJPWQufpAn/fOf/Uy+xNSnQx8EdJ9+6u8rWPaZsSSQDAOvccTpsUCgO4MF9gaaoaFXmTC5YzNHbHnfZX5D7+riLhIFn5Y1z6YKBOHAfwg6z9fBQB0sDgINV88TI3m8BGYizupd+0F/ujyKCBQ6M6ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353341; c=relaxed/simple;
	bh=Ec3WhTb3N+88aaXVO8Y94KLrOBsbGZcFcoP/fh63VCs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kW7yX3OmuwsT9JxxBrj7PoztUb4a6WXfFrDTAqPkzGTnUHVLrAPHb6CkUEEAwf2uAAVFwwu4rsNPoiHryHNLiqc9bKoLH+WwqXGeu+hvQyxl6XrXtAmvd6HVr799MCesAppeveAZ4PXfWO5aKLzTirYFiVI9VogMT2Rw37M9AZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boanderson.me; spf=pass smtp.mailfrom=boanderson.me; dkim=pass (1024-bit key) header.d=boanderson.me header.i=mail@boanderson.me header.b=LlzfcOjy; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boanderson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boanderson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=boanderson.me header.i=mail@boanderson.me header.b="LlzfcOjy"
ARC-Seal: i=1; a=rsa-sha256; t=1715353337; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cXmHnAFmM+nJW5i/CnxSjTSU82tEV6O7h5yeomfEJ6VZTtFVQxhK6u/0UhERVnvaRHeECKtjNTNa0qb+c2FGOTKJtxWRnw1fZbacKx6XJICpfPEsWnfA9R20eT/2A+1QK9aF/14xAOWwB/r7tGcnu/3h+3rXxeCCd9rfU9OhZ8E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1715353337; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eAYs39jcyc3iElqjJFb+PqkM1cSI+FcCSlLl1APrT7o=; 
	b=jbSR42Y38JegIBmqn8AfK2qxDbG5byYCEvOcypm7AvinXsTYE9QRRh3j3p6y+dRON3jwAQXDjUATikbUKMlAaBUbDDeVvzRiEX35zYGrUsdwWS0UoAqHQYPcqcQdfbJG1LVy0jwqZw8sF3amOFx7Y0zjzIynKG86L6o2eYrXshY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=boanderson.me;
	spf=pass  smtp.mailfrom=mail@boanderson.me;
	dmarc=pass header.from=<mail@boanderson.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1715353337;
	s=zoho; d=boanderson.me; i=mail@boanderson.me;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=eAYs39jcyc3iElqjJFb+PqkM1cSI+FcCSlLl1APrT7o=;
	b=LlzfcOjychndMRCJjXRaUoIMpkcGOLmEDRPUfODJhTFSA6VI4nzgQbWjkXGFF7GZ
	0xKJ+ewCRzuGH5hl9f16bfoPtAPIhTljqHp5WCnnXUYM7lyScL/FxqRrypjWA3NshNm
	dOwfKtsIexgZMXUdpS5OT1roMCjOVdU1RpaaSPnM=
Received: by mx.zohomail.com with SMTPS id 1715353335881687.3687977555614;
	Fri, 10 May 2024 08:02:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] osxkeychain: lock for exclusive execution
From: Bo Anderson <mail@boanderson.me>
In-Reply-To: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
Date: Fri, 10 May 2024 16:02:03 +0100
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7A8539F-E33C-44F3-A7BF-5F5D4A26F2A4@boanderson.me>
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
To: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-ZohoMailClient: External

Interesting.

SecItemUpdate returning errSecDuplicateItem didn=E2=80=99t make sense to =
make sense to me so I had a check to see what scenario this happens and =
it appears to be a scenario where updating in-place fails but replacing =
it entirely succeeds. However it seems the item might have ultimately =
still been updated: =
https://github.com/apple-oss-distributions/Security/blob/0600e7bab30fbac3a=
dcafcb6c57d3981dc682304/OSX/libsecurity_keychain/lib/SecItem.cpp#L2398

The behaviour is a bit odd and the associated code comment referencing =
an Apple bug number is perhaps is indicative of that. I guess it perhaps =
makes sense if you are holding references, but that doesn=E2=80=99t =
apply to us.

I wonder if a fix here could be to treat errSecDuplicateItem as a =
successful operation for SecItemUpdate. Can you confirm the keychain =
item is successfully updated in that scenario?

A broader Git-wide question that you perhaps don=E2=80=99t know the =
answer to but someone else here might do is: why are we spamming updates =
to the credential helper? Every parallel fetch instance performing a =
store operation on the same host seems unexpected to me, particularly if =
there=E2=80=99s no actual changes.

Bo

> On 10 May 2024, at 09:07, Koji Nakamaru via GitGitGadget =
<gitgitgadget@gmail.com> wrote:
>=20
> From: Koji Nakamaru <koji.nakamaru@gree.net>
>=20
> Resolves "failed to store: -25299" when "fetch.parallel 0" is =
configured
> and there are many submodules.
>=20
> The error code -25299 (errSecDuplicateItem) may be returned by
> SecItemUpdate() in add_internet_password() if multiple instances of
> git-credential-osxkeychain run in parallel. This patch introduces an
> exclusive lock to serialize execution for avoiding this and other
> potential issues.
>=20
> Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
> ---
>    osxkeychain: lock for exclusive execution
>=20
> Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-1729%2FKojiNakamaru%2F=
feature%2Fosxkeychian_exlock-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-1729/KojiNakamaru/feature/osxkeychian_exlock-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1729
>=20
> contrib/credential/osxkeychain/git-credential-osxkeychain.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git =
a/contrib/credential/osxkeychain/git-credential-osxkeychain.c =
b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 6a40917b1ef..0884db48d0a 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -414,6 +414,9 @@ int main(int argc, const char **argv)
> if (!argv[1])
> die("%s", usage);
>=20
> + if (open(argv[0], O_RDONLY | O_EXLOCK) =3D=3D -1)
> + die("failed to lock %s", argv[0]);
> +
> read_credential();
>=20
> if (!strcmp(argv[1], "get"))
>=20
> base-commit: 0f3415f1f8478b05e64db11eb8aaa2915e48fef6
> --=20
> gitgitgadget

