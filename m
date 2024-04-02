Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD383CC3
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066010; cv=pass; b=ZEYyeiLoXz7MDsvz4XMjrNj/4xrd34d2RpO5jdtUxPVwiWNhUcVpjeOKbc4ki8zeWARFQBmVDSPqEJhw5NMdnrzJkURUXflF9hiKqfahIupdD9b8vCIzjbjKsCRZCs+QQejegJxXLpcFkIR2KNuM8WlRKc+Z9N8uwI2I1vLiA/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066010; c=relaxed/simple;
	bh=lfo/zO2eiLZO2nXvXQrOkUey0oUhM5mOrPGtwobg43I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SL8C0WTCgpwaJCbC+m4PmpPO9+TSa+oa2TsMxDoXjh4EhHF4EXVw1JiV6VpIQqoBrMQ3xnamdP5mPpmBJGPrzmwYHOufNa3L2KB8f8OsytftOETQAWljJsYVAQn4cWB7bu1IBEiep+FYRiN+KS8MupAKeAVSFSgtfdDz9ShFcuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boanderson.me; spf=pass smtp.mailfrom=boanderson.me; dkim=pass (1024-bit key) header.d=boanderson.me header.i=mail@boanderson.me header.b=RFIIRSMI; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boanderson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boanderson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=boanderson.me header.i=mail@boanderson.me header.b="RFIIRSMI"
ARC-Seal: i=1; a=rsa-sha256; t=1712065999; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DhJPzQnx7xBGk/owtJEpwAB9wrqH4ydAo9n0cg0rF10TIneXbnFfe431+lwV+UFA0H890MqqG4FcySkXsVhRdGHRcaS3u5U9/KRIr2Wwbw06he8ITDHe4HOph3VQlXOHuAkN2V9V7Oo4K4Q0PEnIyFNj2Gl9TRgyH++NvKP+iME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1712065999; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6sgQQcLcRMXqM2cIR2jKEfPc/5DKgTBf4m4NAgbxiJs=; 
	b=NwEUSOokju+FJRzGuwWmQH/t68+5M5aWdWoVXXDFj+icW5bIjDoxiW9pwiLuqvgOG+d0rYWcXph1hhsbj1JIIMLNLLok5PwMXMvkSl/I1x7ml9r1FGk2HpleB1SS5g3zryk4sPLXBEmS0HJACj3V6AdaI8W33g2yh1GZ8GmPdhQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=boanderson.me;
	spf=pass  smtp.mailfrom=mail@boanderson.me;
	dmarc=pass header.from=<mail@boanderson.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712065999;
	s=zoho; d=boanderson.me; i=mail@boanderson.me;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=6sgQQcLcRMXqM2cIR2jKEfPc/5DKgTBf4m4NAgbxiJs=;
	b=RFIIRSMIJfw21gr1ozO4LdoUxDJ1tjqMKkwlpmpld1wH4Wq8WYoh3dZrmwXkjY9I
	JB2dAKBYC+aftSjYwCF5UoRhV/YiQsq6UuFk5SC6FRYT6TzBo6k1dZGopSk0QMh8rdO
	661C53/yWLfWPKDcKx4OUtLyqQGzPKE56HCNCoHI=
Received: from smtpclient.apple (w-65.cust-u5093.ip.static.uno.uk.net [212.105.168.65]) by mx.zohomail.com
	with SMTPS id 1712065996946245.04260396798134; Tue, 2 Apr 2024 06:53:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 0/4] osxkeychain: bring in line with other credential
 helpers
From: Bo Anderson <mail@boanderson.me>
In-Reply-To: <CAFLLRpJZg3UhBRfihtjUsXcGSod4FhDCs8fD1k-=5SLnAdHeQw@mail.gmail.com>
Date: Tue, 2 Apr 2024 14:53:03 +0100
Cc: Jeff King <peff@peff.net>,
 M Hickford <mirth.hickford@gmail.com>,
 Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <98F1A6E9-4553-48BE-830C-8FDA9F3B5744@boanderson.me>
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
 <20240218204044.11365-1-mirth.hickford@gmail.com>
 <CFC1A507-A9EF-4330-8C98-34C2B73BC036@boanderson.me>
 <CAGJzqs=wQA=t4CMVu-kap1ga4DX+KnaVMGy71ewmZ7QkFHF8sg@mail.gmail.com>
 <20240307094708.GA2650063@coredump.intra.peff.net>
 <CAFLLRpJZg3UhBRfihtjUsXcGSod4FhDCs8fD1k-=5SLnAdHeQw@mail.gmail.com>
To: Robert Coup <robert.coup@koordinates.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-ZohoMailClient: External

The test script does not interact well with the env filtering. This was =
the case before this change too.

To interact with your default keychain, you will need:

GIT_TEST_CREDENTIAL_HELPER_SETUP=3D"export HOME=3D$HOME=E2=80=9D

This is because the default macOS user keychain is local to your home =
directory - that=E2=80=99s why it=E2=80=99s giving errors about not =
finding any.

Bo

> On 2 Apr 2024, at 14:21, Robert Coup <robert.coup@koordinates.com> =
wrote:
>=20
> Hi all,
>=20
>> All that said, I'd be surprised if testing osxkeychain in the CI
>> environment worked. Back when I worked on it in 2011, I found that I =
had
>> to actually run the tests in a local terminal; even a remote ssh =
login
>> could not access the keychain. It's possible that things have changed
>> since then, though, or perhaps I was imply ignorant of how to =
configure
>> things correctly.
>=20
> I have gotten keychain working in Github Actions before: there's some
> helpers for it, but you can also basically do it manually via the
> steps from [1]. Basically anyone who needs to do Apple code-signing in
> CI has to make it work.
>=20
> @Bo, how are you actually testing this manually? Following these =
steps:
>=20
> $ make
> $ (cd contrib/credential/osxkeychain && make)
> $ ln -s contrib/credential/osxkeychain/git-credential-osxkeychain .
> $ cd t
> $ make GIT_TEST_CREDENTIAL_HELPER=3Dosxkeychain =
t0303-credential-external.sh
>=20
> I get 'A keychain cannot be found to store "store-user".' in a popup
> dialog when #2 runs; then similar for other tests in 0303. For #14 I
> get a slight alternative with "A keychain cannot be found". There's a
> "Reset To Defaults" button, but that wipes everything. AFAIK I have a
> relatively normal setup, with a login keychain as default. macOS
> 14.3.1; arm64.
>=20
> $ security list-keychains
>    "/Users/rc/Library/Keychains/login.keychain-db"
>    "/Library/Keychains/System.keychain"
> $ security default-keychain
>    "/Users/rc/Library/Keychains/login.keychain-db"
> $ security unlock-keychain
> password to unlock default: ...
>=20
> I don't see any settings or code for setting which keychain the
> credential helper uses, so I guess it's the default one?
>=20
> Cheers,
>=20
> Rob :)
>=20
> [1] =
https://docs.github.com/en/actions/deployment/deploying-xcode-applications=
/installing-an-apple-certificate-on-macos-runners-for-xcode-development

