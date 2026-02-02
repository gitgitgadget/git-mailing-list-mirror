Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86242D23B6
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770040024; cv=none; b=HRIT5nxMQkHwSchN4PkVjC3I+Q2D7+YqQz5BM6ILwP4zgxjYIbHalkksMDfWf7q8EbjbmjsM0KVT2EyQ53zVd1/l2QGut+3l9zCscQyLClteRf06mkty3CoiCJ/4U1/P5LUBl3Mj0+ogx5w58QjXJWLxilOn2GLFGVHdkeNeC/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770040024; c=relaxed/simple;
	bh=3/sXDUgIXNOSzXKgJf7kzqcbRI2nViO1wuMQO6SKp1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPITgfE6FfkF8Ds1UiOfVmTcPxl9wHchtrHOufUBqMiqPVe3jLDGL56AJLlBdfVIGV1ZygxeTJ8vjgMkJSRWHrX9QT/gx64RTUeWC3KsvFtOWTqSCyDEa8sQpsXDAEjE7lRoSbClvZr9xHwDGguEPg9CNPxGViwwd2Mx00RAbTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZULyI++; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZULyI++"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso2312983b3a.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 05:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770040023; x=1770644823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/sXDUgIXNOSzXKgJf7kzqcbRI2nViO1wuMQO6SKp1w=;
        b=PZULyI++FxHmgmIaCiqABqwnUWHg9+PoZtbKAUEPUCEtGNK1zCUzAaGn3VkvH5DUGG
         O+Zr8Ttc3UhHLxc5USmKRn8Cny/4+VDkOxkzbrZilvb2vdoo8rmudPXlqEF340KU3b4r
         Cu0GliGm4Gfc8TiHhsO2RMrA/QJ3UjFBNVtFOFxUNSMIlpAO5/l9kKkxW8jjzm59jXuT
         tBieQdrpEovZmDLAW/ZJ1QUewSila+WgTl0m0N8oiYQcKYvj+jAW9JyzqD69djcD/ber
         ayZm8Q4Zf04YgLSvFCbX7mqCEjLgI7uNPiMSpdytqyt3XIzF1AdUcJ/gaAKiSICufc7w
         +TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770040023; x=1770644823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/sXDUgIXNOSzXKgJf7kzqcbRI2nViO1wuMQO6SKp1w=;
        b=fVPsdie0slnDtqilUyFGNHH3FUwz+YHXkvaV01/NMtUFyrB9bTT6UNkPQGDMRN/8on
         mbSASS2eh7pyBRiY+gkvdatMVcFKNjpFSEoTPxC5trhPibxyLkAzhg8b5ZUDY3cm+s82
         LkoH+MHe3Qcrhe2qDeqixqnn4ryTF5FgTFOFXJhJa8WINgZgbfEsua6ef6AX/LsHAQf1
         uN6QUXKYFbN1WMKt3ZKbXrX8R8A3jvDAOBmseF+lBZEXClEO8zD0wUJFj7NT/yB6TuYW
         7h+xRIK6CgQL4knmQJ9s0RJAvQHr7+VbW5OvECxcRspGDPSLUITmwcdFiGFPrT7Nk8c5
         R/eg==
X-Gm-Message-State: AOJu0YzaKLCYY4enI31lsxPuPVsNl2lDWicJAOBa0Mfo1/29q40HyCr+
	JtGUDKh7m87Ps/LO1z/JGmb88/hVAPXhC4l/favDK1zLhIiVP8gB5V3n
X-Gm-Gg: AZuq6aLUfs3rxb7TxsPDyLsALpBOd7/a7tpnTEhyf7khs6EpzCBpQGLbBlKbiIveuL/
	BoskYsmSxlb50H+qHCxg1JBr856uQI9ck7DiwznIODXCjTnD3ReqDFYmlROFVgAvH5E69Ewx3WE
	5qIUq42+l6h1yCwyYYAf9ZbLZIFGwYPCFnA+WP+hMtAA/2LwcSxUt2nON0AnCwhiqVKKZ/rUO33
	FepmMP0K5mHckKiWBWT3+/ne8pJ2qY15PitWomlswyBihjaxtaohGz5HFhOUZfyYJPVzXRJuk0q
	6RKomDlSfmHBjCfVrOmrtclHPa2+ph65S1qnYrmLu2SYisVMhTOlcX338XvP0yBXVgMsYVnXZ3E
	U35QD0wGwen82ATQnMakXJO0A0Ho/4viWc7LqXJl0DTt547qfx+AFhszn0QAlsE2bVSz9N+3PsD
	3ysBJXfMK1mpe0Zu8skf1Yz1h28AVsfkf6ddbRbBqkHZA=
X-Received: by 2002:a05:6a00:244e:b0:81f:23b5:dc33 with SMTP id d2e1a72fcca58-823ab69ab54mr11071567b3a.30.1770040023044;
        Mon, 02 Feb 2026 05:47:03 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b4e96dsm15778973b3a.23.2026.02.02.05.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:47:02 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: hoda.s.salim@gmail.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [GSoC][PATCH] t9160: modernize test path checking
Date: Mon,  2 Feb 2026 13:46:57 +0000
Message-ID: <20260202134657.15320-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAGT0iKRA++yUcCxyRLZN14jLV0xNVSXcKr=F5vJ48dXVEn6PQ@mail.gmail.com>
References: <CAAGT0iKRA++yUcCxyRLZN14jLV0xNVSXcKr=F5vJ48dXVEn6PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hoda,

Welcome!

I took a quick look. The replacements with test_path_is_file, test_path_is_dir, and test_file_not_empty look appropriate here, and the patch itself seems straightforward.

Minor nits:
- I noticed "subsqeuent" is misspelled in a couple of the existing test descriptions (not introduced by this patch, but might be a nice follow-up cleanup).
- You might also consider dropping the duplicated [PATCH] tag in the subject for cleanliness.

Otherwise, this looks like a reasonable microproject.

Best,
Pushkar
