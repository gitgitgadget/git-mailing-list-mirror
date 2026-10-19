Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856C49E13C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402879; cv=pass; b=FmBVXJo/mJE/+9/auoriUbUOYvzyXYFzGtdOuRpOWWZQhlkwnuxkkUr7Gom+ORh8fjbOlGXrarQ3ItOejvF7XRgMB13rgAbT3zZ0liR5Ew2vgGZm4YuCwV0WhUlrrWVW1XjeYWmdkkkPnPQ/SrCYt99/9MjX/R3oWRDSBCRGuPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402879; c=relaxed/simple;
	bh=OkskmWrTdy9TKc9SRecCGvfOXBAHJDxVGueVVTwpKx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRvbZClt0uuPQBqaSpamcrHkKOWE9dXjdly7vyyUjrnX8CLGxqr9bzhIoqT8QCBb0KOXSnPHw1N6dTHII9FP1/JKofFOqP2kl9luGp92bmn9oL5CypkH7CFzn8N0sle2kwvJPybqgVhciUdKczjZsj7GBewmTO+rQH/7buDyfH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qA+WXgmu; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qA+WXgmu"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so2846474a12.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402876; cv=none;
        d=google.com; s=arc-20260327;
        b=QbqP6v1V6TeDra+rwY0qryjV6BpdQNrTgHm2YaX/lZ8c6A1rLy4t1+rQudB/PuWcA1
         9i/WeiUimeN9BNtuuf/VG4RmGEcBqK4qB3HC86HGyvRKwN1upQoS0uhs6nim5wiSOfa3
         QQH8zfltFRbgIPepLHySomJ+p1tTciv+CpiitWQN15PBvXUEv4327pbz9EGyvsnozoH1
         t5FFL2qCAcHl9Nu527g9f7+KkKFfpSYoEZY+60xRUB3X5zVxIGz5/c9tozY0uGvMGRfo
         wxAFGlqfTKctizMd9yZwrMh25dGwF28ReQqa1haHmJSf/b2QI/GG7OQfd1GdV/XFsxb8
         DjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Yct2XinCNSTP9n5N77sLZY2OJA7QJMr5fy9mO5nXrXE=;
        fh=MDPAM6vgiB+CK5rzgnJj5+HjEww0nU+8jg7XFEGs8R4=;
        b=axw1x7Kb8RG+23htPKGEpTnj38gyhDdlwCDz3d49YmluipCxHfJAKDXMtyMOImHeT1
         Gz6sJzBcABqTQLZEzRp8cHL/3d/QOib+ED/fJRV/bFHlzpu0c4atHTZn+wni7NFPVYx7
         bjTqg7Z/abPIMmcHcseZrAAieRWoNMm7RdnfHFejQ66Oc5ew4JaFuIDSeqUdaC35s8Ik
         vk3wjaWgiQRGVfRJnT6NPBzfrbuT9rSbV+h21IH7JdgINoX9470mVJzdP+BFh6Y458q0
         pehBvKgIat3S7fI4aydEoOermhtgQycLcxUJeHmGx9KVeoAOtJUbDljCKSvyWqDvtIYd
         xCUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792402876; x=1793007676; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yct2XinCNSTP9n5N77sLZY2OJA7QJMr5fy9mO5nXrXE=;
        b=qA+WXgmuQrU6yIsO0GWSrnXBa+NIIOLNiBu9enou8zjPLylyGtTg9bvi6gpklABvKx
         iP5GdCvToQM8ajPuoMkSDNb8hW24/zoZJYg+fFeZL8/SCOwDcmMvEXJkk9MmjiPj/Cv5
         K058L2Epu3KWdnwmYoRzXuYhGfWfzTyvelPJZipAtRLGeQnK01favGEUx8o2imChiVNa
         e+DfzQTqAAUJrG4XvIQQrOJrDAbEmXJQ8boKoIOEcP/nSQzl63bhqr7f+D06+EcMUh2R
         iVu05OrRGHQx4mO/7vbBK71iKgqJQFi4rIykApfPHZbmt4Qi4Q7nrgsVNBv38RSV3X2y
         jqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792402876; x=1793007676;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yct2XinCNSTP9n5N77sLZY2OJA7QJMr5fy9mO5nXrXE=;
        b=2fMMRI/3DquJYtATwG9uKLeIDn4LzbQICIwT86gS8g83H0Nz0UwBj06XPuH3Hal4W6
         S458wgET1ePdJBaIujEadUishHnHFQAV1wTKu3AVZ1SwS4MzwuSrIXl6ruOisAOBJJtn
         yeI6FJyG9ruo0WaW9fbCVoTrWBc/pKxRDlZJJa5Hn0n1ukrbx/0S0Vj8ibIStS4EHJcA
         y18YHFb9Zd2qNoFguw2/JoFfOfK8UzQGwgxEUvBe3KWbQWfcKJn3oi1G8/7YY/x9sqQ/
         OVua0Ls3JF8pAnFloJPEu40CLLrMIXgnFciw74iZ4uQALDSCnqg245bAu2sq6/MJMRlC
         28oQ==
X-Gm-Message-State: AFq9FYKKOnTtB0GMvIEm8COTQrpL1YnFaGNMwl/CPitTq8UZn/0Qqq8d
	MKfES1aMWP9OS3Oy5SmZ3N7W4soKtuSApPaSOBjKzUDg6wOngIo3R4rbhO12PS9enLke+7PLY/E
	ZDuHzxMAzbCeXEgDD6Njw58BQHofB/wJSGw==
X-Gm-Gg: AYBFou3lbMKKFltoX2tEvIT/plJDUTBt4NNgar5k8l24WZiV+JK4mVyZDOZNiqd2TYj
	4ccSvCt/g9pz3AzUCoEdTGHOhTmhBICm9VnDD0t5rfVjZQChxXh1ytbK1B0B955yIe2pj0GXFFx
	hk1vJVo+P+L3Drwii2P1TSheGjOtGHumsMa6Uhp/B3xLUHH2l6YCN2jYgfN5BPnmz54m7cugzew
	B8XOYV9H/leuplFWJH8Jm3X3ejQ+00u7lm9ZgVs/smWzCo1GrRPtnuW3O92V7vKFZL44zGPDSbC
	rFaPjcJKIFe49fPbYEazMgcyRkglStUk0uV5PXzuOzXCmhcw0C5j/o8=
X-Received: by 2002:a05:6402:f0f:b0:6ac:765e:def2 with SMTP id
 4fb4d7f45d1cf-6b3a81b87d8mr3128924a12.41.1792402876376; Mon, 19 Oct 2026
 02:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018142130.2701449-1-olof.fairbrook@gmail.com>
In-Reply-To: <20261018142130.2701449-1-olof.fairbrook@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 19 Oct 2026 11:40:40 +0200
X-Gm-Features: AclHuK_FX43injKfVR_nU4HO3A2Ub4fCfjwcm6dfApsa-6_PlzO8kWNBrJksL0k
Message-ID: <CAHwyqnWxr3ZhPpM0WPCnJh-SHdGDZNE0ZJwA1jHhd+6-f0aEcw@mail.gmail.com>
Subject: Re: [PATCH] bundle: do not free uninitialized memory on bad arguments
To: Olof Fairbrook <olof.fairbrook@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

> -       struct rev_info revs, revs_copy;
> +       struct rev_info revs, revs_copy = { 0 };

I'm not familiar with this code, but the fix seems simple enough and
has a test. Looks good.


Harald
