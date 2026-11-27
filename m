Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789061;
	b=mP+ReLAMUWCks5IaTTvoODs1MxdwpKcE1FY/ISQOik4oK1F3CPW7nVfEdDUSUftT8u9w
	 UYiZXLos+QCp2S8yfeMqVjSHra1yQyDZRsGNB/32Aa42anmtaiTU5U5dxWNsLsgl6CBDG
	 U43zOK0aJvfKAtoGsC+rme+E20aiXWbwHI0WC0tsP6L0o4QQvNNDGeZgscvlapXO8uHfX
	 gI/lvEumdzqDqc4c2AbfqtnZNjGtWl+OXwp6S0HtrQ47sbotUMNWKJJIr0yYn2pMI49MX
	 26Q8YGunJub8rhv6IxHMVBoSe8qEPQ3jn4iCLqWHlMZmnJrp7qHSHKN323A+t3AcBzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789061;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=eHhLIIJX5dHZagFaPcooTf98CIVTQUdzNxZNcWGyYV8=;
	b=P855zTzs/yrhJr8VMjJ6KuPYexOBJTUEYAiKLlMxGrrJtOikwna50VKLx6avhfigLr0e
	 RFIqJ5UkJ/ZUozt0OUzO2OCHoAYzCs3RthApCKT6K49lRk5kSEx6nJ3/Y3IaeUoCmYfFd
	 i+V3KXgq84RjAa1YuyPxGHtwmMnnayffezWEGF5hj+qdP2R9CBaLfZGaDnpHOuBaZiCYO
	 D2F42pp8NfmoYa9Ysf8GhHM5AqtUeTVs0LlC3+LF3DV9alk0BSp8IsFfy7REWY07fISmh
	 +wlRjrjdUyfN217OlSJuXJ6tYrWHIMTQ6hy3q90apxaOCv54nLxq3ra9GDPrerS+aUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AjtIp9Cx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=awxXDNz4;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2769606A323
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 14:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2769606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AjtIp9Cx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=awxXDNz4
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DE1A5EC0A14
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 09:17:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 27 Nov 2026 09:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795789059; x=1795875459; bh=eHhLIIJX5d
	HZagFaPcooTf98CIVTQUdzNxZNcWGyYV8=; b=AjtIp9CxpcKLX2QBGUh7KyhMQT
	SNYmqhuUXheqiuq6Pnmzs8gqWUAuHuOdY3bgbjet8/QaiMnq9MblQfd3Uxgfe/AE
	n2Vr6OEks5e+wyjNv5fXyqAfd8FNiv2Zmtb9XSX6khDUE9boOFek1xh+9jGM/66O
	ANY5nr+Nh14/PjNDtBJTXVULYTpjULH3l3I+yXfpK6j1AZcfPDCAS6Tu3+cLTQ9E
	gcA9LESOx3ZpTb8LO5+Tka57WU2NQvX7TD7Clf4oKeAlBvdSWMb11N86zjbhkrLj
	Zjje1EpD6BJ/fzXCsdpTTD+fH7AgXiTv07UCTwOS0RMfTs+03L5NY3CdX7Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795789059; x=1795875459; bh=eHhLIIJX5dHZagFaPcooTf98CIVTQUdzNxZ
	NcWGyYV8=; b=awxXDNz4q3+kJL8RPXBrUGCcjQ0tMWYBZZcXHEbKtzFSMg/GRRc
	LyLAZBV3MiqCsAJgMA5d6I0QXLqm1j40Mssq+sC9UpuXnsbYVd4chKcW+BOZKk9j
	Xa0ALtl4yMsCiHkeNlfJtjIQsAHZJjN8YZFwB85ZzimfJppfCCsArYeOGnzjlUaX
	AOtA/svHBQefGEQ3ypnTItyzPRPvsFGvg8+35hF6yL48T8Nb+W7b4Nb+ny30kKek
	/HzgUT89Ke/FUxsV5JFrU4DdYPxnkue/3i1SIPo191NP8TCCXeAYSCvTkFWSENQd
	rmM4HRl4nieplWLW4pjdfoOL5QJrN6ncpsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795789059; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UX73/SFpXmjkTzkOX/cgCtwKAyirf286Wf5W9KiT5h2c5Ax
	bIIDrOoovjamfUi7EwgN5hHV3VbPGYvx2B62aLY3PC2evXRHIpLuQygkuelzjJfG
	4JYwwzYGCWaKTT8oSisMqVTCnaFVH7JJhTvXWjG8nR+nHo1aPYx5NDNd7n+gZKM2
	9XZ7dlbdtj5T77ANagG0PbKAgKH52K1SuqfrAnkIYiZf9zFLSK+6v/KJKHJ92knO
	o7eJktutbz5wb18yjD5np7fEBal7MlcGrQoESmXh071Z61TOo6m8G5nH9/4TFziq
	VfQ4FYjL6xL5v/6gfvzM20y7R2fJFIvyApVsgig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2rxykn3nSxLEmpx7dS8mS4lTiXtRQANca1lAwU7jz0M=:7nE23WS3MU0afajZcSdbZB/b1QwHvejWorRu7eWF7Jo=;
