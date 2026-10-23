Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792769511;
	b=zNeyusvsjoxirRQ/bTgi5WBp7fwnGNLdx7YTHmc/iKBRySJMXVjqyn8UvjWKOcKzZdKd
	 QecMF76ywe0F3DELzOv1WfxcqYz8ss6vYCQ44iBHO5prH0m/5sNHzQsiLv5JncG99UAtA
	 QQqFs8x/3pubJtVZDgXjOgNPahg4eci7wc2kk8Cu3ofSsGsTLJUzN/x1ZVgygSiT70XHo
	 vBouMXvr7sdqyhXOCK/CnQEh9oWYnzONKSuTahtowyuOb89YtABFiJMK6yIT+JgBNrvwj
	 L/H9XNaQBNu/AJPJZd00b4B8a1UL7oW8OCM27bTPHI+yUPSL3VABG2/m9AbKTMe3K8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=kOiQKtdDZhyyBydfIy8mxKbxR4NFcDKSAITd7gOg5WU=;
	b=WC3DMLnllvw0lHkgr5AlVxJ5TzqI8HP+qjxFItvTr0dMljXBWi29AD4/ZEG+aGd9RPLf
	 rE968dHkXCS7YPSCuO5RRuyQCxZx1LQbGrk7zXut7dBduWdOkxFzHNxK36jINMM0q8iDr
	 Wq8C/IfGT/5audr6XIvaWKRY1HzZ6zBCe0eDBZPW7S6216tJm2reuQz4rhUqV2klapScF
	 dkMvfCq/Y8eFzMRfghILMWOWUDT6kkLEsVb4SeRV5IjkHOef1mEJ5sz9z37PwI+GCFYXX
	 RWFdiv+6ECRURzaCx/XX8IYywJrZ8Ykuj+tzS9zNRoOqpt1U84TBz1Rs0VXw5QQdp4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LVjNybsf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAF60A260D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBAAF60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LVjNybsf
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso1435617a12.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792769509; cv=none;
        d=google.com; s=arc-20260327;
        b=DeiJZxwsROVEERu4634Fr+25pylTT3Th79dEh4vMvM7Ng4UPcZHViF9fKPLCMx9tYx
         BYozeA81d4p5fXUG6HRWXLevvFDdTH68trffht4zFoRt2A87vv0fFYjCl1kFB5KPtI9F
         RKOxUGquLSSQUk7o0VmP2zmsNdpB4d7pgJVvqakKdrvxXHDG3OcuDvQdLeQzatzFbW7F
         ijPKvENkKbP5Hv5JgevOqObdNdsWayUmD0VoDr7CZ65ka/jyImGrA/2rmJBQA/4z/iy7
         v46695WCT9O7Z0bFEVLIJU2pFlVme3eFSV3SJVUSAWABEvtQJYYfXsWPe7kVzkDqSnch
         IO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kOiQKtdDZhyyBydfIy8mxKbxR4NFcDKSAITd7gOg5WU=;
        fh=8KVHYsQo7SpvtQKH4KOhABWHBpdVCe8lMQmYQdwqDkY=;
        b=pGU0CEpciNdbg1nG+c90oNrb5ojKtdxYHCyJiGOkZ2ZtuP/ie3GUptZ+JrzQE7kBjz
         wJuOI6imX5+qn+PzjZHg3xBFlZCr5v6jQ4kCisWOPHnAIXwMmHPWV0fp++84+H7ElcMN
         KshODqOJiDzxL8q9Vm4gBt3tKNc08VCQ3H7J5+zh9c0otpMMuIEnQ+4mYisPNjI+ehvX
         pKjPfHBs12HqWparBetEZZhods9bb9+nvWWzvXZ88e+AEmnbJfJjG0UneIQRjI0ptCxv
         PlQY68/aRoQALR1TYZBlaFNYyf2NqhJFHswud8GmAY4AJDOpCbTk76dlSPLHBZHAv3IG
         l2zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792769509; x=1793374309; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOiQKtdDZhyyBydfIy8mxKbxR4NFcDKSAITd7gOg5WU=;
        b=LVjNybsfkpL/P/kLcs30DA6xndK5/arHR1UNDUVKcGnQ7CPtKzOG8zoW75Yrw9fFPE
         F8GRS/SIUHXrfpAuMEUkTGfVH9yaIGabeMaBgBA44K31Ceq+zi+jXI+hFqvQJhNWVQEQ
         /wpCIAv9BVH2zcV9zJzZfVx7rs9FRdOdRXmbXiSqYwzTNQ8brsty3JofURBe7cu4XORh
         fuG2BmtxRo2lmdYlfFM6hPL7fwIEaR9xCXjt+b4abwIIpNNhXT44LcQaRDpJlHkp2mJd
         n3m05mIOsmoBl7z90Wq0IVnRgMKsayvYxJZzz0oaBfu+VPGn3AQ42Jc+F2mQGdwXg9gY
         nF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792769509; x=1793374309;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kOiQKtdDZhyyBydfIy8mxKbxR4NFcDKSAITd7gOg5WU=;
        b=Ug1D1tDrwmj7s/Qgtpi7btaCSjba1ybnyEiIgsarYux2ogKviYuaD6W1qsK+tHpBkG
         bGEijhAmkvwHnmNVAqSmBgriZHqmyOoTHc428Vg8KGwRTqxdv7t6DmTUNP7HU6UGkUJz
         pGTYJg1beA4nRB2/3BQZZ6CZXH7RCs85X+G1MfLYXyfcCT1/LdttXKQSN1YrHJG/lHWo
         jfzhaotFtFOYBr/W/4Umn7TbD8F/+JnX5wwOBJ4daYt/1UW5TIkm6j2LEgAmFiWLC/xu
         NtuUVY0b99dmtg3qsPfpg17cDAlkHTYbp81en5BHnFRBYRi2BTXIMusFthOtNPwJRp/v
         dq1Q==
