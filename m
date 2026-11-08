Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794112532;
	b=fJbeAVWZyqbHPlrfmlD7B9h6UGqon2fQ+VmFfK14fEri567LdE5LnAwYlkVl61g67/B2
	 degm/aumSRfkNwOpmx6lZpb/qEMBz+339Cr8G6AWhtiInszPhp6oML0PB+9UeJ49j3Xod
	 mJ8kRsmYrsLIdZj+i29wC6DjQg47ahZrH/pJV97BWt0u/LeBh/5Qb+kZdI4LhlhlXiTXA
	 VP+ms5zieSfEvEDVa283Hn8xgZJFyrY+Y2zcx/4db75EX2vaibmz/SrveMVnKtIhcGm33
	 3kGEiwStg+Z2J81BQN4A8ajuWXW/XNb5tCPhsrWcgBdHjWXiitIaqgCVkQuxrnvpYCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794112532;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NMuSlTWPgWKbHLlNMwf+XPM8mHOEq6ChAdvA+EKDhHY=;
	b=nXuE9fFwk6avobY4RO8Z9kz+QTyLJmNMO2ODbkBp+1adC2qXEiwcdjzIcDlE0OPKObpX
	 NI4b58Eb4NWyNKQ1GVagCIIm7+kqmDVm9iixV1fbuTCng0zlphJ1+DfeUTTnpIDPDjrwR
	 ama3Ke+89L7lpogT3utUp/9xB9mbxmumibS0Wzv5cBCG1fHib4M1IPyi2LIZ9hUYFz+uT
	 3a6FerUwCe9AM7hf1qyYIHpTIDV3CE1uhEl6BJyPIER9q5RtfZatZJ+qBdgA/w2zPGxip
	 rM+nCLQeC/ysyx/4F39p/guemUGfNc2tGJonIkP16U0RvR7oyeBnuZTRYg6CCGitJ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LwhWEeCe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WNRjaS8Y;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510E606A31A
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 04:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4510E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LwhWEeCe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WNRjaS8Y
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D1641D00118
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 23:35:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 07 Nov 2026 23:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794112531; x=1794198931; bh=NMuSlTWPgW
	KbHLlNMwf+XPM8mHOEq6ChAdvA+EKDhHY=; b=LwhWEeCexVs1bFkyx7z7pWUS0h
	k3e3lQuhnRPrLyb1h39d2BuyN9iIZoJ0liWyKH52l7vsOpiuKGQdTJqgIEIaXQNT
	1NVqzVzbuRThNHUlCFZA9LBYKeaqd2POhwgE2ebzdM2Zm6tDlrU/eEe4qRmgftbX
	vY5bgbiFtTVzryw1pNC4cEboiF/5wZ4qklO6jC4PceZL46ijltJL/JuwgtLml7rC
	9DIzA8CLJZYMCa+34taaKGc1wMY2hEmoI28gs1RXashTVB20pBHIyfZxDUzfuCT1
	PwSnTd6ZLsqLzxg3tVaHwmgPpPKG+OWoR+6Uk6evGD1016vvpQdTrL0d6OQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794112531; x=1794198931; bh=NMuSlTWPgWKbHLlNMwf+XPM8mHOEq6ChAdv
	A+EKDhHY=; b=WNRjaS8Y9btMYj8nnCil6THMx2AvO9UqxfPeeHa/mSI+MxRa5Gp
	iYp9Jx7eNOG1+yYeg2EYOmdJxC6zp1JtGrRdzWSJc/46yePs6rLAM1qkdLoidD7g
	pDw3VBXs+tPbiYJyQUqBICcF8pDtp/Q/fUGFiJJjF2PAziZu4m/rdo64f/DccUFp
	5AdseHKRt2BfrhlPWeNBLJEK5Ci+q/OhQWi+Evy6yTiwpQA64aUjGMCIHW3nreVy
	rOOWiKX61abmXYkJ65Da3xf8xs8fCmRe2NEgvgutwtFoJaiCWloaNhjfZCork31o
	UUNtBTuZT30C1IJLrVzxdiVyBk+GakOCiVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794112531; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Zl22cvG4VtoixdI4dlFjCK+tKLRp+uQwuJ+jSrS4HZAVA0p
	irnh2IgStPOXlOePW29L9lXMjL41STcRuQVO1kaVhXAsVqEaSTOTRczwbz76vDlK
	s1plCy7eKKYbEiyh+ygLqfPg3A8A5UzedPU5tjwboVWbBgIkXLy2uvwV9ZDHdW5B
	wsg2v+xSnbEwHC1D1Q24pKvPZv5Z9CR2wtHgOvBH8fDZpqDga9ZVwP3jpS3o65Ri
	bSz37fVm9aG8iSfN2dMwWeCKhFrQLQkfVZCBE6EwnxZQXehWFOLiwLjuDjC510Id
	noEBWJ8eKWlQoPgBbPbsng0GnywpgpCfWAIShLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:sBzPTGBmLY1Dn25n4Lt5xwduvTv8FpH0X/6yqTe03ZA=:tBkrwzNU+bFfva2YNBnj1i2QL95KCAq9xw2Gwvuee9Q=;
