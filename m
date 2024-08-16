Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5D15B12C
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809545; cv=none; b=qDnQMMXkfb5eLL7tJ5TzirWqYDfhaTZ+L1gqdvVcC9EhGOWg7xIVVeWYj+BSmUCpvC+56QwD6L0jUBOkQoOL4VBd81moaZXYaJCsbwNnGwt3RXxc90+QLEXs4OT9zP3Vf4Wg1TxAF1d8bhD5bQiPO83mQD9ecA0lQBwLzLLynz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809545; c=relaxed/simple;
	bh=FBjDcoqAwKHRu4o5bySuE2DUXql6hpOsGqa/Sty6gt0=;
	h=MIME-version:Content-type:Date:Message-id:Subject:To:From; b=k3giF07IQMUwvy52l/2l/CkZRlEJjdRZY1QpuK11a/z2TUJDgNgPp6vFntd/ehZsUkFtZRY2S9yaEKFjn6oMdHcNPEgGbrRproItU9vjwFwl9d/W/jS6XRDx29TNFXeN4bMKhjb01ID6GvqneNBKPVCs9QPB9QjrxrweUrWpmeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=gHvea0H6; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="gHvea0H6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=yHlrwHcP0cNpNYbCvjvYdkHec/WJBynYaRVV26zxmS4=;
 b=gHvea0H6B+O7FMYVKylDKIQYJL+wvPrToi5Q6t1jq6nr/0Hh59R8PaTFB9ewNCSQviiR+ZPsjXXj
   7z+mEeyDOlAYKBy26OKygMNXfVtrYL8KvYSdxgf53L0X6OO3jY/85YQIHAnQ0DGvlOLDduV69n5j
   ZtxsIMWu1M5AxA4KQPOTUWDsm3hSPIr6JVENewvdRNBscLE8vAbKDiv344JD3ea/ngiC/f4B4XBq
   wSRofluyfuDo3eRB9TD13qRL24Ewfbd+++juskD56/TTfrG6C3PHdS38/HLe1nR1kjMmrrT/ZXHV
   aiog6Zx3/IX5GyNNUejdTU3TZIciUyYmEFr1Rg==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SIB0000E7PUS740@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 16 Aug 2024 11:53:54 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 16 Aug 2024 13:53:31 +0200
Message-id: <D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com>
Subject: feature request: set remote/HEAD with fetch
To: <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Reporting-Meta:
 AAFBS0Ub6PNARJdr8lDFS1BNWQ24PXmvTIAfOMnJc0qUNWUwavMKyNCQUgaspVdw
 i53z7wllH64LuENmNztODVKX8x6P9anSihFgSRpd7RGbm0spUmBPBHnrNzOl2Fc4
 eX1aIK8b1pvG9OKVMINVPXPyNUqv2FUVY1uSsV2tUpaOXlwqkFHckYoRkJW3QRuG
 LQ2MuQplotg+47Ru44wHc/LHXef2UdtLN+zXhP2uV8SufYXdfx4VPKTIR+qJjIo6
 Q688MMDecTVyJWvolM+yjXi78nifjystPAxSqrc3PBywcXnr2EmmI9fxUggOOdw+
 5MFDQ83mSoA/AKIcYr8gtlKsUt3Le4R0V5xRnw2//CpQT4V51m2s6WPh86yqS8VN
 bVEOaG1zHtsYKOgUs+GydG64fYq6nbo1OGP8oW8b98MUr7k8DoXyOcLuw8rEOBbL
 3Xcy6DeAx9KV/c1tjWUjBAlVBeuYWqVSeVZ/LbVvXtYl92+66rWkTA30

Hi,

this comes after a bit of discussion on #git. The current behaviour of git =
is
that when cloning, `refs/remotes/[remote]/HEAD` is set, but if you use `git
init` and `git remote add`, then you must manually run `git remote set-head=
 -a`
to arrive at the same state. Having origin/HEAD set is pretty useful for
scripting and aliases, because you don't need to remember what the current
project uses (origin/[master|main|trunk|etc]).

I would propose that running `git fetch` should also update remote/HEAD. In
case there is a possibility that it is useful in some cases that remote/HEA=
D is
actually different from whatever is set in the remote repository as the def=
ault
branch, I think a setting for opt-out would be better, and the default
behaviour should be essentially always running `set-head -a`.

My current workaround is an alias:
    fetchall =3D !git fetch --all && git remote | xargs -i git remote set-h=
ead -a {}

which works for me, but I think it would be more elegant not to have to do =
this.

A slight aside: if `refs/remotes/[remote]/HEAD` is set you still might have
a problem of easily accessing the current remote's HEAD, since @{upstream} =
will
point to the branch. It's again not something you can't script around, but
would be cool if there were an easy way of avoiding hardcoded "origin" in
aliases and scripts.

Thanks for considering!

Best,
Bence
