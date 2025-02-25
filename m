Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5235B211
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453943; cv=none; b=JIMzyPBMX36XmE3nfmSsN+SPNifU40GYZ+hwNHtKURiFaC7rS5E01aDCMleSy1CPKonlG86Zy7/B6UxftG4z3UtMPNzbv4NSOlzXy3cvQJuJOYbq36SF6dJCkDZBCIWShC5xSWZSW+O5Ef7FhI+jNmqQxYjm5gQBDr5VxCcgpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453943; c=relaxed/simple;
	bh=41+X0B9AqvQopOkpquNJ/G+uyl3h3csj0O/AHpkfHn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azrV2903Yrl7kA71CTuoV/8Pat5wzLQWbhFLLcXRQ1iUkQrNI+tf/Ew+WittjGWyBSpLdPu3CsbwgXYa0XTDQe8gwu/7uN4yum5kzKZTpFQYnWvi19wG5nXPovQZx3l1OBKFJdT+xa/OQcon7pQztvHGymdtjFk4Rpn7dF/grYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+xjF5cV; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+xjF5cV"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2211cd4463cso102761585ad.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 19:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740453941; x=1741058741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN+nqpSFVcdZp7hwjP20IY9YQz6BO0mvn7CyKut1d34=;
        b=L+xjF5cVXln3XFnPw35Okx6qyPMIGAA6PulpJhhOoaLdXdykJvE2P8WffaKJoEMALv
         C/80eW/YOEQvZw9zDBlgXp8Krr7X7R25w8HfTu9nfCWxjWVD1rQFaO9mVz5KZobBVHMP
         TTG6dToBF987H5Sq8O3J6OmEgeG4cy/9rJpf0gbqu2qcCvrG6H5yqOKDgexhCtQuX3GH
         3F22Ke/QXl2+vOKsYbCCHQEC6qa9W/KxyIDIu3aCs4IW1wYH4LmkT3u/ZJTMlrWT6q1k
         qeXf0F4XahMv0sveSarj5X+yYVyHQsT7u9kpHO5h74fik87r4Mv+zz445ZYmeRAJwizt
         2k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453941; x=1741058741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN+nqpSFVcdZp7hwjP20IY9YQz6BO0mvn7CyKut1d34=;
        b=W56U7xN5D1Jc+PvxU1qi4vRCU3V0/LPUvoohQGWnL3U39zhyLzqNlUzYGbPFC0zwUS
         o54QWKblDoSVYvE2/0OXHn/GI+on5DLOdK5ehr/hzldFsgbZUcrVxnD26EJAGFpIjDS6
         TD5bOI8f+X60Ghpvj9Idb5lyZBDjCg5mqkBRs79izb/uEVfYF7HN4uVsA0sFyubJI4LT
         N86MIwJocjc+q7pIh9/4muxa9v6g8G3l+y0wRF+fWYrJjAMBlH8XJ+rZIIYDZBEgiNkB
         SM8XZxqRT3ZlJskC735z1Jf/g/LHPBdLyfC70GSNuPUp94uK1pqwH0ad1bkPMEqmuSxV
         SS8g==
X-Gm-Message-State: AOJu0Yxp3ceICmGrJr4lDYMqitWj0xmPoBT/WuCoJiAukoRTIXBMvQtS
	SuoSNZ559Ed9xkJiSfMNrSanF36D7X9S6znQV2Wl57Il2/LZpoFB9vQOCbCGU+l2Y+bP
X-Gm-Gg: ASbGncvC640afkpaBY78hqZ5U86rS3CF2UpcGX+sHofn9gG8wmkF7iQIIHm5uF2h5nA
	QVq07cRiTSlKdV3LdB6K92DcCnqcnBs+PupRRVP/XSNzE1umNY3O83v0Uh94WeERW/BZu3cjmDD
	J6+dtXfwfl0l3PI8Rl+35TzMihRivz+QQ23MjmrhpsDeuFLPLpiYGyL/w33nYcWIz4142yvi1qO
	EaUOiWGZCRVMKqyHMHIsMW970JH98GEtHP3rGAWFqaznHaeodtNUbtBf7h8VheE2fCUfYRyeQhW
	KUWmGSi1qmyaPaJ/53+YnKLkju/KngfElLu4Q+0r9eGMVpZmA+QYh7Oacg==
X-Google-Smtp-Source: AGHT+IFIYMgimZqmbUmpwhwD2s10xfGs5wtGMXgCutyaIDZuBnM6D97k/MrC2Ww9odFUEagfmuV4FA==
X-Received: by 2002:a17:903:2309:b0:215:19ae:77bf with SMTP id d9443c01a7336-22307b4c076mr29316875ad.19.1740453941198;
        Mon, 24 Feb 2025 19:25:41 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([2406:da1e:aa2:5300:6c7e:7e54:23f0:7375])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a092f0esm3621815ad.153.2025.02.24.19.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:25:40 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jelly.zhao.42@gmail.com,
	karthik.188@gmail.com,
	newren@gmail.com,
	ps@pks.im
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
Date: Tue, 25 Feb 2025 03:24:44 +0000
Message-ID: <20250225032444.9901-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqv7sz76zl.fsf@gitster.g>
References: <xmqqv7sz76zl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for explaining. I'll separate the desired changes from this patch to 
another since the topic will be different.

By the way, should we remove the idea from the microproject list now that we 
may not want it?
