Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743135;
	b=cPN8WIGJIaZ1pt7yeJjms0P8qKc5pTDa+/mNKkshDTOn38GKvUtl84z9W6bNyWJaqw+j
	 77wYIJ9Pt54kREd3XrAJDVvsOAVmyMly+wV6ehtfvP6vJkrz1pDfTtGn08F5o/fR8W9Bp
	 zQeH12iBHOo0AXIRNrf6rTP900vE2UhNLNJHantT9y/jJN4IvGzcNIQ4+RG3DN+ucAice
	 u9H41XdEJJlzI8O6kdkK5jkhxVp5z9WWeSZkc0kxQra1wCrSFz27Bm6suFSd8ikV/T7pa
	 sku05xL6CmT6Lx9+rPgXSvkzQOiRFCreUsIq3Ju5rzlNG5+BL1iJXE3DmpGZeqEUsEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743135;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=oTNkwVnI+4LwPVJ8tAmtVi/zwh4Cq7pr9JeSsKzU3MA=;
	b=I87JOYKAQgFLBYr46gNVF+crecS1MWL6IS/oLvmRf686Ei78BNJ4sB5LSUIVfNkmZT6n
	 hRIjC0dtFnZyMZyfFx5GEr3rqxPQkuPD4uwgcmdVCV4f4XTMB/xQxGej00TblR7OlrwOA
	 ZvKTMNOHwhl5dzhfZmwIrHuQ+bBNPN+r8xu8savrWH9QysTWo+idh/no7ngRJ5uY4WSdO
	 em2xvQftqPZsjkMXiEYHLWoh5tGInfuz87LoCIususHXJPqg3ROG6wA6M9l3pKAjHeoKJ
	 SW8n/dLlWnT8VKZLlONA3yDo3rtmUznTuzpX2U0LhgJVXLCOfDA0SsLz1GYh6TWZr3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nZSpxQtR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pQ84IRkc;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B01606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 21:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B01606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nZSpxQtR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pQ84IRkc
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2AA35140011C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 16:58:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 16:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1793743134; x=1793829534; bh=oTNkwVnI+4LwPVJ8tAmtVi/zwh4Cq7pr
	9JeSsKzU3MA=; b=nZSpxQtRP90J6jOf2oP6JhkLxoLLOIYoj5IwfAEDuNkrZyTt
	oS9YnKtzEVLlMML4ufbkUBK0QnrbvCnYd/5T+mhp/Ql0lkNooMh1OrrBHFWwBl0f
	dBxttO3aAwcRaHFP/dNIVcSoVIDxtomwxdhBSBW3UGol9pj6nOUynkCeaBrxRyc2
	PMF+zLktPY/75vJPLMl1l1rvW7V89meKJVn0ZFooKw+9sFXk53Sb7UZu/zNFdy1o
	LNu6qNKvPhCZrCi4bS0WCHWC2B8sTt0RlW1jCxH6xNn5HYHOPNF/Qe51iqvaNblF
	YMrtv2Pbch3N15sQGHqwTBTmNleZygrbWUx+2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793743134; x=
	1793829534; bh=oTNkwVnI+4LwPVJ8tAmtVi/zwh4Cq7pr9JeSsKzU3MA=; b=p
	Q84IRkcE+ugtUzylpfixJtzV1a33J/2XyXkQXN1DKSG6Y1vwUdTWH5v8G5Tli7S8
	E7NIHIJL4dayi/g6QzQcQbBSY5Sj+7DTnAhdxS752rJH1JbLdIH9WKZqYijkjsez
	uPspYiF49vWe1nJrlP9+TGnlLVjSxiGO0KeZzHvRrfJ7pRjm4x9xJ4/XOdVg4d+D
	ATzph3aUg9Cf89T/SrWjCh3PZ34QuUIssWL7VhQ8THDxIrc8HpBgUPZhnvQh4a60
	wlCkV8MCF/ZpU9YKdKPLPuFwVa2QFQZoEOkwUkOZYaFAE5X+xLe42IGquamO/qEq
	f1gF+azQ1KDKcvm6GwCfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793743134; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BfN1bjp9LZ+VylHSwyULfPpxyCwqPU449KtDxpYilMKnO9k
	DU+O2EssqQe+rhWpW7RA5ext9mUvWbusm6wFpNXLK6N/DNp6a6L8peyRQiQRpVgW
	9yUYhDws+Fh8BBy51gnvh7MWjAMAQVuVAdOJYOph4A+gaBKH2Uz0FA0AYCOKEEZ1
	HMzrcZcTHTlRJ9CfEYibZHbdaDGlaNmO29Y0U1q2CvzTJELwlaySpGRDS9gq69cm
	MugI6dCss6JUEY9CgzsLnD1ZRoHCnpTBL12MavKx5uPwSYJuvWYDGutkSsV3amJf
	yvwQggMRjkMEY7Ztcqw2PnQiKbTGiH6KsGkwTwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:oiWUMWSCHzX/eqdw+kVWp5IDhNp7tEajDfUjxzQICQA=:HUgh+aGRnTomWlZrwMiRmC38oJGnFiGBV3pi7YnRB6g=;
