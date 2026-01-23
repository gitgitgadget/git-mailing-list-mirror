Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F8279329
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184673; cv=none; b=CPrgBL9grCALdANiktcWXnl8rsuAc7j20EAU6tuK7zGCye9FNrlCOlgToWZYsu0i+/zzTrfvOhwoz06aEi/Z89eroGSb1a9fF/4aDfPi+eR3ef5kjKXwvCbY+DTtJMOLUEc8GDNKAmk9QsY6Qvd+70FeKAjx84+KjrUphuEu6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184673; c=relaxed/simple;
	bh=CAWpQz8wis8O5+ZPgAW4vB6InFiq+ATclrDxt+sFH1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmhWMu6J8JH5lXwA/UPLo25Ak1nMJSwWB4JxTYs0yiaXMReCqwFypp7xgtaQyyRz7923B0IUFWVtH25OlndsECfHNThrfMQcQZKF5u0DE1GS+Px+//YkovPRtVYW/yM+bgUCni+6Zk0622qKoukdWTFR6seukqCiUOJQBZ7agno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiP7tUi7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiP7tUi7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so26913005ad.2
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 08:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769184672; x=1769789472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuBfPvWNp7hzgZIXLIBnfPMCka/+R+h4+Y0oir9wiss=;
        b=RiP7tUi7UJmEMbbsmRN/yyUde+CwDOfltI681bFCt5lcnIqtnvJjSZbOd0s8BsVfUN
         lNEjvaFuc20vhA4E3GDuiEiaOtFX8fpt54lcvTchNvrynbQPgHzOgxzl/H8QHhvz91Bi
         D/Txj4FTeGz3MMxbE48qNuGZG8WeD9JVBXXtIFSP6hrzFEQBIYm4ly87fGdRms0m9LVp
         O5xvwIetpPpWTYYlU1cfl7Xj0vyIAN4bpvEK9syfc/VZetJmSe8DD9URPR69EMcyvHwj
         Cxjaza4f0ZLK6m2z9hURslGBTFRmJkUQT5Em5r69RMeF4xe072IrSl30rabHGHVDMfDO
         Oxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769184672; x=1769789472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vuBfPvWNp7hzgZIXLIBnfPMCka/+R+h4+Y0oir9wiss=;
        b=rufFNJQA4AVgAqvP2aVVbVi8D9slXcthsmABZq/5PcvGuVD/PX3etBW82jgZdbfRJb
         hEieWJp922e5URglDhUtiXSDnhBenlShOxsyC8BAVkiW/NByWAY4UEMRMx92QEvGyj0K
         7zcOTlJZh7GcOdRmAU80B7VN7HbgNxxmTYRXui9HssJa7vWM8tuv/Oktr+76vyg6GCjQ
         DN5IhT1h89O2unPv0xSZKW4WgkWOWhEa15PNgtY+YOodJvZzKGt84RsLkBEzFqkXxIcT
         hnFOT/atZTyx56YcEXE1JuJ2mmAnBu9SB8P05PLbcyb8J3bIXGMKDOxLvLHAX9AjTNp6
         MGLA==
X-Gm-Message-State: AOJu0YwIqw6Oh5pP+tjPYN9MkUSFEp9bf6c7iZtu/Wst2mJ/TiSDXI2m
	dV3AcZr7mW353sAViVYqcBwUsorXbbSRJ9XHdlT+k8d9pVp8jxxhdFaP5oaAvg==
X-Gm-Gg: AZuq6aLqso9VRhBcpM7aj5mpxclkXgGF7RQk3wgOadr+zAhqw4UaZpJTy7OYICpz22D
	UsyJB3u7U207IkqB/2sL67HJVu2+/AJfDfTCBYN5LxPbdop25Mp6jSS4EuaQ5T4DCLN3gwh/iaj
	NL4X89EnaOjTVijzinH/gXmqn2VsSOJ71oWZCNFgB55fPfTRAPK3vMguJ/nPBeKOrIZE2pWPye+
	nO9d2/wDrcbrI6O7vxNTOT8yTZObMtwlxiXWKoiURCN5d211brECVcUoHBs2OMub4S7S9EOWOij
	Lg42d9vNMeTyHDnPsySp7xw0lhwYfOdyWL4LqmbEu29BRmZSD9QC7EjnkAUYN/8yF85RbmcJ+zU
	VuldbpzroZwJ74zDP+hNhs4khAg4D9BRM31A1FSqHM1YhgWoupx2cjm63CQRSGNfZtNNHMqXbnS
	OqwohiNplpLrIa8JhsEFaMqNODyu0r6aeX/XIeTs+g8jeTtw==
X-Received: by 2002:a17:902:ce0c:b0:2a0:d05d:e4f with SMTP id d9443c01a7336-2a7fe7422b5mr32251765ad.45.1769184671787;
        Fri, 23 Jan 2026 08:11:11 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd7:6181:9f98:a763:f00e:e03b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fae596sm23766755ad.73.2026.01.23.08.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:10:41 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im
Subject: Re: [PATCH 1/3] show-index: implement automatic hash detection
Date: Fri, 23 Jan 2026 21:38:48 +0530
Message-ID: <20260123161017.37827-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aXMh0pYw2ZrptCNj@pks.im>
References: <aXMh0pYw2ZrptCNj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> That would be a regression for users that currently _can_ run
> git-show-index(1) outside of a repository with a SHA-1 based index. It's
> not going to be a common use case, but I wouldn't be surprised if there
> was at least one user out there that we'd break with such a change.

That makes sense, but relying on a silent SHA-1 fallback purely because we
are outside of a repository still feels a bit ambiguous to me. It works today
mostly because SHA-1 has historically been the default, but if in future
git introduces additional hash functions or if SHA-256 indexes become
more relevant to this particular usage.

Though, I think based on the discussion so far,
we can only show a warning like this along with the SHA-1 fallback like this,

    warning(_("assuming SHA-1; use --object-format to override"));

Do you think if this would be appropriate, or if anything 
better can be done to handle this or
is it just better to leave the behavior as-is.
Let me know :)

Best,
Shreyansh
