Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9236607D
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325040; cv=pass; b=kvUfkKRETeF7YE5+FpPrfYSEPHjrwasuerqdDXipLgNhyY6Q7EcplHoVaMN1noyq5QM4zRFs/h5QCbobG4Ku4D4VfGPozgdamblSM/a4B/l1T9YKZQNU1+NSvz0TlUsHfKflH46989+CqCdpO7JL9ypmGY47qm9Xs4gFitkNkpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325040; c=relaxed/simple;
	bh=/vtSaOslwClH0ekv5ZjdyPN3yTjelqYk4/Ba6sn3q/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OM+uq9lZWdxM2RRcMrWT6CBCtm/c/8dTmC15/dEpH1F6LlNl4O1RsoivimhmZceZBCX+KnPdsb2TzlopM8fG2te4UI3tZm9XHJxQx4JY32lKHKv9o0vQuncjm1xyDVPP3uPYEf48aET1Vzd57XFsvWBnHNrn8/mGLVh11VbsbGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvWAx/tn; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvWAx/tn"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7986c7b8076so11885857b3.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 07:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773325037; cv=none;
        d=google.com; s=arc-20240605;
        b=BZnCLmOiHSv09ywDCxntzmCXZIUO1BQ73iBq1PguAHY91ac4CCzVBJjDyoiRHUUCa8
         sFhDZ5FlGb0bpQ6WrXYoop4CgZCbTun6/7A1b7qIOo5GZVQJOt81J3DDlrR0067UGgNb
         azrUbkaMnegkW4Cq5Xp5rdWFBaPR+ZDCV1f4hdNW6uCQWZK26yPP3Vzl6tdcGTFnVFdV
         Kwcv//iZWyKKuLvyw/5nZfTeQO/7sXn8MgOc0ZJE4J9LSucb6Z+cJnTakOw4YFHaIqyx
         orWMBW7aYmoZPSntlm3DEc0AkbZQU5mh7hLP78molpzjayBMwXyLJTCIfyYK4tlWce2u
         UzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KhiC5i9YPYh9dKskJTA2z1lzyf350K9cok1WzhZW7O8=;
        fh=iio2uoOBAWn7SWeSQbYhiY0qAwgocdKu3eQ+r4UbYXM=;
        b=fE05RjDYxbncBcvS122KMRsYBKOYN3JNk5LfNTKHFRyEAFT8n8XnTgUqt3+0pBD1aO
         cp2rVleeNoZGJpVBu1qEdreJ0wwARPWG6u3mj573l+clFqxDoNM7KkQpq8XPs14AePqv
         sKCdQRlOcZq6tpdj9OdfbpQxj39vHDZagDiun7LuTBXDpJl0oYFIlvxlcM+ljFaUGjMI
         hfpwKXoXhbG90Dg9ZiYPkAUDcdqyNhaYnunNHbetCYv5fBTsJWgiUb6RvpaihW4TNrqI
         V6v/ndntOW+dmpz0SnN7ZBg87gCuR5GT0p88kK1Hthuc226vPzxvVT8Q0Jimm3MvM8aJ
         yETg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773325037; x=1773929837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KhiC5i9YPYh9dKskJTA2z1lzyf350K9cok1WzhZW7O8=;
        b=gvWAx/tnIWMIHAVGTCO0jS8vEJteBZiPWIW90pC0pIapbNcttKvGbfIdyOzkp9qdvY
         KV6zGEL8lDuEDI5hvXPwOkroKfHNcrrmO1Oeh17CqTLbRivdDRi34lgVRUzQN0aw7oVM
         LF4Po6Fdy4THbO+J7DXge4YupizWekZ4KXuFN/gHa1DD3NDnZ9QW5W9ggqs75pHS1CgH
         V0PJwiuK9FzLHKWWylEWPUeY5tcGdybbNLrdGGoamUx63ceVbapinVhTvZ3lga9zqaim
         dX9IJl5croYqgoe+cZXXWNwwsXRpvuCTi9hAVAP+lAlVzjG+MsZCatL6QV49pGiBLUfD
         0xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325037; x=1773929837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhiC5i9YPYh9dKskJTA2z1lzyf350K9cok1WzhZW7O8=;
        b=IfLx9NppFmwIOajt6lF/7/Lw7Ex4F10mS69Cg66eAkPYiiMQVCj2uDuHqe53EzKpyb
         jJKB9RQ/pmhv9gs/Etne6UN97+k/ICEQYJFPxoEl1CQ+QZCmh7o2ufWPWbfYMDh25uiv
         cIBOZICb4p4dvVpU3waEnMwx6TlXLKesYuTNJ/0jlW69QJv0Qtt1xdImFB6hHXfcHBGs
         0yuTLGEfP1tma5+ZvjixguE0R36GKuDYb/Pt+Zcjad1S1iB8aYNzirBEOzPeyQcQFFHr
         G8G4onpu4VS4NGhcBTtzQsL2Vk3DuWwzEINyt4rhnjtutzGNKqa1zCGnzkl60FCQDe2I
         Cetw==
X-Gm-Message-State: AOJu0YwcxG98FIaRyrNw7H4qEvslgUwSCXrZHH1bF69lp0lr+fi1pbpB
	GezmhF3YfTqVLYfdjKc0UBKUWQjwrSiM1fSuzocwGwOmic6CEgXgo5BuYUX0fyy4K2C/B3Kblca
	kbqUxUQU1KsURD0VNFebFYaVetYalzyE=
X-Gm-Gg: ATEYQzwsQRKpNjIm7xGNv4ypZD38b/lSjvzngdFJy/+Njs54x4kHCMBiqEdSo8Gkueo
	32iaYmlktKMlh+pB8uX8jhaDLfSy4WDWH0awj7BSsWZItJXD0z0oV3qMW0ZGFqvKOnJ7njKocyv
	g0YyTDe16QvU2a0LdLIm3b/R4rnSG/QtLJABfBDoWx4j8jdwnapQxmxov+zuG089ye6y1a7vrx3
	fCuJt5qTxKXs+zVQTdUr1GKGAmUrYs1ofa0DEmY0FEzqpmn+MedXztOj2aQiSHJk/RAcTGrngSW
	AZ6HPnk=
X-Received: by 2002:a05:690c:6d10:b0:798:ff2f:267a with SMTP id
 00721157ae682-79917f824fdmr60942897b3.52.1773325037128; Thu, 12 Mar 2026
 07:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Thu, 12 Mar 2026 19:47:05 +0530
X-Gm-Features: AaiRm50VwrbG1kX6kKONpXGOQPwKlzv2Wq-HDaSj_15vb-853uWVD3sJV9jMzek
Message-ID: <CALE2CrTzYbMam_fi5HszSUFVZADE1haLtpBqhUmd1ki9biM2hA@mail.gmail.com>
Subject: Re: [PATCH] t0410: modernize delete_object helper
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com, 
	christian.couder@gmail.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Siddharth,

Thanks for the cleanup! Using `test_oid_to_path` here makes the helper
cleaner and avoids the `sed` trick.

I tested this patch locally and the tests passed.

One small thought: maybe we could quote `$obj` in the
`test_oid_to_path` call, like this:

>
> +       path="$repo/.git/objects/$(test_oid_to_path $obj)" &&
          path="$repo/.git/objects/$(test_oid_to_path "$obj")" &&

Also, would it make sense to use `local` for `repo` and `obj` to avoid
leaking variables outside the helper? Not a strong opinion, but it
might make the helper a bit safer.

Thanks,
Pushkar
