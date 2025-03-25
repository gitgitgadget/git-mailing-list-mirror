Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDF259CA2
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911946; cv=none; b=R53sv2QAbK1TvtnR3BVtkbdnJc5UUM47rafoIs4+TbzzBg3wAtYJVgSG7yJgk/aH1PJn2w10vigPWJQUXL8akId4gZ1kcjhZnUsNGX4hvB9mErG6B6l7EVQdKZj/3v67rQUG1w+86pNcUKcKl1BY3edJQohoMzstQ/TDjuS1ppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911946; c=relaxed/simple;
	bh=9ToaADHUYWgAwaJSaLhFxA2rImZ3a1vnrgdgYvRRJPo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZshIVXQsNBXANUrjMZYU0gj4ePmXikie80tIsQEvpPfzRZhoK5X/0QpY6KqMH4cuXOJiVncqobygqM/AhZmmrhTBsM5qBBRHaSuk1uXL2GYu/W1CBISzknPUR9uH8JRXqyG21JMcpFX18V4gPYBnCxiWFIFXmY1Nx0LjytQzP+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=X83+Rw7W; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="X83+Rw7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742911941; x=1743516741;
	i=johannes.schindelin@gmx.de;
	bh=9ToaADHUYWgAwaJSaLhFxA2rImZ3a1vnrgdgYvRRJPo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X83+Rw7WQcDsbCd/pR2OS4dILfqFOZZzA1ZxuBM+t6xdNgHbHRYB+NjwesEyM6Gj
	 Q2I+TskrKhM5nyEd0+6KLLvKYacOPLAGoeR96EnDnZ81/XJ+k0wWzGbfOS4vuBds6
	 QqUtmLa4lrRAHITXRWEZdnCy9MhgFzwbaCiJhJ+l7oS8sPuFiV5l9diDwQ4lkm+BQ
	 mcjWYTZITcrTVSDjlYIKzDq4Ki9lNISXbPheVNFCqa5/v4JXG8+NShxEC/XNcC5U0
	 IQApE3/URP0huv+KqKh5vP/xeG30oFZuAk6wUxSMC8geENY3Z9TAJejPLOUi8SzyC
	 uNg8qyjDbT1Pbfcfkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1tXou12qqC-00MV3S; Tue, 25
 Mar 2025 15:12:21 +0100