X-ME-Sender: <xms:A5EJa0HXGF46bnp-K-2rwnO4Z1wHgQrGhe_t6CrmOJ-Noa9K6NfZ0w>
    <xme:A5EJa34azp1_L4F-RTWi2BpEsFbi1r9FBOyLOUi72zm5g_8mmoicsW_X3EKJDUuf-
    iOdk3qEG-yYiqEmDbb-eCpj0DWbfWUUVn_CThZ30-Glv94Lp6CILFQ>
X-ME-Received: <xmr:A5EJa6uJ1uXoFvtAPv03HCjngJk-6XJbGHkqrlztpYSz7B2fPxwnncammZAzFZn70HKZk7goX34kqSVqOFyB4tKbpTmk9wy-mju3Reo>
X-ME-Proxy-Cause: dmFkZTGrFLQiRgOkpliKz9LWYqgpvmvV62+K3/pbGTGnH10Ck/XjI748eR81dTUuby3Zk+
    jZlSBddtFn1BrFA0y/IJO9thXE6J16eI+YXd7ekieDTcY766ReZfOlRI4FgNMglzq3EFi1
    HPArABkvE86fTcRN84qoY9PRygC+7nW6IeZ520Ed93/gdRKF/mTfA8U5DxxFQfVASChphu
    JVs5Hhh9CwN1892y3Ra7p5Gh6hWYhem18VfpLWrc87xTraHnt3ORej1BJKr22PJqg94xcc
    YlwXuvEBaCEU5+6gI6OlgYOgoCKzC1fm5Ws2swD6mV3hgT4/RXyFa/3+tRcAtM4tjuykD9
    ItyJA0Th11/0c2iKuoumKP1utK7J4iFTFmV5HR9YK2vWVDvTKG1Vz/TN+gi55CYRXtgtIr
    yNzyLMPwN+xRNs/Qwk5Qyfwvxuq/GSdEiPV4/JX2MiTnLeUpLz8+jU7d7HGhO3p5yNjRXv
    2jtHaP5JL/eFz9VpvS2DvR2EFuJzwcEhXHpj/SxFoE09GyeEGa8C8e1dBhErBXPGg9DzcV
    /JkWc9aoJu786xPg8YGr/PmguH9Q2hQNAtiDASJ2ENM9p8GApDFzncNmorjxX1aWySnplQ
    nDcVowG4gSZnn5RfuZ3bOey2trprU77Yu+2mK4mUUJnQSMEwkPe/K5/O+1Sw
