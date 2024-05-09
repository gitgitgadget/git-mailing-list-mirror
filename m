Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F87175A4
	for <git@vger.kernel.org>; Thu,  9 May 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275765; cv=none; b=C+2K/CFroqcPV08n5SP65AkAMbzEPdUGz/rrr+wdn0G9DfuCdF3He8wYch8lYrU020MuCUL6ZjkVMZqUyMlr4FK5y5Dx8pL7nVnVFxzdmw6rrS7WM6Gg1cZZ/hD8zbsw55jDXlHa+UZT9pOBsYkLr60ByLO+n5sKXsDyzJglUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275765; c=relaxed/simple;
	bh=6zC2F9o47dBQIJ5VWjnqMIEkvpbhT9jeYwX5J8UZ7Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3qVTpprkLVTwnBEYnNq37uj1vc8xZKZM6G6fu/yjJYCjpXPHpWXRJJxSW97t3RGsjGLbL68i6V6szDdePNlenfP85WmpPHY1JBvFitEgW+ZYJwF33T+aI5Kc6V9MpQQHmLPymMUpvd44W8XAUlZeff/YiKtAnvJuTegJawVkqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:941e:d1e1:dccf:27d2])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 8DEC013F880;
	Thu,  9 May 2024 19:29:18 +0200 (CEST)
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
Date: Thu, 09 May 2024 19:29:18 +0200
Message-ID: <3886895.kQq0lBPeGt@cayenne>
In-Reply-To:
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
References:
 <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hello,

On Monday, 29 April 2024 15:41:28 CEST Patrick Steinhardt wrote:
> ---
>  Documentation/glossary-content.txt | 36 ++++++++++++++++++------------
>  refs.c                             |  2 ++
>  t/t6302-for-each-ref-filter.sh     | 17 ++++++++++++++
>  3 files changed, 41 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-
content.txt
> index d71b199955..4275918fa0 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -497,20 +497,28 @@ exclude;;
=2E..
> +
> + - "`AUTO_MERGE`"
> +
> + - "`BISECT_EXPECTED_REV`"
> +
> + - "`NOTES_MERGE_PARTIAL`"
> +
> + - "`NOTES_MERGE_REF`"
> +
> + - "`MERGE_AUTOSTASH`"

Quoting the names seems overkill here, as they are already formatted with t=
he=20
back-quotes. The rendering as bold or monospace is enough.

Regards,

Jean-No=EBl




