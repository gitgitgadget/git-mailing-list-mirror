Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735FE2208E
	for <git@vger.kernel.org>; Thu,  2 May 2024 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714683090; cv=none; b=UOpKMlvChftE/ZgrbOT/eSsD7AP5aSvoCwhesUZpjrEmJ01iCTf9DqRd5SOITkO5LBJSWXhJhjVvgwxLvFmzm5d2HdrwpxmFbndl/dvICtaAJtcr3gO3Jo1AAhievPCyUiqjontgxlfSNwIGZ4TFvzpDqnGBmhStfxYbPBwPq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714683090; c=relaxed/simple;
	bh=NMi3GvZDDfyKAOrG9W0h/1ZCW2kB3lcN+F61Dlyc6mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF75UUr3kqA1rVL0x+q83PzmGAlXDIpQ72rQ9xelS9fkhEJvTQ4TKMdyn5yVeaklssDD97xwqLPJBwgCpkRgBaR+w5M/VtpBcDBxbGJ5jyxEzbcK2XvLdooIsHaZ3yICNZqqhRj7peTdr7+obhNwM75WlxNf5aa16Pgzm1IwD1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=SX6tceGv; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="SX6tceGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714683082; x=1715287882; i=tboegi@web.de;
	bh=Cf6lhN05T7ygoArJyNT+gFUG6AuJzeM0UXPHx2JnD5w=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SX6tceGv07q/F3hy9GtLU4fPzh3a4rx4DgswdR8oPi7koXMErQua6X19A9zkU5V+
	 /1qVRxz02W4HfGtY3Wat0Pei764i4n+wmQtbpOpoyVV1tx8FLXaM0m6t1rO3VB5Ya
	 yUxdESYguXK/de+Cik04f7UPV7IM6FkRRKtD/JzLbd8X4OXkAowr5FzQgCbdEJMXp
	 srD2UzKvqfnJqpdKZu2WYi39EQEJlMkM9UyYtrWzrtYwAHbcdTX8lQGWtOSKv9/g5
	 OD1/JEfiICOcH3w4x2l4jYrNzW8grGho4mNhvmgovNsxYaD0CoL1SkNVjiAZIMJrB
	 rihDE7U23pHMv+kMkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N45xt-1sk7HX2eLx-00zzWN; Thu, 02
 May 2024 22:51:22 +0200
Date: Thu, 2 May 2024 22:51:21 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	git@vger.kernel.org
Subject: Re: t4216-log-bloom.sh broken ?
Message-ID: <20240502205121.GB11895@tb-raspi4>
References: <xmqq8r0ww0sj.fsf@gitster.g>
 <20240502055621.GA29945@tb-raspi4>
 <xmqqsez0fbam.fsf@gitster.g>
 <20240502185903.GA11895@tb-raspi4>
 <20240502192622.GA1841@szeder.dev>
 <xmqq7cgcdm4f.fsf@gitster.g>
 <xmqqsez0c6ma.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsez0c6ma.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:3k/tM6n1wOxRppHwI5b4rGb2Bs3vgz3EpMSUIwzosmbvYteLWVF
 wVD2EuKuY4dmqfud2RrzoG1xW27vj4tg11ti7qSJO6uGmNxlDSmHLkkH2oC6Lghhkbb6ou+
 hhjGVUyEyanQ7A7G7i/kTIh7KvdFa9v1RCY/+0A8POxnF2nAi1V9KSdOM+uRjUG7USNxy7T
 H8jbXk0ll3iU0H13Jn9Sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tbUt69MwwN8=;vJGya8ZUmhnEVhMDU8ff0njfK6C
 /23RM7EuWO4iYVapGId3HAfaXYQ+YRsrXMh333achKUGRaNSozisrtP1tEjp+qVjrkqT5I+/2
 +92DYv2gvoRUn5vn9jgecJG38c2OqplUGI54JrT541BYxqHEAMOa6ow4yOgvDmcRKibf4L0xV
 sBuFuF8AMZxAZtnvLP1yhIiUuOoWuaybovOvTmOlbngtfc1kvw4xdm3ExKqlPkTv31BwbeqCK
 JKy2ZnY+W8pLTc9u5A7j0jqXx8Eo0ExxxKcz8wrpA8jC/RE8zx28jSJuhbqKa6VkKSBEc7l2L
 8MEjIvjX14NQ/BqqZbqUV6C5Wpwyw8m1fnOuaX8GDRsPV50muI/RaERmc2Ln7aJhGg852vu0k
 QrUIbq3kbrcnqg/rrDiDq3GdtixSqS+diCgAMy3CM/Lh7E7EIYG94a5LnZqafOL9uzyhz+Umm
 gfOEIDSKLQKeGO4V4kH3yhodpm3l1tQDhfMkr9TDCXGg3qQFS8v/wQ0T0zkc+9YHyfsAWsC6D
 HEUQeLEHnMURtqmJ9tt6yNqC0mmNH0Eqx99x8EFzqC8VaPSgbhAQlwgGFRoFghrtjt9rlONiz
 OgizgKqnMC+hFCEfCTklcrKGyp6Vv31HCywijsGgZQrX7Eef33avzVx4Kuc5PUIqmqh94LAp/
 sJvuj2uWtZQBZWZXzaHYffKrSQuJ8ReBfe/zgAvaP6UVMEgOOe5i5d7dS5ovs1KfQz2rzSDIS
 8/heyzP7GvJqoW4OImuYCj5zcvQWFMEwy/ZpZQuazcGEdqZ7RKhYxq81CsfDVsj0YpQ2iF4S+
 FD7ebRSWAhWtvoGbliBOY0acXy53o/7JjOrVPzOR/L7Ag=
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 01:15:57PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I am curious what other differences Torsten will find out between
> > good macs and bad ones.  Perhaps we can narrow down the bad apples?
>
> So, "no, your 'mv' is broken" seems to be the answer to the question
> on the Subject line, and it is rather well-known, it seems.

[]

>  		"$@" <"$fn" >"$fn.tmp" &&
> -	mv "$fn.tmp" "$fn"
> +	# some vintages of macOS 'mv' fails to overwrite a read-only file.
> +	mv -f "$fn.tmp" "$fn"

Thanks folks for digging - the patch makes both test cases pass.
Some official information:

$ man mv

on the both machines says
[snip]
If the destination path does not have a mode which permits writing,
mv prompts the user for confirmation as specified for the -i option.

To summarize what I have at hand right now:
MacOs 11.7.10 fails t4216 and t5318, both pass under MacOs 13.6.6

But why doesn't `mv` not hang then ?

