Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAB2153E1
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532328; cv=none; b=tBZgs6R3CP2dhM4EHkcVvsZaF9ALuZH781O39hLFbu/WmkbcV2H2m2puIZOpNHBxoZE/CIsRuxYqkdULA/ijtz4njIYxmXdQcgmnKXNxfVQiGtb1oBeWyYuW6z8VoSKIeOwn640pJ/KVyFZf4EWbcVrXLC6j4LKxQmtBAy0ZQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532328; c=relaxed/simple;
	bh=rFOheVrwrmxAoCjtE+TvrPE1ne5X19ZAgl6KBvlqQMo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bot5AmIeUdXGEzcCc4t/lcmlorFl2RKg4peo9saAhKrvv8/2mpg3ZgWkM4r2whx+n4vxU9Q1UkwT5L5HRS25XnxRZizUGcff5QtetoQocBNd8DtqH2ulfd0s9GvEqZZxCvKNEvKL/Tl9X8ts35LeNO4D7HtGh2g41zAbOn8cH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=f6c8b1yk; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="f6c8b1yk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743532323; x=1744137123;
	i=johannes.schindelin@gmx.de;
	bh=O8R0/rjazANV6tRV8wb4NNEUD9J3fGChgj187dBQ0EE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f6c8b1ykUBQoPhTqXiIC0gcaqyVzf26DRqPfDerGKF1CgYxltM3U6O4m5A/lub9F
	 GI3dNlENWykxKMA0P+U6obzXuWM//ZMAJHjO27KYWbq4ofmwLpOD6JEof3Pz/396U
	 noPZnBy3HhIC/pWwmQUxcASFFxC85lQED58gTRl3QhVae4meroiG3P8FXVynuEdHT
	 koerf0Pm/dw+k6efs8qkmRlSZPvskdBIKOCAMp1qWwH0KnA49j21IU5C46PRh5Yvs
	 64yaMkQtpWUmXieeZq+3AQGZfKw+T2Ib8n044fytB66En4k7agz3lSgsWd1/LJTED
	 9wfjrLnjwrHqJl1oyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1tBpwe3wT4-00swBT; Tue, 01
 Apr 2025 20:32:03 +0200
Date: Tue, 1 Apr 2025 20:32:02 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 11/20] t: refactor tests depending on Perl substitution
 operator
