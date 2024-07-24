Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BF152180
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818950; cv=none; b=VAaPky8gVgBKdgPjlYfB/looyvrJqb+eOdIKinO/cgpZ1Jak2zGBbyZIhYgKXlBVPfKkl4c/aXcgONdmEOVM3KA6rrgc37pTYD9ZMjxVQax+EpDr4TRBN+yml9komnPtlYtUSsKCtduUh3HGcLQ5UeuPlHD4gNoSaXdO4JRZprU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818950; c=relaxed/simple;
	bh=agTHw0guVEAV8s7heoSOM5jxr3BOsztVpKRSvhQDv2I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ITAf/hYSqcW2qV8jBYbBEq5Zjn7WiGXtWTIdh/0TGqM069+jAfErkEboUYqYnTfe/yv4G2rsS2mPNTBJAzViiNCE9+8dnxzqgOc4tK4WFv5/e5zX0e4ZgxiCuZ8ZFlHSev0y+6nzlq7lv/ZxoFFq6Xd3a5wdnqpKpsTRbgEHrdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=KBB25bj8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="KBB25bj8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721818933; x=1722423733;
	i=johannes.schindelin@gmx.de;
	bh=lsWS7xtznTMSPylR19m47jPA0pHkjyOeEvhbOe10C6g=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KBB25bj8aqHeupE5iuy6tBvx24irgAU/M9TbVcI3LaP5vvAH6wcnpF8HRpU6Pbmv
	 HfQrI0YgdvCgdi0GoGPXrVst92fx5miwS/IpQNxIZrAZPZZXtu2FuNYWS4u5xgLUS
	 xDQxdwA+AliGCJTaE7CDtTOpk3FAMKbMKSJbCy/2ES+pIbZXq/GQG5ez3Efl+LfJd
	 vTiuGv0ZXrKLF0TkLrfG/mY2OzVb5R+13fGJ27o7sO30SQrug6WI9q/wuSlBk3oSd
	 fa490l4vdbK3eZy9X9YNd8kY9t5x2SAgDZiDNuJQcdw1IhUIXdZh9oSGLVgH/r7AV
	 tzhLnO6FAQcEpIfNlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.218]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1sjRwA2rNP-00I836; Wed, 24
 Jul 2024 13:02:13 +0200
Date: Wed, 24 Jul 2024 13:02:12 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Randall Becker <randall.becker@nexbridge.ca>
cc: "Randall S. Becker" <the.n.e.key@gmail.com>, 
    "git@vger.kernel.org" <git@vger.kernel.org>, 
    "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: RE: [PATCH v2 2/2] Teach git version --build-options about zlib
 versions.
