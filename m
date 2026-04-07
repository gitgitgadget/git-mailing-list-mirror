Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D54D3A4F3B
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578868; cv=none; b=pNY6hcvgrlegGvlEN7tMBc1cG49nYDEvJUDGrn1jg1XfNSIDCk0fLSfRlsxP+g5xwIYAfkIuGPfIdnuvLmlYEI6VO2AEIG+ColyMywQuK2W8tZ+Ust0jQ8NqER1EPYbY92UrHc9q/8/PfPSF4Evc+N87oq/G7jrS18FwSjSsc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578868; c=relaxed/simple;
	bh=Sf4xUJ/zP3MfqFatmoIlAHLDXNwErmyKIVuFbHj6iJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXJB3R89Opdzg5DUq8+5UI7Cifv/2VB+PKcYnXT3PJafceGB9HPICgLrrQIg5mbObWPF+UcZF72IApffKGlTDo4mYMVoLxt5PHr4MmqkdA8r6eRTBYHS0YLUpE/KWSOVF4OUPgniV9WIrc3swgza2fcFwa5vkOzVHaohabo4Q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afrq8Gs1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afrq8Gs1"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso3023886a91.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 09:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578867; x=1776183667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=raX9M6/8fb+roopLtAcTqR32hFDYX+U8OBozIS5yOHw=;
        b=afrq8Gs1Ivjk6UOaD4AqfPCyQDTcJ5RXpsYcV+WgdMDmE9rRFnPMEf+P4dcTZDsRHI
         tj89UFuDd6B00k5CB6eYOzj1D4PIgBCqWfWCs0F5QqOhHHzsQRnQsGWD/Q/JILNsdeHj
         4M2keU+C1OYq+eF9vM7c2Cd/TxaKWqu7HQc5uys4pR7elJ/6x47UAQpDOGwWBGE7kBZm
         74IvZ/PnRN3c7jYSlxAEXvJEwIweX1OvLX/pQpph2rrdTCG5kKZDArr4Z5flICU59I4I
         T7Rfsx8mF7p3N62hHGl3XJELnDHzs2rAXEY91eBni1/nIPugxgepvMNBPApNXZE3WFNl
         OF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578867; x=1776183667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raX9M6/8fb+roopLtAcTqR32hFDYX+U8OBozIS5yOHw=;
        b=Ty7davLLO1RCfSoW2cQzt5wkB40GY3fHn8msKi6J9gRg0EZ4Ty+lNlUQIU1wMg1309
         4BYZEF4TFL4IEH0XF7gNUBW3BnoCowP16OQEtx7dt4Geg+nIvXV3VCqzxO4Rjxdg36sv
         67Q8g+rZoZ4Ikg1I33vxHR6ckS4Eap3Man61cqXwuwrkxgChAUBkDAnxRlhWRJyQGMj3
         uqAghPAqTvpm+xyiKxF/c46GEK5FFU0q/jb79qWUkx/FxkJUfER7a750yvcSX94CfcJJ
         LfZdll470YU4yQlKDEKIx+pn/5IlUvZJ+vVxBJFOccLc2NLM6luPVqGxN5oXdEQFr16N
         eIng==
X-Gm-Message-State: AOJu0YyidvxBHmV2ZQA03G2oGMhVj61v26Qab+VrdKGzyV3aftZxjyxv
	PyAMY9tViRka26xHKC7kPsekPeTQLQxKl3ZewxmXcd8oDw6YyBe+I3i2QikC6g==
X-Gm-Gg: AeBDievs4govakDtGEWJQrcdILm2E6FOOko8xfj9I6lKgpB4NBWQ5aLddaSzirJwdpl
	SSNwhMe/8BYoRnHmyN4Y5vXwL4okT7sbmpQcIXy10qfyme48zvpLcsP9uzZYde8nh7n8YHGnLTh
	8OEJoOf5HX7zIu1qkGBjPQw0q6dzdroun9YufDCxIeuTSmksUw7HF0yVZG7CzLKyz8+oewSL9pM
	DhP72XFELK5kO/p85WoUYkT8dutP+xJA0EKh7tIHxlIrrLxwuEvYXHzDMn/AlFW1wOe+I1nSndU
	Fb3Jom8N0bd8cSQI1y1ukCRNTkVUQCuZRs4odEINN4P5pkakVhlaa1qwZbvBX4lPw01ms22ezP7
	G4cKJ/0PAVPN2S7fMA+V3Wtz8QO8PwCBZgKy4rauUnvVPQQHCs7AkaVvdXx/uEk3wlt0J/554ji
	u+tyxGLPkr7TLxIP6wWkZTkQejmIIbwXavGhnjePuZgqBBfw==
X-Received: by 2002:a17:90b:2e46:b0:35b:96bb:47b9 with SMTP id 98e67ed59e1d1-35de68d5e83mr16060267a91.19.1775578866505;
        Tue, 07 Apr 2026 09:21:06 -0700 (PDT)
Received: from Pushkar.localdomain ([49.37.115.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e27ad5674sm9519a91.1.2026.04.07.09.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:21:05 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net
Subject: [RFC] archive: behavior of --prefix with absolute or parent path components
Date: Tue,  7 Apr 2026 16:21:01 +0000
Message-ID: <20260407162101.2285-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0.582.gca1db8a0f7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,=0D
=0D
While experimenting with "git archive", I noticed some behavior around=0D
the --prefix option that might be worth clarifying.=0D
=0D
Currently, --prefix accepts values such as absolute paths or ones with ..,=
=0D
e.g.:=0D
    git archive --prefix=3D/ HEAD > out.tar=0D
    git archive --prefix=3D//// HEAD > out.tar=0D
    git archive --prefix=3D../../ HEAD > out.tar=0D
=0D
Upon listing the archive contents (e.g., tar -tf), you get entries like:=0D
    /a.txt=0D
    ////a.txt=0D
    ../../a.txt=0D
=0D
In such cases, tar emits warnings like:=0D
    "Removing leading '/' from member names"=0D
    "Removing leading '../' from member names"=0D
=0D
This suggests that Git passes the prefix through as-is, relying on =0D
downstream tools to sanitize potentially unsafe paths.=0D
=0D
From a user perspective, I was wondering:=0D
  - Is this behavior intentional (i.e., leaving validation to archive=0D
    consumers)?=0D
  - Would it be worth documenting this explicitly?=0D
  - Or should there be any normalization or validation at the Git level?=0D
=0D
I understand that Git generally avoids enforcing policy decisions in =0D
such cases, but I wanted to confirm whether this behavior is intentional.=0D
=0D
I=E2=80=99d appreciate any thoughts on this :-)=0D
=0D
Thanks,=0D
Pushkar=
