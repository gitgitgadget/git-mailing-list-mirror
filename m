Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021711;
	b=S7xvXzNv5O6vkIfe98ui+0uaCwcVDh+uDSszBZCA12swg91QK6E77lbRbF1WB44+YtrD
	 TvkbdvMC5orSsyBfCYnSZn/nWeTM49Yltw3+TV9K2CjXF1z6AUXB5iTse7cDRTb7XXwy0
	 qiJQBIrVF6iWLGJHoNJp8uGkmfUDpdrLK8ei/AG6Unmx1CKUdC1gctE6EmTfS6MH+wOuH
	 PJ8iD77gysFNN9qYr/cbDkW31rpzWTqPbZvXYTt6V04Ncf2hKm7HJ7iamhLoaAuEuRlk7
	 wyHUSrZuryegI/jxQ/i6UIJ4FGqmMI0x/JGwyhp+bey8tptHzrFHs7vYxvSM8sNMOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021711;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jizhAE/JgVEK0gyYJPzlAuTCudiUL8Eq0sx9Fn9VHtk=;
	b=OoEkTAniBxdHuNxaH6XmEBvXJZWa+GSUA9M69uLs9PApsiqqIkuWI5UiJyvPy7/+nn6Z
	 nc1WwIZffP+iowQ9RKoiG43gUGE3Roe+Dog/8uCTxt+vhiC4HAKJNYQv7n4odoMumgcL+
	 yMw8NOWJWW380Rw2PCzA5NyuHuABeW1CLggCAFlxQAkHwYrPDgGwlfSrnwjUumngqRQ15
	 2itKEc7wymbxlvbkSA3H4n2u6/ZS1n18Nm5th0/ACK2EMAbF+zUEdRZpd380fSESWSRJr
	 B9pwaAZllAbDvAAK9vutAQMTTWLkXGTOTc5gquKxN3s27os9UIWrUr8mST4P96jqQoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Vs6q5+df;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZvdUj+ZI;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E3606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 17:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E3E3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Vs6q5+df;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZvdUj+ZI
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4DA37EC05A1
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:08:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 12:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795021710; x=1795108110; bh=jizhAE/JgV
	EK0gyYJPzlAuTCudiUL8Eq0sx9Fn9VHtk=; b=Vs6q5+dftCzx6V4ucT+AufLvmJ
	klYOTGO/LqG0IuW/e1K+ztFizMXX4WP9syDxOL6/m7C7mjGxqX+5pajJOizNbsD3
	zIimTF9079YON0LFucXhR56Fvcx+qavWFA+xBG450MgoIFS4WnB3Ev3ft/7qddnq
	dMXVGGeiJsdHb4hsrxiOkLp+6OdJ4+Fy+gB/gvLDF9QSJCBhyOb+ILjDrsb+sEeM
	dCB1eukqJQetFUKya5XlmaFAAwiOqMyUPSczZPBO0v2JC92h/7sjVjDPTAqOHrUG
	iT6SGsIHXMfC5GLphLVQCmpO6/Y7XOGtF7QIGw1VytfxLiaZ1gkSP0o29h9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795021710; x=1795108110; bh=jizhAE/JgVEK0gyYJPzlAuTCudiUL8Eq0sx
	9Fn9VHtk=; b=ZvdUj+ZILUPJ8GNyFYHxLq9hEOz6ajUEaM24tKCXYhNfVT09Prg
	PvnoOT4GOLjFKAO2q4mUhcn+h33NAfqwy77CV05AA7To1lVAyTbfNrRrS6+x6CMk
	lOxYIHYsGKHrcxGYODB80IdpIj9FjLsIy9y81u319mV102sTJicfTWV3I2ZzZv9X
	FRYW2th8VZ3iXsG+lCIa0j3Vg0toTS5n1kGGtT78cagdWGIWVp/mUwOhqaIWZ98G
	SuHVgq2fsoC6uDn3ZCnA/usVP/GdiI3V7QTBVimpBN76zopAeq3kqDJ7KopkaZWI
	8QqpoOoUmjsYnjjstU/WgFdjl8k8p7fm8+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795021710; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BewuXbhx+9WdcpK81ckb387QUGZO31m73/9EvlwUZWTQ/qx
	usQWDOR0WpxomaXD5Fa04/PBqAPV2E0i8z9Xr4JT9myHHJ/JVRqUJm3sMlkQWWjW
	I9XZf80LLrq0w6ar4goRxqZTv2LCS2CH+THY4RkhLTDkHgAzHiHaJLnMi5UZ2xtk
	WRyEKKBQEgHahzFiB+PZctzizEX6KcVCfW/v9KZg2netL9CMqejOvzZOUXL3Y7A3
	hI8PTa+6lNqqlnE2eegOq8Qb8fAUbcX0kVGTkZ0XypOYdg4KvB+rHm31jS8ZeJXv
	Qv40vnE9srwGDKMVFcXw8hY87RhX2wGErFDkYOQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QjAKVigJzlw157NDTtqklQZDXSJmDdn+CDRAtu9hY1w=:c4isa2KBRUe/CwZ03+kPSQKqh2nbp62QHdNbhC+F5D0=;
X-ME-Sender: <xms:jtv9aui4o__k3IFb_qPm8jYi9C0siCXQV_DPyMELcz7ypTmqbQysTg>
    <xme:jtv9amciiEjxU6yYixFsO-j8Atx2uWWRg3QvaedmPBRJhw8YdjSzgVy7v6l_hiALO
    7dfYTxGYwaO7F07Xq2JdMDVa6XYt3jjVHqWUPHrflhnjAuZQP5FDN4>
