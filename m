Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279319BC8
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540414; cv=none; b=t4kzqjloorHCxZa3z5UXtKM9dvI5aFVTZtJqhHciErspVDDdilD3C0eaaR9u7RjSpxwkLSxgfblZXNaJgVrFn9bA2DWVxyObmuyvNcSPZVObFoJ348I96MrI4SBDH/Aa/yLGQ2VigsDvFmyhMe5sV0sMB3olwog/0SVycNnL9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540414; c=relaxed/simple;
	bh=M/CpNee2TfvKFIkfE+HYE1U68PGIgQbeJJW9hTi9e8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Etn5qGks/KH3q2XLWah3r76Z+Ckym0pEAOhmYOR3+1g51q4YxZIMp7ksT99sgC6+sia3B7kkf+51sZ07tnX1rliDxcb7ab9n7RdeltJcQbzd+Ju9C7T73yZhnjkfrAyecAIzsckc+unR/KEfDqd9xnR1Mwjb6q6rxeqS4cXV5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jWKUPO6W; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jWKUPO6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789540400; x=1790145200; i=l.s.r@web.de;
	bh=dz7fjHS2XYsb1M709ScuUBob/RkaOgm22N5BJ5nuiIc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jWKUPO6WC/pFz/81NjxLxlUQuygbBwB5Wjoe9+ynxCNYrduEFKer5FW9EwVcv+fP
	 W7yWSKlVnMIZgJfp6be9s43sqNStArwBOyLos8mgMzzhbqLczekobiGZ2wpNbArob
	 vuC0V5Bk3got8tuPR9en43XK4oNSf5uaVUn1nCva+Dr76YjThcpsdy8UOEpcaElbO
	 69A46PswsIrls4zJTbCiWrA93/gdxqQQ3X8z83vCR4D9frwgFIUWBk5FHCjFNwRnI
	 684PxCDAVxXenF9SI9tCdb0XNIJuooslDzYWeX9xm32qkvy++B/zA1FSBZr5FCq/6
	 1WdI5jyGAmlnMkamXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX5T-1wQDNV1fjZ-00n2Sv; Wed, 16
 Sep 2026 08:33:20 +0200
Message-ID: <bf0351d8-05fe-4f77-958a-2ac59495029c@web.de>
Date: Wed, 16 Sep 2026 08:33:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] compat/winansi: fix die_lasterr() argument formatting
To: Yongqiang Tian <yqtian668@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Johannes Sixt <j6t@kdbg.org>
References: <20260916042312.35891-1-yqtian668@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260916042312.35891-1-yqtian668@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RzWXo6P2iU0A2HChLUdpBXqb1s15ED7+BV6yanx2Uq+SfRLyc2z
 UgmluWyaULdg9LG2u3BVtpJupzoiM8cOpo+yFsT+uXKTjJeIewbnkOVZdiB3fOFP/QpgAi8
 gz0dvha+enVl9fLGoeyZqvA8nb90q09FJdLaU1AOPMGU5tto1HjjVIGYDiTO4dHuht5U8FR
 set9ZJgjPCB4qp5Ee6Yvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SDLjnuWrZng=;qQgbcApbW3ulhqeWzXWK2MV5jKE
 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
 RMOMNTw3d57xxlamPvwyzS

On 9/16/26 6:23 AM, Yongqiang Tian wrote:
> During WinANSI initialization, duplicate_handle() reports the handle
> when DuplicateHandle() fails:
>=20
>     die_lasterr("DuplicateHandle(%li) failed", ...);
>=20
> die_lasterr() collects the formatting arguments in a va_list, but
> passes that va_list to die_errno() as an ordinary variadic argument.
> die_errno() consequently formats the representation of the va_list
> instead of the supplied handle, producing an incorrect fatal message.

Good find!

> The other current callers pass fixed strings and are unaffected.
>=20
> Git does not provide a va_list-taking variant of die_errno(), so format
> the caller's arguments separately with strbuf_vaddf(). This consumes the
> original va_list correctly and produces the complete diagnostic prefix,
> including the handle supplied by duplicate_handle().
>=20
> Save GetLastError() before formatting because calls made while growing
> the strbuf may change the thread's Windows error value. Convert the
> saved value to errno only after formatting, then pass the completed
> message to die_errno() through a literal "%s". This prevents any percent
> characters in the formatted message from being interpreted a second
> time, while allowing die_errno() to append the corresponding system
> error and terminate as before.

That all makes sense, but is quite complicated.  die_errno() itself uses
a fixed-size buffer to avoid heap allocation, for robustness and to
avoid changing errno.  How about turning die_lasterr() into a macro for
the same reasons?

	#define die_lasterr(...) do { \
		errno =3D err_win_to_posix(GetLastError()); \
		die_errno(__VA_ARGS__); \
	} while (0)

> The updated compat/winansi.c compiles with MinGW GCC 13. A Win64 probe
> under Wine prints a value derived from the va_list before this change
> and the supplied integer afterward.
>=20
> Signed-off-by: Yongqiang Tian <yqtian668@gmail.com>
> ---
>  compat/winansi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 3ce190093..5547192a2 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -7,6 +7,7 @@
>  #define DISABLE_SIGN_COMPARE_WARNINGS
> =20
>  #include "../git-compat-util.h"
> +#include "../strbuf.h"
>  #include <wingdi.h>
>  #include <winreg.h>
>  #include "win32.h"
> @@ -438,11 +439,15 @@ static void winansi_exit(void)
> =20
>  static void die_lasterr(const char *fmt, ...)
>  {
> +	DWORD err =3D GetLastError();
> +	struct strbuf message =3D STRBUF_INIT;
>  	va_list params;
> +
>  	va_start(params, fmt);
> -	errno =3D err_win_to_posix(GetLastError());
> -	die_errno(fmt, params);
> +	strbuf_vaddf(&message, fmt, params);
>  	va_end(params);
> +	errno =3D err_win_to_posix(err);
> +	die_errno("%s", message.buf);
>  }
> =20
>  #undef dup2

