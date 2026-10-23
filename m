Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771227;
	b=A8d+Q8dP8ztwyGLN+kcL/tC3XxgZiRwCUns7gqZ7PhV/5XIHpUG+tV8z657ELWeaewIv
	 4V48CYfqstIFqlGS6JuhhCkbmt7XYlhSy2CTZBCa3LavRt7x6DjmQrc456mqgQ9b25aMD
	 btkkqoMIJN0It7fjsFBDyE/2wt+WGFw2SkBe6xPMxxSsdBKuy78P93mV65rKsUcEl6rwm
	 t9bb5Hv8cROqqddxm/J5C6nqJFMTvAfGMyjzXlwmOVz+yG/GrHaKss6H9SfeXhbDrHJAR
	 tHBeK1pMKimEAqvbZAHfISV5xtzlkQBkWH+bjyaaoAaYiJt6mDm7FsRzHy5RV805agQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771227;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=SDDhIUkIYvIEtpqohbZUpnQtrkltVXre2R4FQ0FAE1U=;
	b=sWYX3cqNZoUGdfDgeWuy0ILuPDGgQS4PxePXiyrfvfW6UZqD3L+ZZ8ITuPcLB3b86ozd
	 SL5QjT7g5E/mWZbHS/9+AE6N/NjKrVx+r9/pwixhWptfH0vSX6SvHDQ8gab2iTNwI7mGZ
	 Kaufqp6JzzXtZDosXDwJgwvRs+zADgXLmU3g53bt7m5LZelbUjd6zbgTztJePjkMBDfd2
	 EhrvCXujZJVm/K+aX8nfVSC97oDTs/UvceWGwKCg6w5TWGh4zFGu6oetc/Rjl3h9Il1EP
	 EvQrfckMX8tZMYcQMNljwPkO3PN6fx/eMGAqVELJ6VM4aVm/MF/fc5D8Zp7Qg8I7T6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bzMyWMah;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Gj7+YCCq;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD3606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 16:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2DD3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bzMyWMah;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Gj7+YCCq
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E4B6EC0377
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:00:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 12:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792771225; x=1792857625; bh=SDDhIUkIYv
	IEtpqohbZUpnQtrkltVXre2R4FQ0FAE1U=; b=bzMyWMahKZuqHVNOte/Ksetame
	r/mSy95PycrZvdaaChnPQ9I8XW9z5gSIyoFs/qxVqI7qKOwbzO8A1g+wDnC9XP5l
	4wvDN1o93fZvxSF68DVfxxOeggZv0bw74wuy6vgAGNYNbUEnfwp/FjdU9aIdnWqd
	vJkoaucL7K+PTcfuVlZav/I+lUpNRAGfEwRMOa5t/RAkoCYsW3PUS7s9p8eOI3n7
	Oqvpes5a5cs8oP8Mm8qEynOQ2R7rCF3sSTygMJTRwmXlavtovwuZHARfTqC4/6EP
	V6jATpXhaqroRJz/zQ0665Cf8XqmFJtBfndkPK32oPYpDh+2hyZvHqCFRiVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792771225; x=1792857625; bh=SDDhIUkIYvIEtpqohbZUpnQtrkltVXre2R4
	FQ0FAE1U=; b=Gj7+YCCqWHl9fWqGowIAESch2i2oDDqhv3vtFjhBjnuGr+wTpUQ
	HNsaInrcI6ykeAyAQ5ZfXJ89EidzihOGShacbEm9LvphyWB4XmudjnSLJIExFlDs
	HzRcAmyLqjFzjUTqRI69Vck45lwCvYNEAn1TFSbP3EUiaaw8lutqsauPSavmbgBX
	TMCHH5xLV2RvHYKjV5h+vv3qeibxMrUoYkgsnW7Dasp0CMADpjC8qTG4y/7Wk8ff
	yCTQUCx9nVsc87t0OfMmNJzKpRxpc8YrPHDzhRw9W+aXFbibV76RtdRoW7LdSdFp
	M7m2TZdmjiJMjo8Ej0UFoYcUiatnnMHmZng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792771225; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Yr/KMwiUvYTk+2iiMcXfrkxRtH+burmqsn2WI9WjULYbjuU
	l3cPpk72lFSSFlYmjgbZAfnsB8nNwUn27LhfH43QMFFMEGUJgr1/JHucWxv1pn9F
	UBQQ890gUA/yU+GiMySQsYqtqBoVO0CJXi/HRwIcPSHdBgQcM5bq2flYfTIdgp4k
	3aa7tJXzeNXGAmSN84o1Wu7UeS8sEugv08IxZ89sGLG1Ce48rmSxpHVXAXvVaWMN
	9HHeS3eH/pi1d9xoBQ3lAZLVyLXUN0bgjDHSTox9Hi4sG2J2GQyDuSF575YzSTLd
	vUnGQ9FW3sL1FzpirBN+45qVVakKNCK+NgFKPYQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:HAnDC1fRHMPsHvSQKTnn3haGNIXREKyjc4fLUTf9CCM=:QbIaSTC4lhMa92NP8YvN46TAcqkMdLvXF4VCLzBRpdQ=;
