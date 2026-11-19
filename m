Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101295;
	b=yTY0d6QhOOwVmnR8kP2Vzd8oJB4chMINGrNHwnTR+CR94hwvz8XdrHLMO1/+HJg4RwEG
	 gycaBS+eUsguENjY+q+IH6CiXTAdXNKZcp6nbFp54GFcpyZYKeffChBfRjLCy7+GcC76+
	 FtLz2GzmTygqXy+Dl9d7u+mEUr5znnK/tJRLsKxhyAs+AkbfWlKSTvF+R9VDjh5NrQmGS
	 GrQE0ukZNMacmMC8oIKujGEOK+OaI1oFqg0eE59brmCAlxEcJeSqS8/IN0U6DTN0pjR3J
	 jt4XdOn5/NWk4YdOyI1QRG0Q7RX4tTQ6FtVcj22Hi7M1gV83gzQxIh0iOKbwRMuorMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e8/YTB0X9DBvQycE1S/uvLlTC0vSWH2aM57/poKOSuU=;
	b=ajyMJlWYJ8ZLfzluSpJ/zwdRY9Zd1WsJhqO9RFxqDks5T2BRPeAFQIe8M8Q3CbFcGdiW
	 aSJwDz5BIjD15sKXAOeUl4y5bEllriHBYkwYfi6qB0MTNNAOUf9CGezVii99/uxvkvMlw
	 GgGaDgJgtEdei0fjZPPHrWLUuywQC84v47do9hbKCRhQAKrKAuoop3aZY0g6rbxTjuW9D
	 CStmY2QlKYn1qzc3adt9vaFCVmNuPagXJ2vAsXJOL9CLxUQPzVXyocpnndB0xOfla/qTG
	 slZV1+MDnAb16zGVnRkEjTARs31mVh/Zwnl0pK9pLxmmnaQMWXNA/Gqf5ge+8GIlHEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=hZWg1Buz;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EA606A330
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC5EA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=hZWg1Buz
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53634b8328eso22988311cf.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1795101294; x=1795706094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8/YTB0X9DBvQycE1S/uvLlTC0vSWH2aM57/poKOSuU=;
        b=hZWg1BuzFF1pFOJ6ZYm0zh3VST8KeGLgBl6tSECzm7YIH37I4Bw1ZOub12ILKVRMro
         ai9Z6tGz02t2lNlB7ARtsEjs1GVKt4dpREY7JP3y7JZvyKAVqr95IcXKfOk0uNxognAx
         79Ye5v6NmVG9O9XObnxuBpppC937ULS/ExQ0WCVbRVIVXQ9qzbBMT9GGlEmVRvaalAcw
         Kt+n0cqL4gQvRfXo28vI3xdaKMO7NtC4gE45N9Gd0DYuiNsVJIU6fNsevBhBcvyNIzRs
         63vBJkgN6O5wA/NJssaG6gG3lP1goEuNswAzSVh7OHvpUUKypcTigX1nGwFM9AJZJBGb
         VcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101294; x=1795706094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e8/YTB0X9DBvQycE1S/uvLlTC0vSWH2aM57/poKOSuU=;
        b=hkqMwcKBR6nwfdlCEXPszeEQ3TmqZFnEp0l4D9nJaMdn/0/05DiKwWKwr8Z4w/J2O3
         N1faVmHWzPkPFbPUyDEyVaXDrpANe2sUEPY7Z4qjQEVn2JCgJG1L7hXSij+CfleNSmuu
         MW+56OunQzckZ0wUapKrp7KbEyABt5FsmSr2gXkVwT37P15P1WsbDDOTCrtCrzdi2EZM
         RO54MK4qIj3JKf6n42C0mkeG7mwqaEw1vUKv36uiVg9+fuq9QeJ+ki0t4p4vhuFM9uvH
         TI5slW4uvSRXUtNDbg8kBtEVbKDydBLNIFMqv6kJHgawrJxtsBjc4Z1KlLyAZa5yZs7S
         Xnuw==
