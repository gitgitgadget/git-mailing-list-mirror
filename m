Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785068;
	b=sTCgumIop2f7TlkyIphBka6ho3TWnWdGgDdPj+XJgzUo7k2sBDgXNYmsQFYG3mM9EHuI
	 tXha0pIpUIiut0kNdg+lwBaCA26W8VLC4bbcvok9I0ckz4UexaHUE8VyO4yGplQKXkw9Y
	 ecVPm5EnaiOU9tXj7KaO3S97jpW6YjL4PNCCmqKIztNb+RwKf7P8c+XtEOzly8eDWYuNs
	 liTcYK7aJK2JGARz7cBOMQ17IyiD/d0IckbuC3BhNcK85YQYVRk6tzd8w1JVUIQQ8jF/A
	 Uwp599r7VBPpWSyPda3t1fZ5Vup0uTE1vj+VSZApqj7eP8POVEFV9+IcsveyhXfstAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1gZqlbkkE8eNIWCKmllkVgxHrGCvooNy7KYVdJo7UQc=;
	b=Q2tDb9LbqHFNAWP0++JBASOsDjGK7/NjDHfYLopHJSotyppolMfQtGmThd5PThrROX1W
	 fjIVZ7PyIWAkhRHdLpswUdb+ckZlEpg+R7mIQzTVgxT9h/Wjv/H5hFkZbEHMnE3KwVYz1
	 jbbA6coK3WU+gdkdFvCYRQ1mxTDs6r4PfNeLJBYHzqs32+n2qTtNUVc05xIO8CfTkziDM
	 I6G35M0Q74zdkTk4Aj39D5mVTmqQNekq07peQnTs1LE8/t+qHdAMfez7SkXP9ejx8clZw
	 sfenMY3Vbexcw6aR3eT+2yWkwcp7gpvFVsQlk/OlYwWwm+CAPhb53QoUx8HhJO4khuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PtOlAUKT;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265D606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 19:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7265D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PtOlAUKT
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-84621d8c7aaso565043a34.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785067; x=1793389867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1gZqlbkkE8eNIWCKmllkVgxHrGCvooNy7KYVdJo7UQc=;
        b=PtOlAUKTw9uj+xBdE3pdTcxHGRJVeIgDQ9ZGmFqQpi0JQriX+K393+gSwidyKnxGaA
         t1KlGV3fMzN3n3udtw93Wq7rUfvGinKFt5pCa08R7F1RZtqXlRbm/u/x22ZOrW8vr+fX
         4LHvbxjTKW9cKeOCVUN/51dW4lbKeZUT/H2K72uRh68XdtmrY2z1g25CaOzRNg5xkOQE
         Bc07kz1bq7G/w7QZ+cDVAovJtD9dZuMX36CqaNT6ircRftS9uy35I0H8JlUXN0ZsFNZP
         TzTa0xtQd0rvsZPGM55db6Yh8LjM/6aHSJqIaiURKJDktBuvR9KgDcODotpWMidXqXFJ
         zHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785067; x=1793389867;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1gZqlbkkE8eNIWCKmllkVgxHrGCvooNy7KYVdJo7UQc=;
        b=vBr/13F1TkuzFD6TGdiTxToXljLWLF2EqgPMXPUM/xK+nEeedblIuTOMxJVsBE9OZW
         QM2VG3vJErg5PX55u++Xi1pWVVPuuYKxGqukS6Wa9p771lTjltUQD7uzg+jnYFxerUN+
         z3aY+1+7VODfHfOrJihcGvjGt+AEMtZUSQ15EvfNEFhUi9p5lhFA6skljoFujhVd/zGj
         NzRzsxSmXOEJNMRDqXo4TeINFwKcBCO/kf7WlqkH8RpZ2w7xhJ9UYlS2WRBbv+T8FPAt
         C12HbHqXIiNhZ67nXpHiNUbESNq7dY9ZrIRkaD8XPUG8at1nC1xAoQ2XSRiRpFkEFwCE
         9nWw==
