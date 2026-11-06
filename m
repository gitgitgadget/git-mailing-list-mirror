Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974463;
	b=XSLZVZpBywx2nDBCPYgF6usrjdSqQxXMEha25z6jmyPpRYsnmUR0fHCCFG1NGshQjgkm
	 pHdNa6hFu0WgluJDlZRKhI6loJHthdMZYkzwEm05Vspi/MrPd1bDj/7nwqf1QRVmIcPKt
	 DaBzpNEVQVWL+Bdkfuj2j91MUfb5uSuNcq1xqP3qwNayCZlqgHSY1A9SAFUiy7VH5m4AF
	 5O5t39xSYZQUMTEgEkfd9rgvb3dOdcKCwO2lMGf6qRQWrHoe/isWFYiqxKi9qv2Y12k0a
	 j9PeeqcvPCq3baPXozvjnu0lqb0O9Dzs3iqk9WNKzll6oogIUNawO1oJauW1HGeph6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974463;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aeIQCW1/2sUU/Jtr47ZxS8qaYR87i/YriuW9M4WSo5k=;
	b=UZGHzTEOMiyVU4CQy21ntrtjxy/oZo0iTwKbg9PLXNVDTeNoz6LQluA4FY41dbu2N6c+
	 FCMPQlydk5QqIg3+z5+Qer8sHqqNJjaNilcNBiuqffJGysxKbnH5mLmpwd3l/iNPd4eao
	 14NVklP5GkMlMTIGODwywbFCzcRHwZ85+n4D4mzwJU37XCizEy73fL2Z4ude3xWhRomN9
	 kSi/LBTOI6Jfm9daTc6iLjQZIyG7SZvkRqBqgSbAMFsYuURzpxKPNhRImi8TOWxqRREEM
	 Fe7AHelkSAZEvM8TAHAKnu/dO6SI+E3d4gQ7bXQQLOcfwH3mvUo5N7pna27hWpV9QHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ko7PSTOU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LJpjgyev;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F895606A33E
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F895606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ko7PSTOU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LJpjgyev
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6AD5D1D0002A
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 09:14:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Nov 2026 09:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793974461; x=1794060861; bh=aeIQCW1/2s
	UU/Jtr47ZxS8qaYR87i/YriuW9M4WSo5k=; b=ko7PSTOUcsSgBiQS+CKUgrBcuW
	fUPqsn6wjDulnG/U6NGkQOoh/SD3+nzHVKzMy1glu/X+GbKtF8MfS9C/T3CvSRb2
	TDnRj25aJd3TumWwF3De7S0KTKIEx874oF6SwoGIwgJkxuZTz1V+iwqbKhAKtRw1
	HjAAbK5blhlDPYMNXAr2Ebzd3Csc7ft7t5JvJ/UBjwpt3dFWyF3Gzw6BpxFTDjte
	iPPXGgYJ/CTRVZWdpYPzTT+ML+xiyMRG+mjjeYVpjQB84iuyIaHBoqLgF88izkx9
	OMc2AWkdBIXtD6PuI94u405+AZHKexE1XVVL/+9i5fLCgpd01zdJ/Ijw+3fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793974461; x=1794060861; bh=aeIQCW1/2sUU/Jtr47ZxS8qaYR87i/YriuW
	9M4WSo5k=; b=LJpjgyevtNe9lLHVKvuFPcSJq+Luz+xJjPVxZstuev51l0HiIgu
	Wf38SjK3EzO8wRqRmxcE1Jk3hVg9Iiblg4MwLjDUT+7wa9MIqiMoIeS+ZPIpBxqk
	iC4dKXHM9kn2gm483JEgTGDxmkV6tp7Fh3EyqXIPewwPR3BMGkEZNNi7WSOlDQgY
	8rVMzb2JCdU4xv84YE+tQa3I7eA6Gq8ktHTkXN1y7QJWuY8Ptc/t0Urti/BigNzq
	zm/ZAxK9rhalxhyDDk8+yCsxJ/t7ADESE/JtCGugifyjXkXxfZRw8AMtbPgQrTwu
	gFPWLuu75j6gNw1oLxVn9Vjc6PtoyA2O0fA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793974461; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:sU+nY4GGVGoDxlo75oNJDZau8HMKWhPScxyitTmoiP1GT+m
	BhiHZFDg3b17nsSAjOjdWyp6lEXpXlIak42rjlzMxerl5ed508LmBn6SI+/QEoKn
	SQClgFEvuTMTLGuVKWnWh/a2yyW23Kz7nqkjAj7Xvbv+Fd6CDSmMRdSXxePb5rmI
	h3OcL20jLL18pVBzdWNr+RzItrHIU355JmR/H3sQ3M9yJYpZ/FJqbtr/DZ2IwgHQ
	CQXltP2GHrQ2XMdlwC2pNYjdFglHgjqyU8toadIyR5lJOREQhYiTFviNEF26rGm7
	V1HF2HrjVxzp2YB0J60SUj8Xo8oV4r2OaKEcyEw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:demgJrIwfZE3sOQ7cC002a26QNC2NgxRWfb3O90o6sk=:beph+51PW//M4knIcXCpeC1Af3XU0DgnWL1YVDp+IN0=;
