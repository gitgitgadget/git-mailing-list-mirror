Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3736C0B3
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 23:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889481; cv=none; b=e/9X29kRweOjec6KWMsOiuXrOqSP0JdM+paXjcKrQ9OfFwGA4u6oT3meAO01wi86NjVSdGNYvx3QliOo9bSLiKO09kztR1lAJ7mKopq15DxuBFdmDKvLJLAc9V0PgnXJ4W3+WdLgpLeIm1s+I8E/h/+MUl6DV4+iNsQZ21uz4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889481; c=relaxed/simple;
	bh=MR6lYS3CpGyQlbQalccvDMfdrKpDlg/wt5r1+FKQXRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ig5A0qQ+krleXpiSJ+NGfcGtVR4dg6SoMuYYgb139nHWIVWKh6kEkWuKUHtFHrf9+3OXrmyA4CwYIDywQKoj9t6Gi8U+IoYm4MC1/hHHfj+XpYzIV7wGp2ga2SgVOihwk2iIjUkhdh8oZ+gACGfMO+ANLB0OLZpv7owFpUD6paw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=O0Zf0iIO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mhgCrG4S; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="O0Zf0iIO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mhgCrG4S"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E7783140012A;
	Mon, 23 Feb 2026 18:31:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 23 Feb 2026 18:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771889479;
	 x=1771975879; bh=xqKWX9W5+OM8iEwsv+W/j7Kz4ddWuWlevVnYLgXEKjc=; b=
	O0Zf0iIOgYtB3YUOUvSJLa33UxvL6TyhsMq1SRseVj06Y74XvfyuDU9/A5B5z+JZ
	B+sVWCydz4tX9nCLuTaDxvHkYmFnNvwlBYZOuIZShUDknoCmKowaDLVHliWUS7Dl
	ZOryVpJu2RSdVL23A4nwHGjFIZuopCvoDYxEpCxTBRAUNm8RW9d0VS6ZZGEkM33Q
	Wl0NjvnZNXguhZzqM5LGWvpvBkyY40OgHPkHR3nVY3z/JOPQA2r03dR4dHJu0zHD
	iCjcejlYv14QANf4XNCQLRGH5ohcSPAqXvVoVcHtyjD/yf78+xKNk0Xg6sLtCUGx
	FRozeHrEozmSSNebsG02QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771889479; x=
	1771975879; bh=xqKWX9W5+OM8iEwsv+W/j7Kz4ddWuWlevVnYLgXEKjc=; b=m
	hgCrG4SZb2IMoeJzmHyKXMAzJSPVs+sh4GL3rdujhyoMKoOX5RjyI/9lhbt/JfvP
	/oinUc2cr8qO13TFwrNaCMOdULo2SKhW1Y5XfUwO7o53u5ncvqAhJfzRkhvUUSOW
	ZJtlWrS0XDaDvoy+qRv+ULW6iShV/E25TiyZQB0YVccWL8TlQqe9h5qQvNz9Theh
	152so/T0HJM1LlCq3rmd82L+uLIs3ZoWpOFxNHFSuLNfXZEQOCTmixXEHMnm+Nie
	y3SnwuCRzmftJLS4Ppg6FJcvHw/ecxEE9MenQ4UrHf9YsS/GnJPaHTprKVEtQlqr
	rt4pzw8qAv1epnvAu8faQ==
X-ME-Sender: <xms:R-OcabfS9xWZBHveRTTuu1x8gmy0_72RN5pl6jKOkMQxsJFJXQZir0I>
    <xme:R-OcaYoZW6ZX71jCjHwoDcyuhIebuSLdmC7evJi0vp0AUkPyJ6v7kETnpcMORjvba
    -jI4EbAjdrYn1E0QhkYgdAljBmQPgG7S3kWkHTxZzk7MwqqlgSDtM0>
X-ME-Received: <xmr:R-OcaR7kcRnDd18ykAIENkN0yyO0dIigXymDVSTt4Z8o_g9KBSDw02yIxwKUyHGqNt_ukej73EjnFxm13QSihtWZSqtPWJObZbbcrIYNoNxwh2zzaSGp5VKWXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvght
X-ME-Proxy: <xmx:R-OcaWqY42CWJUpnTywni5aC8JjGJbK9PZWpVLsDRV7JYzgh_tpYIw>
    <xmx:R-Ocabic8JNP4L7ZaSS8MPVXUiP2p3HIsTmDx6EVp08lOAJ1fhGGWg>
    <xmx:R-OcaYKLcT4qE_NXYR053adZ3GFdUglHVpbXVUR9N0rJLPXrW1awkQ>
    <xmx:R-OcaTA8Wl9kzye7XIJjtZgqfj5CHHvOEKBjsVzrUygcZuPVRRwwuw>
    <xmx:R-OcaRbuFbetnZVdJ29SKNz3W2bVal3rEFxOdcpesem8sE7Gl2HID3gt>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 18:31:18 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] format-patch: make format.noprefix a boolean