X-Forwarded-Encrypted: i=1; AL+hErGwWzAl61lXMOZ73a+vB16hOrTnpJ88elP034Z2vCvtH0slbeJUF7pjy/zTSBM1gBZ3B84=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1LKIPf2EF3sdG3zu3wBni4zrFWLcAIS71X0yhFgN75lx1PI9B
	6RS/c9AlVTwlcfo9Xgt37ESjAk3Wa9Zp+QEeH5Zot2g3RuXW+C2PE0GhCD/My7bGxTRmstmM/jJ
	JfrvawSkupUSucZHjrBhO/9ao9TeCSRjX4tsr3mlWvsKzQcU0xHfzgYqM+x7LxkasUsRh45t8Be
	amJNaHdxaX2vs39tn/Mf4SLceE0tpoOQA=
X-Gm-Gg: AYBFou0Pf9cnkfdMhrZzlcR6os6Vw0db+jLlprpsqi4dEbpUtHPWDkNlKdLldj6SHfo
	ZWFfhUwCp5qZGO10F58A5CPXuhM7RB3pHZGmnCYWAnXY+W70EF3WdN1/sv2f+ZMCxcK8RrDnnta
	1/B5hIjy7f8dzDMp4m3cizXOjdjB5Grler+oQWlwWKlxXweJBEKVuxa5yKNXGy02mSkJQ+Uu52G
	qh2faN6LxXRbbZbREk+fcdfXWNFCFHjtDn6udj4Rq2olNGC5eq5qUTYXKp56aB8SJ6tchq/V5r6
	OD1Er4lLo/xEtSQi6Iq1krkXhFQ0Qod1t2B5IcdNjFtFWnbhzKBPlgL5hxEoFQOT4myf2FZB5yp
	0wspVN/eHeAocZf2edqdDYA8YcZAt31/Gr7RcVuOFi3MuN1oRajUrtq6IvnQ2oOVwmbsJ1RBXb5
	Q6oDn0d0N/znum+b4cFOFfMh9pwCMbTmGWQeSx0sYVWgUj3//epBn1ele1Iwfcds5khmXBTF5uT
	tZ7bqdQ99ludeaG6Qlj+RKI4xWCNNsaWpSipfjwZ5miqwAexAe72cAe3mVHJGTp1dwHtdi3VJds
	w6Il3Xfd5Jtq65EdYEGfqrjntCSSko9usV158sRl56jx6/L3b2s0rogZSrIjRCBU7tQ1A9ujioI
	boB4u/LNvrppKlW8IF4bMaIt+Vnaf89bFVPjNFKSEQwRbRQPIUXtx3ESeUHKwmCSaSRNWBb/v+f
	s2CMRjvRONvZA+tpxVxme5/3rS9gX9vC2wgLrOPyyxeVsZmjiLTId8MhWvMrYsciLuhYxrzof5Z
	YCjKGtYtx8=
X-Received: by 2002:a05:622a:487:b0:536:64ee:73cc with SMTP id d75a77b69052e-55d76a62980mr3249661cf.39.1795101293575;
        Thu, 19 Nov 2026 07:14:53 -0800 (PST)
Received: from remus ([69.43.65.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66c52318sm25373141cf.29.2026.11.19.07.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:14:52 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: phillip.wood123@gmail.com,
	git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v5 4/5] ref-filter: add %(currentworktree)
Date: Thu, 19 Nov 2026 10:14:48 -0500
Message-ID: <20261119151448.86546-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <641e821d-ec7a-447c-8311-9cd395d9a5c5@gmail.com>
References: <641e821d-ec7a-447c-8311-9cd395d9a5c5@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phillip

On 16/11/2026 16:42, Phillip Wood wrote:
> When I suggested %(currentworktree) I was imagining it would be a
> boolean format like %(HEAD) (i.e. it would print '*' if the ref was
> checked out in the current worktree).

Thank you for the review. Our emails crossed: Junio was against 5/5,
because in a long branch list he wants the "+" next to the branch that
his own worktree is bisecting, and I agreed to stop the series at 3/5
[1]. 4/5 existed only for 5/5, so it is dropped too.

Your idea to extend %(HEAD) to branches that are being rebased or
bisected is interesting. I will keep it, and your two points on the
implementation, in mind if I come back to this later.

[1] https://lore.kernel.org/git/20261116161553.56756-1-me@jaspermayone.com/

Thanks
Jasper
