Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018836494F
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781908865; cv=pass; b=umCvi1FdqOVFCSd2kC6l+zq64yk48VRSeX12ZR6RWk7Z8hMR3GcoK2nqMNVdHoMYuaHEa+nX+7S10nd7+dlCe/ep8AQWifcjJFPK/OqBjoJeTZ9AcWqAkM2Ds4rha4bpJ6uN+DrJpO+U4tpj6OKQyvEgbAEhB/JDt1hayefsw14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781908865; c=relaxed/simple;
	bh=ffHqHcYEJB992pAZrZFZtT+LZGlh2oH3uVW/mlq55jU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GMA8Fyg33ivILQsb6cXrkvyOFOQ8v8MnAxWIdifrkKF3AwSN+U+nhkgyz7Ie2xNwnVbfTHUbFxQsV07Ir0WfPDVJaundtcapSkt9tVmsg3P9mzRNJ/ww4lrfSbFFha6piWs6GhyTrce2EnF5UnmA8cNSIcuOhMXrbTj5HUPi22o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZjg8DDU; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZjg8DDU"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-489795617e9so533963b6e.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 15:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781908863; cv=none;
        d=google.com; s=arc-20240605;
        b=TcAMtZvNfZqXnni8z6ekMQ2lDnnjwPZdjknvdta0iOw4zUxgUNTwOIxk80bpthu5Tc
         7QgOL443hz/8oz/5GS7pahRmOulKK+g/0Kzbn8uidBwqz5wUja+M3q+GXM68uzTAoQJP
         bxD/V+vifVU2n6CP2lUUKlDQvIJSGpkUXEDcDwwT4BELK14MyeSVefshRTslJN27aE1i
         /KkugyTdI9CBT95XZl6Ljm6ISEqWi1xUfQ8TFUukddg1pmEYP1aNDHPrEfQaNf+ATn8T
         gH2YWEln1rsIMtyhWICCeCis1jYS13rcapoixdDa+CsFrwoYghIv9XDcnW3rn/hcnjU1
         0Htw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qpzviS7IzpnmQEkcbgJqye/TwUInu/Lw3gkcCK2cyPk=;
        fh=YbRKR6BrbWXnCXlp2HQVjprJXXNDuw2froTlkW7/RDk=;
        b=WqmU6lf8fd4wv2DeVhqo4yFCXipBgIITNdUPXXT2N4dce3xJPW90wEpwKFrjqcTcfY
         tJD53rx9atqeEc4/5eQiVquiELDOBsUTKC17roS8cF+rr6CAu5twTs3pMp/h4nCodE3f
         FWoBowhkb6m+v1CvRfcFQbWY6/pEeW2FekZtVoDscFypehBydPhWd61IjrJQJ4RimFoF
         fB+al+o1YrNmqFH2u3ZQyS6HZjjsylcTRrc1mIuw1He2HgauDujGFEp1lgYLr8zK+fh1
         kpJyELZr+uxxvoeOGvglL3dskG9cQEZocPAhmFCY54iz6PHlDPL4ki/cJjQqoyTrK/C4
         ilAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781908863; x=1782513663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qpzviS7IzpnmQEkcbgJqye/TwUInu/Lw3gkcCK2cyPk=;
        b=mZjg8DDUhlH2AJ+Jx6IOlkJLmuYlgSxoR2pjgUo8Z+Y2VNtITJBIG+VxnG6dhZ5F+0
         QrUM+GuAxagNOofBxR7t6zJO4j+h4DK0Ufqg+aN1Nfwfgo3czDzdWov0UrFCK2Gy/XR8
         yBm/kmoI49g5ElMPkraI3vh8B/ZcetmWyg4ZcHqvzn5DGNs+FrXNEKeNzYIaJ4ILyJ7e
         GK8UDqPYkVUUa8/UE7XL16GQukCw2MTAsS0qa7JtS8nUa9dBTgKCOxoYVaOBEuJsAzoL
         4IwsXMRKq2eUPk1yNOjIt+K4P7gIxb8Iz3jcYBuA/Y0AiGtVPFXbRGoXQyBKusNIJkin
         tHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781908863; x=1782513663;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpzviS7IzpnmQEkcbgJqye/TwUInu/Lw3gkcCK2cyPk=;
        b=Mdxrz1qFkaoMYdRjJ4oh7Z7xKLfeQJip+tso3v6YziQ+eOkF0/C4JDX9epOVOdwoFz
         UqqQq4wpKdFsu0/KegK/VphVzDy57ijr4OoWQ/VLWbW+y5VGR7xyNn0ZxeLzvLPCbaMr
         CkMbWG+icqvQX6svW/Bfk9cankdVS8L622vGRU+VzNPLKpjO11YtV0yZ3fJ9K4dUU+qB
         MvUoEELmZ4JZPem+Xu1bsoIFOWMfQfVjJh7J/+RvOCL6Pl32ywprCHKX58tzrfWaN2qB
         F/MRAyZPIpCJCuMx8gRRyLtoYe/cdiamjda095F1ZZUmwNypp2iwkH/l2crKCk4V/apJ
         EGLg==
