Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3336A3672A3
	for <git@vger.kernel.org>; Tue, 12 May 2026 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616124; cv=none; b=eAbLDuMlIL4nA0/MjrLNAWXZuRTq0aJr39aghqLbP4ilBFBiMPEMtiMD3K7/7PTM5LK9saT11j8DUrzZNNXYdphrIBlWSCJ/d36wHDmSyDwz/PI70yTm2LhvrfN77I+yyPjPbq+S1Ij/ZlZgHDwaV41SL5eitdUP1rpARpiggf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616124; c=relaxed/simple;
	bh=zuU3EULCU6USoMdK2MTGHaLAUrarBylSca7NnjVzD74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWCZFlbroJBoax29oah4HE/Tf/t53xjps0HYjYfcvufQ6bHPPwN4xYRfIBsZF2X0Y5eYveUtVgwukoJX/eYae+jTlvgKRMIS0riqnTkem/0LI6XtkPFFHTO4xfdc2OCjSvbKJrQoDItNGomfklTGrXNX3yLbDJipt5myKYS+U0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epEWPXsR; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epEWPXsR"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651c5d525f6so6672632d50.3
        for <git@vger.kernel.org>; Tue, 12 May 2026 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778616122; x=1779220922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuU3EULCU6USoMdK2MTGHaLAUrarBylSca7NnjVzD74=;
        b=epEWPXsRWbX3M1SGuN1Ln/doIeJd1snmPOaiTsoSq/Z4jhzCefwTWixqpxdPjt33MH
         i3sR1DA7ZdCnsxLHrF7Va+Tn6VbCHRbmK1mbJOxJUja+ycDg15+w401fmMz0NfX+9G4F
         TCNpt8t3wqLx0AMtNfP2UqOwlhp9gxvwSYh5oE8KHCeiQDW3MJ53AmZptNrbLd2EJR8p
         BtixTNSwNoKyzVebZ2ioGdWTsBeb5Map8w8xtCW8xgiOTA9Kojp923mi1hoamLhZVcMq
         Fx04LowXKpCloy+mF1jg5/+452VNrsuCp+QUBWdygkrze8cL/Z1xg3ETzZCLzrBdu8k8
         vEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616122; x=1779220922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zuU3EULCU6USoMdK2MTGHaLAUrarBylSca7NnjVzD74=;
        b=WtXZ2K0nQzgBDz9j+oBUEYr4lwBytd/283TPH/Y8qp9ArJK4wn7qQzu6vVRjD5EL1x
         G7/feMQ+PnxySr02Kjs/wiiXewJNNiV91ZL7C9AqjfmCkq7Wsjz79d+RbdFJzQLz6h+m
         CwGNKvxZeXrfvWYgjbPyu1SIvp4qdRrUprjOLfj9dXaf0amS6hPTXNFI4XVe6DbFyzfX
         BCTAdA/VjvbdD+yBlY7okgGSAJQjFmf0E2Jtprzz9cv7BRlUCWmpnSv29TA8YqhT8X3q
         zr2ArYqpV7FJbZFszWMmQ0i8FakWDmScY6srFzDhyUOh+Tp0SoGTugI6+Sji84yVyXPV
         ClJw==
X-Gm-Message-State: AOJu0YxMj2hEyIMmGXj0fGv54fsjEbnIl4HqWHFhyVPWt89YWadGlTiW
	52Rwe+0eHLWizaaJIS4gajbbS+PTi23acrJ+jeQVwtU+IXl2BjqSepawRKWJ7c41
X-Gm-Gg: Acq92OFqIBGbrSY/gHEcAt5Tnq9LObju6GtKEPEDnxL5DBRV6+H5Um4Iv8/6jaqgWWm
	C+ZVF1fx1oOvfn93YvEjBDGFLYhU86dvTltbg15jBPx7+CjeqfEj8KDP0D1EPNbt7u10jbPiaYK
	8rrGdz/BfZB8V0qGhdoICgs3GBmenyq3eE8yLD2TyrOVLmQbL9WXL8XdknceRnr4X8FLXnqtyhB
	pqV5K0tOXqWtIbX02bvORnwVm/0XXNmdFwaMtzrJdzPGeoAHdjk8Gb+zCMPt8cZhL7nE8b14qB+
	XffKuHlu0suikYNE5K10tLxNlKEpz2ryVeg0hhuzMc+l2M4sZO9NtHDOuYTzk2KB3V8fFB5JzCB
	u7ulb9BHWGysxanZj/31GD+PireHHHNidpaiXcdZZRPpt8ZYfxbjWumkfl9HU/i64b+njvsfJyw
	MG1ZuCTJEh22ec+N5/e7h92DGw4dhJyI7r46nmvztHPtaBfrNuQOlesH5WzdQiDnCFAS4eOg5BO
	OMxMgS6d6+SSZ084uOsQ0w=
X-Received: by 2002:a05:690e:1509:b0:654:468c:7dd5 with SMTP id 956f58d0204a3-65df633c8a4mr353684d50.33.1778616122117;
        Tue, 12 May 2026 13:02:02 -0700 (PDT)
Received: from alibaba.. ([129.222.206.134])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96a67a9bsm7423765d50.9.2026.05.12.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:02:01 -0700 (PDT)
From: Zakariyah Ali <zakariyahali100@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v6] t2000: consolidate second scenario into a single test
Date: Tue, 12 May 2026 21:01:40 +0100
Message-ID: <20260512200140.1016654-1-zakariyahali100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429103607.406339-1-zakariyahali100@gmail.com>
References: <20260429103607.406339-1-zakariyahali100@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Junio,

Thank you very much for your patient, guidance and feedback throughout the development of this patch series. It has been an invaluable learning experience for me.

While my initial goal with these contributions was to participate in GSoC internship, but I was unable to do so this time, however I have found the process of contributing to the Git ecosystem very rewarding. I am excited to stay involved and look forward to making more contributions in the future.

Also, I am a software engineer with over four years of experience in the field. I am currently seeking new opportunities, specifically entry-level or internship roles where I can continue to grow. If you happen to know of any openings or could offer any advice or assistance, I would be extremely grateful.

Thank you again for your time and for everything you do for the Git project.

Best regards,
Zakariyah Ali
