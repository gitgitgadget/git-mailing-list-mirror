Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2B2777F3
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306255; cv=none; b=RPM2nQ/XvcTKgzOB5I07cRei5GnCT8vwS7wuadTLYGPDYAG43unOLAiMcSBgVN4p7V+JOfA00XC8+Rp7lKA5BaAZQ+72R08goZSb7QNEw98dxJ7WHZq5fL+KQM906tYz8L57Emrl58AZrbT3tPnZ7Z42swcGbyDUYhNiP6sXiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306255; c=relaxed/simple;
	bh=9xFhKo1GYkJNAqvBmUodo1Y5bArYxaFHj+2btZyzvoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hw/x0D+YBmim6YyABgwiVfrO6C6DkHF9MLlb3tOAw7GGoy6FIWRMJoORNV/miu0wq7GDxwcA9LZNB2oozs9IcFfd695VqvNQPPBYNn6zWuyRZV0TRIQVqh1gbMC+TFP4+zol4+XtpsvF7dEQhgInpB0Y0w+JFgee5L0eeIKazCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ad1ma22q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6sUBVpY; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ad1ma22q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6sUBVpY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 109631D0005C;
	Sun,  9 Aug 2026 16:10:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 09 Aug 2026 16:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306252;
	 x=1786392652; bh=CSEHhwNfNB0RXCwyN9a94FXTg9PZMERLFR2mS4DOvvk=; b=
	ad1ma22qht5dLttIiE+HYFil6yu40rzhGLRfUwxu9/hzp02M5jbkV62i0clY0XWR
	meEim/z7ZoPU/SnRjFUbSNdW2Hex94Uq7otmMuHGuMfGJh5ZVFv9jHnllJ+2XRdb
	HzjS8XZlrO5hH8zpOEwMNtrQfbK17+Z8/uHCeR1qmJKJ2CZbpfbg6UfgMHc5XpBb
	5uSvHpgbaYfAPXOR9cZ0t8zSKfVRWl50uIGva2yTaQW9Q6Hh2Cp47kGyW+WlScKP
	NCO9nGqCcqNWfteZOeQYfbkOxzMjd7zkzaGrS468e26vYnq+FK4bV4jD/pChLIpq
	FfgMeMFndpEXDmr6CwzxPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306252; x=
	1786392652; bh=CSEHhwNfNB0RXCwyN9a94FXTg9PZMERLFR2mS4DOvvk=; b=b
	6sUBVpYEHXg79Vo7syQLgdAO7Moxw3fa0NZx1x16MuPaVaZVVX0MlWsmxImpDRkI
	k7z5CqtFJ2gxXa5/qHgrSH2NGyaxsJnWUfLtBTqTgheborHmF0pcjWxT8sI3Dm4u
	gATeBa9+JBkZvn3KKVrDvskGRX0CgLMkQvVrp58dFTDd8iI1/zFyvHqX675Vbx3R
	s+iDsB96SUZdPhLr18Zadii3wHtMDYz3sCZuRgC1dqCrIu0ue/LeVfaY5aQXGFam
	d50oQRW5rn+uOdEV3YlUk3NT4dM8K22gMopVViSd28e+7V7d8honJera5nkxcpnU
	8rVv6GA8+uO5kykPaP/RA==
X-ME-Sender: <xms:zN54agF9o20fHu9JPLX3LQPQRexS01hTE0CiujXstc2eFkv9x8Uob-0>
    <xme:zN54aoYaQDqGXl37jRywb8e1K8DdxMP8ep3cqrNwOITCLsL-iSS0mBpeIe8v4BXfy
    jk_2jqomQFlQpNHcuUBPjEZx-q0P8thbYM5AW_VxnrPhXqYb4B_TQ>
