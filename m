Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611880;
	b=kINVVjJQXGJjy3L85bvYuybSKi6MSr6VoLcdr4H6PZ/WPObOu8kyI2p4P+Qiv+TW0zWa
	 AIqOkH9fAyGgV9PLYB183CLXpgXwwrtmLps5s5H73mcWqfbjMTDt8Mj40NCpO0qNlTL5l
	 04EKv/DoF23jUjWOHesXVNvtqEuXdq6aZaYy3DBg49WNRKlJgGmklCkQ5ZroLd8tFm3jv
	 3+2wi3Mf2HQPZxiyn9/Pcw+uZ/8P7k1BPrzpMaFl31G/twRuD7PmoKO9+MmVNBtNgEpEk
	 hQwTmunfj0KAZ7Nx6BGhlIkMRu2JUDj2oq1y5cWtmu3MkvOJrLNf+9qYi0EJkSmVJQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611880;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8A8nTuwo9bJIa4/nMnZmC9Z4FDoVAJZW2xRB2vIwrvc=;
	b=YfyMMY1efirHfzBTM8zTaOKEDpp3UYve/TdyNgSDass87cFR/m6O4dILEU4mGDT5TXkq
	 UTzxnlKENyK1ollwBqR+ZRRWq/LEtwRE6Tbzf1MJ+TEhJZNyjD+gePVeuoTIrMqwpWsB/
	 qyWl4zMfleGItJeCITip6fjTwaX+tx0Qlwmp0Cbjvb69Gzy4B74leeMH7dFTZEEl9EHcG
	 pbbiVqNQZfJdlVMZvfFg7lVXrn3611nGSlMuqIr45snwvBY8/dOR/ZAO4iCuFEUTFLm3c
	 +JH41IQa4mH9CrVro8SrAlZ1jlgyKfS+xPLfL328/HQt4bBj1mdcv+m9kJE2CqAa5/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="dkJud2M/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RnLI6iwO;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C65606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C65606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dkJud2M/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RnLI6iwO
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8B457A00E7
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:31:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 04:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793611879; x=1793698279; bh=8A8nTuwo9b
	JIa4/nMnZmC9Z4FDoVAJZW2xRB2vIwrvc=; b=dkJud2M/RiQB8GcT+5YuHGlHo8
	SfHkYzY+hMKgXsBecTnNCqtsOy2Xu+q6ROgvJHQLKeP3JvPd1p1lgookHsknZorC
	R5AOQg2M3pUqQ8MkzbDwmXow3SrWueqnc/XCYOWvTPAiMtg8uoPwiEdVYRVgowy0
	59++UrxjuOAAvHgX754Wep503cGnomiJbhGT08atisO5iLFGdLhxlND05V7UqD34
	hnYEbB68fEkdp7fC0bAq6v2/fBp95rYyyAIQrdcv+MhgnZ6UdJV6Zc+Tf9JJ7s7K
	jXcTTMNJ6o+0KVD9wAz6bxfHMLXKDymKHQDfW6C+U3RwAvcbY54XI4RIWLRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793611879; x=1793698279; bh=8A8nTuwo9bJIa4/nMnZmC9Z4FDoVAJZW2xR
	B2vIwrvc=; b=RnLI6iwOT/wK7M6bnXWBDbF0tCLQaKK3QqRYOfjpS6ZvOuOfXH8
	7DQvTB90qz5K7wyWxG7oPS5TKKn0ISIkDJQQYmvlT6IpNliKoRy9+KO7UGKazDOT
	wKaf8bP3L1Qri9VQDd4UbqG4kjhefKUwlvMThBWMkihnnnTJfpfOR6QkcdwO1rQM
	m0PMA6oJ0Xl1uFFu7cL65Ltr4IOfkkUey/faHT0Gi7TuzeJEGMUCgx9XJ5JKwL/R
	xhEeLLUuUCRQrpyQn/YOzam7oEUZBx/aTn7jEem5Rwn/7gXILN4triM9H7Url4jv
	dGDAaf02l/8vNBwLTdYlrikxXhCjZrqilsQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793611879; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NK3QQZy5j5+E/YiqBpko1F/hPjkgE8EjNNmAjYa/H9Qc1jU
	1DkPYO+xGZCobimXCzqO8v/7oREM9Qir8JMoMarKkJMb4Z7SiRzLTSpjH37d/hQ0
	3vxkJ3cmYXrveSa5zvJUO09lJlyzRjyyWcPiCcTGMB3XoCCC/kaDUQqyLq1zY48M
	NplkIVM8gHCBMg+BHYzD6pT3+5pWuj3QaK843smrpp07jkBOj13vAMcWJGCsmPSg
	/9MXz29Y/pdUPvnbR3krAN82b87dHsrXgp1fCKsT9655BkGyUlUBvKzMzVfIpfQz
	a7q3MwU4LJnU50RJVc+DDtDs8ktfo7D5qezIaZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/jMiWNokT4UaQ6fEQ/eI7jvj4U6JsO4NFl9M/aq6+kU=:3QirBHkbxupT11OoR2EwN2mHwJmee6d/iZQeXMSkcJk=;
