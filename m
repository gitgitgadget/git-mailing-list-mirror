Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF32431498
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439765; cv=none; b=MeiaSyakT9704i5qugvTJVW4CoNrzwpLGTeGUP7PrRGYAZCjg7VcGMb29hd8Cn140rxHwcNaRytYmDFv4NsUa5qAJf1n946OWyNM4ZGM/ve6DELGdvMCb2NKCAbAtky/TK8STEVtIMgKyBqk03DYRltFDFO+y0kkrynbE/47NMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439765; c=relaxed/simple;
	bh=/bAd70HOTsVpBgvdH+ryB4knYqy1oK6rsj9rDl4W7RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVvhqtbuukO3z3T9j2PeiO1C3Kv8cZ9MeS71Mxef3UN2TtjQPd9n2ZY3sm5oEmMuRmmIlWBrbM9WBxruVdFykw6y2cE8SXOiEeIohGNNjn8+rlzpUPEIi3Nsa0TJkhezzWZbrvVHoYT+VxpOhu7BugLEsWN9dCfjn5A5OIRW5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bRk8wyX1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFh2fZte; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bRk8wyX1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFh2fZte"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 622CD14000E2;
	Tue,  7 Jul 2026 11:56:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jul 2026 11:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783439763; x=1783526163; bh=B1G9nzapte
	9+jmXJ3DuM43f4x5E28ekuZ8i6Gh0vtPA=; b=bRk8wyX1bCjo/llypAU8xNX/cO
	FsLphX3yBhlEVfYdA0Mk3nF/4PeRYL8mfJBG8Zri9FlAdg9no0UO1oiQTrEst4Ow
	jyGNshmr55dajklxaerERF3IGh8nQ1z2skN6nLnToFTgSC7U+h0VV9ocViZoa3Nd
	qz39ZyDizUWGVEuD6Dh+7CmjSTFBqmF9d3snkiZghgtzoec6UwA1Qkn1Ehp7M+ZA
	hNzuvXZa0aVcRfFVudQwQcvLkpfCUhSQlA3gejTIndc1qH2WzrhM5GZrTmcyf8n2
	E/Ic2NUNFO8pnyp0tZGLkp3SDeNiFPk88ERHx+Amvd34iUj8KasWZTPR2H7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783439763; x=1783526163; bh=B1G9nzapte9+jmXJ3DuM43f4x5E28ekuZ8i
	6Gh0vtPA=; b=eFh2fZteJ0u+XJ9SslVbpA0mNK5I0i0r3Bo/fYRX7tTqRPr2UIj
	r/7GsvSLvwbkermMF3fYbDAlaFriEu8D/kAmfU4cCZ8ie0hLM5rGFSb49ftaLYF3
	F626OI1j6GnuvrJoFAWjCKEMzqGdHrENgvJJDuCFwgFwmoYz5CnWpcY2yOH9N/U3
	a6AHTU5tjFGXqRmj08M/vWL++9pRalqanO+yFIY1+qukcGluwxOFfzHYiWmCuj9s
	QMMo7UBokEcwQNYcj02IPJRmcXXB9AMoVo5GtZPzBuYQlZ5Pkmg9vmaI3MQT5sCf
	DLTBT/iBIUJ7+2k4spkCROkS+Ts0urQFGmA==
X-ME-Sender: <xms:kyFNaudnTJJinDL8p4agS8YOOI6KbcJL5MLY0okpAeaEREA7CPSl4A>
    <xme:kyFNavq-p7x1iZaoIRw2w04ACJyL85CrZze557TFW7MocRcFAgfInPly0mmSn-RwR
    -uXe6vjAqhzVZB3JiF3Tf9FsvpVXpPgGNCsTQ1v1GPxRasNV3OIfg>
