Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323CD7262B
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156035; cv=none; b=s+Gri9viFWMWNcWALqP2Lsznf6D6Pd4SGaJ9jqrHPjqf7CLmRtcRmon+ZjokZqk+XQgdOpvjJK7PtmoW0vK01gfXbnr3wlo0O+6L80kapsJxbqUrDtNof+lUljO06ld+75kxBpnWnetZxYLQjCYxUBFzCabLIUn1Hh99lAEGPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156035; c=relaxed/simple;
	bh=bu8Q7HFLQRqcM8/lPtIUuC6WNeL5YWdh+cs2GjN+5CU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IzGSGSH4yoM6wMblEHhhoS+t9jhLrlcXY2AJNXftZ1BobrHWBtjZkSEpbUfh7uyPHgcANe6L2QEJEYEWSgMz1RlHQLwifoiDJscMkGAqgVcRTeVclnmV88zE/l1kgke0zVXUdj7FGVcP73XYg94T8QUGtcM7eV/utBlReRC9L6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBFn0Epw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBFn0Epw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4532ff4331cso15264585e9.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750156031; x=1750760831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t/XDxZV3Xe5sDRNAwbUmTbNBEKX2H37htR+G36wjDZw=;
        b=IBFn0Epwlb8PoRKxsyS7N0CcUL0SpRfc2giSHpcLNWc/7QULzN1c6/c8hq6+iK3u+F
         9VLXKtQhkMI1aJl739ysd4bF17V0+iZtPR2jHU9Q5nTH1v/oI1dp3h+IKQvfeSnpnnib
         zUGuLqlOa0waJUvq+pcDVS7FkFIkBHl7jd6TsUuUhYWxx+p/FTSGElF7ZuFaZtwBW03P
         fHDf8hG87BnXNsl4J7U6ECn/lFSDQNS/OOj3cuFbhYSJMhr1vu8xQqzRI9dA9GCeypcZ
         GjUyhdMnbnKRPOFK6swiwjyJ15tt7aZz5Wj2dEloBKA0ikLfXR6/oZU5VDrdULTMR0un
         B5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750156031; x=1750760831;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/XDxZV3Xe5sDRNAwbUmTbNBEKX2H37htR+G36wjDZw=;
        b=cNXzkLHW/UOS36LhSwPtb+ces2KvJI9HddDRZbK6ZmoDGih6MvgBhOesVIaZVeCM/C
         Zcaz7kCWcbMxMW4/U2Pfmv01OBZyUomZj9+eoUoxPdlUQf/4s0Tkwtql4fuzvzDvw/Au
         +XJeucOTMNiVQqii3qpCxicOJAv3rF0KXHuOEGcU2a7GIRlsQgz1X3qfnDn+eBwttLkB
         95sCHigJOMuhtni10OmL9riTeWVfcl4aHtlFRW+EFGstBKhMk8qx4Dra2mWydHXaLxtq
         jULeLumXumcWf700u34lL68D6nbm6Nan6wacAzmMCZJk1a78UsS1coZRIDpzpvsG4aN8
         5f2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHphp3X1hMA00jEJsDmUa3/NYU6pHVefu6nH0HRZAA93W1CeX2COdhcWnejjdFf7pky/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHldKOhutZ0mxShh4DOzCcjiM1nWpyaEV126DGWDBweQolWFoC
	d+EZTP1Xgv/OHs4lizu4gWEj7JtAzsdaK/fRmBWRligBJdBGV306omLU
X-Gm-Gg: ASbGncvd94G3R3cuvjQXQOOPsvXTs3vqND1iSs/34mQxMVdU3oPveptQ/+WE2Gge21u
	gwAvkLWTi1SwPHXNPbLwJ0ITV5Yic/DlGBW+sZxi7KEb+xMZwHNR/6Lz8R/e2YIbpkhXksJOCk5
	wjIjH8Ht6kqEBHBSVQxo4+q7HrgGDNM628IToA+CxlgXbtPQ4im6TsVW1c0uxSs65zRYen/PWU7
	KhtvaQSvfqwnOpN07ilNpF71r8flFrvzenihZvHZ02VO8D+kQU7hT/4Jt8WYKl/AYN/s6tBXbil
	sl/b6m5pgU06L1PxPT75J8FT607Z65B2z86AvJ9KPAoRY9oJwhwfxG6lk+ss3cP+3y1tohBgVsY
	10WscyQ==
