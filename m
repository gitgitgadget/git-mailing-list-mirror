Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EFC1CF9A
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551742; cv=none; b=EBAtHwZBJAtasIfnf0meiT6vHhNyrkaJu9u4zdT/AlyJSa358ZKBYQz8ubqqYzuVJ//wLn3AEK3iWF1hUul22IYdGY+QBOewMX+7AC5dxdxo1JMuQt7JUHh7Y4FQY1rLm3BAImzmQT9nr3rekTK9NdxdmQVdc5cagAWRz5pkg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551742; c=relaxed/simple;
	bh=tv7htHcPT6YZ7tQGSQMafylQBnAFwKtKvjSeIsNJX3Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PuWFIg0gP+b09YKVgIfGhOb56L3koSI9az6ab3Ee5BA1ppuE9S+yacPZl2r+Xsl0xbu0FgyIPQAFf00St4nAR/xQxfrwnY4KeKJ0eSWctfF0arqiJS0bZ/1YNBdTz/mbhhAu7XOksq1uzlyqqiMiNovnRIOJDv0Q0uefjz17Ees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=WzScaWSk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="WzScaWSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723551732; x=1724156532;
	i=johannes.schindelin@gmx.de;
	bh=l2Zx5uySBpoySUvP/qLseD0zyHAvwGwafvcqEX7+14g=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WzScaWSkUw9slR/ckkNGoDLZJ6BvGnku687b3zsDT1lpteeUXVNTVGiyBE/TaVXF
	 sZYhqOwWi7NX7YtaoaUCizTSNV+4DNVPFfHHwOa+uZ8mdtHVeJ8yuVLWG+OZETHSn
	 7OIyr2bOrL5hQ3ZNYPvs9rr049V7aTCOB19EhUhWuRU7M96v8gVTK4aet8uzviDx5
	 h0QYCvn9hnb8LJ9SiUz8hipchdToLwbt+1iMYGVN8wpeN9pjc3+SlvQvjAC+HqWqE
	 Ycf6a0GQHrNm4GJkDGtRKm/LGpba5bDFqSYQo3T70DHEUUVpmiPa238EzBggf58fs
	 IGf8iVIqy0Trsbwmqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.78]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1sAVuZ0GB1-012j6K; Tue, 13
 Aug 2024 14:22:12 +0200
Date: Tue, 13 Aug 2024 14:22:11 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH] tests: drop use of 'tee' that hides exit status
In-Reply-To: <xmqq4j7uhfvm.fsf@gitster.g>
Message-ID: <f5d0510c-d455-5e80-08b7-e08c81df4adb@gmx.de>
References: <xmqq4j7uhfvm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dEAzSSQwhv1zf2sRD64nUZNlqnCp7Q8o+yMKesaOJhdY8swlQWF
 SiKlR31OdmcdMu68VHkNy4IvCDDBAft8MwVh7ILy04rxWR2ylpVO5E7snbKjgB5P7l2NGop
 7arqpAZqta4kRGm3lLjDHcegEG8M2zl0V7w0M8IpTS3vtg+xD1k9/8nFpUyXxmK0OdoviYu
 xIvWo6zbkhgmAhcKTjqAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Om+jAtzUiS4=;Pjd/ZkU+aszY+c1s5kj0tEtkNny
 ++rXMsugOg75AN2evj+O5h7Nh/Kzz7Z0INo7+WuZi025NuvQV/GTA3h+BH471XDuMpk1l+ziI
 ESgmqy+fm3Tp9192E91RW7EI34qkVKMFHLV5ppoYoz6U4nz+ZepV9XPxlJjQ/0pkCXP/rvCqR
 pCFWO6aPyiVMvGkyg2XY/wVwi7VE8aZNO/8muS3UAi3ACSvg+leznolEJXTBSaRyR6dfuIBci
 xhUXuKZ2YjKmqEEGhe9VIZDpqahGyDnB9HYiI7g+DuVkSSTiAi7cu0tUCWAXVH7Tv/Ha16eMg
 T4GFMMMDeNu5FLYlhwOhO0oVC9Bbo5ax7WAkn0qZzG5rj8sTpUDB7kODyXbp5V75275OuMbdw
 mC0zzthigKN39QvER+Vgby0eyf5KTo6ntYCY9iW5X3NRK9tXfD8b0IPcenIRZTk1Ak7thQLoH
 fvEQ1AboTvzhV0kdtAgeOup1suG4AAAYZeag5/MTLLffojhCNtrAiSETnMl4AsNyHRJs0Ssel
 UY3/wqtDeckPKxU5vKaCPjkYK/1iOKHniL7YKshto+8PN8ozQNstYupbXWAzD8Rt8DUy16weQ
 GkSlNdbC8nzjbGzYeJDaLP7jf3VPoqb3hEt/zSW4UxSMNcdBpcyGt1wNTdDid2cRUd318t0T6
 inSpjqyzL0URMxep2mxjZpn8QTfouUakFxU5HveI705Rbu4baJxcvRjiPGRSPm36NqMR6Rv4f
 kHGBHvWj46O0IhBLeQ7EuiB0VauX1vJfBgqVDjivzSZ3J0WRXs+zIbNv1ClANHb/Fu6MKBVbO
 5i+ba/mC9ykI9+T7pwCq4X/A==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 8 Aug 2024, Junio C Hamano wrote:

> diff --git c/t/t1001-read-tree-m-2way.sh w/t/t1001-read-tree-m-2way.sh
> index 88c524f655..48a1550371 100755
> --- c/t/t1001-read-tree-m-2way.sh
> +++ w/t/t1001-read-tree-m-2way.sh
> @@ -397,7 +397,7 @@ test_expect_success 'a/b vs a, plus c/d case setup.'=
 '
>
>  test_expect_success 'a/b vs a, plus c/d case test.' '
>  	read_tree_u_must_succeed -u -m "$treeH" "$treeM" &&
> -	git ls-files --stage | tee >treeMcheck.out &&
> +	git ls-files --stage >treeMcheck.out &&

While this obviously fixes the bug where the test case was incorrectly
allowed to continue after a failing `git ls-files --stage` call, I will
note that I interpret the intention of the `| tee` as showing the output
in the logs in addition to redirecting it to a file for the benefit of
additional checks in the same test case.

I know that I investigate CI failures a lot more than most, therefore many
might disagree that removing such output makes future debugging
potentially a lot harder.

So, what to do here? I don't really know. The easiest option that most
other people would likely be happy with would be to go with the `| tee`
dropping.

A more complex solution (and hence inherently more fragile, which I would
love to avoid) would be to introduce a helper function that redirects the
output but makes sure that it is shown even in case of a failure.
Something like this:

	redirect_and_show () {
		local file=3D"$1"
		shift

		"$@" >"$file"
		local ret=3D$?

		cat "$file"
		return $ret
	}

As I said, I loathe the complexity of this construct. Hopefully the switch
to the more powerful unit testing framework will make these sort of
considerations moot at some point.

Ciao,
Johannes
