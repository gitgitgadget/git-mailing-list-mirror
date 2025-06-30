Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E92475CB
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281425; cv=pass; b=JwCnq7yhKGwXYeqs/qzlD3d23IyAHl1ptEnZM9bfATylfBFHJ+ceymF9gzeBNKaSj9uSH2KSYGiNKPZaiq8wKefJs1Z4j3YADIsPVpvQg+VtRvqnCCd4O1pypPEQCkKE88jLhMCzEdBqvW/sZXVhrnmmORvSg63gsal6FzyKnAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281425; c=relaxed/simple;
	bh=/6X5b9ydMaPr4zPHlP3JVSVLHYU97rXNZfJcOByZuTM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=gYRoDDw4Gb/7MFki9ooCD81Le9TgimV6zk7tedlRIzL53EuE6xxOOGYA9wJ0nHipb7bOLPC4oJQL0jQkbnoCMo3N9CpHbhAegZFooK/82WPoLeTCYdZ5Rz8qj8VX+aW4DI3i1K3UM2Q0+UzbGeNuTKEA8cpr8P5XyoLSlcV2Lz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=kCIu2lqv; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=6f9KOkhX; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="kCIu2lqv";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="6f9KOkhX"
ARC-Seal: i=1; a=rsa-sha256; t=1751279020; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OLziQWq/k3dHE1xocUUdtWuIWEd+DgakAgd2jx12wAv0/amUACe/8m2fcaWgYjuVgB
    xihCL2FwZpjpmyptHlBBK2A1I6w1ID5QixRwHo/3xT7Hn/oDCKVMeyhibQKyUyZP7QdK
    WJBQ9B+1HR/S2AFM0S5orw3uA/VxtLBvAXsy8mOWszy22/i9sallokQzW+s3n5z81rRz
    GA7nrWgTg+q2Oiui4HNIQAjJLYrriteWYTyN8m8GZ6iEfuZ3nqzGo6MVAaOhqV1dyyB3
    ZCS6TBO8MGm+iHo5Sq+FGinwGRRaSIZdfdJ4kelawY0tXogep2ZpKK/Ozmgt9FD2vYH3
    jcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751279020;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=/6X5b9ydMaPr4zPHlP3JVSVLHYU97rXNZfJcOByZuTM=;
    b=JYygoQVaYt+vOkZ9Ulg7rzmeynm5ukY+wB7ALFUecScIWHrkYQeprRLOrhd/jngmWg
    VYkVobs5RVW09J/NiGVhwPEGY6+bY3+DXgZR2uAGyoSje4zstqi3L7nEkjrotP9Bow6h
    ZyNSUxc8czAw6CHNXmU+HlPfqOuYlbrjv2AIrsJDd1V5G5wpljeF9Z3cZrZZBiEVxwLD
    qMH9VZRiqB9mD6tSU6jAziwd1sBjQ6lpnRjf6JWMY6yg/yZve3jdfxS0wcM99x8UoAhc
    euNXALE5uwcP/bZpry7f1Z0byNgkXZBZ92zHOHUtloJppNW1U2ZIN8EFp8iJQOfblSDC
    AJGQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751279020;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=/6X5b9ydMaPr4zPHlP3JVSVLHYU97rXNZfJcOByZuTM=;
    b=kCIu2lqvuzwXftSBZiDuRzugoIuBYttwPVPECw8OZIFYiXzSAytdrxd3NyOAx2BeqD
    Jcd3TtEkxuIcRmYRdLjzrOJmKF1TRLIFtTjCOZzC3rEHgm/36Kn0jXqyxazqW5+qe6UW
    J7HQGxEufpILQwuaGfeLV4vhoXYOawcekLsKHb24TFnIKnG+jUdWMLxslNFdr+56gdEn
    uImOvKqTJevS5/jX2e9N2oovUBB/An7XSn32B+qskQgX0sbVo0dvGa+JYEgTLDkDj1Ot
    7Y61z4L6O6iKCmfLj3388TxfSoGVgefSC8a9n2BK1HJqS8Z/Z67xcVWzL5C1ccwXKV6C
    SnhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751279020;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=/6X5b9ydMaPr4zPHlP3JVSVLHYU97rXNZfJcOByZuTM=;
    b=6f9KOkhXqcY4UW0nc1/4aXYmKNilfUjaSyQ6nHRktfbG1j5QLxR9aHOxSuMAwH5+o5
    RQ7NTG++ZkxDAGUhsCAw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmzGoJ8rBK6cWAVfDMmnI2IZ8kj8s0jE6n+P5L1"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D2e95d15UANeDaY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <git@vger.kernel.org>;
    Mon, 30 Jun 2025 12:23:40 +0200 (CEST)
Date: Mon, 30 Jun 2025 12:23:32 +0200
From: Olaf Hering <olaf@aepfle.de>
To: git@vger.kernel.org
Subject: changed output in git branch -a
Message-ID: <20250630121839.6252d9d9.olaf@aepfle.de>
X-Mailer: Claws Mail (olh) 20250514T101025.84a10d9e hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oiq44wBgACqEsP8tbXtY7j0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/oiq44wBgACqEsP8tbXtY7j0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,

my dumb script parses the output of "git --git-dir=3Dsome/dir/.git branch -=
a".
With git 2.43 it gets the expected list of "remote/branch".
With git 2.50 it also gets something like "remote/HEAD -> remote/branch".

The newer version runs on a different system. It might be that the reposito=
ry
was already cloned with a different format. For some reason it does have
.git/refs/remotes/${remote}/HEAD, but the system with the older git lacks
that entry.

Is there a way to suppress such lines, or do I need to filter them manually?
There is no obvious knob mentioned in git-branch(1).


Thanks,
Olaf

--Sig_/oiq44wBgACqEsP8tbXtY7j0
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmhiZaQACgkQ86SN7mm1
DoBXkg//d48hibhcjk8ICzAEp/hZbuR1P2yVzk6ppLDfzmf/9XLN60W9YqmkdQ1O
+J2WNmcTlCr33EiIRTDQ4Oovrwr/Y5n5fpaQqMEtg+u+4GL6EeKjtk2iv304ukCm
kEksSGAspN9mFX6h0Jefx+uE6OaP0WD6EKlUBFpvS/gix/PTd40GNwAxYcDhlTcU
CBPPd8A68W08DHNsOVPB8oKDHHFYm0EmU/zU8HXZlti1N3YjYuyqdjSj8KauVHO7
XeBq1thgp8SNevp2H7stwQ2Ll6jQNqiGBxhmBFBoVmpnaWlwPQAi8ru5E/gxIshP
B1lyxAxv3dGK5gJ5N/uvhDnnPDbdZFoefiNL5CV+ZUBmkO84/g09e4kIM89yPxsg
FZAyD7NfH7AZH7BPlOl7PaGxu5BdlYkvUsbTaxVqDGv5PuSTfWS+b0fMvlzaomBm
B9IUtcPpjM0hAegeRi5HUlQbZvbsKZOS1Z/XRWgKmMC8arH4jWNvxalUeNhLzGJP
4kmuDlQreOa1V8xCgSZFR7hygeSErwcCZlKfYtqKCUd3E87iQFPjcAHRkU3tbLD7
aFToQwqocNFFZfoch/UnayzBWDP4wRwj5wsJfJ2pDK0F0DUs0GrgnnnLueAt99Pl
urq3LzDBtqVpI4LHEE09bhEd2e6VrbTJEr6SL8vqUX8K2P9IBcM=
=RQ4J
-----END PGP SIGNATURE-----

--Sig_/oiq44wBgACqEsP8tbXtY7j0--