X-Google-Smtp-Source: AGHT+IHQejhdZkq1cQyc11HH5FRT967dnkwPgJMkumCDLBbZ4cdjD63YrxzdQQfSRAbIAhPgiHpFqg==
X-Received: by 2002:a05:600c:6095:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-4535627dbe5mr2760405e9.8.1750156031209;
        Tue, 17 Jun 2025 03:27:11 -0700 (PDT)
Received: from ?IPv6:::1? ([2a02:c7e:62c0:f800:bbf9:48de:266d:f95f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e22460bsm180471065e9.6.2025.06.17.03.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 03:27:10 -0700 (PDT)
Date: Tue, 17 Jun 2025 11:27:09 +0100
From: Phillip Wood <phillip.wood123@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v18_04/10=5D_imap-send=3A_add?=
 =?US-ASCII?Q?_support_for_OAuth2=2E0_authentication?=
User-Agent: K-9 Mail for Android
In-Reply-To: <PN3PR01MB9597607108917195B9690F67B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <PN3PR01MB9597607108917195B9690F67B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <F0A06034-99B8-4BD1-9CDE-515A3EA430DA@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm not really on the list at the moment but I saw this was slated for next=
 in what's cooking=2E Apologies if the formatting is off, I'm in my phone=
=2E=20

On 9 June 2025 21:22:49 BST, Aditya Garg <gargaditya08@live=2Ecom> wrote:
>=20
>+static char *oauthbearer_base64(const char *user, const char *access_tok=
en)
>+{
>+	int raw_len, b64_len;
>+	char *raw, *b64;
>+
>+	/*
>+	 * Compose the OAUTHBEARER string
>+	 *
>+	 * "n,a=3D" {User} ",^Ahost=3D" {Host} "^Aport=3D" {Port} "^Aauth=3DBea=
rer " {Access Token} "^A^A
>+	 *
>+	 * The first part `n,a=3D" {User} ",` is the gs2 header described in RF=
C5801=2E
>+	 * * gs2-cb-flag `n` -> client does not support CB
>+	 * * gs2-authzid `a=3D" {User} "`
>+	 *
>+	 * The second part are key value pairs containing host, port and auth a=
s
>+	 * described in RFC7628=2E
>+	 *
>+	 * https://datatracker=2Eietf=2Eorg/doc/html/rfc5801
>+	 * https://datatracker=2Eietf=2Eorg/doc/html/rfc7628
>+	 */
>+	raw_len =3D strlen(user) + strlen(access_token) + 20;
>+	raw =3D xmallocz(raw_len + 1);
>+	snprintf(raw, raw_len + 1, "n,a=3D%s,\001auth=3DBearer %s\001\001", use=
r, access_token);

This looks very fragile=2E It would be safer to use an strbuf or if there =
are no embedded nul bytes xstrfmt() and strlen()=2E This applies to the nex=
t patch as well and any others that are building strings with snprintf() or=
 memcpy()=2E=20

Also the comment above mentions the host and port but I don't see them her=
e=2E

Thanks

Phillip

>+
>+	/* Base64 encode */
>+	b64 =3D xmallocz(ENCODED_SIZE(strlen(raw)));
>+	b64_len =3D EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw,=
 strlen(raw));
>+	free(raw);
>+
>+	if (b64_len < 0) {
>+		free(b64);
>+		return NULL;
>+	}
>+	return b64;
>+}
>+
>+static char *xoauth2_base64(const char *user, const char *access_token)
>+{
>+	int raw_len, b64_len;
>+	char *raw, *b64;
>+
>+	/*
>+	 * Compose the XOAUTH2 string
>+	 * "user=3D" {User} "^Aauth=3DBearer " {Access Token} "^A^A"
>+	 * https://developers=2Egoogle=2Ecom/workspace/gmail/imap/xoauth2-proto=
col#initial_client_response
>+	 */
>+	raw_len =3D strlen(user) + strlen(access_token) + 20;
>+	raw =3D xmallocz(raw_len + 1);
>+	snprintf(raw, raw_len + 1, "user=3D%s\001auth=3DBearer %s\001\001", use=
r, access_token);
>+
>+	/* Base64 encode */
>+	b64 =3D xmallocz(ENCODED_SIZE(strlen(raw)));
>+	b64_len =3D EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw,=
 strlen(raw));
>+	free(raw);
>+
>+	if (b64_len < 0) {
>+		free(b64);
>+		return NULL;
>+	}
>+	return b64;
>+}
>+
> static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
> {
> 	int ret;
>@@ -903,9 +969,51 @@ static int auth_cram_md5(struct imap_store *ctx, con=
st char *prompt)
> 	return 0;
> }
>=20
>+static int auth_oauthbearer(struct imap_store *ctx, const char *prompt U=
NUSED)
>+{
>+	int ret;
>+	char *b64;
>+
>+	b64 =3D oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
>+	if (!b64)
>+		return error("OAUTHBEARER: base64 encoding failed");
>+
>+	/* Send the base64-encoded response */
>+	ret =3D socket_write(&ctx->imap->buf=2Esock, b64, strlen(b64));
>+	if (ret !=3D (int)strlen(b64)) {
>+		free(b64);
>+		return error("IMAP error: sending OAUTHBEARER response failed");
>+	}
>+
>+	free(b64);
>+	return 0;
>+}
>+
>+static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSE=
D)
>+{
>+	int ret;
>+	char *b64;
>+
>+	b64 =3D xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
>+	if (!b64)
>+		return error("XOAUTH2: base64 encoding failed");
>+
>+	/* Send the base64-encoded response */
>+	ret =3D socket_write(&ctx->imap->buf=2Esock, b64, strlen(b64));
>+	if (ret !=3D (int)strlen(b64)) {
>+		free(b64);
>+		return error("IMAP error: sending XOAUTH2 response failed");
>+	}
>+
>+	free(b64);
>+	return 0;
>+}
>+
> #else
>=20
> #define auth_cram_md5 NULL
>+#define auth_oauthbearer NULL
>+#define auth_xoauth2 NULL
>=20
> #endif
>=20
>@@ -1118,6 +1226,12 @@ static struct imap_store *imap_open_store(struct i=
map_server_conf *srvc, const c
> 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
> 				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth=
_cram_md5))
> 					goto bail;
>+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
>+				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER=
, auth_oauthbearer))
>+					goto bail;
>+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
>+				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_x=
oauth2))
>+					goto bail;
> 			} else {
> 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
> 				goto bail;
>@@ -1419,7 +1533,16 @@ static CURL *setup_curl(struct imap_server_conf *s=
rvc, struct credential *cred)
>=20
> 	server_fill_credential(srvc, cred);
> 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
>-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>+
>+	/*
>+	 * Use CURLOPT_PASSWORD irrespective of whether there is
>+	 * an auth method specified or not, unless it's OAuth2=2E0,
>+	 * where we use CURLOPT_XOAUTH2_BEARER=2E
>+	 */
>+	if (!srvc->auth_method ||
>+	    (strcmp(srvc->auth_method, "XOAUTH2") &&
>+	    strcmp(srvc->auth_method, "OAUTHBEARER")))
>+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>=20
> 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
> 	strbuf_addstr(&path, srvc->host);
>@@ -1437,11 +1560,22 @@ static CURL *setup_curl(struct imap_server_conf *=
srvc, struct credential *cred)
> 	curl_easy_setopt(curl, CURLOPT_PORT, (long)srvc->port);
>=20
> 	if (srvc->auth_method) {
>-		struct strbuf auth =3D STRBUF_INIT;
>-		strbuf_addstr(&auth, "AUTH=3D");
>-		strbuf_addstr(&auth, srvc->auth_method);
>-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth=2Ebuf);
>-		strbuf_release(&auth);
>+		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
>+		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
>+
>+			/*
>+			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
>+			 * upon debugging, it has been found that it is capable of detecting
>+			 * the best option out of OAUTHBEARER and XOAUTH2=2E
>+			 */
>+			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
>+		} else {
>+			struct strbuf auth =3D STRBUF_INIT;
>+			strbuf_addstr(&auth, "AUTH=3D");
>+			strbuf_addstr(&auth, srvc->auth_method);
>+			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth=2Ebuf);
>+			strbuf_release(&auth);
>+		}
> 	}
>=20
> 	if (!srvc->use_ssl)