X-ME-Sender: <xms:mYTbav1gJCQTwYrUhPdz8-2JaZFiIdnEl-_7mKTRY5t7q0e2MSUFxg>
    <xme:mYTbagWequAM9D6-tGG8_sce0ojWTRAJ4SBZn8IkKDHAJg1DtWGAFIl7SBxkxFYeJ
    5lcqSHhobpnKLYhauWJ14al86P2d_6nb_OI1xx3lg5H47N5FFPfww>
X-ME-Received: <xmr:mYTbaiKifeCAzICSueBPajS85a3gy4XClaJOhzqYCsBfEVZFY16isVJSCIJ21QA7ev0iksP37RR0G__othTHa3G3EHD_UrY8NMN->
X-ME-Proxy-Cause: dmFkZTE/IYtWBXcvcEHi8vn4UNRW0EdKxco+1NnYq9fVr3BcwzXZkctfbosqbvUMAgdhBX
    Y2eicFqMnY5mLMgFbUu5BQaFQ0jKnlePFxV+Nz8pbXZPnXACJY1MnmRU/w1N2XmxhpUmjE
    hKrPxHlMyph8HY0+LvEg59sBDDtOGOgCMgMfftop3NpeIC5rQeMlU4N4zHF2plgKch8t5/
    SSvqGeiyXSH6i39+G0LojcYAt2aBTi4tWMIw9wowqMwKrwKP6L+9Z429U5qOqGv72lYkl9
    7wlsHTAvnVj0b7upnqI5TIs2OQSZTrYVBbhzNB6txjloTJDvoQJkmSlezVSpUVFx50LUfL
    pmKjx5sdB3WFfQu/KchZXMWMWkzgd83X6UgoteiNsvNqOXSncd2u592tSXTzTwymaNwy6H
    BEHB7IsEjY8e1b516k+/kcVm1ZHKLrWp8YVa+tnHGNdlZoptml9wDqiU6haGBJ1wwwd8hu
    BLuOumzV2AtrfldYvTd+7Yecy1Be+wYOC3UAg/G5t91bdaWqC2apDgcCJKDrTQgN2HMRrc
    zPCkPAeBVHQttmdwQ+Zoj5N7GV+Yi63RWhUiJk0/sQA/gOZoLHW3LXHzcrumVl1/qxoZm1
    CQE5/HhlyVSqZI8PJ8DzGnG8Upe6hkooOGkXnr4hXTixr+yxuOb9jfFSa4HQ
X-ME-Proxy: <xmx:mYTbaq0CMPdX2Rhg8siG32TZSCun-xwxP-BxqwXMuTCm0vRe6mzJAw>
    <xmx:mYTbag5mCScjN5BV6zDT2RjJUJpSbpvSyNqnLnbIn-chEvVkMIe_lA>
    <xmx:mYTbar9n5psi57g7jBOpLKHLsfLgDpLxyzmaEkjCCJ30YLxkZTvkTA>
    <xmx:mYTbavUhPhxxU4Jfvvp1cJPIVhN0qthdEREANKVgsZHzjlhhBcT93w>
    <xmx:mYTbatZfL6ClF606Fy9fTRFN8srYNIFZLMZGosdOc5P8fz-GZnzwqYZO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 12:00:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 0/6] [doc] Add new page on merge conflicts
In-Reply-To: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Fri, 23 Oct 2026 14:04:47 +0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 09:00:23 -0700
Message-ID: <xmqqld7o9zl4.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      @@ Documentation/gitmergeconflicts.adoc (new)
>       +    "cherry",
>       +    "mango",
>       +||||||| 1c22e48
>      ++	"banana",
>      ++	"cherry",
>       +    "mangoooo",
>       +=======

Is it intended to use different indentation style for the entries to
be removed from the list, or is it a simple mistake?

>       +    "banana",
>      @@ Documentation/gitmergeconflicts.adoc (new)
>       +]
>       +----
>       +
>      ++With this view, you can see that both sides fixed a spelling
>      ++mistake in "mango", and each removed one fruit to the list.

"removed one fruit *from* the list", no?

I'll block time to read the whole thing over later today.  Thanks.