X-Gm-Message-State: AFq9FYJ3oJxKnnXxY8P3F52vrFUk5CoyeBG/29ExangoAeshL13QowKR
	6wbs0aj9LWQ2IoZWfNqoE9VpNUvSvWrZLRZjuET82ugho5qHpxEtwDmy8ZyE+n+1anCE6sTVe/5
	IyUR8+ghVR2SIYWmApcIaD0CZ1+ebctU=
X-Gm-Gg: AYBFou08qdzgSTL1A93XYxN9suwEKjgcJ22mSlFQ5GJn7pfgX4LZt3vCi8Kly/g8r2I
	Poc3BAT6JmWa7VpocDEtWAx6/yb66Ln6IcuyqNNBMOzozuc80+PVqAFb42Z52BBrWxSPA0eg+g5
	mpX12g7isNNLQxfZk2drJEbGu4KZDHx7r1Ec3bbllfh/jBfPM/lzZlPbvwJiltxDOC+zeUQkDB0
	wuIf+mPgBS7t7j1Ey6+Sesmo7oRAr243o1J/Z110BbxcCFtY8UaIi4HLmLH+tq4k/2qnGaha23F
	yhU1D3By+gQQnDtCuu2FgI4/y2LNJllXFnV85q9idmjXRz5te2J94zY2u5oKhV2H/RPJjTrfYcp
	GAlbYqrKAi8xSDQEOUIfzrH1y6ykjV1/lmKFa
X-Received: by 2002:a05:6402:1ac3:b0:6b4:16fb:b9bc with SMTP id
 4fb4d7f45d1cf-6b432c0e688mr2909705a12.37.1792769509009; Fri, 23 Oct 2026
 08:31:49 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com> <fbbbabee-c586-4305-bdfe-3f7cb46b7191@app.fastmail.com>
In-Reply-To: <fbbbabee-c586-4305-bdfe-3f7cb46b7191@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 23 Oct 2026 17:31:10 +0200
X-Gm-Features: AclHuK_1n7gFbGBJR4DyOXMbpGCeGSS26qARIRdtynxVcWJRIKokZ_YAx_6ZbYc
Message-ID: <CAHwyqnUSfx=NgKD_CepbEU5GZRrTPnMjTCDHcQUMA+huwc0MMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] reflog: add --operations and --historical-branch
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> This sounds very useful. That you rebase many commits and then the reset
> points (where each one started and ended) get obscured in the reflog is
> classic for me. And I think many have had the same issue. This is why I
> sometimes use `ORIG_HEAD` instead, or maybe make a backup ref.

Hi Kristoffer!

Would you have any time to take a look at the latest version of this?


Harald
