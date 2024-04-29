Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191EB33C0
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424037; cv=none; b=UHny7teKBjPURJFLBabm7HnHtzGRhyXokzG+Rl+gAKIVootl0xgs3/ceFOCVgwqu199fodMa0iSsIjkmtfuSPFvlkRsUW+09Dp61sGNw4LO5r4yT78q3XIhmayT4Nr+9FN15SaHATHFkseEoMu96526kPzE8ie76eIgEuGQYqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424037; c=relaxed/simple;
	bh=o8gcEGhB3SDH4DuX/veBGv0kUEU0iXwQjOmraCtdSno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBX+B/hTVCjMGgAk2at6Y2eE9k6BX5k2GSSky7t31lyFm/k92tO5JXxXWxu4kllnTiZRh0Tgvbvb8T1pzEpns+cLGtfpZc9YCAwJvfvfOoVwKzhplkEtyhCdwVRweZtSpGX6N+W9cOKtJttYMRZ5j7th9PAGDrRodF6ElBRNzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=sJOI1ZAW; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="sJOI1ZAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714424032; x=1715028832; i=tboegi@web.de;
	bh=0vZWAiUJQQ4n2Tzl5rSU9WQ7dMHckVc7XLfptnv8GZs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sJOI1ZAW6BjqvfXA2ao88C+EkjNfHfq2YdjIfBJXizCvydrPbCBw/djiyBYcx0ms
	 h2pyViR9gb2aquysJ0r2t3cKBSlwWSN/b6IwADTcg73iLpKBXlJzUNEfJmw6Si0G+
	 DYEyqFEITavqzTaCknOrcuYSk8pqVqf40Lr+ud6DeO/MNnbmNHLX1XMSHfCGHNISn
	 pnwNMn3Mu3d15Sh2j7ocGVdISPHdaLwaro3j8PhyvOefXHCIMkR/eTWFrjr3OfO2s
	 g/vAqohamvFs1PWJwKwIuwIXX+CUDJOit0Vmoh5XpmNT4iJBH2ju0SjvJwUHpnCQh
	 9UBhWWMszXfqA2bouw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rTG-1s3jrs0IRs-002RB7; Mon, 29
 Apr 2024 22:53:52 +0200
Date: Mon, 29 Apr 2024 22:53:51 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Matheus Moreira via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Matheus Moreira <matheus.a.m.moreira@gmail.com>
Subject: Re: [PATCH 00/13] builtin: implement, document and test url-parse
Message-ID: <20240429205351.GA27257@tb-raspi4>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:6sc1uw+rBFgtjoZl7pSb7KO3/jqbUqGLJ0xyKGByRSphzUd/GOC
 MoGNn3mGMoRm0s/HWXi3ngP22KoO7g4Wk9X7Qn5zGw97fdqujIhb5uIZ/e2cExOLFdsXyFD
 ZSnVd67yuONGk6ylDmszycg/wTYhk3WBdjz550uNqihIuFoAY5U6cpM6Hs/TnbGhsKS3xqy
 9l3Mzw7pn1ibJZOb8iaHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OIHDsOsg+IM=;91lCOelQbwy7LAefWuFxNZndDqG
 9dVs/YVDrBS09VOKh7BbjVnuxMddgzbJq4mFMej/4HgR6EwDCvxl7gWfWrKCPN/W+R3x9n5Uz
 zOawpw+XiOU2hI0yJXg3gO3Hmu6GwXPiL8z2LSl0EkphizBEVRnECY30ISueZY0ViUb5fxtfo
 Nb2wAS/rvywgUkvWElV5BCNXCey9HBvCwgKSsF6bhKYra2YPpRrOX5vXXsKR7+3YNp2VVN7An
 mwVakd2oruc08PmMn83b58T9P2tw9mTyEGmio9i4OY4tgaN7UhU14opTg8+aStdmTEQRGXBNl
 LGZHU/WEiF5m3uW8/TTMXlq/oJMi+ximgDcMu+Et49x8j5K4OuWUQ+RSwqEwThl+lQj9zSK6W
 VHa0z6W6z2kyGx5RDqe9QHU+vl2kBlCLAlububscgwtcv1zEhdKygOBPyXAAZNHeLwv4xIpyb
 vPRLCJAXS1k6CEAEkPGiDB/dS6pXISfHPgFAQ1o05txxXo16JvLp3egbUVQhbKu4ezWsv076v
 mJP6VoA0n+id/AnMvkaD0eSVcCK9oPyZ091xrt+RAta8F6Bme2m/DHrONqFDo3ottsG7BeIPP
 RfJ4FqK93bAVY2Ksc4yoSI1sR/gHW96CQvqpTM0z9T1YPvaqCNP1i2WnVElWfIJnCk8WWhqKM
 HBNgwNrBueFhH5/yKDnbU4/NLAFIgnZLdQiJmD26mX5/qIOBzkPoW/XCLJn8FUohXWDXkd0yv
 2veFZFW1Psc097hxRR+x+iiOCZHLyMV05ss9Y0MISF1ah7gKKekwphFYYnyIA4EmHopufaZUY
 Nt9w53Z0853U9mBNikr0eJX4rRwf9bt/LnbSXfE2xXaPw=
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 10:30:48PM +0000, Matheus Moreira via GitGitGadget=
 wrote:
