Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19F3F327E
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403149; cv=none; b=qKfpd6fw6PHg1VZP6b8gDYXop0maeXqAWeWyziwJQ0iXyZD5fUvJGtxMoEatEy/OPf3rOcXeoS/p1loVOouyXYOwomgMp8LnShcPt50hd11tQvxiIryNPlBbtNznTyrKJu5rWfQedR/ocJE3IL712zdmhULnuA9uP4qfcS4mY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403149; c=relaxed/simple;
	bh=2uj+1JB4BZEj7YRvVo97J8CW9nPYews4mnOKrN88/pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTSXixa8VLPOd0niTwJQQYeFtz7g7cOutR9c96tw0yJ+hqZ/Cai+icaUOnVIFhvtx2x0MtOE/Gt3fP40QuaIdGjlkKWN8IOEEwpCTMdDIqat/dbI/ftl+pyFqsrs2bddDyrqTKxJzDMJ6LqCNNx6xbptf5L71Hr78tQPECqzrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ceIIU284; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UrkllC1v; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ceIIU284";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UrkllC1v"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE4187A01C7;
	Thu, 30 Jul 2026 05:19:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 05:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403146;
	 x=1785489546; bh=gnokYJhCVimqj9uTNikP6w3BG7bzTl75e5tggUvlJ6U=; b=
	ceIIU284MH7zrbVA1QfrkfLtYxabdog4wklPaG2fk+fyBoRyjsPrZsRQ20VATYuu
	h4ApGbahi2U6pOC220X84xxv+zSb8k5Ihk4iVnahpe21t02fgrjFn/vFNWUcmWRE
	z3A9ec1gm8wn/YTlduCBaG20B+cwSdkVWdXXnn4DKt4FHnZVtgoPvz65to7AinVj
	ovs4iuRNT4Xq8Qe/12OR6yXOEZ6G2Ld6wL0z8OPWkkTeBRtyS0YwDC3T/VfAWhSk
	zcxW+Dmy2dhw97DaoSCkrzBj1GaebP5dnz0Ci1hrLtB0qK9iQhBPPhxCQqfwfVMl
	8m48YjD+taiWWjtITl8rLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403146; x=
	1785489546; bh=gnokYJhCVimqj9uTNikP6w3BG7bzTl75e5tggUvlJ6U=; b=U
	rkllC1vNAtXUvJ6F0+Xn+tnMGljSorATPDHR5YBCKqe1o1fYxqTilT4bsw3pTXzy
	baIOq6Xc8Soba1jPZjzC8Yg+3yucZADORXgwIf2L5Eoql8Id5qLd/Kcu7Jyx2p8h
	4Yfq8TR18M3DIqnsV+GQOn4+ceOOmOLQNDs7IeyZicOOPpwo2TH+wZ36RIn1HYbS
	Dlrb2CqZhArk+MPu1gtD8fU1R+dYVUb+lmfes82CcfLm1fVMJoEAe74LPVclE+jL
	s6QOKlF1XNYmlpdpGPZKi8DN3RjGF78nlfR6aQ8Q0hHshlb1sI9Ylv5qbt5Y3PRe
	wP1rXu38st1c2dNLik8Iw==
X-ME-Sender: <xms:ChdraiwENeeufQDsff2a03dxF0Ub6bcs3H3uiFJP-gGQpCiQQWlae4Y>
    <xme:ChdratVJS6J1GfTAe6wQ8bN_0CAVjhzId83wFAWU_iTTpQAIpGcBga48Abvoz0Qpt
    3dsTOxyb9XZsyFF3DJp52II-cyBW68kF5eohwsXN94fziP_vMRVZw4>
