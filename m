Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678823D7FF
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010382; cv=none; b=PV2704qzOLDgboYBUEGX7X2Nmux63Rj2dE2Cz9ZVWzRWmO5yu+UVq/ESpK4RLJxhJcWan82nTJ+oAiJl0EYkt2fgcqE56ouZAX4xA/3c161rXgZxBphAzm3TWvEsfuRdnrNjnf5tdbMfIpNvU3Aii3JIOxX1Xiqd6hcs1/Yc1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010382; c=relaxed/simple;
	bh=FHZbl58ukwHt1L1rxIWV5GPzgt5xyB9UihGnw7kfY3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJMCQFMF8qNXqP9oUi6U4fjz7g4AgnPIV1kanV//tDvLmTzW4fUxCotSIXdaYJg6FYuOPziQXanPgLWrKpYeoRV/d8EkIu4czcyr5aFVa/W9hXjlqU8967dxsEkrb46KfCBdsfRMzN0xSs3VEnMpEdveBNZDlhkuYCNeI3y6vYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=QP63uo3U; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="QP63uo3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778010378; x=1778615178; i=l.s.r@web.de;
	bh=nr9hweyjJzFGZZHHmpqLjretym256QJdvUVaUCIHR6s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QP63uo3UvYDpl0dbhjkgdN5pWwc1VGm3Akkeiqe2oJ8yka61mdKESH5nVu14rvCg
	 oCgWmavTUdYT6/BvwVBZt+IiQJRIXn7b7pUnOwN2jWdBBTIjOy9/FSrst444u25Z9
	 YvMOVJ6EL+GZe5O3CFyQ8nsL8PKBc9HxCclvQwiQ5M4QrJfu2w+erxohGIUb8xMrJ
	 AZEeqhnUaBRQdNR9SdAJ2HRsDiUd/fn7E/n7Mnm9Mf/TonUyisLtD2AE4yTvVgSu5
	 R2btbwiLZUist2xuRsYsS/rYPeXEzHgCgcpUwi4Sb6uvYPpsFxmm2gkq4xQk6lXme
	 Ah5wRSs6m+Ah7VQwNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6pZ-1vNrZC0hTj-0180AL; Tue, 05
 May 2026 21:41:01 +0200
Message-ID: <3364c573-b7f4-4ec0-b471-312aa11028fe@web.de>
Date: Tue, 5 May 2026 21:41:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git trims the last character of content from remotes
To: Chris Torek <chris.torek@gmail.com>,
 Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Cc: git@vger.kernel.org
References: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
 <CAPx1Gvf5Vts3oS2BdFQ4PpCR-UY=5cYW7fgOkRuQpi8ug2JXDg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPx1Gvf5Vts3oS2BdFQ4PpCR-UY=5cYW7fgOkRuQpi8ug2JXDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0pZ6oQOJdWfNuPcPJ+ArNsITH012s0X1EFX518TlUwU8VfelBnc
 MLhA/eZMGHAPcSeFT2dc/oeO7aTQGNdmkzbPJBG7ltGiwyAmYT518mxYwOZFYiOjKi+a2S+
 7mUUGGT5xQAnDP0s/bObLDfINbqu59IQ6TaWSV4U6CoL0AnvCBy2AbXR4sPkSEIr8nUJ4FF
 yITFHdluCXOlIm7q2XkXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fXGz+fg1iF0=;7YWRmUaM42TqYkGQHJZpKU0cowI
 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

On 5/5/26 2:34 AM, Chris Torek wrote:
> On Mon, May 4, 2026 at 10:02=E2=80=AFAM Hugo Osvaldo Barrera <hugo@whyno=
thugo.nl> wrote:
> [snippage]
>> When the width of a whole line is the same as my terminal width ...
> [snippage]
>> ... sideband.c prints ANSI_SUFFIX =3D "\033[K", this escape
>> sequence being "clear the line from the current position until the end =
of the
>> line", and this is the root cause of the issue.
=20
> If you have a non-empty prefix
> string before this "clear to end of line" suffix, the solution is more
> obvious: print the ESC [ K as a *prefix* rather than a suffix, but
> that fails with the empty prefix.
We do have a non-empty prefix, but why would it be necessary?  What's
wrong with clearing the full line starting from column 1?

Anyway, do you mean something like this?


diff --git a/sideband.c b/sideband.c
index ea7c25211e..5bfdd1d372 100644
=2D-- a/sideband.c
+++ b/sideband.c
@@ -120,7 +120,7 @@ static void maybe_colorize_sideband(struct strbuf *des=
t, const char *src, int n)
=20
 #define DISPLAY_PREFIX "remote: "
=20
-#define ANSI_SUFFIX "\033[K"
+#define ANSI_PREFIX "\033[K"
 #define DUMB_SUFFIX "        "
=20
 int demultiplex_sideband(const char *me, int status,
@@ -129,15 +129,19 @@ int demultiplex_sideband(const char *me, int status,
 			 struct strbuf *scratch,
 			 enum sideband_type *sideband_type)
 {
+	static const char *prefix;
 	static const char *suffix;
 	const char *b, *brk;
 	int band;
=20
 	if (!suffix) {
-		if (isatty(2) && !is_terminal_dumb())
-			suffix =3D ANSI_SUFFIX;
-		else
+		if (isatty(2) && !is_terminal_dumb()) {
+			prefix =3D DISPLAY_PREFIX ANSI_PREFIX;
+			suffix =3D "";
+		} else {
+			prefix =3D DISPLAY_PREFIX;
 			suffix =3D DUMB_SUFFIX;
+		}
 	}
=20
 	if (status =3D=3D PACKET_READ_EOF) {
@@ -172,7 +176,7 @@ int demultiplex_sideband(const char *me, int status,
 		if (die_on_error)
 			die(_("remote error: %s"), buf + 1);
 		strbuf_addf(scratch, "%s%s", scratch->len ? "\n" : "",
-			    DISPLAY_PREFIX);
+			    prefix);
 		maybe_colorize_sideband(scratch, buf + 1, len);
=20
 		*sideband_type =3D SIDEBAND_REMOTE_ERROR;
@@ -203,7 +207,7 @@ int demultiplex_sideband(const char *me, int status,
 				strbuf_addstr(scratch, suffix);
=20
 			if (!scratch->len)
-				strbuf_addstr(scratch, DISPLAY_PREFIX);
+				strbuf_addstr(scratch, prefix);
=20
 			/*
 			 * A use case that we should not add clear-to-eol suffix
@@ -230,7 +234,7 @@ int demultiplex_sideband(const char *me, int status,
=20
 		if (*b) {
 			strbuf_addstr(scratch, scratch->len ?
-				    "" : DISPLAY_PREFIX);
+				    "" : prefix);
 			maybe_colorize_sideband(scratch, b, strlen(b));
 		}
 		return 0;