X-ME-Sender: <xms:Z1joakaxgJi5Zjwo8qFBIBd6mtb1BZysLOsvtbbxFd6J5cF8WnFn3A>
    <xme:Z1joamYfxxHQa3RLUp2pLaErEpKvm1wRo45jKKZTBMMibh88U2rGNoWTOjaSg6yVB
    zjfp_642KDr7crv8gMULM9VdH0qXjrnVGJecZ7SQ9QnDlKAXFCNpZ4>
X-ME-Received: <xmr:Z1joaj8Q8EszVvpZX1cC9f-LHM_GmJNBGrzq7iKGo4FzGhF7Y0jarTPSrnv8n32sWwVgdADsNrCAX2KNG2U7Z0-vP20V8w5vSw2J>
X-ME-Proxy-Cause: dmFkZTEJkn9A9cM4/ojbpys1kRUaI4GB2Pyvqo+LkHeJc/fLxs5eChp60OYr244mYRrY8n
    UBcDEg8j62yJU/+1yK9GTuzltL4D4YU1JTBiMOU9gFcM23jc4HYbaI6c0BI+A1V6gO/3c/
    vvp4d2E5VeFV8F4FTa0MJqu6XRAFyF5qZ1hQMGgYY9r5NbWorS2wm/jaYJ7esGRm4aleXs
    PQ5784QE16K0rbwH22zwEmerNjScTHaD0e3VFIJtWEZNHpw8la0Ts6tSJTGTdlXkKaRlMu
    alllAKlMHFieP62BOlOH0NgpxgxKQYbn03jJEEvJRp8wURTw3umRiY17bXnopVBwul+clX
    QXN4ijG/QA5EqgDlKDygPEwaBIRF9EYVPKwYvn7xvzPqQhvEO5bfnA6z1vs405jSlllc86
    MOtU4PkVGC1+/xuwPdBShmcsowYe1JMsNpOPow8AI4BgylEiZaOdutt2AXWPkk+Yf4nhNB
    4ARUHwC0JklCz5vL58gW9+jW/wQqQbFwaEXYy6NUA8l2c7/HE2n4r6xyMZndm3OsYad9eU
    fhxSaoSD40l4I1LjgI1aA3l6VFe67QCALHTV3bT7R5YgYfVytk2Q3aTtDKVKc6mxzVKw+O
    9aLpCPJmiXyVr3UOH/NreEpzVJgG5BM8g070We6rsK+wxG4Y2HAkWHloIi9g
X-ME-Proxy: <xmx:Z1joatiSA3n4CWU-iIGkIq4CkHcW4hZoJw7zU_lfz9yTiRbCv6sacA>
    <xmx:Z1joarfL1BjTKJpVrBmEfqVordXIHKvPesgjCbEBtlSZ7UOwE6n9gw>
    <xmx:Z1joasp064540RuStJzfO3LDQxnDC60t-kxfumMDGsJS-7C1aJE39g>
    <xmx:Z1joaoBJUcPv0xYak1IRFLMyd300Jkqinv_pLEHVcRnr_uaEqZClCg>
    <xmx:Z1joajdbk5fc6HHLC4NRB1CN3UPf9_x_uZF5NBVWiOR3FqodprN-woES>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:31:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Anupam Mediratta via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Anupam Mediratta <mediratta@gmail.com>
Subject: Re: [PATCH v2] git-p4: avoid shell interpretation of commit ids in
 applyCommit
In-Reply-To: <pull.2411.v2.git.git.1790238482045.gitgitgadget@gmail.com>
	(Anupam Mediratta via GitGitGadget's message of "Thu, 24 Sep 2026
	08:28:02 +0000")
References: <pull.2411.git.git.1790093506966.gitgitgadget@gmail.com>
	<pull.2411.v2.git.git.1790238482045.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 01:31:17 -0800
Message-ID: <xmqqld7blguy.fsf@gitster.g>
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

"Anupam Mediratta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The shell-based call that applied the patch for real went through
> git-p4.py's own system() helper, which raises CalledProcessError on a
> non-zero exit status, so a failed apply aborted the submit. Keep that
> behaviour by giving the new helper the same ignore_error contract
> system() uses: it raises unless the caller asks for the status, and the
> two callers that test the status for themselves ask for it.
>
> Add a regression test exercising `git p4 submit --commit` with a shell
> metacharacter payload, verifying it is never interpreted.
>
> Signed-off-by: Anupam Mediratta <mediratta@gmail.com>
> ---
>
>     I have read https://git-scm.com/docs/SubmittingPatches#ai and confirm
>     this contribution complies with it.

I do not know what this means, but anyway.

This round unfortunately saw interest and reviews on the list from
nobody.  Unless we see some volunteers to give it a review in a few
weeks, I will discard the topic out of my tree, as 'seen' has been
crowded with topics that have been collecting dust without getting
many reviews.

Thanks.