> Git commands accept a wide variety of URLs syntaxes, not just standard U=
RLs.
> This can make parsing git URLs difficult since standard URL parsers cann=
ot
> be used. Even if an external parser were implemented, it would have to t=
rack
> git's development closely in case support for any new URL schemes are ad=
ded.
>
> These patches introduce a new url-parse builtin command that exposes git=
's
> native URL parsing algorithms as a plumbing command, allowing other prog=
rams
> to then call upon git itself to parse the git URLs and their components.
>
> This should be quite useful for scripts. For example, a script might wan=
t to
> add remotes to repositories, naming them according to the domain name wh=
ere
> the repository is hosted. This new builtin allows it to parse the git UR=
L
> and extract its host name which can then be used as input for other
> operations. This would be difficult to implement otherwise due to git's
> support for scp style URLs.
>

All in all, having a URL parser as such is a good thing, thanks for workin=
g
on that.

There are, however, some notes and questions, up for discussion:

- are there any plans to integrate the parser into connect.c and fetch ?
  Speaking as a person, who manage to break the parsing of URLs once,
  with the good intention to improve things, I need to learn that
  test cases are important.
  Some work can be seen in t5601-clone.sh
  Especially, when dealing with literal IPv6 addresses, the ones with []
  and the simplified ssh syntax 'myhost:src' are interesting to test.
  Git itself strives to be RFC compliant when parsing URLs, but
  we do not fully guarantee to be "fully certified".
  And some features using the [] syntax to embedd a port number
  inside the simplified ssh syntax had not been documented,
  but used in practise, and are now part of the test suite.
  See "[myhost:123]:src" in t5601

- Or is this new tool just a helper, to verify "good" URL's,
  and not accepting our legacy parser quirks ?
  Then we still should see some IPv6 tests ?
  Or may be not, as we prefer hostnames these days ?

- One minor comment:
  in 02/13 we read:
        +enum protocol {
        +       PROTO_UNKNOWN =3D 0,
        +       PROTO_LOCAL,
        +       PROTO_FILE,
        +       PROTO_SSH,
        +       PROTO_GIT,
  The RFC 1738 uses the term "scheme" here, and using the very generic
  term "protocol" may lead to name clashes later.
  Would something like "git_scheme" or so be better ?

- One minor comment:
   In 13/13 we read:
        +       git url-parse "file:///" &&
        +       git url-parse "file://"

  I think that the "///" version is superflous, it should already
  be covered by the "//" version

