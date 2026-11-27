Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798487;
	b=YdSx/pnNFeNdcAxcRtR208J79TpZNUD6b9aajpACQnzTpkodjEvvEI4ZVZIV/MviBYIH
	 +SxaLvAJspVmm1cIspa8wrWBejTnkOtlGqj3U5xaVUEPolbeR9C1VZlcUCuAiYFzkAJQ+
	 JCgpJM3LQvIt0io3KeaNZ+FjxXaAYuZdeIyElveiomFGOWNUKADxTU5qqrUFWlok/Sdct
	 arf92nZ6a+QFrYvQHP/eVzT4xOVgUqKqf64tkbbK4PIpU5Pti7/LsE5bcj4pibL5H83ev
	 sjNCOtMeJhJDHfRbKyVZw9/KIRfpsunN+dkxExy8vCGCqhv+TDr128OL+oNUpuWAH0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zUbMg1uBKciYtUd5AvNOS51PwQFRURpwVRO5YAVFj0I=;
	b=2t8pnnpIOsMOa5vOHIb6r4O6qvToDQa5UqR5jGNddwbKjRwGuZAO5ckJF3YuseYQ5SHr
	 gVGECG33+TCx2Bvdo335tDzC0s7Y2zNVPZrNzC5CjEIAo6D0zXGgVHUcjY2o5oMzvXGlc
	 tEd6oVoRYLTL/VbonjEyzB0wzfrXhl9faF2aUZ//dqCcjw8TrHmMDQ69qqCHG80xkd3sM
	 9jaW954qETQZuugGgWEeni/2PtajkbkvuHagvGg19vGhE0zuDcc5vhSxq9riRzWin3JMA
	 W61ezoN0V6nDht+3Mx73fQe1rypbDTnF3uOzSXXMMmDzK8rOo4qp3tc+Umm3waKFlWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oztVsHll;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA95606A31F
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA95606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oztVsHll
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so4578624f8f.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798485; x=1796403285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUbMg1uBKciYtUd5AvNOS51PwQFRURpwVRO5YAVFj0I=;
        b=oztVsHllYTxkOkwxMxYknrEz3nPPnRlDccG5I6+i6O8MCEnhyix0psIvJNDIpwe02q
         VKqjjaZbqcws30sl1dK5D0c6sP/ZXOhSJSBR7RRdAptCHfhafB3xeqMOw/7qif8ZYTC1
         VxZQ/EBcdHvPzTmijjGjjHRSOGcmfN4cWkmWJVCPZLK3GUsAmlJV8hPRTo1wHS3uUUop
         6kMTx1H8MF3Nc2U4I3GO+e/Dg/6D+10NjyJsyGG1b/Ijnf0GyCNaT8nxltEV2Ny6ziZ5
         2+079TUz9DumtDkjvEw0Sz3xX1ZXBHKBjQVTi8RXP7GoaKWbhvnP8pexZVeuubBMUsdB
         4wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798485; x=1796403285;
        h=content-transfer-encoding:content-type:mime-version:reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zUbMg1uBKciYtUd5AvNOS51PwQFRURpwVRO5YAVFj0I=;
        b=S+IIKZPLYjC+dF/8hbEphJ4Fu+edZ6vKgPMbMMOOKyeCqMpH/zdBYzKlEWZNnEqzTg
         XT6upLcQqdewT8IA/w9JYrEhSfgoSWf7Svfiflt/1MqTiW+xlbZBfQgoWIQYhI5jegzv
         weC7uvTS+7KoIt1DVfbK+tYUWRQEV4kXuIZldMpVsUVRQrblN6bH3VSrmh15JVvs1Kt8
         swg7Ua5Di3RhRxOrxSTW8twNCXMcU3SVq9JmAcVKI/mLWNqHt8F9AIfxrzsX+hZ2/Xty
         U5l73/Qmkeg8crL7PPYZoLT07QPK5m4N/8U53b8dd4SNbCUPXW66a212+YKmPS6UIL3J
         PKKw==
