Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59E2AD11
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297699; cv=none; b=rGoL5X8tzrYb9UPAio3gs/KHD/tiU4BPW4TrxpnHL3SAmSzSAZUBv3G1jHKHytJd9ZEQEsUbWa/EOyTRyS3udpWICFxEH5tLI/V3nYkGpptm1vrUVflovhvTvL0Rf3NeEkgcRfEykLVOw8wviCkT24VdrSt/0bGusg+s18NeazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297699; c=relaxed/simple;
	bh=mVWStQnzo6rL9KYb5mom5Vz+sBWzWTi0czxLinEWSkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElwoHT+TmohTMy/FbapS+2n2/z75NMS3CsRnZQr18+o8If3XRXpyd0bx/jzQUertcdztYtscC5Rhq55uik/B0veoHeWwVQdf1b6i7tzNZDAVZWidDHvUa/ZVMoWJSda3WClYq8LrPXkVIYoiKaQemqW7EkMBfmXs3iQ7JBnY18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=XH3APSM4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="XH3APSM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754297695; x=1754902495;
	i=oswald.buddenhagen@gmx.de;
	bh=B+yv8P6tuVpTeBlYuhfBxXjFqmHxPkJ8wKFcsfsIHXQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XH3APSM4MWnXLNyNSd6tOqUqOD9teO/eMGMQZ4Cz55PLiwWqrAqJmIHelJTKpX0S
	 lmW6Je74yRDQ6Vwmrc1GXnVgmcWSOGEfTRiOmzFHLHtZGfkY9XSfNtJcTBlkJUhVH
	 aaGCakWPpKKWqu/8XZ4mgAzPXUOvrUss8hFa1gqIArbFyNedLoBaFMZ9h5Ndhn6F6
	 DhonCncj/l7yk/6qB3QPRRFwPdLQtZHTaHGm4bpFIHJDWcvYuXnhKZuLarKGxN7Jr
	 1rQdFPTEbZPmZRUyXY1E7ZAnp9Skr6K7WORO9t98BaAkkT8lKcMRC4cNbsRZbgOfu
	 DdV1pAiB9Hwce0TkHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.126]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1uC0Bi3sW8-00pRjl; Mon, 04
 Aug 2025 10:54:54 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1uiqy6-r69-00; Mon, 04 Aug 2025 10:54:54 +0200
Date: Mon, 4 Aug 2025 10:54:54 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] mingw: drop Windows 7-specific work-around
Message-ID: <aJB1Xkr09XNjb-ON@ugly>
References: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
 <6b4f062d82a80d82eb927cda7304d053b2984aba.1754256318.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6b4f062d82a80d82eb927cda7304d053b2984aba.1754256318.git.gitgitgadget@gmail.com>
