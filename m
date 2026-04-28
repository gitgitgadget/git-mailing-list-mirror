Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556428CF4A
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389413; cv=none; b=MBTepqJp4rizZEJBlqPgtuseYBpd1quYuTYYkb45SOL0Ucc06b0bF8Cl74AzMiyD737A7Y1MHxiAJtC7ISaXNW9SBcSr9yE3Tf2ncgKrOVLJSioT5E+YBdnxk0TcENsj2HZicoEE85XmdMSyJALizSrNgQExaUMzOInygY4B0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389413; c=relaxed/simple;
	bh=Adjh+T+GPrx4THDY7xRe0umT390u5lOtuZpz2NLYjKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWd2RMjurG3z5epPgjvrCJFMxsK2yKrs3luqyFATdSQp9eiDGw7x6nAyhfS7EofuVHjilPRgmIBnbpF+VnNDH+ZPICaZHfr+1jVv+Pm9ZbTCw8pVk/GQ1uFb8cXO1V8FCEArmLyl1R/35u2607bbRG+mbbJo0lePvr8MqcRg2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/VbTsm4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/VbTsm4"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a40b2d268bso9393505e87.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777389411; x=1777994211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E5iW9G4CU9XzszMfF6KdAzRSy9UF2M/0bnOgBjG6eA=;
        b=M/VbTsm4V6hKp/KorP8vlNyAUUicv1La2rZS7jQupzHBpahYrIkjNz2OCksNNMW95E
         MeGbqYk6Ey6IxlqFhvW153+O7ovDRLMvEx+VeIS4Ix1TRR0Sl7x7WfMgcAZm9u0vJa0j
         VYN3igwPTuWDAp5CSa+xoQvHk+ddGSWXSTOD0p0MADW91rQhWkNwP26twTUq+6kg3Fgu
         +/vHunmvIg/Ed4g1Obo6TcikdOws0ZDvcOgdabU1Piq3pOYVt+4l4hDs7PYU5bCB9vHN
         mqbU0sP5EM+z/U7JkTAKx/5MqhLh+eTtadBmb9pyIu5FrHJgLz+O9C7RjFiCY6Tj5VyH
         fTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777389411; x=1777994211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3E5iW9G4CU9XzszMfF6KdAzRSy9UF2M/0bnOgBjG6eA=;
        b=ihWDTSgtC/zGU+ylYAYc15Tk0I/0qwJEUUBphPcP6uc+Z+Gl1lV5zjBnby6CnbV1wu
         trf5nwY5XXMaFwzFmQ+St1XSVb7i5sLSF7TExBu99erhPolJSIdmV71IRqvuDSMicZ6E
         ZS30aAoiI2bEIAW4mV5HrmgrYs0BAD7kIRJtBwNZjDguoOmSd2VeihZXdnP/5k8P19Wx
         paA/M34bdX5kWX3EgVkJEPGFSeoqg4gnrPnXxVO2ji8VG1hvq8Q/STxmNKzvDLlu0etW
         WnrTRcfl22gh0gspO/zsmJEB73w30Gb3K2GHjP7rmzhMvHNFQfrP7/cOTWAdytfWb3wj
         LHbA==
X-Forwarded-Encrypted: i=1; AFNElJ/HnW1wW+cLtjYPciW+Hn8jn+DYeNFap8fsHMbwpk2yvJby2bjge0tDkmnwLEWueNJNlqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+ORNFdLaoGGQ1Ie9rxKqAyE/YOR/CZJxXcW481qe0F+dXTTO
	Rg+lixMpHmgL/9RaWAJEYvZWtcv4ww+sGvmBPccdcI+JV+gAtM7agPlS
X-Gm-Gg: AeBDiesS+yJ3VWlA9MV3BF/Ak9674LtJEl12qzIugiuAZVXlEWkSbaEY4qHXJAAWorF
	qX0bJWeUmm+GtqbyKlR9e+1z3qfuwVBbERdBQIC9LMALlCz/W+InmxeOmLh3kwG2HzQ/0xIi19V
	+7CvTUqgTw+TxxU9VrveG45sGgUBw7l+m7ZsQBO1lp3AZnbiEr6P4NOgcjys15/PF7Cpm0cCpZC
	QPGH5yhY8ad/mN7aPtoS/mtzqUZNtuUSgdddx+PM+NdbzncNSCRQMLV8iG9/4x1Dh1BXX5DGfzz
	SySWUu8wAio0pKuX+ujo4o8xjRVpcnehLtC5EaonsUpcSyt24WJ2yDtx7sn5JrOM8C/b3W+9Hc0
	/Ve0+9n68YwwYFva8OGqB/dax1cWgQ3UrGEMKNBl5rdZjmOZZuOOOOOFou7rHu+pE8qeKSC0oTI
	a4rTi4olqYF7R5YnkRQkEM132MiOMk3qkEYz20pk98TF1QWBjHbGjjS/oCsQnyh2N/aDlsxoE54
	OynlezOkUm99Dlm0P8H6FuhrJ4=
X-Received: by 2002:ac2:4c4d:0:b0:5a7:3eeb:f63b with SMTP id 2adb3069b0e04-5a74660f3e0mr1061519e87.22.1777389410421;
        Tue, 28 Apr 2026 08:16:50 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a7463fcdc2sm708854e87.58.2026.04.28.08.16.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Apr 2026 08:16:49 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 28 Apr 2026 17:16:48 +0200
Message-ID: <20260428151648.55826-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <6d60573f-a02d-4aea-b891-6dd52e2d7048@gmail.com>
References: <6d60573f-a02d-4aea-b891-6dd52e2d7048@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This uses the existing label which is sensible, but I wonder if "Stash
> HEAD" would be a better choice as the merge base is always HEAD commit
> that the stash is based on.
> 
> We can always change that later

Yeah, seems better to do later.


Harald
