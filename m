Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810F19D06A
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653829; cv=none; b=O4AQ5rwWDvhNY57aHGbV40Dm5x6bFOcZ43pOLROq9S16q6F4LrFSzKOfhujfIk4Zf66rrw502PTXjNUxaRNkezl2CY1GicllsLjvoKzB0kLThOkrymjah9ZaISBj87cQtyqWAj7dan8seMXmRrRVwfujtm4aYkLmJEkp7KtaYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653829; c=relaxed/simple;
	bh=eioYxrW3IYGdlIb0t7B7PwezIfFdDlhwVIHdaOwuqxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWZR0538M2+7GzkrZ4N12JK977EU7VUI/xtBVwLRj6p+Ol3sFuL89feWeXKW+VHT2XcOfuYstgDq6TuQlfhBcaTGdCxOjjPulE8/2KlJJwI5N7RfnBnLhM6yFXgX4/sREUDh6fhfh9w4oaSQQ6O4dVhARQ1uX3TnuPvDdFRYSuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=NZVakIFG; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="NZVakIFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744653819; x=1745258619; i=tboegi@web.de;
	bh=HaMplDlW1faCopmIVUHihCZFqVJW2mFasPIXlDHMJuU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NZVakIFGQXL5kwvoajG7dNaU3VSENKzZAXkOYIYqt34p+acKyCCDbpOZSCOnMXyS
	 QPaRecI7Rsg7oG6FoIrLYwW4lGGhhS/qCP2y+m1g9AFaw3x/37Lo1wnLz5GTyayvE
	 zSFtCBAgw/A2wdMtHA/wC2V9c9MjRGtPJZzDNtyXmPv84Q/JIDHi7Zki+/4CkRGV+
	 e0nemvOE4MjhdIb7dKshssgjhO3I+g6CqHpq89raUx1AM1G7UfrLm13/fetekWeqW
	 zT1ZmnVz4sf1zIGreD30aSz4fxT72h4yj29hSFqgxNWPLBSbI9p/+KJmRUaD3Azir
	 zoBnL32Zy9ijR4zohw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28SL-1u1u780FJp-009sNH; Mon, 14
 Apr 2025 20:03:39 +0200