X-Gm-Message-State: APuU4Z/85OltrmLZEHKvZAigD2M2keoCGEHsCV66s0y6Ymg56NYoeRcm
	yYHQYOjvzDZNdZPLY3ttqZf8FCqG5G2MUJcucAyzbXckKm1TZKMiXP6OYFtb/w==
X-Gm-Gg: AZFdTZdZDEmf0jNXNJG3t/nL9E14V2gDhSPSpV3ABXTGAGTrUT7M8OswyVhaRkBo3UU
	/M64VlgBgsaFUCUjsJNrr71xiZSbnVQ+ESs+iK/5kxpsVaVWcAGGdMgoNoQ81D3iGncwTgATQxu
	MnWPNofwuxQNjNGisGkeU7JKTAp2PxnHS99D+KRfT9eugEQYFVMUQ/XZ8S4tbdJIFeKASArvul2
	9AqgUTV8/bMxdIkjQrh3fbIbCihl2VFQAxpl24/G4ywUiziOZfAC5abmtW8qdlTfyK65PRj7z+B
	NNnpejSdZIA8RiorEcDR8xnhNkPxfFyoQl126Mki2pF2/UXj1cfR+ps0Uw0WmXrr+7anHCYIVHY
	nPwPTUy4vvKWv04igod74GdJfDIXhlfCgBvC0/e5gKtKgOyAJjp9DZ57oen0ZvA19KkwCocsz5m
	GbML6bvLed4wYOmABN/FP5dyGurBnZv53hGGP5qUZg7Ev3NgAsppcz13JJGs2rLPUylZN+y0KMb
	sATzruvl2ChWQz75/ZJPzdGROPPIpgtR045qiAY6xWIf/xxU30LTpBhKgpFSAS2N4/3V1E6gpce
	XDlfd3fCz/oFAScnTw/iTykGlyIe8yZhMYc4VF0Gta+dg0Hk4irItw==
X-Received: by 2002:adf:e010:0:10b0:4a7:518f:bea6 with SMTP id ffacd0b85a97d-4abb3a4d2b1mr35901195f8f.28.1795798484521;
        Fri, 27 Nov 2026 08:54:44 -0800 (PST)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm46440606f8f.56.2026.11.27.08.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:54:44 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	MD Nahid Hasan Sagor <nahidhasan141400@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [RFC PATCH] quote: make sq_quote_buf_pretty() prettier
Date: Fri, 27 Nov 2026 16:54:27 +0000
Message-ID: <ee7de58093c69fbbab686a68b5b781bc60d90a2b.1795798429.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.1.576.g0cfbda1d5c7.dirty
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The output of sq_quote_buf_pretty() is intended for human consumption
and as such it tries to avoid unnecessary quoting. However, it
is over enthusiastic about adding quotes to multibyte strings and
strings containing '~', '{' or '}'. It also adds unnecessary pairs
of empty quotes when a string starts or ends with a single quote. Fix
this by using a dedicated quoting routine that tries to avoid adding
unnecessary quotes, rather than reusing sq_quote_buf(). Tilde is only
quoted if it is the first character. Braces are only quoted if there is
a mismatch between the number of opening and closing braces, or they
contain a comma or a character that needs quoting. Sections between
backslash escapes are only quoted if they contain characters that need
to be quoted. The table below shows the change in output for various
inputs. The aim is to make the output more readable without changing
the meaning of the quoted output were it to be evaluated by the shell.

We could further improve the readability by dropping support for csh
which requires that '!' is backslash escaped. It is not clear to me how
widely used csh is these days, none of the big three BSD distributions
seem to have used it as the default shell for a number of years.

