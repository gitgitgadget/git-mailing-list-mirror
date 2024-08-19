Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457212B8B
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029189; cv=none; b=VDToBQj+lUA+wkSEXQ0PcUIFJKdB6cYDVoy+nPchdNtR+tFhIUidCzAvnL/l9M2rR4+IekK6NPwwvty6/3pLJWTojX+4o03nV7cm3mzJtxm6fxvG06R7jwbG4xnqKbCF0RXrc6+fijOAFcghVAneS13EMWpLZHhIWIp5yn5UvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029189; c=relaxed/simple;
	bh=rBLFDEl9GFQpg3tQO5lF2YslFrhmfQXfz/ye5T3UibI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=flItdAgLsY/34kVYnzUzC7RrUwWiTZEJf2tXmjhQU96bFTEdEBypQREgjJ3dzLbMeEbQq4Sx40oLVjOme4KfkLEsPxfbrL6EdaAsq7GL/AQ/p8raaVwoKJioxdwsEIq5xKGYZKONBo9Q4vQtlW24LJ3CAT3CLu3I/p0KNmC+L64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbCEtkSd; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbCEtkSd"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7094641d4e6so1504306a34.3
        for <git@vger.kernel.org>; Sun, 18 Aug 2024 17:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724029187; x=1724633987; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBLFDEl9GFQpg3tQO5lF2YslFrhmfQXfz/ye5T3UibI=;
        b=jbCEtkSdR71oeSm4NFXsACvDSoZ3lzH9heQzkb8HNo7MBr/X8bRDbRHTQMSjJKQSf5
         NBNwi3WOx+ouqYXIfu/QmZDTRqaBTJlYum055mB4L7bmrJZmIri6JCXwZ4DxOsSSCx0C
         ttORthPQsJhkoL0kJjFmu0qQQd+VZjQeaoD93cW4V+sl0NjmxuEqsNv3FvfHf7xFoKOl
         5h6GDZH32rVhEtoMruN49iyWj/QsP5l+sFDwg+NQuWSpL48y55n7GvYIuGhgmJbhyLha
         ujODywwIuYJkCw5NILlQkFJvtoBmx1OWzmo/IBxp/OdCCoi4iNIlNc75SDyFjxRARPaq
         Cblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724029187; x=1724633987;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBLFDEl9GFQpg3tQO5lF2YslFrhmfQXfz/ye5T3UibI=;
        b=fsd6IoeIxoEyftssZT90smv615sWbFQuZnH4ZawWuSdGHuDh82ngILJkPPGxY/UtMQ
         PWGnO7druUIRfx0TTHCDDbNe9Zmvd1092553SkqkQzqI/ZhYWMv8XPYURPcey7ftn8dr
         58buDLu4FTCSJPrLwZTjcRWiZkqxRibybbQXGk4dbkl1QZbIYqVLA/MzjUanDvDVIM4I
         QpNfFG/jmPHWvnnMFIWUs92g6ybtaOYC2P5AV8TclOnoJucVfQFu8npkcM9fYsDkWp3t
         XvbeytNCjoItnGagfHQCYh4IUAjTPkUreazAUQnnG+RVWDOZZ8L5Nz4lSROPDIy2UjRl
         0L9g==
X-Gm-Message-State: AOJu0Yyap+bzsmoD+7DRH5j0APOyPX5a0Rhal2spU3UfLM+YHbd7URtk
	rhEgI7QzDEDA46hK4xvLhjCFWeiupfRqFlJXvUCTBhHgYoVQxqbOhC4jhTG6XMM25yPkJILRCP2
	qPoIP7tVtMqZXe+0DRUSKnji/iG4jlR2j
X-Google-Smtp-Source: AGHT+IFhWTMPwHx/lKjQQZk4eFM8m1BE9H/dq/0q4uDG4equAWc/JvUd0+qp/Cj3mpIYY/qclrOapdDuuNdxe5bibS4=
X-Received: by 2002:a05:6358:431f:b0:1ac:f109:e248 with SMTP id
 e5c5f4694b2df-1b393115ad2mr1388811855d.2.1724029186642; Sun, 18 Aug 2024
 17:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
In-Reply-To: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
From: Yukai Chou <muzimuzhi@gmail.com>
Date: Mon, 19 Aug 2024 08:59:33 +0800
Message-ID: <CAEg0tHRave5gCWeFuTFeZiR0U=R-bnW6tYGXJp9GQP=oVh5gRg@mail.gmail.com>
Subject: Re: [PATCH] doc: add --show-names for git config
To: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> +--show-names::
> + Output also the names of config variables for `list` or
> + `get`.
> +

A bit of inconsistency: both singular (`--name-only` [1]) and
plural (`--show-names`) forms are used in similar git-config(1)
options.

As both `--show-origin` and `--show-scope` use the singular forms,
perhaps `--show-names` can be renamed to `--show-name` too?

[1]: https://git-scm.com/docs/git-config#Documentation/git-config.txt---name-only
