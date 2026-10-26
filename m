Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025026;
	b=lQ5L/0w13CBwy8szxnuPnRe5SYHP+knMW/XyDGR9XG9lnWggt2hhJdscq5s8Ff47/eqK
	 CQ4CWnRuyu3bmKSZT/7xzToEjsvZ2GIWNyQ+tLoS+Nkfp7UhBhb3td4YoUx5RvxgeSMj0
	 T5QbFMXtS4U+HTjzEqYOw8jgiB4X2FyA/fUUYxnoo4OrRdawcnqmeaPKMAhC8UeParRS6
	 qmcQLTMqhM98wXVquFpzvJOsGZD5k+E2ZJIEWm+rKgldPWmwywhQc+RqwCrW9RHLDBJkh
	 u5+fo7IHDZFizpFh+rLiSrAq6mRJpv8QYqDRhbHNkwQoV5P8UxzfWcsL3VWLfAy18EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025026;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=C8FZP722LaT8IGVy/a8QbuMVfnqh7TI5bmXNyO7JRSw=;
	b=HJIsWmuxAvF0tA9GCOCWJZK5bVKdySiyHu4FEE/dOT1Kk350oRWq2bigzbAvvSDzJhBc
	 cZgEGs91zhy8uKT8z5ApyS7xlbAateE2qmCEhiX54+yfnXTQQ5gP7JzDROILjaokGqg/f
	 FBpAOByFaBgCYkRVi0bMdFXAxiU3RCaDmyQSMkvYgxhws2229RhMXTNZvr8r+dmwt9uIG
	 KGEH8Ia6SUJ1DDcFlFkv1EgW5lDMFBEFOKVA/rRXJbwsxz25zZXEyc4BHRkIGKFkPCnRJ
	 6JuTAbq2uNzCVy24fDEk6RSe9cMKmXEYEOQHobVbu6q0eucwS6V/buz737HCncdDQig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Z++zmXfh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZQjgBOl+;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E15606A333
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9E15606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Z++zmXfh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZQjgBOl+
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 424C21D0039D
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:30:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 10:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793025024; x=1793111424; bh=C8FZP722La
	T8IGVy/a8QbuMVfnqh7TI5bmXNyO7JRSw=; b=Z++zmXfhgh09Pc+KwJH/SO9ZTy
	E2F2KNewBtDXxxuTNo8m5CjGOF9yNJH+ICA27szKWDX+ySYaDRbSBx7sBZj97ybS
	KVEvvKITN4mKu/iiCg7LLMPULn/IKMxun3bAVmih93gLRfvaYT92yHxn8oZv+E6O
	xiuXPfmIdyXweDLwdUdgI9syJ+OKDefyKmrJ+BZueMB0kF2VWVW/fsS26ZJNpSPe
	5bavWaPHD6+iQQ3PLz0gASebeogwHrMgaMUeg6w+M5qZvakKieknXeqaYCJIKIfz
	modyb7CFTfIlqxgoVDS1q/jWfVC00NbocgKJhor+uP2Bzgp6PA/X+8y9hQ6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793025024; x=1793111424; bh=C8FZP722LaT8IGVy/a8QbuMVfnqh7TI5bmX
	NyO7JRSw=; b=ZQjgBOl+mZEtFObhrWASkV4IEe9z08clIPmavO6TBf9ixNgmbEH
	I3RpBVu5Wq/2ZiQ8XVm2E5V9x9/hCgOHNB/0SxOiTeWbAjsgII+ybuVkXK0c3q5u
	d1/gCHlOzdmPyxeggrg6x3UDSz7/fdz6RC0MABfK5t29nYtOk9ajge2FQjaNP/AM
	Vq3wskYDFyes0yrKJraA5nWnVdJqktGL0gTxR/PwljPWDSpFACg1CqVVbiLa7DbR
	ImvwakBNJe3Grw6bJyBdelP6XUuRmiuniWSSHAXeThVaxUa4rutcPOSqKWCkk+F2
	Ub+9dIlMyLN7MjmRZHMM7J1d7pcyIt25vcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793025024; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:COQ39ft//mQrAW1sgorReveINSLjeX+7i7rWXz9Ecl+S7r2
	RwmEiI1bQ9pfYDqqGdqows55j1uba25SXt4uFioBO8L0+CXma4OdS9SG5OwH7Mhu
	DJ2wwAouZtckyBUZ3m353ISkQpjJkSbjqMpPVyq46mZAteqpQ6Lk9BRLdiPTuHV7
	uX4rmZGNIFXqtzehaOJg7siN3aEnjpU34eC3swbPzYQiJ6YysBNBM7LLbIdFF2Oa
	K7gJyAD6EteH6WACLPflw/rp3F8nV6sYHhCs6ZsxuXEDJBcG5qP28vVPHaT9jTMY
	gBmBDOcdHOV6P6M39RLqyLbfmXj2TxZJrK0E7pQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mL5kWaPsmErHsyR6V5TtTddLJv4w7elec/KB5YG3sXk=:0gLRPKtGfIs4olBh/vOduLPa+O2h2SrbWE0WDsnlXAA=;