X-ME-Sender: <xms:HlnqatlxGHcZFsBPjPThnZPz-sEuRemBl-kruLhuKGOeO09DUz3vkg>
    <xme:Hlnqau0OUaar_1omQx0EVx0SJuuoB_VmsD38qhRqLANVCktupzTQW4BXPRarLINj5
    609lkt9D3rxmFIFoKe_6F6g19mLndJ8OPv4ZHCNtHeeGAnQrkwIcz8>
X-ME-Received: <xmr:HlnqahQ_sSDK0ABdBADZEeP8fVnv7Yh4kTxDamh6iqIRgMf7Gw-u1245N0bqZFbpALSXtiTIjhSf3dwpXHMftLGaPbhbJsWYBx02>
X-ME-Proxy-Cause: dmFkZTEJQaLLjU83Lu7lBAbVCsETQJbEXpyU7pNpGA7SR/bA9mqvNHAcDTohq6n2AO5r6w
    xSI9Ndxt7rxRhIzqOPeHP54xKyOg9bAGNmm1kvHh9h34Ohr8VDfC9abbkY3JZLdqEOKBGi
    1DM3pSAe4HSe18p2IWARa4V32Ajr4raGWi8KNhfAo1qVQQlgdLagA25hBobdhwgm6BG+WN
    QcXDTVIgP7lh5qOJRHWsVZVwro6SUNmLGiAiUXoqs/EHZrUsye5vgN4X8FyQVDSOnP9Mft
    4FdE1189mCG5CVyQc7vb3B42D+Y8RF5NVtzkH0N1lWT5uGhiqOxGp012qm1YnCxUOnVqoP
    2k7vxtVU7YcCJuCOGkglFAEiPdlpLZ04xr7l9T2t9QncwVpHe9yFDDe/AyjQ2535g/AOF5
    +/92lx2pPBLzmSsguxQbZa74gVwyvPve4z/hqNJVId+QP43ZotTRO+TSE8evxzIdJoyIsP
    98T4QhbvbfT5zYDCKzMf7gyGsLdLGYUDsVIYfmVwE6qe84kQpoRZptegvgiyqZ1fu/LFW9
    4aEhrM3tzb44tbbzDrnjEH4Csg0NQy/s9iOvAfZqCOdWeXHo4KyKpSg4lSoNQm2++2SIlE
    ANyT9UOp0obNzdt62BakX8nduyqBdOXx1ZJCX01mWalK0OaPybCUS+ssFPMA
X-ME-Proxy: <xmx:HlnqaoscbtBZw69N_-VquJmQ0VNwJlVkTf_82FAFx2phnS0hC7I8RQ>
    <xmx:HlnqauaGcXDykFQbfHlxCPWTdtQjb4Zajan_SsGjveeJK_A-r5CL5g>
    <xmx:Hlnqalv_KE1QuEzSCHABbV3RhK5PisJCZZKKBapWjckZVI6VmETZ8g>
    <xmx:HlnqaoEuWd3rL2ibtPdQ4nHt6SFLNG_17Kv0nbaLkt4lD0nY7qKseg>
    <xmx:Hlnqao9gcDK5A4Fc4UdwitE2A-tRsfES1iuu01mCK5jVP9QPEsFe01mV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 16:58:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] branch doc: consistently promote 'switch'
Date: Tue, 03 Nov 2026 13:58:52 -0800
Message-ID: <xmqqwlqt4lwj.fsf@gitster.g>
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

When 328c6cb853 (doc: promote "git switch", 2019-03-29) updated an
example in git-branch documentation, it made an inconsistent change
to turn "git checkout my2.6.14" command in an example into "git
switch my2.6.14", without updating a comment that talks about a
shorthand to create and checkout the newly created branch at the
same time, which still talked about "checkout -b <new> <start>".

Update the latter to talk about "git switch -c" for consistency.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * An alternative would be to list both "git checkout -b" and "git
   switch -c", as "git checkout" is not going away (for the purpose
   of *replacing* checkout, the switch/restore were a failed
   experiment, even though they gained enough users to stay).

 Documentation/git-branch.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/Documentation/git-branch.adoc w/Documentation/git-branch.adoc
index bfdf459329..a803c24858 100644
--- c/Documentation/git-branch.adoc
+++ w/Documentation/git-branch.adoc
@@ -406,17 +406,17 @@ Start development from a known tag::
 ------------
 $ git clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6
 $ cd my2.6
 $ git branch my2.6.14 v2.6.14   <1>
 $ git switch my2.6.14
 ------------
 +
 <1> This step and the next one could be combined into a single step with
-    "checkout -b my2.6.14 v2.6.14".
+    "git switch -c my2.6.14 v2.6.14".
 
 Delete an unneeded branch::
 +
 ------------
 $ git clone git://git.kernel.org/.../git.git my.git
 $ cd my.git
 $ git branch -d -r origin/todo origin/html origin/man   <1>
 $ git branch -D test                                    <2>
