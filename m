Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745635;
	b=FG56FDsrujTyfcqtUqQvKvShGzsv+ibEQbpQ78dtJBJH38VUFg4P6uYPaGES6fX7gPx5
	 lj4EDl+XZy1smOnJ9k2TCEz97OQEKvHIpWlWuyTMF4Th9jcpm/rtvmeFjlxXIt6Gg6xDG
	 o1jB1HVzWqD7QkmkadsjrSRJx3ZHJQDONPSkBVvKz3lSO2PgstMJqsJXLIEDNp/jnA2BU
	 M1MzNIRSC6d1OBXBRC3hgfYa2tr+4tVNZRuTPHl06aEX8umS8JhF8XY9woi+OmkJR6Pi9
	 7+x6syjxavi7n0U0x4nclprKtatEfSMu1XgYreibgzsKVGdNd74K72FYsm8jzFkYPyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745635;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=weKSnZ+h0xT+uL7lHBaGUmm4zya0cBmro9Ob30ZBqMA=;
	b=UYSSDudKxZlPwHTOGzd2BIoTvoLWg7N8k2mnmQRLJC9YTnwj2A3uSshvOiBNgk/AUHlW
	 dlx8Xga7qI0OD6xLtaJoDIvDlunOCY5WRX4GOyXTwu78LuBwWzMkgumlRENjww0o35i2R
	 ErG4Qc5Q+lk1gDdhOM6oUznNheTQqysa+TtsgWCeTwifIP6v5T4AbdGFxU7/mZL3c9oIF
	 O2lXqlmV2Z5FuRbr5AkOBNE7Ez0526MfF6WK83id0tyfiMuZ8uSgxU3Q2TwF963WxuUY3
	 1cxPAATRkhiv2XXzrad1VwPOUM0l1Q5PI/2G3Z0SRsUe7iXDNXnja4PEBaHptSazGqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JJ9ehpdD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IEDR73iN;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20A606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 22:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B20A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JJ9ehpdD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IEDR73iN
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC3631400104
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:40:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 03 Nov 2026 17:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793745633; x=1793832033; bh=weKSnZ+h0x
	T+uL7lHBaGUmm4zya0cBmro9Ob30ZBqMA=; b=JJ9ehpdDrVVcmPsQxKno5Kxhwg
	UZDNkEgJJ6KVquLhnTAo3ozRjq0+M1sw2DC/zQsVEFFMn6/g389pksSAOSfrRVJW
	UfPDFWN5V+lmDkzBLTyU691+z+kgNrjvZ0rylePAXvhIquH9p69k+uiLcMJRY9Iz
	FWOfWBjgOu90Gtx8jqrd+XIjkCp8nghi2phKXQr15GN64Hy95wgnVLe1xqupf/3u
	UGQKVbV0qT/curWR8RxzWHwnJGRGuENk0xL8b93Rgsxvb2maXiZ21B1bP6HwIMJp
	3wbCmD2o3pBmsxPoX/oOxaZCQb7G+za0qab+HIu6xGW4cVwW3fNyTg5gImIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793745633; x=1793832033; bh=weKSnZ+h0xT+uL7lHBaGUmm4zya0cBmro9O
	b30ZBqMA=; b=IEDR73iNNb/bIAyo1v959RCiIH0cxrsdZa0a+G00skZA/3Mmya8
	Z9PG3TxIKn4F0/+ibd2ejhpPuBqVdk51XcIsCf64SEcGroMIThO11fy9tzfuB7sS
	9nLp9GQ+JeGCMR7QSCvvCwano5xR5L+fworpI6UpQtd5PcSVRwIRl4JUawo9Xpya
	sYie7nkaD3fbvl04OGa4tl97hOLi7Nqc6zwsbbfaRGr6MxIk6ynK7bOR5P36/QBv
	y7Uu06mK7xb9EAlG2VIKmEUaeWAtrMwMCX0Tphs/JP6WGddOoWsm5DmPrPzob5G4
	Wn+6sljJz/Sbztrll4ZlyXzbGwO804/ZdIA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793745633; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PLbh6dmpmIHwgejo6pMeaAyedSEMvMftuHY3dcWr08T7Hou
	TtlanrtO7TwCauMf0i7mG18KpjzYbKlNpQwviwkTC8ITx/vX1qvgeWcJChoEd618
	8TjNMgVOCrumUcb33GqRZKVT+O6OvSvkUeXuJ5aY1QTZww4drjw29mLoIMs+Dazs
	MxF3lho4381+ijBFKfoaOI7rZRGOfqdbdoN+Dhx85l/u6PmzxqxH58fYAtU47K73
	a9gTM2Q5UPvRU2Ucusk76rd33RBYck2FxuHQ08Bun0KdrJnL7M7PqX51FAAdRILd
	WirsFbGIa37F8iARWupZnbjx+/iq340il+Rk6hw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:VdY2QfE2eSrAOheI+s4RB+3CmqKOdeabajwQExV0dq4=:+BaybGr+kIvRBkfGwGR73rkFz6qYG3werCnV8UxzIkg=;
X-ME-Sender: <xms:4WLqasBm0wx-ARUSl2YI-vJSIpBIAXhgwmWHGj39ur_BEY43hSS7XA>
    <xme:4WLqal83JU9NKI2Y7dVLy1_GPqBBw3E_N0uCeBPAWQVPwXo8zvYBB7HvEaeedjEwL
    1GHUoKf5j10PdA5gJidDv_YfvdelFrsy-0fjG0luYuH-hh6U8B8uY0>