X-ME-Sender: <xms:AGTfalHDZiy8w0hJziQ9fojYGgSyA-uEx53EuTiCMggu82VykMAcMg>
    <xme:AGTfak790fUGo0hTkn089Du18PJvDe8KKpT0Mmene8Y641SWNe9xRCd48u1Mg1912
    Ol1Cii2DmoJEwiqNMu9ZK15LZ_sgzpCF3NumHRvk-WR6YeWaZNqVw>
X-ME-Received: <xmr:AGTfajv8BFVGK4lzSYTodzp2sFwVBZWuX9R05h8a0wlNxuwShz5UBUzqQ_PygSDIF_ORV4b2e3F3MPz_InHx2j4p1uJCNZnleKbH>
X-ME-Proxy-Cause: dmFkZTEpklx+TSE2ikuKrosJ8/wTKtNMO0yoxplOZr7G/XqDP0RbdUnMIf5u2fLrlRdjDC
    aOa4LmHcUxnfGkEM8zYhf8z1sSEsMLo2SmMB53BwecnrJCGdWIG8cA5Y9wITxJueqaVE/R
    oIYFZLE5BDeEmm15dvlISJDH1DmqNgPcQ7KwBKABWI0snEfy1lC9NMTBAT7xQU+4S46isk
    GW2G04YmOjsjZ8glQOgLOf5Jjf+lPo/Mbesy2ZGzIQbht0vxipscTmVFxzuv9Bu2mK7fIU
    0Vuaf5WpTmnzENMhoSmMBb1CZ3eNp9phjgTxoBhfl9MmuIJeRPyzNp/ZpLGNyYJJ8qXfnc
    5glaBwY2/VeXvlSiZpSnI4gSDw7EYs2Xjh22B4DoADDDUs3f0ZaH0vUKdr8eDVgA9ofAfN
    RUR6hRAy+6KERjLxih2c4WmnTS9bM/SJ9oIFeQvAAjMTpbPVOfX/GfXRu3eTbP3+AOZFOZ
    PO6pms0Ayi17Y0eURaQVZ0bnHD/PSRugsm3iPtgBF+hEDpWXDY6U51ln0e37HTiByYolW2
    4QXbeIpAXB8kqWUgNhLLyDRwqKM5M0BLeLer1DUOb+ZJipK8QvlUGHRAGw0jIeJsDJ7xTO
    oauPYKAndkRAwBSTUvE5atADjnd14IMjWng9l1eZVoCvE8mI4MdKn580qsQw
X-ME-Proxy: <xmx:AGTfat6cYQv7OPE7tL8uvm6NDmgWWlPANEqF4hv9f6sVGNWrPzll4Q>
    <xmx:AGTfamWMvfoH9tkRCE2uLEGwLS4dlyD0FDrij5xR5vgtb8I5I2Z-bQ>
    <xmx:AGTfan-Y3pmA7BTGftD6cvujjr9doWurLlLpb784Vfwf9jR91DwNEw>
    <xmx:AGTfaqnuCVNieg6QnnoDJ4kNCTxQjfBTqUT_VaGNcnfYvJgyJfchCg>
    <xmx:AGTfasWhuCmC0wFNuJuUhPsqrNOFJusDbcngXnWjOE5VF5NWEOnSvunl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 10:30:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] stash completion miscellany
In-Reply-To: <at8TywNz2WcDc-0c@pks.im> (Patrick Steinhardt's message of "Mon,
	26 Oct 2026 09:48:11 +0100")
References: <cover.1791827304.git.ben.knoble@gmail.com>
	<cover.1792761643.git.ben.knoble@gmail.com> <at8TywNz2WcDc-0c@pks.im>
Date: Mon, 26 Oct 2026 07:30:22 -0700
Message-ID: <xmqqtsm8v8jl.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

>>     -    special case in completion code.
>>     +    special case in completion code. It still appears for "git stash <tab>"
>>     +    when GIT_COMPLETION_SHOW_ALL=1, and when typed explicitly we still
>>     +    complete options for
>>     +
>>     +        git stash save --<tab>
>>     +
>>     +    which is helpful for folks with finger-memory for save.
>
> Agreed, documenting the status quo feels reasonable to me.
>
> So overall I'm happy with this v2, thanks!

Thanks for writing and reviewing.
