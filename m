Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B3317145
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471959; cv=none; b=NjDlenBp9SD76mj1QuXcrkPxCrOn9WfV7tCPquJbEkqfey5Yn+JLSAu4/sxZ+p2w5746chCUjGExYmmAwKC8aNBNLDcK43XKwxgGQAtqqhwZYdgpUrRM2kqVzo+2sZuAvOnA5fwHpkyeSqtTip8uV6swObXfP6XJNfKFwgQYfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471959; c=relaxed/simple;
	bh=HfT/S0wjln0NA0rDBo2W2jwRrRxFXfLKmF7Tdz6O7JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRy41Tk2948oJiIteF+cHaD8psBETVZ3eUU5N3CjTvUOuIatCbai/+oX+tsd9YIKtB+Z5rWWA6G6Fcfr3VD8KeJPzfIeQW4/GXpNrQjduRRyJlNPPdMmQJShTe+o4bj2UJ2xBwLu83PReWis9DsK3qIigtj1cY4YAD/6L+EXcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=cRWHCYGo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="cRWHCYGo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so2988555e9.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788471955; x=1789076755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2gyKoRUBqvGScPNyQl7ZTVDJNd1Jd0wDjPZfahXCOAo=;
        b=cRWHCYGoXE67FwZ+JmxNS3o+9hp2jLfw0plBOR4QWo+9z9FYUZgnVpNynfJ7mGZssF
         yyRUkSYqDPguSHMzvm1FITLTgGWKj6EvWfiHPewTzNHHdp6CCcVxdoMz+f4VlgQ5kW6K
         utQXYFrA+GPVi3Z9H7IvBZgqr+HWjkXJbnblxCkahndtZDbFxssvmcRhopRR8N/wgkit
         cfS3LDZTf4jllMMRwIUYV2gr0akGSwimGS0Q7UjlvD4rfB4BKEELmRFuwHmGy2Nrw1cZ
         3k5LsdT6sdj48Im7/d3io34HBEVsG1OAiUHLnzzH2SDmq0Xsnfn2pjYMI+NvKJaGqA9Z
         hhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788471955; x=1789076755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2gyKoRUBqvGScPNyQl7ZTVDJNd1Jd0wDjPZfahXCOAo=;
        b=P2VSrQSpS6aNw5D1VF9+ld3ohIiJlGZfWZzqsrmdH1HyFqyvd2wqI2OLzWp+USZag9
         Lpb0ZS1Zip7sEboQXKWp4/d3LX0jZlhn8Wr2GVf3loUD8EjgXhKadCo+0x1UDp/2/Ic/
         Whgpf6BEikj9IRkfb7YoINLeC2UnqFnNL61q15SnqlEnIwyqTOMXTErdSTp+JBsxZ2kZ
         cZYQVniWIwn2huzr3a2n1p2CxA+m6MpQkepXhF9jeSfr6Rc5VsaQmowOx5CF/+6hHT4q
         RTxc8tesQDTXKc8l9Qo4y2kzw3SOxxgEYfHQSYzX1Dk1//yty3qzjvq6HrcEkd6ld47x
         TEug==
X-Gm-Message-State: AFuF++lRsmNFJpWq1gF59o+nY7QR+sFowARq+lns/cB0ixQPEYOVnzaB
	X7DXZj6S7Y7y5J07gmeIOFIy6t6pWNwcD26d+lpvXljZODIDKqJ5p7xbmVwAVfAI5ouw6iVRSEl
	dzndcRXVZKw==
X-Gm-Gg: AYBFou19G9QAUaoPAWZF5LR6Pufgh3OvmEfL7ghZbTjDVm6LaOSiau45++kkwekf+3E
	c8mRwb0wbG2RBEKZzBh5YOaTq4vSNFhyr4viUOEIz/mitNUgUWaunfoC0cnJKuChC3W/Qnd/QBx
	rGEjWeh0/OrdbxfSwIkC7q3i1ov48DRJIIOS3cZMNp3b93k6JVYXZI6BD6rG815VNiK1vxCtHur
	fFE8cA/1J+3H4HlGjmRqcZtsAS8R5HPTtppCi5XJjTC0Wh/rVqvBYLGHgmAbGS807oRh7ieqMm/
	YgqYAZn1Hupoji0sF40RoA1a+Sk+iDeOHROc5s0TqUl0sL3Zcn5JhULEfmIbEWpsNFdWLefqxRj
	FSk3tMJqH3ddMJPgYkzb+Z1X5ezBPuqOkNU0UTvpREyL5A+tIXZtETUtZPMmV2PvCIoIHMzRp+E
	q4SVjTAz81OSDCsHD3zYycfZxvgDSTErgDJg9SEKjsNNNuRTqXobN35EbJgxQduDr45/XY
X-Received: by 2002:a05:600c:3e0a:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49cf8267a36mr17661955e9.12.1788471955414;
        Thu, 03 Sep 2026 14:45:55 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm98527905e9.15.2026.09.03.14.45.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 14:45:55 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a conflicting --no-commit
Date: Fri,  4 Sep 2026 00:45:53 +0300
Message-ID: <20260903214553.53942-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqq7bl29g2p.fsf@gitster.g>
References: <20260903125524.67889-1-f@lex.la> <xmqq7bl29g2p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:
> It is not apparent what problem, if any, the description
> above claims the commit addresses.  Nor is it clear why
> checking these combinations is relevant.
> [...]
> Can you help me understand the above two paragraphs a bit better?

The test pins the one combination t3507 did not cover. The file already
checks CHERRY_PICK_HEAD after a conflicting pick, after a clean pick, and
after a clean pick under --no-commit, but not after a conflicting pick
under --no-commit. That is the case a user hits by accident: the pick
stops on conflicts, they resolve and run "git commit", and the original
author is not restored. --no-commit never wrote the ref, d7e5c0cbfb skips
it on purpose. Your reading is right and Gemini's is backwards: under
--no-commit we do not want CHERRY_PICK_HEAD, and the test asserts it is
absent. Without it, teaching git to write the ref there would leave the
whole file green.

The message was unclear, sorry. "it" was that missing case and
"siblings" the three existing checks. v2 with a reworded message goes
out once 24 hours have passed since v1.