X-ME-Sender: <xms:veDtaiDkHhVxq1l9keriP3ZcNSuQR1_DDc9N04eNGeBQd1qp-CLFnA>
    <xme:veDtajiiyi-CA-OU9GS27DCCAJ7ao30emIl1rL3aDgfYwGbWT9krjkjaZIyThFoiB
    79UL9ruvNwVHKViwz8xVXbPjSiaA8UvrpittdyTBlwWrRL0_EqE39v_>
X-ME-Received: <xmr:veDtaqlvj_DpMuw2MA23ZIgBRSrO359C6kA1YKjviv-rnwtGQno1CDcGzjEjtKnYaLnBxg>
X-ME-Proxy-Cause: dmFkZTF67bGEiyXC0ZPfuj6Su8SS8719tThVeavWC+k2eDrHPDI7hPyOxqCBxu8EP3lo7B
    lHP5BS76uw6gI4Drxmq759qvoM3Y1v+dEg0sv9rAMFvxpfOrEKh68CREJQ91GTI15hRCDG
    975cJVlDR8OuAbYynNbgZFhoTeF0ixRhiy4qXtlXTan9FSfj8cI8GoHN7oOG0XjDcCN7b4
    rw+43TCi7/IcRZ1kA8ebfP7M/NSqG8DnsYbxtub4ksDsDzSbnZUWlAs48V137vun+kx4O0
    HT9Ivy77x4ehJAhKcRUdjXdO9FpAHw4xZRYt8PHe2Dki2PB+/tKe/yeuyTQGe0Bu0cw+Ut
    MifDL9ix3I22dk1WjhqOHJvErK9yqMT+u+SLKpqyMiwmBtart5Qsf6kVaZ+gqtW3zoJFGE
    tzLDqqJqjmIv3buF7PK8Fs6mdA/22/qhayVoEE+dZPprFu/yE/H8ka+9fnzfo8/PUKF3Pu
    T7H6NOivSulGEGZkmQs53IZIE2HT10ssCTyTacHdZghunYKcd1ReD1j52GcOhtkEQjmxsK
    pfRTWC48uKlFN5MEk2gEtAttyJhZiZ7jeeETT/hOa/c3Si3RC56rPtnJnOGsrF8dKjqkin
    6aP2G8MAczi/sVYj1XSdhrahrK7OxUlJmuVPabzXGhPJexOZDpse9cjiaSmQ