X-Forwarded-Encrypted: i=1; AFNElJ+LPNpQbuPQ65NYzK6I5Mn+gcid3Sh4jETVupZNlStKWN5MllrYjfR19pv3Wsvsn2sJxV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9aIyMQZSbWw8WsO3MOLfZkMLjvIfAfi9eL8RIJvFGIkP3+ig
	7XqVOtV16s9rHvZaQnSid8Kn8iIIiKxZsYNB3PAJDFJEUD79BSpFCWcNC6NUjQAG60pioAg3lM6
	F+7/XQXgYto9MNvLZOH7BNUA/W3L1DCU=
X-Gm-Gg: AfdE7cnWUa03jVZYygxoO6SGC+I8QGNLUVMUsotS3K8w2vkCis4rlr4iU3+ve5ah4gY
	XsQ0/Z04gHZXF8vYURwHofKtXF/koFa/77CyqyMgUBhxCUw7EtyUGRu0r5m59AJqg0HVE7pbkRp
	qIVDy92Qm7Nwwo9SVF/wB4wZV4RUaRWF4veDKRvnZTYO9rH0OJOR9siJKBd0Z70Xr1XbSeItLGQ
	Eo3lPJHPmmPOEvtld78YkjiPUrNluU7rQYb/7M4ORJ3d2aTUKw5vmiQ8nmbKHcOimIWsMIc84sk
	zBoCA0n5Fo5KQK3qoG8bgtCJdKW4b/JAagzuiRdOOjSE/w+04jeMlWDsbnsKhG7TWMfGP1NP8ch
	KB1oNALgaL312acv0WdSDrYajcA==
X-Received: by 2002:a05:6808:5296:b0:487:57d9:9d1c with SMTP id
 5614622812f47-4896aa727d4mr4601539b6e.14.1781908863201; Fri, 19 Jun 2026
 15:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Fri, 19 Jun 2026 15:40:51 -0700
X-Gm-Features: AVVi8CeCQgCVJMamoQZGpiJ0g-btrRRoAIULyUDWbnXgx1o-pd0hV10yFSYvHro
Message-ID: <CAC2Qwm+WcGkd9pAV5=JL1hfCDRisGQRFmdfOsMTrMWyx7aa65A@mail.gmail.com>
Subject: Re: [PATCH v3] SubmittingPatches: address design critiques
To: Junio C Hamano <gitster@pobox.com>
Cc: code@khaugsbakk.name, git@vger.kernel.org, 
	Michael Montalbo <mmontalbo@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> +Be particularly mindful of critiques regarding the high-level design
> +or viability of your proposal (e.g., questioning if the feature is
> +worth implementing, or if the chosen approach is appropriate).  Defend
> +your design decisions on the list first, work with reviewers and other
> +members to improve the design before revising the implementation, to
> +avoid wasting effort on an implementation before its design is solid.

Slight reflow suggestions:

  Defend your design decisions on the list first; work with reviewers and
  other members to improve the design before revising the implementation.
  This will avoid wasting effort on an implementation before its design is
  solid.

The rest looks good to me!
