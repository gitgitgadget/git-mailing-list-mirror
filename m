Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793359768;
	b=mx6agL3nObRSK7806XyYDj5BWGrj2EPqYVF5su4EephfiLzXf/xyTxjr2X5IfoDaY0SR
	 M8P2Hk9WSJKnK7TCN0EmEnSsUXq96Sqdpl7BIha5iFs5O7if73kZVeTqkxVOUbBcbhSEG
	 31shLBO2hdxLpv+eqCWqsXNrOHlgU7TZl5Ls4L3NWZkmSLPvMEx7m3WJpIjo4bBCnNoom
	 nmmmQdC3nRpPDQxsD9d4gF0hjIeSzZc/UdaJH/wul8SuBJuXit2uWKlKzKANTJwQzOQA7
	 Pc7DPdTWalnw7i7wSLmLmnFy1e7oCCDlMQuAD4u3cU1PexCVqDRrRUp68vZiHZoptbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=dSCSWRXkrhgjdUGqYXEEVh8DVAlKG1eLuXOgLELyYXE=;
	b=bNJ/cYakQzBhyiOVT8AfsEi/95XyY7XX4g2YLMDWTMQ2ZgDrg++xsipTMcXdqI7PVwV8
	 N0CcMrkQEPcUwBKQo7v2yM/9Ss1rLY6zYItvtI6ICy4fWI4dq4+fIHfPxV+BW3uJ+3gw1
	 G0eWN5lJrHU1JlhrTo1YCQu8mwbuxdYRi0kklNbILXPmeezKEfxnu4+9oarbzEdxeiHKH
	 /DApHcbjZPNSyBOYEm711poTHIPhvZrgxFDmZQJAwMmH/IzZhdiJv1OfvopVIignw4OnI
	 Csrld1bNcrX+uIURv21n074onI5r7UCBUmgyJZk0VQcyJ9+AN01AgD5jJb/RS/cRV2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=DseK21L5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74331606A325
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74331606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=DseK21L5
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso2846833a12.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 04:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793359766; cv=none;
        d=google.com; s=arc-20260327;
        b=YBXBodv920zvVmpU1w1MYp56r6Gmh4/YtAoh58dNTTro349tzWLSkrp8XkYZWDYsjK
         dkKvE94uXHoZojOpIrLUMvVAtjr28oFu1ZGJpcCJJCVO4mQQLnMGYkGQMIk+wzc4x/yj
         Nj1xB+ynKumi6QGQ+ZwfXPZIgjTKuvQE77RI56mn/KbCK1LTURz4kV7LNGoPnt9U6cF0
         +ppi/lfyh4SUVR7SzKFVKIISX98oP7FOJQVliGdYsFQDqG+VyLtC88ajB3Pm1qGbbVxx
         7aJjBl388e3YGwOEdAmg01X7orfuaRId3s2+j2RV83SmjUbPBsC7bEYufSCJezmmYW6G
         MOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dSCSWRXkrhgjdUGqYXEEVh8DVAlKG1eLuXOgLELyYXE=;
        fh=9tCTmLeCXfmq5OzEbw9Unxz1Z59H+4UXYkli6m/qvNY=;
        b=lkb4+pYu8E7HDBjnW57baLmIRlzdmwbVmrwiP/aFDcD+Ik7uPOMCB9p6VksWrGwT0b
         jGqw1YGovpD46Tf0VMY52i6sXcvvWAT2v5GRGtt9SKYqmFGLL1i2y2p5YH6QDPs33dRQ
         8RyehkaeL+8mZKUYhMGEmi0auano46Z9BLoyQeX60Tt+KIUj3z2KRHyHoQwnH1nBRxZy
         +tjGGVOYykdch05ZFyagDGx306JPefTH1znsUccVvoBUAwTrNWtGgZokLXeP+CMcluOG
         j3x3Cn8W9QkVHWglUlM2h96SQPEbGAZnqOSgVNm62MNTT9lfnzG7zmYYbyDGJbP2+51v
         UYEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793359766; x=1793964566; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSCSWRXkrhgjdUGqYXEEVh8DVAlKG1eLuXOgLELyYXE=;
        b=DseK21L5+l6TdOREiA95+hZ9RY5TOZ7+BINLKIGV7M2nF6YinjIIjl82506m0wWP2f
         bH41A8yrwbTkEB2NSwr4jeKBDbcyIkh8q7hzRI3Nkz1A0f5+8h+yd5+JUjsfOlVXelxp
         MfY7kM8Dk3K0imPXftg7ZnTFi/ahI9+juF3lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359766; x=1793964566;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dSCSWRXkrhgjdUGqYXEEVh8DVAlKG1eLuXOgLELyYXE=;
        b=DV+1zQ02+1C6OrdRJEiJH9jcYkDoU179jY0TQITRmZzppbo4tKKrAmM05shdwGpMIP
         5PMp4OTPhAq4E9QAE/K7cHcO4zEveH9j+SF9HXYSr7w/IL/fU2aBRf8Rn9ImPn/lI5nD
         lKcTtArk5oERCr35euLEofLI0vf6mvwVjvTG06qV75aWSz9o5hVVyIwKBjPaUHE2pHwr
         24fzXmSh9s99TJFc1XgLD/yDyufeptoltMpvR0Hrc22xURrkjv8pzExTyIekyYEFQB1k
         rGjrvT9V1cqrucXNfnMlxeUP15vsmtX6UEUppjZdGNnmrUj39tkv42XLcQY9I+TRC5bj
         16pw==
