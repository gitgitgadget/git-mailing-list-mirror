Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067432;
	b=t//TmXbyVkC+m4Xiibb0BFR9GJ0h1U0BqVGzhuMXpBZLYrvnsTYQfpESnVsf8MZ/psK1
	 Cc9KWzH39bfq9I9DyY3rQrRysQDQ8KZuX8qP4fM1VxQSWtWvNJj4/Pjbxs6YAN2odiedU
	 4s/HFYczrRMYPwna16pVjGP8RgAfX0hSFZ2WDvBDUKd7pTO54kRA+6Npig30vv+pvVBAE
	 7TwrnQcSu12NyCzUebrRqh/e5I394dYGnUwFnycYskDEnbGcfwbGD6Qak+Z2Lhg166vyN
	 C3Ifdsj05Puz4KshxWCpz+nVbJ9wBKSHYa1jThpvRlaD3RcOfC1vkoOPUYPhNXBqJog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rhQWeIEP+TC2rsoFHjG6i/NESEouLzUOjr/Qp1CIBwA=;
	b=UwX99RY2wYiMbpKQR6yXRiGI0GRQlv+Bk6I7Tlesbsv+rPGsa8VHZ8kRNbGIKR8usfWK
	 FXZy/W1kZ1D6osQSrjOWzn9IUW8cG+skSzbUqrX2HghKsH1AqNPq+9K80qpfDsiJS7+iJ
	 FyhiKzbuz/YcigmnhkcikOOrMzeFeyxzV9/0gJCOgWRtqC+LGmWxfy9iduxJktzKUi6Wy
	 EW20+7L2RZ/F2xEzq9EUegVrnRwG6hzIjrB5FRhHf/gIpwJ98GuThV6Zl48YRXYbL1c2j
	 iUiMJxAniQ/Gq6zpoW/++3q9DrKtow5sLTpTRimOVoqU6qgICbmFpOnxQGf8xEO3AbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fCnYlXsW;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF01606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 05:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFF01606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fCnYlXsW
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490d59c3edaso368816f8f.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067430; x=1795672230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rhQWeIEP+TC2rsoFHjG6i/NESEouLzUOjr/Qp1CIBwA=;
        b=fCnYlXsWbdm82qRiVqQbwL+8+HFBi0at2U+UMxHHlFU9PlaFbOnFha+y7RGswjZUrO
         gMjHKrfS8g1SEb5Pg2kZa7oF0rYeMWEHTTpJ2CvoMOxJ+6822cRwrT6BRT2rtc1dRGEB
         si8i9atxHEu1sr0mlbJWH23mPFusDNb4F6ZAEi3+MQtRQYmEtIGXL5DgJdeRhDkMmrB1
         R53XhSMgJM850TkwZaot2Co1OKyJ3ehNkDUUVTvd7u0MoF+qEY+l2VIWX8NEWgBJJebi
         LV0ofCMKID8c4eG58PuIpBb3UDcMRV7uKjDWRGbtpL/Ab0AHeOPgnv2i1SIV1iQoEnMQ
         yi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067430; x=1795672230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rhQWeIEP+TC2rsoFHjG6i/NESEouLzUOjr/Qp1CIBwA=;
        b=JqZOxknJV1NUOadiV23HU6JS+8ulcnZwWo6NQBT1LXUYpo4U+9P8H98WFVKrgadnU7
         EPtdsbqYRcPD/pbI6aHZ4wfjoGGJeYG4Bl4Ioy/OVr5ooyJHmsdYhY3SSrSdovk9WZRx
         xO2XhvVkIQcuZRz/MMHx+GdKnKtLfJvsChjRZugHLZ0zFWZ/2bByP83MT8nQrMd/ref6
         B/ve561kTvxrcP2L1zJtdsjNE9J0VjAOGknzU/qdbnMZEGtfHW5CMhCAXv6UJBRodVu+
         TInexvtjIJBbK/N/8Sx43FVC/dC4H49PyBfr9bdF9K5VNLHkwyrB1CSq2CTZKLQ9CIYl
         Ba+g==
X-Gm-Message-State: APuU4Z96iFO6PQsECO1kOWpK3+VfLEcbPtAGoURI+opw7fAILKvi80LU
	B5WoN3xRz0tLnBT8t5Hb/meu9K1MYX/MVQ8jmnj5pGhBS5h2l5FQ5H4vBPlmEw==