X-Provags-ID: V03:K1:05jYqQMb1yucecCJks2abpyYnNPJ8Z5Uv3ezW+FM/O0vRMiTBHj
 +zqpOxGq5dX5UjwVy0IMPC6oBGMl9TClhwqOnpgZ29UN3gulMD5m690gORmr95ChbQ6F1pz
 SHayvSUSKLiHFp7NfwbRjwLhHlbE6jonRZNNHrmmsOz4XdL6LMauXhXl8wevT3pQh7z+9qh
 DGp3UcBavlfDLD98Kgyjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1/m/xbsDoS8=;HXGB2Cv2AWFpF/zbiWkGpOsW7TK
 FNE+Ir+bae+dcngs8hgkdy8nb8naWDudV/T2vlt3zjEmKM8nH7bqNI8Ylv4H8IaBDpcjBnqhR
 RDRKGK3I3qDHj2Ivdqc1ov30fCggIJ+nyw+t4M2ZLr63UEdr/gHz6eNYcjxIZe9WRR0dkV+iq
 CGavh+9YblvvfLdHVT5IjCGTJeyLNuGCQmvsf9uUjRTJcHSvaHZZBjtaOhrArv0XhVH/Zk4jz
 Cx116qXCtKjAAKIOTuhVykugRxrbpGeckhZJ/uH9LtwMZrOuG6pII4MaD26O4I5jK0YwzQSu+
 TznN0zbPfzw4ZMfvMWoSpEajMmJ0it3mELKVmE/W+cUzV6h3wWThaXqimVKTpWo0F4CHhZkFZ
 9xSeQVE3owqx/RPIXD08d/Xa5GdzbX1amPdKdCcmA1JX7PbhDl6I134pi27on7UnreEUXPog/
 P+XsLOC++TrPFH/5v53zPdMl+B1dAVoL1KmCy+ucicNDNeQnfzAo4GL6HWpC/WPn9dpW/D0xX
 EcPqTi/sJFvNup+vKrNhNhYvZFjz7uTVBfACPZhplF7r190JNI2fZRBHKqHvn8FbIB7QnxbXu
 yXyEUR3HJjTB5mtUhxWfiAcsURciS7gADak7Xt+Vcz4b0tsZKrmxbDbXlgS6Zu3pG9tcvcwTy
 eqoXyQ0fudSdpXsVcqErZOEiOY+64C6PQ4jtoeLM7BUvyvZTF1XIve6u8wYHzFhIQAN6gTnzO
 toXau1ot9vjwzJZndGqNwjMq7b14oKmojoeLTNHXRcfzcVxTcHw+E/kl9bUBOL64ViHZH7MJj
 WJD9RTG+ELJORFbKATxu5Z8Ur04YpWRHXp12qoFtr0HbbwkyrOzpE6eV3QoJOVXrDokoeMlVa
 ZXNKRJ8FCtHruMJQXR6YPBwqcwVIPVE+PzLVeIYa28nfN8HTjXRGvw+v3Z1ivQh7I5U2+UDB8
 Wf3UeaU7DxbzSVOOuW+8Xl+HxoB0ZZNfDNJ0zdsHyX+dcTvgY29rK8sNVmYu96tmK4GEdex9x
 iuZbruphbFirQXfqOWb5a8+3QKrxQOYFmfQ+30lRCZB+MmzlpMZeM5cYNWkodApr+D0Fp3SPn
 7FIRwgd523PbRwviviLwp2HD4nfViqVDXkpfBzIfqetpxRcDG8QJV3EU/U1JBHA7rJ0Pe0tYi
 drIRRuB4N+4cugU4pGVqpB4hoZmDkWDI7q3RlBBU22w7wbePEeFrAQHVHu9HXenUwbLsjR+Bo
 ieu1/rSOCM/qE2EzboLu51C0uP6ElPfMnWXdK+WU+OYvXXV+WEQ4MRQ2If8SsOYxuQF7SZhwr
 58gMQcmtPUrVEW+RYMMq3sjVi/EcQqLrotjpgaS56V5FoIRzwb2gWNSguanEEngYKUCT+GaW2
 +BS23GqENIr5d7yeDFdrk79Kx0MNk/5rS2he5u0wg05RDlDd5rMoq0o+iKAEqZlMKy+NwRsCx
 Lnc+Z52EI7D8Yzo7FdoiO2emCPRUhX9sjsmNdqwJUcAsiBc/OI7DcNKVsU4JZ5aXWoX4VZCZP
 NAWtGbxV8RdVy4WDoNWkXZm5nBw9e4f4scIfW04fAsVc4Tym6mOOYexDBc/oOzDoxfdJ4aS00
 r5LnY8noC3RtoDxTFNlGArBjOGHeOm/Y979+p1Q5qfbZ6EzhUZLtlG5maovL4a0Al05ZdlYzj
 lY3/XDAUdduj9p2/1tt5knVK8CqJ3UL0AK0OU0B3ZdJMi98qBYv1hY5Rh2tNl2yQujgXTnWqo
 tvhPTVdBOLU2WGKaUwZ9nosFdPgMKoY163Ba5fIWAS32MccMa+JDi8aKMfxXyn0nuvs7VkchZ
 OCtIlpa4OKMkDP8rN/cicAccxiS3TSiSj2A08JxnTHgH2L17CwtxOmkJjIC2uzq/GSQoZpXlU
 u5PLge+nbMX6lsH3nL+UQ0gDp5svOsqavdsNEziqmcBm1JGc/fh5lJ3uk+Tdnt7uylPtf6Asx
 +4Z0yX0ufD7cVeWKp9l50hwwPebruhvCCDB3FTjhlr9tODLmgi5hcL7a5DA2QwuMYsoUmA691
 c7tU4lwkgek0k1zLQaL08WDxivDSSuVymkBhcreOmyD2Y/p2NPQ5W+64QCx9ZYqokojRExP2b
 O/chQSy6Z9uUuHBN7jAdl0RR2WNCkYOlx2pfW2LojYasei0nQsp90SLk1jtqrYq6z0rcHsYo/
 pkx94umeKgIbDdZl8L4+5nWRrkSwlNtQ9FqmDVs0c+8d6a5ZRu1JkpId8PW8dXP4ac9FTYAIw
 3vRSPtQbY3V6cGJgNKnx6WNfAZ9iChfKpSmnkZGqrGzKS2MB5+nmCE6QhK1ARTl/iVaJUQ59O
 YUAvJ0DZwcRQAhBH46PG19yoXOyOAjc7fIiVKyxyu9XH8eLnspftjRI1eNvEnfVIhw7yBjkhl
 o01Z2NafQsZqbPUAROohkdVppCkv2oC83JFQGwvEaVE8VN0cZQisvb3Z/PlRn7iLg2/ZY/81C
 mIK9c83KnPOGJOfZlZwW8SvoO18PH94EUgM4FyZzp3j85bvOsvxVnyP8Z7oFmJH3bkr7kkr54
 tePBgKaHO13lWAzrZcNbWq8BgPB4w7cYmR8mqEZa+8hu11QR0jjb0xdeUzS9Jx23FTt7zRhTK
 BEkSLnrv2PRWr7EDM1xhh9udBZQXPusfKcY+41rzUEJBBGWxgHge3iDL2DiOmfRBYDrKM05VG
 wnq8seczsoiJda+t6rrBrjUm9whjudTpQNQK57JqIIPA5zjg8YnloPrV9xHApZ06LP4ol3qaB
 dBpIvziV/UiI7hKmCuFzqdl0mEI/CF6HtjpyzwNRdgARuPY8fIgbPSBeTTSefI17Hd76R6QLY
 nWUMQHNTHUujuQY7ViZlFPtcPv6tsYbjtYIpYcRx1/UXuidZ33ZaVrWSYp1kmvDNLAFByo0iO
 A8BzV/iO3c3PrOmh/zPJA7ZJP/foUxMVlyU85We8aAWAnmygiHg3q1YBwctBnUpA+rVfbz/yF
 iEvdWSNIr9JZ1IU4m1bAzvXXjI86jBdeVa+0AomrHHu6gEtu03+X/YPDKbJrZdypKAUy//hml
 4AW9mI9M3NkT4v5Fno7VY5BjdL5B+B9fJmfX9xpPQXGUi2JfrmyoDc7IsAXUEqXaHT62RZglG
 PYRMsNpHUzrt9xRWO34tqpiExk2oZ/awILe++0szXCLs2jGB8YrQx29MqBHbh5Sj2QMFv+suu
 E8j8M9IFTKJ/EHDm+cpPI7SI9S4/orjjwIkEf9ZpnkEFRVBqQwV8G5WtQNKmU0alR5Id/Oe8m
 gX5AFvPHO2AE0QNxuMXOiaxVF1tCQDb2nrG0+FYG4xpzlNQFpiKb+6EVBJQBizAEsr8z7AKzH
 LRhd1UE/cQPK9RriZ+pu9EJe4G7N6ZHPocp2U1NuLcHEybZI45dKIDO0+M1iC3yT1i7bX9Bjj
 Ow4FXn3XTWNb4KAYr6eKpasRbo5oYBuqaVed3iLClTCPtML38mOI+yARWMx6BCQrzfPniHiAC
 OMHz/KUqtFvanxC4YxNhtKHEIAU0zOgByxVe6tSe/k/kCRbpCffmEBv1fLdfniaLa3JRHhWUx
 hQ==
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 03, 2025 at 09:25:16PM +0000, Johannes Schindelin via GitGitGa=
dget wrote:
>From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
>In ac33519ddfa8 (mingw: restrict file handle inheritance only on Windows
>7 and later, 2019-11-22), I introduced code to safe-guard the
>defense-in-depth handling that restricts handles' inheritance so that it
>would work with Windows 7, too.
>
>Let's revert this patch: Git for Windows dropped supporting Windows 7 (an=
d
>Windows 8) directly after Git for Windows v2.46.2.
>
it doesn't follow from this why it's apparently ok to remove this for=20
even newer versions.

>+	 * On the off-chance that something with the file handle restriction
>+	 * went wrong, silently fall back to trying without it.
> 	 */
>+	if (!ret && stdhandles_count) {
>
the comment should really spell out what that off chance is, so one=20
doesn't have to check the log.

it may also make sense to elaborate why just dropping the restrictions=20
isn't a problem - my first thought is "huh, doesn't this open the door=20
for security holes, at least theoretically?"