Text		Current output		New output
danger!		'danger'\!''		danger\!
'look out!'	''\''look out'\!''\'''	\''look out'\!\'
Dvořák		'Dvořák'		Dvořák
HEAD~3		'HEAD~3'		HEAD~3
HEAD@{1}	'HEAD@{1}'		HEAD@{1}
HEAD^{/,}	'HEAD^{/,}'		'HEAD^{/,}'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
Following on from the discussion at [1] this tries to improve the
readability of the output without changing which shells we support
which is a bigger change that requires more thought and discussion. If
we do decide to go the route of per-shell quoting the changes here
will be useful for supporting POSIX shells.

There aren't any tests yet, though I have tested it manually
by looking at the trace output from commands like

   GIT_TRACE=1 git -c alias.z='log -1 HEAD~1' z

I'll add some tests if there is interest in this patch. On that subject,
does anyone know how to easily write table driven unit tests in clar
with a separate test for each input?

[1] https://lore.kernel.org/git/02A50A47-A048-417E-9D1E-0C12D8FB1476@gmail.com

base-commit: 77904e546de3bd940621092ecec47a88d0cede5d
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fsq-quote-prettier%2Frfc-v1
View-Changes-At: https://github.com/phillipwood/git/compare/77904e546...ee7de5809
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/sq-quote-prettier/rfc-v1

 quote.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/quote.c b/quote.c
index 235fac8e470..dfd379a102f 100644
--- a/quote.c
+++ b/quote.c
@@ -47,26 +47,79 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
 	free(to_free);
 }
 
+static bool needs_sq_quote(char c, unsigned brace)
+{
+	if (isalnum(c) || (unsigned char)c > 0x7f)
+		return false;
+
+	switch (c) {
+	case ',':
+		return brace > 0; /* Prevent brace expansion */
+	case '}':
+		return !brace; /* Quote unpaired '}' */
+	case '~':
+	case '+':
+	case '-':
+	case '.':
+	case '/':
+	case ':':
+	case '=':
+	case '@':
+	case '_':
+	case '^':
+		return false;
+	default:
+		return true;
+	}
+}
+
 void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
 {
-	static const char ok_punct[] = "+,-./:=@_^";
-	const char *p;
+	const char *p = src, *q;
+	bool quote_it = false;
+	unsigned brace = 0;
 
 	/* Avoid losing a zero-length string by adding '' */
-	if (!*src) {
+	if (!*p) {
 		strbuf_addstr(dst, "''");
 		return;
 	}
 
-	for (p = src; *p; p++) {
-		if (!isalnum(*p) && !strchr(ok_punct, *p)) {
-			sq_quote_buf(dst, src);
-			return;
-		}
+	/* '~' is only special if it is the first character */
+	if (*p == '~') {
+		quote_it = true;
+		p++;
 	}
 
-	/* if we get here, we did not need quoting */
-	strbuf_addstr(dst, src);
+	for (q = p; *q; q++) {
+		if (need_bs_quote(*q)) {
+			if (brace)
+				quote_it = true;
+			if (quote_it)
+				strbuf_addch(dst, '\'');
+			strbuf_add(dst, p, q - p);
+			p = q + 1;
+			if (quote_it)
+				strbuf_addch(dst, '\'');
+			strbuf_addch(dst, '\\');
+			strbuf_addch(dst, *q);
+			if (!brace)
+				quote_it = false;
+		} else if (*q == '{') {
+			brace++;
+		} else if (*q == '}' && brace) {
+			brace--;
+		} else if (!quote_it && needs_sq_quote(*q, brace)) {
+			quote_it = true;
+		}
+	}
+	if (brace && !quote_it)
+		quote_it = true; /* Quote unpaired '{' */
+	if (quote_it)
+		strbuf_addch(dst, '\'');
+	strbuf_add(dst, p, q - p);
+	if (quote_it)
+		strbuf_addch(dst, '\'');
 }
 
 void sq_quotef(struct strbuf *dst, const char *fmt, ...)
-- 
2.56.1.576.g0cfbda1d5c7.dirty