X-Forwarded-Encrypted: i=1; AKwUvBz5QWyP61nDVXGXkwhgmvnmtAC6H8QTRmaA7lNVP/8bJEPFhc3Ee0UPDeJEKmMmaomHMYc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdr69ZNHLF/Gkqa0SoEq8qgwoqglMY1+bs2rJb6Ht9FMh+SK0k
	S6+r/lOa7zvzVpvsc424CQ1qeVU5al6kvDfSWsNsjmhizOR5/hLQPRFwyKCb+2sJ1RHaZn9Zx4F
	xegoPuB2xDXQb86udgsIPHAr+PAAbSSg2UUrax4qshcKWNbasqqpjTZkISA==
X-Gm-Gg: AYBFou3vp2jy/Vt/qT1zHK5ZGbzjytTFP1+T2hHkROyjeWAz/82sdmRiED/pz6GHJ3h
	KhIbr/n/AKFmfkau7crRTHkaemGoD9ZyMrRsz1LWVCgiUYhMhfVE3z5c2TYZVbZLvgssEsTJIcL
	2eKiFt+MWcfp4a1zDRqo/FW1qcRBxEebjgyfTqDixt/5WPQoGPBcqpdjum4nVaOrgw0HIkOZUmA
	xhKkMQgn6iyKdCRdToqAwn9ap9Hd9JRvv4xm9lrUbNDCRCDDzRRzUT4WfBo1ipMUhealyM6p65X
	7GW8HambANZdaY8PeKkQg0P2H1K2y+P/o4VY0H8wPU8/OhBYiKS3lQMp7WFO0k9FNmJvR0utquA
	jAFTErl/fs9kFiV2lSePkyEs3ztAwJU0fcV9zpA==
X-Received: by 2002:a17:907:869f:b0:c41:825d:ed8c with SMTP id
 a640c23a62f3a-c49d147e127mr475594766b.26.1793359765660; Fri, 30 Oct 2026
 04:29:25 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com> <auNvMUNxmeJe31Bq@denethor>
In-Reply-To: <auNvMUNxmeJe31Bq@denethor>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 30 Oct 2026 12:29:12 +0100
X-Gm-Features: AclHuK9xf8aVwVCFGZyAy6daclTF1psOCr1PLTJRomJdKSZsJymaiRjwTGOWEdg
Message-ID: <CAL71e4P9LauUqjKTx1VeqehGVrbOpb3PXC8z1iQ6Bh7CFihr8w@mail.gmail.com>
Subject: Re: [PATCH] odb: do not list our own refs as alternate refs in the quarantine
To: Justin Tobler <jltobler@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Oct 2026 at 17:57, Justin Tobler <jltobler@gmail.com> wrote:
>
> This indeed sounds like a bit of a hack. To me the underlying issue here
> is that downstream git processes don't really have any concept of an ODB
> transaction. We rely on the git alternates mechanism and overriding the
> primary object directory to get the unaware child processes to behave
> how we want. This typically means setting the quarantine directory as
> the main object directory and the "real" object directory as an
> alternate via environment variables. That way any writes that are
> performed by a child process are written to the quarantine.
>
> For the connectivity check though, we don't really expect
> git-rev-list(1) to write any objects. Consequently, I don't think we
> neccessary need to set the quarantine directory as the primary object
> directory here. That would avoid git-rev-list(1) processing the "real"
> object directory references a second time.

The connectivity check explicitly disables lazy fetching so it
should be safe in practice, but it's hard to reason about
potential regressions and having a more strict flow for this
would be nice perhaps.

> >     So the question is really where this should be fixed: is there a better
> >     way for processes running inside the quarantine to tell the repository's
> >     own object directory apart from real alternates?
>
> Building off of my previous thoughts, maybe it would make sense to make
> the connectivity check a more explicit part of the ODB transaction
> interface? Maybe for the "files" backend we could introduce a
> `odb_transaction_files_check_connected()` callback that configures
> git-rev-list(1) with the appropriate environment to validate the
> quarantined objects and not cause this bug? Happy to explore this path
> further if it seems reasonable.
>
> -Justin

I am somewhat of a novice here, but I had a similar thought,
that this should ideally be fixed by tweaking the API somehow,
although I do not know exactly.  I am not sure if we should
introduce odb_transaction_files_check_connected() or resolve
the alternate-refs into fixed directories earlier in the chain,
or enforce better read-only mode (and add quarantine as a pure
alternate for the connectivity check).

So, I am not sure what the long term fix is, but I think your
idea makes sense for that.  For the short term, I think
something closer to what Junio suggested in the other reply
is a reasonable way forward.

Thanks,
Kristofer