X-ME-Received: <xmr:kyFNas709hePqpa107ZU8YtQOQfXA-dK7f1C-S0HtZCBI1auLpgOuE6kmAYdaSTAkQzRQOEGhNNqodkNO8eh5hXwn08AAIOQhcYMu2Wc3A>
X-ME-Proxy-Cause: dmFkZTGVn3iwKXrmJepC2rEHyhVbo0mD5hctFe0U1twUgkTmTg4KHlvgXr1lj1DKk77EUg
    p35vNeWvOMLwVGqKaPU/5ps41LsimTS5MTdp9kqsRxkWtXdIKmac7RDzN/3aWbmcjuPsc6
    h7h62YZ83DOQPADNq8qnXzHrsdNt0wAIIK7lRIui5LFhV83Wl3XxzuTis8YbzqhYihzt26
    y0ldLkZi46siODuQRHw2+cvTFRveDytYLt7uONl/50BbpoG/LTqQFrwshCOjT/QDFg1qpF
    3gOa74EjEvzRi1PFi2KZYyF60WdzuqLuF6Jj5z5Znmyoy1twRC2ro9AizwfGpYJMnPzuhb
    drdDBjrMP/4a8LJnZTpM4dL0HPa4p/55cgOz/G4aPCVkFuQL6H+zSecbO6ZUCYu7ToPdta
    BET56BQ8jzavHVWMfE46FHot9+9UbrwjXMhDwBp92gNaKNJFNScmth0nEjcxcn2rEsqaB2
    R8mb6YjdgQpe2CGfFSk1jfMDFmLKEqYaHae3nUkmQnzMOl7ofeT6CoreL6QsDkrFEKhIrP
    3ZbXY66NoI4GAlJwZurwORGPYzSN12UdM52iii95oRwIOdMUP7mP17x3X6J1trtkxns6L7
    NG6pIEXcT2UXBts3KnkaSR5B0UqmVMBuE0uD+5wLLWtaagTqjgKG1qbCZUYA
X-ME-Proxy: <xmx:kyFNalrTyU7UzDhc_kqwOz4oPsxOLksvzR4pEPKBUggyUqgz3p2gFA>
    <xmx:kyFNauhUKy326pmVQ1opnQTdbateLCpV8tAdjWAYKihj5JREoWioJA>
    <xmx:kyFNavIXLap-7jZMSp1-ytu5oRuf9XxC_9Eyx-N1J9fxGlu8RhgZIA>
    <xmx:kyFNauCnoVUrTGftiWS62Q9sbMgqKHRlWxv0GpATtnB_CQWJO2tm1g>
    <xmx:kyFNajI17Oy1mzJtwMF9Teboy8FG1-qAKq4WqoesBGFvv9ds2_hJcPlD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 11:56:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98e66588 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 15:56:02 +0000 (UTC)
Date: Tue, 7 Jul 2026 17:55:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] coverity: fix leaks and error paths
Message-ID: <ak0hj9em1agVr4rj@pks.im>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
 <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>

On Sun, Jul 05, 2026 at 08:24:17AM +0000, Johannes Schindelin via GitGitGadget wrote:
> I wanted to whittle down the many issues reported by Coverity in the Git for
> Windows project. Turns out: The vast majority of the issues are false
> positives. Most of the remaining issues are in core Git proper.
> 
> This effort was forced on pause while Coverity was down from May 16
> [https://web.archive.org/web/20260516152422/https://scan.coverity.com/] to
> June 22
> [https://web.archive.org/web/20260622182153/https://scan.coverity.com/]).
> 
> Here is a first batch of fixes for those issues.
> 
> Changes since v1:
> 
>  * Edited the commit messages to put function names in backticks, and
>    reflowed the messages afterwards.
>  * Took Junio's suggestion to avoid (ab-)using errno to determine the return
>    value of load_one_loose_object_map().
>  * Dropped the obsolete patch "run_diff_files: avoid memory leak".
>  * Rewrote the commit message of "dir: free allocations on parse-error paths
>    in read_one_dir()" to clarify ownership of the allocated untracked/dirs
>    buffers.
>  * Changed "submodule: fix cwd leak in get_superproject_working_tree()" to
>    reduce the cognitive load on the reader (i.e. to make it a lot easier to
>    reason about the correctness of the patch).

Thanks. The reflow of the commit messages made the range-diff somewhat
hard to read, but from all I could see the changes all make sense.

Patrick