X-ME-Received: <xmr:ChdraqiLTBhRcqKzHIKzTs8wL4qVYJgjt8RJQKZ0bllctpy9VLXrpkng7iIsSyhQyp7gSSGy2cJKpj0kMpy6rCqwAeuL0NcNc5FkPgOTkhyqBO0Wv5J3v6o>
X-ME-Proxy-Cause: dmFkZTGEif8V06QLJWp4Tr0XxWuthpDPXu8yXzE/6Wu3CJpYbMgM8lsm5jyJLeAnyrpZvE
    ycYhVYgpkiSon46eDu1/hD+XVIJYbH3Xeb45ZwNPUiCL5u1BeoKbRMXd2Dx36ClBh4cRfN
    3RDdslMGygM6+dnnjdS0m3p0cowhCsC+ewPbJAa763IQffx9meKZsfDOfBPvZRNlWFR95G
    1b/AcIyh8aIPq+fnefmHue4bAAgmxhPORPpGS4E1ADDTPqmGVvymu3hORTq1JjLamGV8UH
    NKlINhhPvBS5G13SWysle528nm5w3Xu9Dc9KfX3qSPABHdwZB6fD+D9CaGmb2OAuaqQ+pW
    pz5ae2WeQauMHyzEgGNMCZFJHtZjwlKnAkvUxKU7RjuGwFu+yyLF1wU/8OSGEnI8xqfPVU
    Gt7l2EIlk6qOrTTuKzm1cStl8yZWea9hwiFTMlXr+XimuteOKPcIjKfZA89HdM3Wn8/7N4
    ji3dDz1nPxRSR0z0Cm5HAHH2fGNIIJVnKic8s4S1+jCnk6D05sL1rD9wHoc0/vQQdiCOx8
    jG2udWWrPElf1bNxFn8BqGINKi5yR9J79dRjq05xLI3R2htlLtSTjM+GP6a78eUgoRukbu
    +pwbGtXH/mIaQ67eiypu4oUA+Y9umQ4/OgjeNWIVhDswz8rTq9KzqgnoKOPA
X-ME-Proxy: <xmx:ChdralCE2QE9MxJ2TGykk0WBajpcbGFL-P1Wq5166WIHc1jJmEipZA>
    <xmx:ChdraovEe7iWsa6PqfWLLm9EoG8slhIH9WtmQPsscpV9wvoxPjS7gw>
    <xmx:ChdrahePI1qwbaFL7Hthcch71SR74yqKcOX0PfEeLaZU27pKuXq9xQ>
    <xmx:Chdral_nqbEvbaK_kYlaHRBYcVjjGuEygn9WKDB5KMlGuvKSvE-umg>
    <xmx:Chdrah192fzbY_6FRdc0ulu-AJulLMs4W6Mu-HXCbY4T4d_LasD8EgxH>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:19:04 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 01/11] doc: interpret-trailers: stop fixating on RFC 822
Date: Thu, 30 Jul 2026 11:18:14 +0200
Message-ID: <V4_less_RFC_822_focus.ae3@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This command handles the trailer metadata format. But the command
isn’t introduced as such; it is instead introduced by stating that
these trailer lines look similar to RFC 822 email headers.

This is overwrought; most people do not deal directly with email
headers, and certainly not email RFCs.

Trailers are just key–value pairs that, like email headers, use colon
as the separator. The format in its simplest form is easy to describe
directly without comparing it to anything else; we will do that in the
upcoming commit “explain the format after the intro”.

For now, let’s:

• remove the first mention of email headers;
• keep the second, innocuous comparison with email line folding in the
  middle; and
• remove the now-unneeded disclaimer that trailers do not share many of
  the features of RFC 822 email headers—there is no invitation to
  speculate that trailers would follow any other email format rules
  since we do not compare them directly any more.

***

Talking about trailers as an RFC 822/2822-like format seems to go back
to the `--fixes`/`Fixes:` trailer topic,[1] the thread that precipitated
this command and in turn the first trailer support in git(1) beyond
adding s-o-b lines.

† 1: https://lore.kernel.org/all/20131027071407.GA11683@leaf/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Msg: s/trailers metadata/trailer metadata/ (knock-on effect from
      change in the *next* commit)
    
    ---
    
    v2:
    • Use `***` as a thematic break instead of `❦`
    • Change to “metadata” instead of “key–value pairs” since this series
      version adds a paragraph after this one where we dig into this
      term. And “metadata” describes the purpose of this format.

 Documentation/git-interpret-trailers.adoc | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 77b4f63b05c..1878848ad2a 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -14,9 +14,9 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse _trailer_ lines that look similar to RFC 822 e-mail
-headers, at the end of the otherwise free-form part of a commit
-message. For example, in the following commit message
+Add or parse _trailer_ lines at the end of the otherwise
+free-form part of a commit message. For example, in the following commit
+message
 
 ------------------------------------------------
 subject
@@ -107,9 +107,6 @@ key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
-Note that trailers do not follow (nor are they intended to follow) many of the
-rules for RFC 822 headers. For example they do not follow the encoding rule.
-
 OPTIONS
 -------
 `--in-place`::
-- 
2.54.0.22.g9e26862b904