X-ME-Proxy: <xmx:A5EJa4517Xz9zA31uPg-9wJNOkG02PWXHXHmNUA0KtTltyRWKIhFew>
    <xmx:A5EJa1XvNlqpeMNZ9wEayWep7qC6FBxwV7RyhTTskr-BSa16-sBqtQ>
    <xmx:A5EJa69YsaSjpjFI9mFMMwyERIjUCGQwldlapVrkNA7sh18p_nFIVw>
    <xmx:A5EJaxnjsBNkTz6qkU1MLb9lskRu_559rfpNHVv7eTmCx6RhA-SoQw>
    <xmx:A5EJa2vhUVKDq9Hkt3mzPmcYazv-WtWnEfQvf-qQlVJN64_gIyIjWxRU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 09:17:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 1/2] command-list.txt: add gitformat-loose(5) and
 gitpacking(7)
In-Reply-To: <20261126201110.9046-2-taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 26 Nov 2026 22:11:09 +0200")
References: <20260909052501.8448-1-taahol@utu.fi>
	<20261126201110.9046-1-taahol@utu.fi>
	<20261126201110.9046-2-taahol@utu.fi>
Date: Fri, 27 Nov 2026 06:17:38 -0800
Message-ID: <xmqq33sme4u5.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> Three manpages from sections 5 and 7 are not featured in
> command-list.txt as concept guides or interface manuals.

Since this series is now based after the removal of gittutorial-2(7)
from command-list.txt while its stub remains in MAN7_TXT in
Documentation/Makefile, there are actually four section 5 and 7 manpages
missing from command-list.txt (gitformat-loose(5), gitpacking(7),
gitweb.conf(5), and the obsolete gittutorial-2(7) stub).

Updating the count and mentioning gittutorial-2(7) alongside
gitweb.conf(5) here would keep the log consistent with patch 2/2.

> As easy fixes, add gitformat-loose(5) to 'developerinterfaces'
> and make gitpacking(7) a 'guide'.
>
> That leaves only gitweb.conf(5) which could be added to
> 'userinterfaces'.  However, the manual would then appear
> as "web.conf" in `git help -a` which is just confusing.
> So, perhaps we are better off by leaving it out.

The above matches help.c:drop_prefix(), which strips the "git" prefix
for CAT_userinterfaces (unlike commands, where it strips "git-").
"gitweb.conf" would indeed show up as "web.conf" in both "git help -a"
and "git help --user-interfaces".  Leaving it out is a sensible
workaround, at least for now.

By the way, plain single quotes 'git help -a' instead of backticks are
preferred in the commit messages.  Nobody passes these proposed log
messages through AsciiDoc or Markdown processors, and they are supposed
to be pure text.

> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  command-list.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/command-list.txt b/command-list.txt
> index 56d0d7ed9b..6936ae8409 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -225,6 +225,7 @@ gitformat-bundle                        developerinterfaces
>  gitformat-chunk                         developerinterfaces
>  gitformat-commit-graph                  developerinterfaces
>  gitformat-index                         developerinterfaces
> +gitformat-loose                         developerinterfaces
>  gitformat-pack                          developerinterfaces
>  gitformat-signature                     developerinterfaces
>  gitglossary                             guide
> @@ -235,6 +236,7 @@ gitmailmap                              userinterfaces
>  gitmergeconflicts                       guide
>  gitmodules                              userinterfaces
>  gitnamespaces                           guide
> +gitpacking                              guide
>  gitprotocol-capabilities                developerinterfaces
>  gitprotocol-common                      developerinterfaces
>  gitprotocol-http                        developerinterfaces

Both entries are placed in the right alphabetical spots and match the
existing categories

Their NAME lines in Documentation/gitformat-loose.adoc and
Documentation/gitpacking.adoc already match the expected "<name> -
<Capitalized description>" format consumed by tools/generate-cmdlist.sh
and Documentation/cmd-list.sh.

Aside from refreshing the commit message for gittutorial-2(7), this
step looks good.

Thanks.
