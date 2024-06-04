Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43921420DA
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491691; cv=none; b=KWQzUit7XTduFa234bfnJFgEXSQpRbNXmt6UOO/Q1Rbhl9mRPWYQDz0EQZ2LCvr2GFx//2g1E4LXK+N4JGNsvr5vKndizXujveqrkWAhNxMniVD4lqAJj53iDPup3CHlw0H9r6irv+/3k2THeXwfBNdTwZDYlLoXEnyZAND6VQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491691; c=relaxed/simple;
	bh=Vo5XTvHD7VaR3ikFV/zKwl36YFVLDa24XxeVYUD6kFg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SZOhUs2NJz4hx7lnxJ8ybXGQn/q7b8ms0JXTo2G7Vp64YS5LkGU6vONrGvymovJqfzZ7VOwPc04fbLEbgO4ttWOay1HMbn2L91lbOO8sykByh1M5UbuukCCyD9vkrkWF93OrYvIuFrgMB44cOxN3KPGFn18lx7wXqbhUW/DVZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freshcore.fr; spf=fail smtp.mailfrom=freshcore.fr; dkim=pass (2048-bit key) header.d=freshcore-fr.20230601.gappssmtp.com header.i=@freshcore-fr.20230601.gappssmtp.com header.b=nKMQe77k; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freshcore.fr
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=freshcore.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freshcore-fr.20230601.gappssmtp.com header.i=@freshcore-fr.20230601.gappssmtp.com header.b="nKMQe77k"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso8582391a12.1
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freshcore-fr.20230601.gappssmtp.com; s=20230601; t=1717491687; x=1718096487; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vo5XTvHD7VaR3ikFV/zKwl36YFVLDa24XxeVYUD6kFg=;
        b=nKMQe77kr1GhILpRYsW7220LAtXSOClMjYieYaS9bQQvCBTWi/L4JIBBD7gBgY1iWF
         LJKZErANe6NU8GbdIhgYMCDvhh+XjOgu7895sHnb0JZBDxhDP5UC7uhg1KW2am7RPIVY
         UH1M3m4nhGd05zLLQPg3UxluKBRx2OmOIAMJNUp2rFIfEM43Z6VQ/5LlIjs9gOP346Ie
         5pcys4FO6l3zRawyN3TfXyQ6vuTWahWfiNQrDLsnsRGZts9alDzP2E/5tbinIF3pB3Ob
         dnHmFpK3FSbTts55gPM49sXoU3sKJAwOMqO9PInFwrVinmJvw2y9Qru6oTJy4yv6JtPW
         1UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717491687; x=1718096487;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vo5XTvHD7VaR3ikFV/zKwl36YFVLDa24XxeVYUD6kFg=;
        b=pcwpNaE0emDybT5HHPOzQtQrZgIlT2areTo7gBsfe7Vp6n0f5bt2Vq5JoPAO0a1Cr7
         PC4vc+cLRpX0KgbnB47PSwE6nnKPJ8D+DEDsHkJ+zq7FXJdUnGba93SVYqZ2NUpRmrSQ
         rPGnJDhDKUEw9igaZ3uyuOXSmwoWA6a4JvzBm7mcDxsMjBZRwqvO1X3X2VUcolbFgbPb
         3ouHPPNi7ay2BP90b53haOQOZFGk4+vkxFUil0ArP4eYwbN6gclMXai6hUoHbBLqKyTT
         XqHjCuXwDVorU0nban9lElQPYiqRBwX3doGodzgN/el3W2BN3PzXu+9xC++NkDp5sHLx
         EGlA==
X-Gm-Message-State: AOJu0YyvfdKrqlzaWYGqew4Xdw/Pt9FJHaP7zFeBDP31Xd8n+wys5RaX
	D1X0PDTzP4I7/T46Vqrj1plf4JBmxmfF0hqHdQwjvY0FhTOax3HUrnk6W/p746FSKafnA29M+cC
	tcl9V+/J5K4PQup7xRqdgLxTjKmSUzPVDrwiBNnfIN25PnhclytY=
X-Google-Smtp-Source: AGHT+IFBrSpdiYkvLDUoCw002HVJv29q3ejn594ncntMwD71/Iu77GL0vsFvJdFqkspEeQhLQtIpfcFfqX2FiuJnvuk=
X-Received: by 2002:a50:954a:0:b0:579:c5df:af84 with SMTP id
 4fb4d7f45d1cf-57a7a6df7bbmr1713214a12.15.1717491686642; Tue, 04 Jun 2024
 02:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bastien Bonhoure <bastien@freshcore.fr>
Date: Tue, 4 Jun 2024 11:01:14 +0200
Message-ID: <CAF4yLXEvx5rk6XocTnRUq6avjJhwZx5jLtOKyt=H3n1qoYoD7Q@mail.gmail.com>
Subject: Loom UX Issue
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I just want to report you that when i create an issue on the board
when i'm on creative mode and not brut text, when i paste a loom link
like this one :
https://www.loom.com/share/15e0f33acce943109f340b500f139179

The browser is freezing and crashing.

Hope this will help you.

Regards

Bastien Bonhoure
Freshcore