Date: Tue, 25 Mar 2025 15:12:21 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Philip Oakley <philipoakley@iee.email>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 0/2] Avoid the comma operator
In-Reply-To: <f30d8ac4-4748-4b73-b86d-6f85c9bac622@iee.email>
Message-ID: <ea6bfd92-3d09-c611-abdc-dc7bc987446f@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com> <f30d8ac4-4748-4b73-b86d-6f85c9bac622@iee.email>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:60nMAmPtrcxSZxS1FAnOXDeds6g2sYMnTRW+F/rySVAqBtzCtCg
 HhcDBUBiDgPgJod4hxOVBfZo8Lg73Ujf9Oi93CJgou4d6bxU/4t9Y7pmMrmrlkQR/tUIdyw
 SdIPSKUj4NsqR8qPZBerOjg6Pgkyc0aE+G8Mi7XunkSHivhKEv40VJ4Y4bCtjoBEOEePcqZ
 o3YlgruuYrQQdqHDVpcOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5q6xuukN0to=;UIcr9wC4nRfs0pLtk37GzWMUfDK
 X+wLhSd+6uahBpKjbH5ndU/zdMoKo16vM0+Ed4O05rBautV0aEHVqZ3vfXKctjK+v0eeCOCEC
 vVkwEnC/xGjueB+3HP8B8LOvyfiL9d/14hmZzCAGF8/HTiQV84GOWG8cBQsvSDn9vUevocS8/
 VaxT8OrBgMrjATFh+WJCBGD3X+yXHXQCURbcd1MUOzBb3Chr4GVMlMbPnikPjIQ94ZDccap63
 tQmTAyk7UduZ5SdygOV4oTng3hAafvNDZEtTAfJmLXBcMMDPyK5ZAK1/PpngPPy9+xyaaAlH0
 +Jfe3tGYCWyPR06l3rsjq81Nb9/KjV/hcLdcUnT+nNikUigKrNS19C3xoAZwCjCKfGmtOqnp5
 1m2VcGG20NBBORQTCy2fYAzM3d2cyIF542iV8xm9mqA8TNnife4G6Hp1/1eVllUyD4evvVZnl
 0t/6gPlAED+OOx8YTYy7eWvk+k5UcJAb5BmfAWGs9Ll7NTPDeouFBwbmaStr2KtR5lXNQ96v1
 4VEPumum9lfiS57LcdZ75nLWjOlKlDNPWoTV8uheAZQnzuvr5F+TJEUSk40nDQVoDJ29tNh51
 krLnfYNpFYB1/ic8cxady/OebteufvaeSsxnJ01QbFVtqWXBl4K+6RYUykHKRccI33BwCFNbA
 UfeA7OQZjsSWLtazMzUgxwnEkSzL8N+R8McG/3JS2NSr7wQf+G8PEFC2zx98RthlXFq2Z76+f
 nnIi64nQG0QsGFhXq+kZgbSN3TcqW/srGDM3MawDYpmiUOl6ScEPJUmadCTUXBdlJBldz8x6C
 LESy16keUu8ow3NmZPtqp2kBMIEdlRTjE+CJHaHN7wzPjr5VFZPzeKGzHXbvT3l4oENGk6/cR
 IKk2D9V9dFzdWceqVd/vIIQ6uGP0Trh7V0hNMz71hZM7iDuKkqpAZv93VvT9r9/F2ldvspfbI
 2FySJX/g1T5EFgCi27BTw9KVABGFKcecpitLMI11S7SZpfQSwKidgpGdN+ATY5YSIFoCnrZCJ
 PpnXshTiDYlt5xJq7UboqE6oMdZC2Ckd9doZbpJUcidPlYMTITZB7bCH8B1kxX1s4hVP/CEVT
 8dOVITRr5eyl2wGFOACKSG3Iu0MYz98bHos3MpRYa1PzlE57nhOa8pDr0HRDKdnvf4n+FJ6cu
 baTbHp5qdhYfEOUxvisTW6W4NI9wMD9GHQ/Mb9LXZuvUgtuSJBRFoPo6DNRMTSpNmp5WPdTZ5
 g8QCI9CTTizMr+rx+aKT+wKPrRMnOKmp0WvlxBvmBM1ZsBxMohYmlQ/FMtOXXCfUXkt49pABz
 JtRl5bb1Mcykzg3QDAufSCoUInGAGBW2knU/MDOhRewpShJ7GYVqnd31CyCEB9MOvcMoF1+zb
 0ikRgxpKChepmO+twAmzDEajQu+aYV96SBWBqVWZZtfapuxNPBeYdVlQO6+uHoqu9k4VWj9UA
 sePdjVXLskDaAcMV4gguemJatO/JyxzWLWpvYCg6isd57Dp+T
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On Tue, 25 Mar 2025, Philip Oakley wrote:

> On 25/03/2025 08:01, Johannes Schindelin via GitGitGadget wrote:
> > The comma operator
> > [https://en.cppreference.com/w/c/language/operator_other#Comma_operato=
r] is
> > rarely used in C anymore, and typically indicates a typo. Just like in=
 these
> > instances, where a semicolon was meant to be used, as there is no need=
 to
> > discard the first statement's result here.
>
> Minor aside: How were these 'discovered'?

I am working on a GitHub workflow that uses CodeQL to find such issues,
that's how I found them. (I also worked with the CodeQL team to get this
query added, way back when I was still working at GitHub.)

Ciao,
Johannes
