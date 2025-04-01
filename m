Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDEB1AF0BB
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525027; cv=none; b=YP8sIRbzJiXs3YggUc7vQddL1ie9bRgYu0v27Z+t8UxCoh6mOP4VKGst9LU7vp9crctB85N+sOssm4+iNnQhfQj5S2nwjhHr2rIwaVoQQPaaTk3MKcrhOtkQQfmNjtfCm+v9FQuBV03QqDnZJ55merCtqKdP4xzR7UF6NB7HM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525027; c=relaxed/simple;
	bh=TfT+DPHGcI8E+ueXUab6Xcp+WXMcm+DxF9UZlEdjhz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FtWwH8VTPd0RaCRml50szDHpMZcqXBhupEo9tj4NDxCrBfzdVWh9WZ+bE2Rd752aDui99tMI1LCKoBUliO1CY6k1T4l1BDCjl6WeY+Yzvu7Tso8UoitKSZA8pbAECeJ1xRe+OiX5Emt/LmWtE1jh8/KBJtuyqbX8I2ouCWqm65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=BCxfK4L5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="BCxfK4L5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743525002; x=1744129802;
	i=johannes.schindelin@gmx.de;
	bh=0NVbUTg4s7jChTAsmrVqBxyU0PFARtL1IJRjK3m7Wao=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BCxfK4L5IfBNUW7+F075hlE7OSpOZk7kfa+A/Wnwzk2D582Cu+o7xejmNvyIOGkn
	 1XI9aoAH+/leT7g6VPEBlhVyWoVBnNP2vjTBa00RsaHtAdfdLk4gholJy+d3cm4eI
	 hOCtPEjQwE8hXJt8IMqAr5MFOJ3IxEiYKv/NSlP6Q8nxOmpDVpfHkmHBeR9nQUZe8
	 Qkew+p0wtw664vtjQwE1IpYDbK2hoEDvPqGKxD251T88ixSKjak1lsWL97UPO33Qh
	 EEQwehYdd7GU69Ps7p0RZX9YfutjNd/oIque6nz0aDgWufRaTbvN3iGwHgVpTRVwo
	 wSZjYJ8HdAz+hQdJZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGz1V-1tw68n15Xf-006dLK; Tue, 01
 Apr 2025 18:30:02 +0200