In-Reply-To: <20250327-b4-pks-t-perlless-v3-11-b436de9da1b8@pks.im>
Message-ID: <70026fe9-8c99-ab00-531f-1556db63b0d8@gmx.de>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im> <20250327-b4-pks-t-perlless-v3-11-b436de9da1b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VeIvg135orcHIFRYYE7mgiwHvrU0Pa+uxS6pj9429ci/XyzIcxT
 b7BDzAUejxi++BKePxTc8jsQ6BtegA1Ia/nO/ITD6zyEFFf5XceI89R088sZmJxr8vYnERm
 2k8anxSZhOyvhj6wo9o2Vw7iDm5OLdQHPzqg4hGWRA7gU0/S74YhSTU0YX65JZbVeU3MOy2
 mKIzs22RFwu/VS+YRP9WA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hsfZjAq0Vbg=;LfINIf29pCOwL0LZuuDqyUI46I0
 Nt1rvqv9WoKVQqgk9IBBI0v5KoeC/1LIAj9SmZutvOBjMRY2FwUHc2TCSE/H2p0cun4OrjsLC
 kxVCvKihT5PBm+19jhFB2/8fHhUXZhVz94sOAadYV57frPCP2AdLuW3bBUzPr+Z+ngDtLjsWF
 XqMNCIHDzjePtESFWWGjlQM6Bm/c0Iy616a5VBzD6jIO6CVNELFtMCb0xNHitrLnTOv9RlB+c
 xVmAveDlkfP+Lr5f1adMgL/CK4KO1UCsrPvHF5Ng2PC41pf8yCjAx2o4EGzqJpYlrsSl/6MMO
 yyNdz5FMhz8bYKbM2+OoTi08DuZZtLMYYXZU+/rjBXE8OR6h5AdfhNExW465aJO4kmSJcmczO
 EADi5jQiq35ykf4Ex19f9G3gHEDCTqOZ5dHQLJ7TvYDUPOOxQmXMQ+zINN2bcXfmlt0sspQnP
 +niUPcoOW8IAkGEvnPNwn1KtRgkshT4jTGDWgyCW0njR+8ydS/Jmr85bEFJ3DX/5rg/bsNxMe
 g9hs2uIlKDUQ+sxYZ6ChzeCfnOz4FL1Zqg5KICkRg04ZREDh1fQS1aGmNnQhu6H57byuD/GmU
 XQgBpc+2wqXPULd60ayH509n/RQzU2SaQygZ4fkO9wp8gDOe8GZf4xLx/2pn8KFoUVJHoNCbu
 SKzGpO7OjrDUIqeXo5xWTlefDvPbFah+OffX2IZYlZHphk4rTA45KGdEVi3+5yRjdcmNlRavy
 dumPlwXeOrDIs96d960D3H7voF5EVCvQb+tx+CQF5T7mjeDBgHcTOfdO9sW9KGD8b06YvsL+A
 SOpo0LRlqiCZptleYw3sKXm+JrITWwoRN8/4pilwSReEAbAuMAGCDJaTlAw8SgmCI1tLkIfIu
 olvCEqggCrrUP/Ay6sJBlWZe23fyTIGpJMHDQ3iKVK0X+JorkAoR+RhQLYJNvQWnP53zA9Pyw
 Z1Ex79l7n9zKyj/KfLI0r03JwYAG6DXPXvqoCOtS3viIOohYn2TdMGq9AJ4cQYK+lRwRQHfE4
 wK9+ciklDxjSUUYggzuaOSLKg3aoKr7SNXJmDRTAgD7gtO1WqPFmI6n3qA/8Z/2ICKUwrRFCg
 V2EqefjTjKJT0ipOoWvCykodRi0YUDapT5ioccy0tkPMyrqu/9+ICJJD0AqZLxyDTKdttnxiy
 U0eGDC+bbh1AvslvPI0XKHScw3en6RVa039PWMN8X+5fpNmZwpN9MPB8xHg7N4UJ0YPIPmZnx
 hjztEhEgl6wCtsfhagrkpaCRaf/UO3qu+YaclmF3IXOByeOIKi8FYJvSMF+8csNUYM+kL/vv2
 4ntzvZJVPn7I7BZKrj1wJgfyzRzjtbtUJy/aYfAqbeyKqB8XHvr/J5ODkXY8y0kpw09tFrhp7
 PK4PPJH6gACFwydAf3zgLGgNyrDbE3Xlt9iyyx7lHUr+Fa2itnCuU7STODE2MbC1TQeJMVTxs
 YmXPcSiTjchWoqeOUv8Qs3CTPg5cb0dxOd0R+5U2nwUBT0a4A
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 27 Mar 2025, Patrick Steinhardt wrote:

> We have a bunch of tests that use Perl to perform substitution via the
> "s/" operator. These usecases can be trivially replaced with sed(1).

... and sometimes `tr`.

In fact, it looks like...

> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index 14c41b2cb7c..cdc1d6fcc78 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1064,9 +1064,9 @@ test_expect_success 'status -s submodule summary (=
clean submodule)' '
>  	test_cmp expect output
>  '
>
> -test_expect_success PERL_TEST_HELPERS 'status -z implies porcelain' '
> +test_expect_success 'status -z implies porcelain' '
>  	git status --porcelain |
> -	perl -pe "s/\012/\000/g" >expect &&
> +	tr "\012" "\000" >expect &&
>  	git status -z >output &&
>  	test_cmp expect output
>  '

... this change is not about `sed` at all, but only about `tr`.
_Technically_, this hunk would therefore feel more at home in the previous
patch. But practically, I actually do not mind it being here at all.

Thank you,
Johannes