X-ME-Sender: <xms:EvzvagHiECjKvEmjASh8JUF7knqfBr3bV8834DcKHoD3H49mrfwM4A>
    <xme:EvzvatBhmmgdkE_xH76OX6c1K5Z8NaG4nsQf_QRvyzURDf-m-STyDp78HFcZC7TWC
    UyCTRJMLgV5sBkTInvytUoYEIZOKZJ_i4Ky5D4a6H9RSqud440q6bU>
X-ME-Received: <xmr:Evzvaj_gHxKMPOBv06XZx0q0XIkDqFarLJk2TRa9tUibZ3C2_JihrSQ2nhCBOTOP8sIQuHEupBcTPr_KudST0zZhjwa40s-mya-F>
X-ME-Proxy-Cause: dmFkZTFusMZyTWVy/sUNhTeV4lYTlUupQp1rue4lfpacRBZWENbGOECgfwwuNdqT/3pRon
    9VhwyShaE4qlpI3Kcd/ldoATkxauB0aqlgnj2zm2nQ9w/V+d/KilxzH3mtTdRKgEZFubnW
    VV4WFlVNjXoSvibGapv+OtVVE1UNzlP3FZyA4gq01u1Z0rDzH8rcoGnGe4ulcvpG8CJP/L
    H/vsnvQXMtdJ8HSf+znrc0lqLW06MCqt3tHjZohQ5qkWqS1b6tcrd4m/6nIdwU2WQtdpa/
    b3dYlsce5hHT2KjkNFT4gfFjcNePT+6mwRqktIl6D5eAL110KVlkVl6eMHl/YnVslruZTz
    4xTpTPIUvoopkYjgpr+YeuCRxXZOUt6NBQhSNMRFwj0RVipbdOkh3IfnzJuuCapWgD4wYO
    BE47fJC+TXMUxplTT/YBKVvo5HzhjPu5pZBTs5l+VxVSogMi6V3Orz9M8209voBIR6Vq7A
    R3+9L7589BIHqjQVM6uEIqPRICC1lS1WBWJZahKBCjyTG/fkDCSx1D8It4obxjabcmvLdw
    ZxJRCifUIC7S+3+XFIs+iLS07MU68bpnLR3qjhsFkIsTOopCB9cYLL15s5DGsyHUGwnWBw
    6NPCTi80YdnvzZ8Gys8nhTx/v9AthW/ISJhCJmbU11EoMKdIfuQWvitWFJ1g
X-ME-Proxy: <xmx:EvzvapCEDJtuntLfvT1WEEsL4LiUgX34ANPpetkAQ2eaA1swmPLaJw>
    <xmx:E_zvaoSgo74eEc186eCoTZC_M5hBdcO-RbWt2pPmu7zSTpnnwqr2Kg>
    <xmx:E_zvagsPwi58U-X3yKtRHDba6ERSDeB3ilb7II6ABsc5BYg-j5CivQ>
    <xmx:E_zvak3AULiOQ-xo9RFufCXwl7W6W1eW7tUwXzgmvWnoBD-Ho04pRw>
    <xmx:E_zvam2uubeRTQnEO-18xxKYD5ZFLEqR0aVpS09YSk1UkEtlOnlEaGk0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 23:35:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <20261108023730.GA1242909@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 7 Nov 2026 21:37:30 -0500")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
	<20261108023730.GA1242909@coredump.intra.peff.net>
Date: Sat, 07 Nov 2026 20:35:29 -0800
Message-ID: <xmqq33tc6ium.fsf@gitster.g>
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

Jeff King <peff@peff.net> writes:

> On Thu, Nov 05, 2026 at 03:40:17PM +0000, Julia Evans via GitGitGadget wrote:
>
>> +[[name_only]]
>>  `--name-only`::
>>  	Show only the name of each changed file in the post-image tree.
>>  	The file names are often encoded in UTF-8.
>>  	For more information see the discussion about encoding in the linkgit:git-log[1]
>>  	manual page.
>
> Sadly this syntax seems to work with Asciidoctor, but not Asciidoc. The
> latter doesn't create the anchors, and then xmlto complaints that the
> result doesn't validate.

An offtopic tangent but didn't we repeatedly float ideas to drop
support for AsciiDoc, make sure our documentation set renders well
only with AsciiDoctor, and tell folks who do not use AsciiDoctor to
use pre-rendered documentation pages from git-htmldocs.git and
git-manpages.git repositories at https://git.kernel.org/pub/scm/git/
during the past several months?

Perhaps I should add an entry to the BreakingChanges document (well,
I know I know I do not think it belongs there, but since we hit this
so many times already .....).