In-Reply-To: <DS0PR17MB60311800BF14CC1C5C7E707FF4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
Message-ID: <0bec87dc-d852-4133-1e6d-11e9a1c5df2c@gmx.de>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca> <20240621180947.64419-3-randall.becker@nexbridge.ca> <80112f79-f2ec-28ff-3ced-9df9d7ea87f0@gmx.de> <DS0PR17MB60311800BF14CC1C5C7E707FF4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Pr7MW0bqiCm6A4at67JsD4iQOsqa6u9MBkqUNFcIZTdh3N6Ec0o
 4iT+IYEuV2y0Es25mzvJn37s+U3xEn6eguiSpdMcqBmrUm5V936wIjTBNNlupDCrcZP49RH
 hHGDQU0vbxUBvXOuogqTD4woxanmvoPkMo6ZL/6eYWjkHRHDGf7W6Am7aGmblYqB/0IjwqY
 Q10sg0TS/eWa6IZC1L9dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EYIJ7/32XLM=;AH2d1f2Y3lOLNeJohRf7PKyYB17
 fKhgmH4R9E6vlItzmlOwEQ+CQfVkuosOFPxbB2/RsXo55opkcBMzjppBlSc4tQHvFtZ88SBmK
 wpN1ljeIm+qn+7xoH7VcoMQ8DN6CJYMqXNp9mt6v3W7fXfv97d59zXGsOV3D73GTq7fJzEcA9
 aiWViZNOutaL7xaxka11Ftemkj0tsD6FGJrmEtArpJjtVzMiYZTkzm0fAqtoh6AduXUlr7T75
 JLq8pOJEpz5MgFyPF2PkOpG9AuVu1v6P2IjZiYVBgp6skfdKJpeyj5YOwNt8xQy7cwAuYKtQn
 HELilL3G+gHEWkC/qhev0nkTfWFItmfXjmNJmkZD5g/xJbiU6srRxtpjXBFYt3WXedYJ2UQ4F
 j4oQixIweoN1lpY0569hHFFnm6B0fERQKIkwQAtTIlAgJ/7csZ550mhPcmzDH1VXGDsbm85xG
 2WmbzaqIKci0gsjCMxfYqHw0oA+87P3mk8sbxSL6pnDm/VK7Myp3pz+qRVNHe7SRLivN5KQ0i
 XV9gPyFNTCPHe593zI+078YCjIlRQPsAaDxPY03gvDxVEFKbPY2S5YzU1ANf5P1GCQ4NFF0AU
 pd4CAtHVKpWAQTokOImj+CiKq5ZUxPxuwf9tPlXX18Sw0NSPoy87GoBVHA0fhurpr/xulKmbR
 GHwh+WWYJ48tcp0yLJWLi9TDCHI3JtEglfn1QbxUhCItwbhL3ErgSkyrSTBoj4lujq7SjsmvP
 xub3ThOQfFnmNYhDfCOTTSFiBcaBChfRr0ruehLt2ZxQBxwG5mqr6Dk0QH6vIlVPYZ6wMXGOX
 Rp0DqYQRS6zoI2O/3WQlZYkw==
Content-Transfer-Encoding: quoted-printable

Hi Randall,

On Mon, 24 Jun 2024, Randall Becker wrote:

> On Monday, June 24, 2024 10:16 AM, Johannes Schindelin wrote:
> >On Fri, 21 Jun 2024, Randall S. Becker wrote:
> >
> >> This change uses the zlib ZLIB_VERSION #define text macro. No
> >> stringification is required for the variable's use. If the #define is
> >> not present, that version is not reported.
> >>
> >> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> >> ---
> >>  help.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/help.c b/help.c
> >> index bf74e935b9..f378750af4 100644
> >> --- a/help.c
> >> +++ b/help.c
> >> @@ -760,6 +760,9 @@ void get_version_info(struct strbuf *buf, int
> >show_build_options)
> >>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");  #if
> >defined
> >> LIBCURL_VERSION
> >>  		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
> >> +#endif
> >> +#if defined ZLIB_VERSION
> >> +		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
> >
> >This reports what zlib version Git was linked against, at compile time.
> >That may be misleading e.g. when running with a different version that =
has a bug.
> >Would `zlibVersion()` be more useful here?
>
> Please see my comments on the libcurl sub-thread. Same logic applies her=
e.

Let's summarize the part of your comments in that sub-thread that is
actually relevant here, okay? Here goes my attempt:

	The scenario of concern involved a customer having installed a Git
	build targeting the wrong library version.

Does that sound like a valid summary?

I am quite puzzled what exactly your answer is meant to tell me here,
though. Is it meant to say:

- Yes, it should be `zlibVersion()`, it is the version that is used and
  that might cause troubles after all,

- No, you want to continue showing the compile-time version, even if the
  user might actually use a different version depending what is installed
  in their setup,

- Yes _and_ no: both versions need to be displayed, as a discrepancy
  there might explain reported problems and could therefore be quite
  useful when handling bug reports.

In other words: Please understand that your answer to my question left me
wanting for an answer.

Ciao,
Johannes