X-ME-Proxy: <xmx:veDtavpuUKLiIqnwBl_eVJk7QiOT4qOiin8CDfqwo3kNs7xfeAvACw>
    <xmx:veDtajESrSf6dUpOCjWG21RL_nhf2yfT45ro-AGT1cLDsB8Tv6b_LQ>
    <xmx:veDtarwSy_TWgUnlgQ5nSAFhZgGc3IDOC3_2sKzznMZpxUS5kyx6KQ>
    <xmx:veDtaor1hoLZ8lk32joQuZizs_yJjFhfaRC1pbmAhMbasfgJO8-Qkg>
    <xmx:veDtav09nyNzlWL0ZcXUEwC3TgSfAX552RVzD3HWll7RbBbv1Vu0Mhh8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 09:14:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b1acea6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 14:14:20 +0000 (UTC)
Date: Fri, 6 Nov 2026 15:14:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: gitster@pobox.com, szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v4 6/6] log: fix --follow following an edit on a side the
 merge did not take
Message-ID: <au3guSIBfekx7gNL@pks.im>
References: <cover.1793298331.git.vmiklos@collabora.com>
 <7be8cfb3ba58a4d4dc040fb2f229524599524b78.1793298331.git.vmiklos@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be8cfb3ba58a4d4dc040fb2f229524599524b78.1793298331.git.vmiklos@collabora.com>

On Fri, Oct 30, 2026 at 09:10:14PM +0100, Miklos Vajna wrote:
> Take a history where F is renamed to G on master, F is edited on a side
> branch, and the side branch is merged with '-s ours', so the merge keeps
> G and drops F. Here 'git log --follow G' doesn't show the edit of F on
> the side branch, while it did before the previous commit.
> 
> The problem is that follow_needs_renames() only searches for renames in
> a parent without the path if the merge base still has the path, which
> covers the case when the parent renamed the path. Here the other side
> of the merge did the rename, so the merge base only has the old name.
> The parent is then told to follow G, which it doesn't have, and the
> history of F on its side is lost. Searching for renames in each parent
> that lacks the path would fix this, but that is the expensive search
> that the previous commit avoids, e.g. 148 merges hit this case for
> include/linux/rsc_table.h in linux.git.
> 
> Fix the problem by also searching for renames when the merge base
> doesn't have the path, but the parent changed a file since the merge
> base that the merge no longer has: only such a file can be the old name
> of the path that still needs to be followed in the parent.

This isn't true though in the case where you copy a file though, is it?
E.g. the following test case is exactly the same as the one you add in
this commit, but instead of using a rename we use a copy:

diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index a85fb78ca28..c67d9481ab5 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -297,4 +297,36 @@ test_expect_success '--follow follows an edit on the side the merge did not take
 	test_cmp expect actual
 '
 
+test_expect_success 'setup merge keeping the copied path, other side edited the original' '
+	git init keep-copied &&
+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep-copied/F &&
+	git -C keep-copied add F &&
+	test_tick &&
+	git -C keep-copied commit -m "O: add F" &&
+	git -C keep-copied branch B &&
+	cp keep-copied/F keep-copied/G &&
+	git -C keep-copied add G &&
+	test_tick &&
+	git -C keep-copied commit -m "A1: copy F to G on master" &&
+
+	git -C keep-copied checkout B &&
+	printf "line 1\nline 2\nline 3\nline 4 T\nline 5\n" >keep-copied/F &&
+	test_tick &&
+	git -C keep-copied commit -am "B2: update F on B" &&
+
+	git -C keep-copied checkout master &&
+	test_tick &&
+	git -C keep-copied merge -s ours -m "M: merge B, keep F and G" B
+'
+
+test_expect_success '--follow follows an edit of the copy source on the side the merge did not take' '
+	git -C keep-copied log --follow --pretty=tformat:%s G >actual &&
+	cat >expect <<-\EOF &&
+	B2: update F on B
+	A1: copy F to G on master
+	O: add F
+	EOF
+	test_cmp expect actual
+'
+
 test_done

This test passes on master, but fails with your patch series.

Patrick