X-Gm-Gg: AZFdTZeYhOZdk542z/NsemflhZ/PftLW85YVMkOJEyjof3j6+A6SJcqYY+iZHgwp5Ka
	8cU/6z7v2zlR+Rty+gTFUM18Bt5YbBrpYbPydvA0lnGIr7lI0Z/yroQwfwlCxuSvmYNncogWubB
	MMht0X+qTrOHqGXOsLRoXs/TGO66Pgymg+8MzCnzffg9CNcBa0Gf76xfEZ5uDo+Il0aWSik5aU4
	hK03q6tr5AH/hWkbGsjJcAoTrw6xy+FPv5a4fmXkIa1q5j9E/qRWhvHIiXrby8hu2+scuIqusQG
	Y2d1+bhrcZtgZnl5uoomjXZMi5MKFrHZMWDLrC/kz2p0uVdB/5FSo2qyW2YJ4qM/2sloJacX6bS
	fOfyXJk4uJblTk3HCO2zVGE3KpdH4Pob4sEfCH7ZDnOBG8+GYx5f+C5XD5D1hMf18B99nwX97tu
	GssDAY6AT1zfhUQYyyN802rM5BhGe/7p59TpZcBSsecX3KFczadpcNUSwLDiFiMNaHxUZQ2oFpN
	jxV3PEMU46YHVq0YkIkP+V+/aOPZwKo+EZeAMQjKh1yyehzskeUCsJ2BR4EdxLoQKqhC1R2X21a
	eYRZDaToDzGVju6uqMi1BGTq7xF8Mh15iosUka3D52aBV7pYL+jW68NvMPFhdcQ=
X-Received: by 2002:a05:6000:250e:b0:48e:d7c:4bc3 with SMTP id ffacd0b85a97d-4aa5805e1e3mr135563f8f.21.1795067430071;
        Wed, 18 Nov 2026 21:50:30 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65100c6bfsm8242025f8f.2.2026.11.18.21.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 21:50:28 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH v2] status: reword message for a missing upstream branch
Date: Thu, 19 Nov 2026 06:50:26 +0100
Message-ID: <20261119055026.759205-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqq5wxu87es.fsf@gitster.g>
References: <20261019175722.5223-1-gitter.spiros@gmail.com> <20261021072137.258934-1-gitter.spiros@gmail.com> <xmqq5wxu87es.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Using --mirror means the local branch we are interested in (e.g.,
> 'master' in your example) would be sent to their 'master'.  Do we
> need to check if their 'master' is what our 'master' is based on,
> though?  Can our 'master' be tracking their 'main', for example?

The first check in push_creates() catches that. push_ref is what
"@{push}" resolves to, and for a mirror remote branch_get_push_1() maps
refs/heads/master to origin/master. That differs from the upstream
origin/main, so we return false before looking at the mirror setting.
With remote.origin.mirror=true and branch.master.merge=refs/heads/main,
"git status" gives only the "--unset-upstream" hint.

> We are content if there exists one or more "push" refspecs for the
> remote, regardless of what the value is, but is that really
> sufficient?  What if our push refspec is deliberately narrow to
> publish only selected branches, such as:
>
>            [remote "origin"]
> 		push = next
> 		push = seen
>
> and the current branch in question is not among them?

The same check again: no push refspec matches 'master', so
branch_get_push_1() fails with "push refspecs for 'origin' do not
include 'master'", push_ref is NULL and we return false. The refspec
and mirror tests only come into play once we know that @{push} is the
upstream; they are there because push.default is not consulted at all
when either is set.

> You mentioned "nothing" in the log message; shouldn't that also be
> special cased?

With push.default=nothing @{push} does not resolve either, so it ends
up in the same place; 'status (missing upstream, push.default=nothing)'
in t6040 covers it. "matching" is the only mode in which @{push}
resolves to the upstream although "git push" would not create it, hence
the special case.

None of this is said in the comment above push_creates(), which is why
it raises these questions. In v3 I will spell it out there and add
tests for the mirror and the narrow refspec cases.

> But we call push_creates() to compute suggest_push whether we have
> advice enabled or declined.  I wonder if it makes the logic flow
> cleaner to give a few more arguments to format_missing_upstream()
> and move push_creates() call there, not here?

Yes, that reads better. I will do it in v3.

Thanks for the review.