X-Forwarded-Encrypted: i=1; AKwUvBw9zeZyP97HgNL8cEC3b9Ols2lm5NGeQlpYB2VN/iFhyxf07J/5juZly9iPW9sxzcaaJ5k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOzI1cKJ5gEPNwij5ZSjzNgrTWe6JPM8TKCrZJNo7LCLmUhcRo
	/aGWy5syQQlNkG+4PqD+182qj6glG/cYpPdTLnU6GQB30/s8RZA4wg62
X-Gm-Gg: AYBFou2vvB2zbsOlRneF/e+gDZaCdGOwqnnBHP+F9y7/EwtagFDKGaXXOBcRAUPNNEY
	/6YjEeV0Qs1nZPO64KUGivXHab3wwwW6FHS5mLADiP3fATP1LHZDIqXZ3LvdR/NyX20GxlTQ+65
	soOdaNwS+alfuNK0GZHZFfprZk7eQQObOGIKIheFoMhq1ns1AjFKLemlD5O4a+gEeDwyrRtN3MK
	LR/AQ9mhhzhxuOUKDGjlnrYJZT286RITp9fQTm+mp0bFUUEG3qFLJcE2iJDYS9h7l8V1ovH+YE1
	lfQlMWtGszmJw+AjAhyH+tIxQ5CSgvv4jZeus6Q32D2KdZJ/sd2GsUGyQvHynZYKPbSeGQF8Yte
	uSz1j5PejBwOR3816ECiu7vavGeA/UvFPJfjOu8PCLECKMSy89G8qxkVeoEvW+Xo0JS+YcjS/iF
	11K7bXlOlhLKoXY6r45en1xdBBAavO6YV4eUkqMmHrT6zKaJqXvgRU0wnq+CfFzXEb/A6vKcwfg
	ZNeTG+ziQbflGaTdF3DohrOcrDrjKoPmuZrbdO3TtQLzYVAy4QUoKBl2E0/zXbwqqMPCxfrGE3H
	yF0CWFASx/7kGF/n6BmOzJaUcQLIcKmyM0XxHC5xMK6EQFs=
X-Received: by 2002:a05:6808:1b0d:b0:54e:31cd:dcd2 with SMTP id 5614622812f47-55c00353913mr161192b6e.44.1792785067172;
        Fri, 23 Oct 2026 12:51:07 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ (162-199-88-188.lightspeed.sntcca.sbcglobal.net. [162.199.88.188])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9dd3c9b5sm198752eaf.2.2026.10.23.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:51:06 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mihai Cosma <mcosma@gmail.com>,
	git@vger.kernel.org,
	peff@peff.net,
	stolee@gmail.com
Subject: Re: [PATCH 0/2] status: stop holding index.lock while collecting
Date: Fri, 23 Oct 2026 12:50:55 -0700
Message-ID: <20261023195101.1087983-1-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqik2s5kt3.fsf@gitster.g>
References: <20261022184420.3648771-1-mcosma@gmail.com> <xmqqik2s5kt3.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,=0D
=0D
On Fri, 23 Oct 2026 11:33:12 -0700, Junio C Hamano wrote:=0D
> Mihai Cosma <mcosma@gmail.com> writes:=0D
>=0D
> > This overlaps with Jun Wu's "Wait for the index lock instead of=0D
> > failing" series, and the two fit together: his makes writers wait for=0D
> > the lock, this makes status hold it rarely and briefly. They only=0D
> > conflict on the one lock call in cmd_status(), which his series renames=
=0D
> > to repo_try_hold_locked_index(). I'm happy to rebase onto it. On top of=
=0D
> > his v2, the slowest "git add" in the clean case below went from 1020 ms=
=0D
> > (one failure at his 1s timeout) to 160 ms.=0D
>=0D
> Perhaps you two can work together and send a single consolidated series?=
=0D
=0D
I think the two series are relatively independent:=0D
- Mine changed non-status commands.=0D
- Mihai's mainly changed "status".=0D
=0D
Neither series replaces any part of the other.=0D
=0D
There are multiple subtle pre-existing race conditions involved:=0D
- I fixed some read/lock wrong order races.=0D
- Mihai fixed a update_index_if_able() race when skipHash=3Dtrue.=0D
  (This alone could go to maint.)=0D
=0D
My preference is to keep them separate to bound the mental complexity=0D
needed to understand related issues. The actual textual conflict is just=0D
one function name.=0D
=0D
-Jun=0D
