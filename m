Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889520E032
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596288; cv=none; b=GUUhnpsxUgSxUaxtFezafZT+ee+zQnwbVsuK83q2TP1PJmbq3qjIUCVxCuHbioP/6eZkz0cx2kXpCvbu6NiJm+w9UvWpfwJNscKww4uxDv4UkN9gRG2eC71u7qrtZ406jbIyH0UnsbDwookyCiyzs1yV7ykNeealQIqTMfXdHbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596288; c=relaxed/simple;
	bh=aZT6oR0kAfGJsGyl/PNaO+3xj5yY38SAvD3jdZHGxIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvODVkn/5Nc/q1OQotDi/fQyjlOnIhYc/g5DiztBRcpZhhtQ+T3554Hf7bXdw+XCW2R+2MiY/mYI/L04cn2rGhdz6NqyUFwg0UKGhD/sm9PFBFAM3X9JNbv60skl0kjN9487SmZ3d/BmTtlLZuN5RLCJe/jSAy3qjpHrCDBrGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=X3XTdngg; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="X3XTdngg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754596278; x=1755201078; i=l.s.r@web.de;
	bh=6VcR1x1znpALw82vux/uMPS6lH0SqQHtD2kXxk/X0o4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X3XTdnggRUrZAEVkFC7NUw+NreB73iY4mgZLWFz+kPVp6oWGhBWNHyXaWQ0ahpMt
	 K0FlwtnJFUVRwHexDM0wHvyi7bScaMIkQdaH9VCwlMKrSZGbrenPGrsLqyBTliR7j
	 jWdJpmIviINwR8Sxlef+SmTdM6GBuaa/p0lRVHDrE8r6U603wPpC/lfZhiS8QxC/Y
	 FMZQCp0HARcDBYv5rTBuUUloboXXAP5/O2cBJ7u3UKe4QzxaB6zoZLigplvd5Qm73
	 Th4Nsc7IXFeNe4rVCLmtE1z8ttR2fD02gTjBZHT4R6MiJXhuUeTRlYhypEbS0hckT
	 TTai6VPZAuyC/yd+Sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7aV-1vBzaL0daR-00P900; Thu, 07
 Aug 2025 21:51:18 +0200
Message-ID: <7650da07-dd89-4e79-ac81-1c99f4700d9e@web.de>
Date: Thu, 7 Aug 2025 21:51:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] archive-zip: remove unneccesarry condition in
 write_zip_entry()
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
References: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
 <20250804-toon-archive-zip-fix-v1-2-ca89858e5eaa@iotcl.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250804-toon-archive-zip-fix-v1-2-ca89858e5eaa@iotcl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1W41Me1vXSlurdDnasZWtKXskPcN2XvNIRfKaTiA7sfczt4+M6G
 osQMRfHolXj39dTVJQ+WbuUqotzDBIhwpEGaFjAMPSDXATDU1c6ztjf4WaNvhfESP6MmrU8
 qeCt7rn8WDLZDgc/lWq/r/lc4YVK1jYXENJx/gfjt8A/SkJJKLU2YaRrP/9qSSXl6FYrZr9
 y6Ai2kHyXAT+lvywHUisQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7DAF6dP8j7E=;7M+UZMZRTo8zm+X1tk9epMmWgz+
 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

On 8/4/25 6:56 PM, Toon Claes wrote:
> The function write_or_die() can handle a length that's zero, thus we can
> remove the condition that checks the value of `out_len` that surrounds
> this call. The value shall never be negative as this would have caused
> data being omitted in the deflated output.
>=20
> Co-authored-by: Justin Tobler <jltobler@gmail.com>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  archive-zip.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/archive-zip.c b/archive-zip.c
> index cc6d0cadd9..d41a12de5f 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -478,11 +478,8 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
>  				die(_("deflate error (%d)"), result);
>  			out_len =3D zstream.next_out - compressed;
> =20
> -			if (out_len > 0) {
> -				write_or_die(1, compressed, out_len);
> -				compressed_size +=3D out_len;
> -			}
> -
> +			write_or_die(1, compressed, out_len);
> +			compressed_size +=3D out_len;
>  		}
>  		close_istream(stream);
>  		if (readlen)
>=20

OK, less lines again, great!  write_or_die() handles out_len =3D=3D 0
just fine; this won't increase the number of syscalls we make.

Ren=C3=A9