Date: Tue, 24 Feb 2026 00:30:50 +0100
Message-ID: <V2_format.noprefix_boolean.422@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <V2_CV_format.noprefix_boolean.421@msgid.xyz>
References: <CV_format.noprefix_boolean.39c@msgid.xyz> <V2_CV_format.noprefix_boolean.421@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The config `format.noprefix` was added in 8d5213de (format-patch: add
format.noprefix option, 2023-03-09) to support no-prefix on paths.
That was immediately after making git-format-patch(1) not respect
`diff.noprefix`.[1]

The intent was to mirror `diff.noprefix`. But this config was
unintentionally[2] implemented by enabling no-prefix if any kind of
value is set.

† 1: c169af8f (format-patch: do not respect diff.noprefix, 2023-03-09)
† 2: https://lore.kernel.org/all/20260211073553.GA1867915@coredump.intra.peff.net/

Let’s indeed mirror `diff.noprefix` by treating it as a boolean.

This is a breaking change. And as far as breaking changes go it is
pretty benign:

• The documentation claims that this config is equivalent to
  `diff.noprefix`; this is just a bug fix if the documentation is
  what defines the application interface
• Only users with non-boolean values will run into problems when we
  try to parse it as a boolean. But what would (1) make them suspect
  they could do that in the first place, and (2) have motivated them to
  do it?
• Users who have set this to `false` and expect that to mean *enable
  format.noprefix* (current behavior) will now have the opposite
  experience. Which is not a reasonable setup.

Let’s only offer a breaking change fig leaf by advising about the
previous behavior before dying.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Use `advise()` for the hint; you get the `hint:` prefix and color
    • Rework the hint, or the advise, to say that any value *used to be*
      treated as `true`. That better helps people who maybe set `nope` when
      they meant, “no, I don’t want any prefix” (for example)

 builtin/log.c           | 14 +++++++++++++-
 t/t4014-format-patch.sh | 16 ++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5c9a8ef3632..275122b807e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -40,6 +40,7 @@
 #include "mailmap.h"
 #include "progress.h"
 #include "commit-slab.h"
+#include "advice.h"
 
 #include "commit-reach.h"
 #include "range-diff.h"
@@ -1096,7 +1097,18 @@ static int git_format_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "format.noprefix")) {
-		format_no_prefix = 1;
+		format_no_prefix = git_parse_maybe_bool(value);
+		if (format_no_prefix < 0) {
+			int status = die_message(
+				_("bad boolean config value '%s' for '%s'"),
+				value, var);
+			advise(_("'%s' used to accept any value and "
+				 "treat that as 'true'.\n"
+				 "Now it only accepts boolean values, "
+				 "like what '%s' does.\n"),
+			       var, "diff.noprefix");
+			exit(status);
+		}
 		return 0;
 	}
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 21d6d0cd9ef..c20091e36fe 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2541,10 +2541,26 @@ test_expect_success 'format-patch respects format.noprefix' '
 	grep "^--- blorp" actual
 '
 
+test_expect_success 'format.noprefix=false' '
+	git -c format.noprefix=false format-patch -1 --stdout >actual &&
+	grep "^--- a/blorp" actual
+'
+
 test_expect_success 'format-patch --default-prefix overrides format.noprefix' '
 	git -c format.noprefix \
 		format-patch -1 --default-prefix --stdout >actual &&
 	grep "^--- a/blorp" actual
 '
 
+test_expect_success 'errors on format.noprefix which is not boolean' '
+	cat >expect <<-EOF &&
+	fatal: bad boolean config value ${SQ}not-a-bool${SQ} for ${SQ}format.noprefix${SQ}
+	hint: ${SQ}format.noprefix${SQ} used to accept any value and treat that as ${SQ}true${SQ}.
+	hint: Now it only accepts boolean values, like what ${SQ}diff.noprefix${SQ} does.
+	EOF
+	test_must_fail git -c format.noprefix=not-a-bool \
+		format-patch -1 --stdout 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.53.0.26.g2afa8602a26

