Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E8142648
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238421; cv=none; b=WwRX+xAcvxge0VHEAebbmDcpDb6PNVIxDN7GSGa3aM8icTHp004vXuqPKy7fPm8V/VWqELr0mHugpY/2Gku6z9D10DNBxQgEjy9Q9zp8ypWOMIYPP/7zU6qtJlQpHTwpyopuT5E5rWCb5oWxcM1qi7MxTPQyz+y9AjxSm40QySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238421; c=relaxed/simple;
	bh=8xiybj575r3GnCzZf7ov6PQeRu73Z9MafvphTPKF8Kc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y9z/vCtNClpOp0U0wa+ZxoCZ483BB7b6WPqeI3vCSoIXGb3XPJrfMzPdOsY8JF6Tf75P2ccVFFwo4aRwYTpMIF68sFGKYO3cjQKxJvyCvfezRmT8Fv+3ig/HXwqNgIepVXYVdrcHwnWDsO240F8DuKyJGigPzbGtEbdpm9kGLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Ux3cduIs; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Ux3cduIs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719238405; x=1719843205;
	i=johannes.schindelin@gmx.de;
	bh=SzqJZJjNRuN4O+S5j/P/yox9TtdBms2oAYjHolHqUZE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ux3cduIsfPuE9qSvkmSRIs/kzTbFJkAgSfITEKrFN8PUUoKC5bvKGTsRK3sIfDm1
	 BryHRVtX4tc+vCq1uzP42rQxRDk5UOGAimXQaoihaMAjUIjiZFjQlLNIRripvwot5
	 n1Ol+29tRg+P3LEFTLQBsamXTbp/ar3iQFPnsdjFfE6nwrcN4kKKN4sgUL5uMGjuv
	 i4xSik6jWyvxpgFilaBlhR9mqeARrZYZfXnqVtCzfBgzzdLrkNiHgljinYnOhBR6B
	 JEr4yjM+jZdnu1xZyUdiEG/5eraDF4xH5i+Xp/BdnBhCv/gfHgnwqIGTrH/YLcmEZ
	 c8Cnc+lCTMYYJCP4SQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([104.151.5.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1sBWeH3wtB-005OuM; Mon, 24
 Jun 2024 16:13:25 +0200
Date: Mon, 24 Jun 2024 16:13:23 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
cc: git@vger.kernel.org, "Randall S. Becker" <randall.becker@nexbridge.ca>, 
    "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
In-Reply-To: <20240621180947.64419-2-randall.becker@nexbridge.ca>
Message-ID: <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca> <20240621180947.64419-2-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pdq3cr40cWThDN30AIUi0XkX2dBeUHd1dyjSzu+c/62oD98NiU7
 Ip60GKcWiT+Rmar1YQYS75cLul8eFju9OBcLMMKxQDVTsN0Boj7VgAOrV4vZvKKuNFwusRr
 817NI8n1SymiZf7qR7Ji+J3UnDBz5x8/hSDOtVqvD/BMlCNmHcKCv7joG2ixE0YlriWD9rL
 VQT9TWp4tNabPRANjazvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d3A5Nh0Aoc0=;MSAn7zolB+rn8oW1Fl0fwsx36Vr
 xhJFL4hibjJh1Pe8tgVhUJmOYla20j31G5ky7yB1RmR1K7ahCBtD3FYtYZU75iDYW4rQrqtX+
 iftAFWeg2eWxM/tWSWsjsQAeHBdyzUEIruKTaKf3zryPD97wuXBErR5uybzd+cA2KZAham12c
 I68XEcpY+0ELDvv9yuedTRIYufL6JLeRX2Xaiz4j8mfIheX/xeRRKth5UqqhZt3C8rMUXIkoE
 uzUHGEONB8LEKa6vgGwg4k3w/JQEIjN9Pozl03c4CqDNfX0gtrM9N4r83xdiTJFiveJuDxUoC
 SQq/HH48pYulSeyDeONwknT+SQ7gMx5wB4bYaOql1r2BWVfnw8ssSiP4w/H3YeB48BylyOgD4
 RHov2OoJqyngBPerv/mkp7g0gKosnMcY1qEAzsBP6zJnwbZ37FuaVLYdlmAqSUggQhjcfq+x8
 TJX4anK1KF3kE+dUhfVPI5sCXegPNJf6xOtyZsPwuuufs9G3NJiaE8fye/FJxsP3rSTN5elea
 LQDBhVYn1d08ZqGIcreB/QI+hkfG0FUYcRsnCNTvLU14lduB2ThhmYveQ5dL1HZGYCeM0VugO
 rY/qXsoK81auJkdIA2l7ZkqZfekYiEj58GBJ/8rptll1lLSBAUi2i2oVgNg/Gr93VbHHQPuj/
 GkrSrlafT1Os3Zi5TChY1OKSMMpQZImYBc1dOhlY0oEz8BkpRD2AK4t6X0lLpMLbozCmtpDin
 DamVsUxeuMDbq3BuZkVPhErrOp2obwN19OHE3QcOvYdVMXoGIqOGgolameL1As8s9+kPIWAYi
 +WdHj3DibH0ecnjFC0TdWtPTjUL90qi2M+8C3dGPWqyZk=
Content-Transfer-Encoding: quoted-printable

Hi Randall,

On Fri, 21 Jun 2024, Randall S. Becker wrote:

> This change uses the libcurl LIBCURL_VERSION #define text macro. No
> stringification is required for the variable's use. If the #define
> is not present, that version is not reported.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  help.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/help.c b/help.c
> index 1d057aa607..bf74e935b9 100644
> --- a/help.c
> +++ b/help.c
> @@ -1,4 +1,5 @@
>  #include "git-compat-util.h"
> +#include "git-curl-compat.h" /* For LIBCURL_VERSION only */
>  #include "config.h"
>  #include "builtin.h"
>  #include "exec-cmd.h"
> @@ -757,6 +758,9 @@ void get_version_info(struct strbuf *buf, int show_b=
uild_options)
>
>  		if (fsmonitor_ipc__is_supported())
>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
> +#if defined LIBCURL_VERSION
> +		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);

I am not sure that this is the most helpful information Git can provide:
It reports the version against which Git was _compiled_, whereas the
version it is _running against_ might be quite different.

Wouldn't calling `curl_version()` make more sense here?

Ciao,
Johannes

> +#endif
>  	}
>  }
>
> --
> 2.43.0
>
>
>