X-ME-Received: <xmr:zN54agVtNKA4n6kl8MgCcxL_HAZc9Y5flswHQqHrODcQmnGnV7RxVH0CFiJ-33ku3rUr5iciSob74lsFpZ3xrt8Pni82UzFqNTnZJd4iVaqKGh2ZNwoSjNU>
X-ME-Proxy-Cause: dmFkZTEcdI7FD+6TWE4ETRG7ILyNt0FJmLCkf4B7Rh7bvO9LDSLJTh+a8sSGJMVUTrqw4H
    t+TcTQVn0225EKdTVhRDBQrL3gn3hH52gWv+bGIdmXvmIP18dxA6walyfMaaYln20G1xoF
    kRKdLe8RsVLgQpNI5NFqcuau5PlG11BgHlUCxZ0O5jphPzlOd3qmyr13Ux4UWy+vN/oWHF
    50/FAfD9zQHH9iGUl2Xc/1q2la1VviA1N0mKCTbiLbIiGg1/ZCTG3pL2DaODFhu8wNIiUr
    9P3zZ85qGs2o7yRcd1dFb7Azn2UrkJrazICMpJpdxrrQnz7x8H+iHPqNcRNEv9rHIIH1Gq
    RgMkkq861QPEdJNWI6LkMIJNTMz33C1Z4/mx4aog/8gGlGcle1o6/mJ3Feq4aHBJG1+B0o
    djLOgj2umsNmuKzvLKUZmuWSetBP2MNUHuaK/nP8Tr5uOisW3fr2uR0IqX0u5l5T74kj6T
    jquQ2DDcOUi/hEnjGxi5lZPJoMR1CxhAl4x5HWLS3Gf50HBaZvfI+4YPmMYNlOLejH52vS
    bB4DKnD6qOHxfwkzpb+29ixJeEcj0k/D9uJQPu84ynb6hU+kcJZEFOKE4DU7mzi1ik4sbp
    ox1YaTD0GAQbuAzBbXU7XhjdNDxg1m0ii4IlfKSISBcWxegNqzRV6kr/Wbcw
X-ME-Proxy: <xmx:zN54aukGypvktnxMJPmOK3Rp3hkD0_SS-J8CUAnTVmi-N3P3BkWxBQ>
    <xmx:zN54arDVRGz11yXac7kszQHIkQp0lVEVE8evpvWyUtKTRoj75ycABA>
    <xmx:zN54atgZQ3DILIFynZoGFV3_MeLfvwVKG8PBwDRjhisOkikD6o38IQ>
    <xmx:zN54aoxhrbv6neUHfpWEpaePDWhIfiI6Z4RZ_MMMFj9Z52ryGFuBGg>
    <xmx:zN54asAsuwI4txoLQO898OKKqLFZsDD_zsbB6Fz_e_DdFTG4otyW7AEm>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:10:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 11/11] doc: interpret-trailers: document comment line treatment
Date: Sun,  9 Aug 2026 22:06:35 +0200
Message-ID: <V5_trailer_comment_lines.b31@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Comment lines have always been ignored but this is not documented.

The primary motivation here is to be reasonably complete in the
documentation of how trailers are parsed; this is after all the only
documentation page that documents this format. However, and going beyond
that point, we could imagine that someone would want to use this format
outside a commit (or tag) message context, like say in Git notes.

On the other hand, it seems far-fetched that someone would be caught
off guard by this considering that comment characters/strings are not
likely to be alphanumeric,[1] which would mean that these comment lines
would be treated as non-trailer lines if they were *not* detected and
removed as comment lines.

† 1: A notable exception is that Jujutsu VCS uses `JJ:` as
     the comment string

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v5:
    • Msg: add missing word: s/to/to be/[1]
      🔗 1: https://lore.kernel.org/git/CALnO6CB_0ucqnAowrNcPmsXmxxDfJQZPVGkbsHVuya7NLR4dsg@mail.gmail.com/
    
    ---
    
    v4:
    • Msg: rewrite motivation for documenting this. The motivation is
      not super solid, but it reflects my own ambiguity on the matter,
      so to speak; I think we ought to be very thorough about
      documenting the format, while making sure to not use the main text
      to exhaustively lay it all out. The information should be
      somewhere in this doc. But not in your face.
    • Msg: Add “(or tag) message”. See patch “not just for commit
      messages” where trailer support for tag messages are mentioned.
    
    ---
    
    v3:
    • Msg: finally fix area
    • Demote this point to its own “other rules” section, out of the main
      running text. It is not important enough for the main text.
    • Since writing this I have realized that we can go into that long
    
         # ----- >8 ----
    
      Commit message separator scissor line, maybe other things. But I stop
      short here. These things are even less likely to become a problem for
      anyone. And maybe we’ll add them later?
    
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index ac59ef51f80..b4988d39eab 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -117,6 +117,16 @@ key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
+OTHER RULES
+-----------
+
+What was covered in the previous section are the rules that are relevant
+for regular use. The following points are included for completeness.
+
+This command ignores comment lines (see `core.commentString` in
+linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
+and `commit-msg` hooks.
+
 OPTIONS
 -------
 `--in-place`::
-- 
2.54.0.22.g9e26862b904

