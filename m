Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFF7470EA9
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335156; cv=none; b=qLnVccBczcFmQ2tR3xbauYMWh90tneUqKM9eyfETPXNfEJI7e91YCxOZw6xYggPr3TdtHc43q8pBepdOXPMjm5FzLY4RuOYZjZT1IWeBD+HcU8IIs5y5cCrOSHh45OitbRvNPg3JFPRwDEfQuACD6JZLuNM7LDwgoLHm2kYrTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335156; c=relaxed/simple;
	bh=71yDkMgNZNIUIlCeZY6ioM/MlkTKZsGGB4B3xsNYJPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zd9gL4zTDDnpqQ5pz/viFhynIdPCtcbbbfE/w6sWsf55qm+qXiVtDyTNlS2EJmFmUDFFq0U7oTh5M1cOnvkSNpI36B4QsOvqN8DTHRUN/KSkIUcoGfX+OFvMd5LdpFJtrbxSAiwSOnRG0G+L3mPouehXXNijwtEctyPolfr8Jq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyMRvd7J; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyMRvd7J"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so8498545e9.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792335154; x=1792939954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=71yDkMgNZNIUIlCeZY6ioM/MlkTKZsGGB4B3xsNYJPI=;
        b=AyMRvd7JL4o3WcNb0Sq8GN9bNe4dSj7gzipv/ib5mviUtbsUW4Jib+giP/yabJuPFq
         sxNnF94Wb1B+emad3hVGnk7IyX1VaY07uYc9VloqCCNyozWvs/QN6NlhvHPEJz7TkKLE
         OaJ5QmcbW7rviDPIlWkdyCSGSqNhDqthzj3922hfQ8jU7hOcUZGEGkkPQyoMfpkXxrBI
         IO1dWHlblH87/mqw+4AjX7m1kU91uM6LcQxaGh8udwl6rXsQKzMc7suGsqCqzdNM9Xij
         9jn+/6hnQ4smXUyLOZaGP/TCkW2glbDJ7E6WKBBKQe/1e5liN0T9zQjI9Y9RR0/Se8sO
         m1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792335154; x=1792939954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=71yDkMgNZNIUIlCeZY6ioM/MlkTKZsGGB4B3xsNYJPI=;
        b=qTaf+sz4KA/Tk9GMr+1r2o9hWtylxMUeFBHEkLdk0nzd0hK9OWr8lGRaqZPceL3M9A
         AsFi05ab4L9xG1t7rjEuxOXWXH4w8jIe8s8i5skB4BfKexuYaEReHsfChE+qC6Ap0qC2
         hXVSnse37AnvZz2TcHTfdJDdZUpMzUfAVH1AwdR6nWsnFvitcDuK2Z+BInEx1gRcsJeM
         5lC76aieSYItu6Iv6kq/ZIabg7vkmoyLisrFfqhuVZfOWDc45ba3Tv8CuWL701nIdREf
         6h103/lTCJ6oUFNzX5/Ncq58UrRvTmK2lmdqAU0TLRisOe6IgVrEzd6bZs9zkYl2o4f6
         tNxA==
X-Gm-Message-State: AFq9FYIjCJHeSUyMS9kLNXdxhIobk1cRJUaQFRE7lSGdhLlrt6XmT3vX
	+CohclPNpD6WzZ3l95sZ/MO+l6pU2d+XGFuMNvqodmPs9Y9d1jSWynsMEAEpga49
X-Gm-Gg: AYBFou3R4OG9nVkIMimAuCGp1iYujM++yf7tg7gM/yKkES8hlI+QLnziPtWHbn4ix5B
	ZQH7Jd/Q0NSnqpe60thCRw82pmA/qxSAOAgy7f7rZq451vkJKMIHlyFUefTTazZjj4tWyu/5p2s
	u1G1R4C/Rhq13oR9PnkxIqm1GLbt6enEuHYeavpeiyKEuNqVG0PZJB/SjePg78Y6cXnefrw/eB2
	YpR2YuY0N+dQa3CB0q1q0wIKQ6V+191yFaC7tcU/jpXbMf5qpgAwGpJyHmlBTFbMuqHK0r6zaTG
	KExnCVDSpAYNWyuTyNLL0Kouf268wYyK84CuDqHXikPwlc8X8PGeBh7rUeOpQ1m8YGvozhDPMa0
	IxZFSnJpBkiB+NQKjXYZ46NRViLL21/DVQpvxfAVXApbwZNlgRSpu2mN2zvwJT7eZSPBr1bJkWH
	ry7Xxa3g9T+cmV2P/H8S1R3Xp2tUapHcb6Uu0IiEDJ49axu/VcDex0jnQVfJhtMC6w1ktAfXv3/
	dBpsLUy+6QZ/PEb9GphsOzO
X-Received: by 2002:a05:600c:1552:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4a1d762a26bmr112188605e9.32.1792335153576;
        Sun, 18 Oct 2026 07:52:33 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([102.244.156.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a88bbsm301538415e9.3.2026.10.18.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:52:32 -0700 (PDT)
From: kerylefondji7@gmail.com
To: phillipwood123@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: Re: [Outreachy][PATCH v3] builtin/var: refactor to use parse-options API
Date: Sun, 18 Oct 2026 15:52:22 +0100
Message-ID: <20261018145222.579-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keryle Fondji <kerylefondji7@gmail.com>

Hi Phillip,

Thank you very much for reviewing my patch and for pointing this out! I didn't realize that `git var` had already been converted.

I am new to open source and to this ecosystem, so I am still getting familiar with how everything works. Could you please advise on where I can find a list of available microprojects or files to work on, to make sure I don't pick something that is already done?

Thank you again for your guidance and patience.

Best regards,
Keryle