Date: Mon, 14 Apr 2025 20:03:38 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: messester <cnotsomark@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Potential bug: Git instantly converts utf-8-bom to utf-8
Message-ID: <20250414180338.GA2398@tb-raspi4>
References: <DM6PR12MB386578E1F28B532600ADF575F7B32@DM6PR12MB3865.namprd12.prod.outlook.com>
 <A743D2B5-0397-4AF3-899B-FC3D3AD2B5CB@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A743D2B5-0397-4AF3-899B-FC3D3AD2B5CB@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:/Cb3+Ec3fZW282ZZIvPni/q1LUdka6WMnd5iSpoQ4npoyIBBOI/
 erZjSEbEJWGEjxfmjanBr9CuujFdCu3lFN4dmfcudUmMEVUXObwWhMiAyoYDBTn2oervTz3
 LU3gOySl13U1K0v7daQV/616DK6RvAt12jdWh/FGXU0CqMu/lYA3gOP3ae4FcVEdTuL+wUM
 bxjXAk7aZLBMe838tP6hA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GcmLbW4pGsQ=;FHvkRx7gWe7RJ9G0x2WGYb7N4qb
 9KZ07nAslKB9Dy5i65KDIJ+hPletFJ05a5M4adH8aBAEZEYRhDoJc+MOGS2jd5NdaMDFZKWkK
 yLwbfoPhmgQjeUjJ9lyG+DbBoUK5iENSOW1SVk+dDWGl0RoBoxKpuht5qdcfvVxZhGCL6VcND
 7i6iT+EvzXDWsZa4CioGl87j4LiEYBgf2Do9WHPHTwoRzFC4q6YDK0dpfWfTihhrMPUItlnSm
 qUQGfbUj2afbHHoJBX4yxJC0Luz5ZDG2omYRGP9oRKIyTUmj17ACnmcJwY8bEhq6iz3H+NoHa
 Cv+jXRG3hcP22/4ga1+fmGXsPkID2JC+TXu9ahyME0cdy67oW8qRtyPF2DjH6xXJnrIRl6/nl
 p9bVeHMnKiRzCrU+pcdwoIYLGA4T/ihSRZrlcJAXvTayppoIZz5V1ymVQOdKfHofb25lyIcYa
 5to8svOB0lmW0bQBxYWsEciAY54Ud+eGUdnsuQSMYv6Yg4HRDv4gmm1myvebsT71zbxL7/80b
 nVj1tSnIQLPZ1zRvhgqSb//WeP68LAl+qNNoJ1LglsxgK95GNbQDvMzEMCuUD1LMnEsQO4dQe
 fjo4smsyFiYOOkq0NAEKs2HZWU5eMgyhNr7Wge1qUKyqfRCnwvoAmo6uawzACO32XpcIgy9BX
 B+1mFXBMzjL66TCT+xpnkf2tKAC2GltXyixGShFrIvDxpT21eE2TdHDhT8uXbbAZ5xQIsDdy1
 dUBwTcXqwICHKpPGi5jABFFeBkt9/JANtV2oX5XoxsQRstBgkq/2YIHfuDsnOlpZiHy6HC4OL
 MU4QvLqTqgjHQWwUoqzLTIoyShXzvG22zUKXRcg3DxblVcf7UrM7T9YLgxa3quBpL+6gJgzYA
 kDFSo7Q0z4tuyiDQ8zPjhGw1Gw1yyRqQE0kZu8Y0QKB7rJYjlTDIMYKeCfWkrUq3GrJqPv06B
 u5+el6MRsip1R46MM9WaB+UCsKqe6b2leC/OS2LhyDYClbaMubrlSzyZAxY1Xl6diEIBwg8U7
 j7nbciQz6IRaYku/VhCnVSR2XaeiK7h762oVWfUXfs2w4VcLMEaLjsahLs92SYT7eXJMDrg3i
 E623Z9ZWCORLULabpSE4E8SJh/rAS2531OeaGkzaHzC1CgEADRUne3fhAT410y0bljL3JgGn+
 2P2ZXdDH7KfJrWesM4ddzG85XvviZspfwu5HN39VFfD/tceQxTUQbapymRov9st1+nOxyKcn8
 UAsBXDlW8yzsPFLi7EBeZGdHdd9hSJqCG7aImojRnCpdcoTNyOVJXUaX/irIpBBgz1fG1R8vv
 0LiH7lKNgiIJo4B3Yg3wejYNPNWLj4uTpfeT4L++bB1gb7yrAqFkSsu2OsEfiZMZDZvDlo065
 JaeQV91RdO5LP5FU4qa8K6lCKMyGnc5SDKKBCyTzeEWrWrb1x4xEi/DBqFnfkl9Kangh7Z+yg
 GqRZQzDEsXdu//h7S9za8vThuPudTeOkuUHdnYWnmSEF5Xhti
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 02:19:05PM -0300, Lucas Seiki Oshiro wrote:
>
> > When I clone the git repository https://github.com/NinekoTheCat/infini=
lore.cs.git into an empty directory and run git status it shows changes wh=
ere all the files are deleted and then added again.
>
> I tried here. I'm in a Mac, it shows that several file changes.
>
> > The difference seems to be in the first line as opening it in a text e=
ditor aware of encodings shows the change from utf-8-bom to utf-8.
>
> Given the warning messages it looks like it is more related
> to CRLF/LF than to UTF-8.
>
> At least here, for example, the listed modified '*.cs' files
> are the ones that ends their lines in CRLF. This is, running:
>
> ```
> file $(git ls-files '*.cs') | grep CRLF | cut -d ':' -f1 | sort
> ```
>
> shows me the same files as
>
> ```
> git status '*.cs'
> ```
>
> You can also see that are some '*.cs' files that are not
> CRLF-terminated by running:
>
> ```
> file $(git ls-files '*.cs') | grep -v CRLF | sort
> ```
>
> > I'd be very very grateful if anyone could explain what's going on and =
have a solution.<patch.cat>
>
> Perhaps a solution is:
>
> - Define a CRLF or LF as a standard
> - Convert all the files that don't follow the standard that you
>   have chosen to the one that you have chosen
> - Declare it in the .gitattributes file
>
> Hope that it helps you!

I think that this is already done :-)
However, the repo must be normalized:

git add --renormalize .

will do that.