X-ME-Received: <xmr:jtv9ajc4UW7hNbvO35Gpqsmv52_WDrz3H52R2VYJEjoQ9mnSCZB2urSfNT9adtC2woT6KAdNvWpS0n4f7iF-WItrEfRbZJihFb9i>
X-ME-Proxy-Cause: dmFkZTFI2n60dE99qF7rXExEZekMuAp0v5L8LWgNma2QBZKZetbxvj6TRjpikJukL+v0Nk
    w0TDYe1GWOnhFsdR5HFv7hkMxot0nrvt0bkO8ZRvLj7uvU4TY4KB5s3E3WduB4W66+HrTi
    wpDFHywGs5elgla1EIDun+BgZFhW478z611HwMoswJ0X6dlprBZxyRozf3xUNwc97pIx4g
    7ZBKJJhzaQTcXs615ipQJp437sqsq4LjslgVIuPRaDjN5s+65scXLK7WUKNxjjs7oAVu3G
    9yrtYB6JGdYFsSkGgBFFIEPVpE+O3HJMnf87vHSsJN/4Q+345UGaN4lkUr/UpqmKw6zoSc
    N/vA0v5xjSqSCU3OoVvTkMAQHwLglqrcK0F/xR8dUytBfQruPLNEwtGugnLQz8vVyA/+rH
    Sh6L7CrHmgUAWQz9FGzDr4Tgsi4jJryPnaOeIqPbQIAZ9sEv0m13tfVrpkmbf9OGKQBWhX
    Cu3ECGigD3WzG0V/kIz6pMrHcILYiAwPJvQ//gCNK6KGFEylKBJHKJzOMKWF65doiqeI0p
    +LkuI6amlZHu2WEVFd0qkoYPsxq6ZFMZItxz5qBMFJr9kR3UoJfb+1gGuQSa3ZrNXBnKx9
    q8IUCJFjqGtmXi679pGjbRWjznlbxYodbjPpuwRInVMK8foCo4cKwLQAV5Mw
X-ME-Proxy: <xmx:jtv9ag_dlF6xooIS2_H3HhJYX_ZlqScw95hdYGkIj_uxhxR3KQuqfg>
    <xmx:jtv9avkUMzqCTZ9xlzbKbn5oU9H2S8CKBKUNWJGVtIguI-OHmVbJGQ>
    <xmx:jtv9ai8ltfoJoVqeVtE31lt7B3kEawykA3jGE7BBgfrspetwxmy-cQ>
    <xmx:jtv9atkYsPXBA3W0saHyRQ5MnZIjjzD7O9pNoC5ftCMpcJdGsOzjEg>
    <xmx:jtv9alDRQdFQyy6W1COo4eGzGuYryCtzzlktik2PYo6UUnO3KCnTeoaz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 12:08:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jakub Kulik <jakub.kulik@oracle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t1017: add missing quotes
In-Reply-To: <20261118155935.60345-1-jakub.kulik@oracle.com> (Jakub Kulik's
	message of "Wed, 18 Nov 2026 16:59:35 +0100")
References: <xmqqik21hiqi.fsf@gitster.g>
	<20261118155935.60345-1-jakub.kulik@oracle.com>
Date: Wed, 18 Nov 2026 09:08:28 -0800
Message-ID: <xmqqo6bm6p9v.fsf@gitster.g>
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

Jakub Kulik <jakub.kulik@oracle.com> writes:

> Signed-off-by: Jakub Kulik <jakub.kulik@oracle.com>
> ---
>> Strictly speaking, POSIX compliant shells do not require such
>> quoting for pathnames that are used as redirection target.
>
> Indeed; when I run it with `bash --posix`, the test passes.
>
> Here is the patch with space between > and the filename removed.

Thanks.

I would fabricate a log message to say something about our
CodingGuidelines ask you to quote variable references used for
redirection targets or sources while queuing.

>
>  t/t1017-cat-file-remote-object-info.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
> index e2919aa061..8a04cfdae8 100755
> --- a/t/t1017-cat-file-remote-object-info.sh
> +++ b/t/t1017-cat-file-remote-object-info.sh
> @@ -69,7 +69,7 @@ daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
>  
>  test_expect_success 'create repo to be served by git-daemon' '
>  	git init "$daemon_parent" &&
> -	echo_without_newline "$hello_content" > $daemon_parent/hello &&
> +	echo_without_newline "$hello_content" >"$daemon_parent/hello" &&
>  	git -C "$daemon_parent" update-index --add hello &&
>  	git -C "$daemon_parent" config transfer.advertiseobjectinfo true &&
>  	git clone "$GIT_DAEMON_URL/parent" -n "$daemon_parent/daemon_client_empty"
> @@ -519,7 +519,7 @@ test_expect_success 'create repo to be served by http:// transport' '
>  	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
>  	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receivepack true &&
>  	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo true &&
> -	echo_without_newline "$hello_content" > $HTTPD_DOCUMENT_ROOT_PATH/http_parent/hello &&
> +	echo_without_newline "$hello_content" >"$HTTPD_DOCUMENT_ROOT_PATH/http_parent/hello" &&
>  	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" update-index --add hello &&
>  	git clone "$HTTPD_URL/smart/http_parent" -n "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty"
>  '