X-ME-Received: <xmr:4WLqas_1qcS_KCVoGgJTkTOwBVwwkNeYQdQIvtEohNl80nuCjoilN8qekF2HYfqLKyi8qdAPh6jNYOnDRhwnuZoAf8YP8KRfrn-N>
X-ME-Proxy-Cause: dmFkZTFLkgsMdLfmTZsuX4OZPtU9xwz8blVaMoxKK9H/spqPam11XqQPZU1rLad0QgAjKA
    rG/g2TAkpQNooL5O8yi34JzlSK2vnoxQ2dT7YuC/NUIWyzjfkt2voHqh26REKEio4M1u+O
    LgrPqdg0ZIIr98PnoxMWvo45Zn97zMuu2YTLGfQdaS+ktx92ILg4Cds5RgI7kP5TUUmw5F
    TK2yfZyaOgps2wx0bTVsd2dnAlpSo27MmlwrET9bmzgH94zK+lYE0120Y2S32Lj3csGks4
    A0JLStt9jaRFHF7jZSAmeru0ZLhhL4Bpd1s2rHgYhu8zUNCZTMT2aCFn9XfH0e9lya40X9
    xQkE9SMARQtvx0h3fSIXWSwJYS1koakmGVWD1TQrBHLR7l/kXRdWSAAVtW0KYYIgY19L2r
    cU8wcVMTc6vVOjasCU9gW6YBYLk8BoWwj9CtRIgTEk5DfVSWnKY3qG5nZBxMi5AdBX75iV
    58HcgVc9EQDnbRjGlo8hm1OFA08jVuXOgeM2n1gK5DPW2k5BJ1rYuyewjwG8pMjoGhrVZ8
    3Fisfvrr/e6vvyd6APoYte3seA08NtoifkKOscosqxFvR4EjOwZ4Qp0Y/xpd7jgalcZv3k
    ivufAwIeRxjZc5n9+g7je8DAGNGr+cKH3kayUBmAL4fZid6LgmUtcoRh90Ug
X-ME-Proxy: <xmx:4WLqascm1HQK92V_BY2b5jfs6CNzB5QwOa1FPMxVRSzDV0aVD8Bmyg>
    <xmx:4WLqalHIABWWRxqjOzpaz3J1X_m2wquuDElLvva6XErI5kcxDQragA>
    <xmx:4WLqaqeRi5ifkm4s3HknGzuaFL2XW4FXYP65mqdPwuePuBKphmdB8g>
    <xmx:4WLqavEXEN5u7jahSpKwCTE5N72X1xdCnMQ056qqkTejMlaQrvaVVg>
    <xmx:4WLqaolykU3QzdjIhjth9VmfwIpxS26WWlXIT_UKzDzRDTyjAVimyJuI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 17:40:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Windl, Ulrich" <u.windl@ukr.de>
Subject: [PATCH v2] gitignore: rewrite wildcard description
In-Reply-To: <xmqq5wyjxgyn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	30 Oct 2026 09:59:12 -0700")
References: <07b3498d83424cac87221724b371839a@ukr.de>
	<xmqq5wyjxgyn.fsf@gitster.g>
Date: Tue, 03 Nov 2026 14:40:32 -0800
Message-ID: <xmqqh5hx4jz3.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

The documentation for '.gitignore' makes reference to fnmatch(3) and
FNM_PATHNAME to describe how an asterisk "*" and a question mark "?"
behave.  Even though it spells out that these wildcard characters
do not match a slash, it does not say if an asterisk matches an
empty string (it does).

Rewrite the section so that the readers would get a more complete
picture without requiring them to know what fnmatch(3) and glob(7)
says.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * let's adopt the most explicit "(including the empty string)"
   from glob(7).

 Documentation/gitignore.adoc | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
index 7979e50f18..87f37c2b0c 100644
--- a/Documentation/gitignore.adoc
+++ b/Documentation/gitignore.adoc
@@ -110,11 +110,16 @@ PATTERN FORMAT
    and `a/frotz` that is a directory (all paths are relative from
    the `.gitignore` file).
 
- - An asterisk "`*`" matches anything except a slash.
-   The character "`?`" matches any one character except "`/`".
-   The range notation, e.g. `[a-zA-Z]`, can be used to match
-   one of the characters in a range. See fnmatch(3) and the
-   FNM_PATHNAME flag for a more detailed description.
+ - An asterisk "`*`" matches any string (including the empty string),
+   and a question mark "`?`" matches any single character, but these
+   wildcard characters do not match a slash "`/`".
+
+ - A pair of brackets that enclose characters match one of the listed
+   characters, and a range notation inside them, e.g., "`[a-zA-Z]`",
+   would behave as if all the characters in the range were listed there
+   instead.  Wildcard characters "`*`" and "`?`" lose their special
+   meaning inside a pair of brackets, e.g., "`[*]`" would match an
+   asterisk and nothing else.
 
  - A backslash ("`\`") can be used to escape any character. E.g., "`\*`"
    matches a literal asterisk (and "`\a`" matches "`a`", even though

Interdiff:
  diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
  index 671a5a4c99..87f37c2b0c 100644
  --- a/Documentation/gitignore.adoc
  +++ b/Documentation/gitignore.adoc
  @@ -110,9 +110,9 @@ PATTERN FORMAT
      and `a/frotz` that is a directory (all paths are relative from
      the `.gitignore` file).
   
  - - An asterisk "`*`" matches string of any length, and a question mark
  -   "`?`" matches any single character, but these wildcard characters
  -   do not match a slash "`/`".
  + - An asterisk "`*`" matches any string (including the empty string),
  +   and a question mark "`?`" matches any single character, but these
  +   wildcard characters do not match a slash "`/`".
   
    - A pair of brackets that enclose characters match one of the listed
      characters, and a range notation inside them, e.g., "`[a-zA-Z]`",
-- 
2.56.0-511-g14903f623d
