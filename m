Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD3E571
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764015736; cv=none; b=he+dRiaKiTIBN4UE3cKV+lhYnnl+6T6zkBcL22DDs9NrSlXixF01/BGZHoZrqfPOHrr7estuiqJKQuQoYhkHefvRkwa8Dw8KHAHpEP6TpXw7PYkwz6UCbceyfYA4dLF6RZEH0l2XVr3PiGZZjLHTv6FPWv7uSQiiZZYL4Afa83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764015736; c=relaxed/simple;
	bh=Vg15PfQ2qlwVlXnw8g23pfppaOwEJQY2lbd8nfwW1GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=BYLjyKJ/Jz3VnhLV8pyMQjYhY1vUp2ByqLEAZu2YHT7FcSoHHiGX5pCXoF/CwkbT44OfZSUcW6vPYrP/8xrmPOEdBX0AGMUdDEpcjiVbEPceQb71X/xghidrXHapd3i750xqCxymNync6qZfoJJ8oSQ7wiPXgfR+N6lWt6jdGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=m13YJ/hU; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="m13YJ/hU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764015723; x=1764620523; i=l.s.r@web.de;
	bh=BVEZxA/BjLLfIeO3yuxgveHue/W5CYIXSQRw5gKirK4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m13YJ/hULNMJJjVpjGS6lzx32M5TQTvGDGSBRzh7uWoh+Ixps12lSv4TuN5ltASn
	 w/0EJcSCXdSAVyxGmPtNFndWQRv028D4mtE1wHl9SPRQW7vFkEpX8rBzCD3JMvABr
	 PcuCHzIoUUmuJ+7s4gadlkx9YW4S51Xrk813YuIdO4MpOEXOh2ikSDWHCsDRVWQiI
	 yIHqVTRuxCwJ0TEkZkMy7j1Y3/wIMt+Sm4Z/bQnai574qA/NfaVqFz2d3Z76JbxI7
	 TB1HA1bOKxHhTXC1VcF6QmQuOndsPwsrP/uQLt468pX4PHJJBbidhG7zhtQZso5ex
	 EU+R/MsIBgz/qyh9ZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.127]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQcl-1vo8Fe1pmz-00m8yS; Mon, 24
 Nov 2025 21:22:03 +0100
Message-ID: <74cdfd68-f13e-4e45-9aa9-9629429ad0e1@web.de>
Date: Mon, 24 Nov 2025 21:22:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] erroneous suggestion for "--add" option in `git
 config set` error message
To: Paul Wintz <pwintz@ucsc.edu>, git@vger.kernel.org
References: <CADBJ995pDG9R8EJnK5nwWKPWAf-XF5P5KTY+bAx71EhdMvvO6A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <CADBJ995pDG9R8EJnK5nwWKPWAf-XF5P5KTY+bAx71EhdMvvO6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0fBManK3pLNJ63CboGaZKapKfZn59SEtB+LKjd2MItH9qgcnewU
 ornuI+KRQiZ61dbmgkBHJKwisWFz+bACQ/MBIlww4LVYstoSlTywnzEfSuJsGjdIMIHf2HW
 XoRYLl9HvJSNgdSY6cP0clIPjHSYLihOgUkUHQxMH3GHd+/xmww2IadQglxEkODoIm5Gt9e
 gjG9CaTsFi0y0/xUID9vA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ccflB5qkD4k=;ctJAEK1U5w3fOnKPUVb0D7XAdZ3
 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

On 11/21/25 12:39 AM, Paul Wintz wrote:
> It seems that there is an erroneous suggestion in a `git config set`
> error message when setting a value that already has multiple values.
> The error message says to use the `--add` option, but this option does
> not seem to exist. The `--append` option should be suggested instead.
>=20
> Steps to reproduce:
>=20
> 1. Create a configuration with multiple values:
>=20
>     git config set --global test.test 'hello'
>     git config set --global --append test.test 'hi'
>=20
> 2. Try to set the value of `test.test`:
>=20
>     git config set --global test.test 'hi'
>=20
> An error message is shown:
>=20
>     warning: test.test has multiple values
>     error: cannot overwrite multiple values with a single value
>            Use a regexp, --add or --replace-all to change test.test.
>=20
> 3. Following the direction to use `--add` produces an error:
>=20
>     > git config set --add test.test "aloha"
>     error: unknown option `add'
>=20
> The error message should say `--append` instead of `--add`.
"git config --append <name> <value>" still works, but your suggestion
is good nevertheless.

=2D-- >8 ---From 066828b25bb7d3086b9bff4188af30e07c7e1c16 Mon Sep 17 00:00=
:00 2001
Subject: [PATCH] config: fix suggestion for failed set of multi-valued opt=
ion

The command "git config set <name> <value>" balks at options with
multiple values and suggests to use old-style "git config" actions that
can be used to change some or all of them.  List modern "git config set"
flags instead, as they are more fitting in this context.

Reported-by: Paul Wintz <pwintz@ucsc.edu>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 75852bd79d..86e0cd77f3 100644
=2D-- a/builtin/config.c
+++ b/builtin/config.c
@@ -985,7 +985,7 @@ static int cmd_config_set(int argc, const char **argv,=
 const char *prefix,
 						     argv[0], comment, value);
 		if (ret =3D=3D CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --replace-all to change %s."), argv[0])=
;
+			"       Use --value=3D<pattern>, --append or --all to change %s."), ar=
gv[0]);
 	}
=20
 	location_options_release(&location_opts);
=2D-=20
2.52.0