Date: Tue, 1 Apr 2025 18:30:01 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Sam James <sam@gentoo.org>, Eli Schwartz <eschwartz@gentoo.org>, 
    Thorsten Glaser <tg@debian.org>, Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH v2 2/5] gitweb: fix generation of "gitweb.js"
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-2-6b06136808f3@pks.im>
Message-ID: <e9ea3630-a831-dec5-e461-3f550ceb7ec3@gmx.de>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im> <20250331-b4-pks-collect-build-fixes-v2-2-6b06136808f3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VvX1clHgrx5AUeGDp67AP2ccZajmZZyO+8+ITd/mJJ5otg1fnI5
 w1SCRnzJC63qdcUW/vtW7DnpKjCwUNdNj+fBK+mhTeOoRqAavf7ECe1G/lCWv2xYDrr9NUg
 x1O4wdMKkKpwBMBx1hUoUXevsalY3SmkhdIupLnbFp5Zk9ciqwIyo8bvUagtLQD2NdTWAsB
 984bduG3iXy2Fwj/9hi7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+9PrDIZwJXU=;3nkMzUShpp5pmsIfYsrmqMFS7+2
 tD85MQ/kaZUf6FpxQ7ftJilH2o4MC05AfwYruD2Rlcpa/6+xML3SBssffd7vbKGBkrsMIxfyz
 OoTNJpxMq2OtMct7QWfcbHmEMqfPwa/XQsLz7ASrUtDMmP6uAcVNbYbAbrDCT6+HpK/Ag2TiM
 LtKMqKpCwzBEJuNJZ/ZjfpLJP1ILdwY6fc0s4UUdeg3lAXhTEFYGbqTXEG2L4894720ww1lfb
 sJkpqOvd9g+ewCh8aLwAgNfnfwA9LgkJIwGJPkl0XaQvXIJwyHVlhc+YK8cWcHjEVpXwgtzn/
 RfOoPkt9bltDPV3bv6YWe8tkCFnp9lO91esgKNkVGEnJO3M3IxkH4zk3Cy+uQ6swKBlzkwmGp
 +VaSHzLhhT6pgchCU4FOPgL8ZyRsD0vDew8onoURnN2wXU6pYtDbS4//symem7LulTe7YBMzK
 zmuR4Ayed23L4qLtc2OM8V1S4GteOwpzXkkMtPUIEDIWWDSY5LBwNxdk+dC4nklh7bzi5zAZx
 /9Idxdz0AbnEUjCk8wAlaH5wFkaSHz/B00JiNZImmghDYtiLAHe6WX6wrYrlbM3TgGxbW9HW1
 NjRYPy++YzkSM0Dffz0XSeHGAfh7ITJwP4qwyPlMybun1xgaU6Qna5Wi6hXAxMnRIGgesi9i5
 yQEoiAAcSL/K7Mvk54ekZvr1ySBdoU/YX7SmKUXCipUR7c/KhAd4LWcYpfYZKvKQ7GhM+L2PA
 uQg3mzKyTFUZMwLdcFb/IdT/B2h6qdyikt22UZdmkcs6EfPW/iYO1zJfEvDGHopujsD+NaNLA
 muWlxpFnQkWQmOG0kvIRTP1v+4q211/SMzZeOOVe/2bX2RtPuEn0FNjvHIIlRCrPbx6lxfS+Z
 mQjTFz1S+znQHYE94bgVzmPnPVbUp13ZlELZ6p4zWGCoCAs6Tu/R2yNY52QJi8YT1wwEwrHmq
 GOi3uCaEd8Vqq1kSA7jc8n4QdvQzY0HbU6nY3Xhwc65vGY7RmKRfmkS1O6kn6xval4ZEP1euB
 guOkd9AyR+QVMsyeATIFq12tUQEblbrMnUZWeuab11bA6vkqRH4ZHX3FAE6Ra9jQkaLAJ4rtT
 mTSVMaNLqLRPBBVgYbqteMBuQ8RB4HmhOuaUo5aL5Ae5T+YxLvd93AmoS4NrFGhUE9DSSaZEU
 q2cTC79ZMiogvoNpY3I/65JM0h2c/vY6M7+nfu4imj/GYiqFz+s1ztmLXVOm4U+CGaG6g7R2c
 AtagZOtQvqXAATyM8cHmOOe/N8tiIsQEa+J+lO5hWTxiv+AGxuMEpNHQHmjQkG1fJyydzeHSU
 nWcTAxMLaF0ob2Z5EQXwQd0AByf3KE2lLBQ1an4KssGKbqCQHcjDVheT/Cm97teNlonhKnoxm
 qykfRAP3NzjZnb5iJn2mVLWL/Ymeh5NRl8KT/zZ0JBN4OSPuuZ6CLWKHHxhMj5sbOHkqmmnpQ
 K7xL6tYBXNZAJy9w/3SEbJydHx4XxH785JwbQZCj5AgOFVty4

Hi Patrick,

On Mon, 31 Mar 2025, Patrick Steinhardt wrote:

> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index d5748e93594..26a683d4421 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -118,7 +118,7 @@ $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
>  $(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
>  $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
> -	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $^ && \
> +	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $(filter %.js,$^) && \
>  	mv $@+ $@

A safer way might be to use `$(filter-out %.sh,$^)` just in case the
Javascript libraries might at some stage be renamed (I could imagine, for
example, that someone aims for ideological purity and renames them to
`*.cjs`).

Ciao,
Johannes
