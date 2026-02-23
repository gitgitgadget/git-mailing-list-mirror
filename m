Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5A34E74D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837201; cv=pass; b=g1BX8mTpeAm681WXDF1qWXBthrODNJlEwokT7jc1tTANxcOlwHepuLUkIwfUYww77GFETiufKcQ8Pnvs8FpRzEyhQBzyA5kJimlU/5TP9hGkUVOf9l4Y3XxueqtrLXOTx+yz34uPR2PzAnfLlav900pypgFbxhAFqZZ532LiQz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837201; c=relaxed/simple;
	bh=IrJP4aCMg/pUbxYXwsfCMWIjbqsCGYVodG6tzvJ/R2U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DX3EptJk43+rON3401P6KvUTOH8x67ynWMLm4SoZZMSDA00EpHL9V7OG+UBq/C/H8DWKLEibcKG3LQYoC066fk3/SyOtONr5OeXHPWW6RcnO19/GpqBcDq1TdF8ehZgAtVWQ11hAyo7yq0DXQgK+GtBPIsdY/eHyYsqy8TGwC1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bU9+EbLG; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU9+EbLG"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12758ce1e8dso1440566c88.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:59:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771837199; cv=none;
        d=google.com; s=arc-20240605;
        b=BRKYpNaDMYx/fDKl9HZdskMINk8M02RTTWg+P5/GnxMAn/fQ0jICnwuJx2/DJzSrCt
         nuImpdNs+AF2ecOBrLomWqSkjKa0ilTn4Hu/PVVtxpW3oxWlq65q6KskHUgLUuvgM0+e
         X+Cwhqo1cCK9ISC9LNy26YtoKOAf3lI15P4LXl93yhkPg5YnG9J+vGRYX251vEawljWP
         DdfLL3fcDoJc+FJUDO3ESwfeeqOUwHI/mVMH3UIowY6SJp0SiarlxNxsmiNvdHN/bx2x
         3gOVisjYYB280+4ZJp0ItM79DSDOX+bWOeQIo/lJri9yvs8hZwWcoFcXSJGvEtO6MTQm
         +NhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IrJP4aCMg/pUbxYXwsfCMWIjbqsCGYVodG6tzvJ/R2U=;
        fh=wsvoWvBz3+zI3cO8xbdreD5Z3aI/wpKopH/flyQpgVg=;
        b=NceTDib55IRG2Ol/o/rSEuRyfb++EaeEPyqygKq2GwjY6lVddp+MISUYHBciTpPyWU
         qJU+3ZHkIPiMiUpptlMw3c6H5Fi63pu/eu6thmAULom9zfmKKHWGGtBjmMgjcw4o07v3
         j904jgNs7gjqk31y6+7PpqFegz1cLgq0VY1IuC2jIV0wN56G/swPcsCg53xqBDM0DsoT
         xgltKPOypTwRv8McX5lmCZ1MZzP8dNnd11RIOzQGJa75ROxQlTSCzQSe/cblR8KyrL/1
         8tb7gvOBJu/B7qPMGohWvQP7rbN8OsgLd/h5l2zIY3M31zE+w/TbBBz9w+CBsefBahwA
         74AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771837199; x=1772441999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IrJP4aCMg/pUbxYXwsfCMWIjbqsCGYVodG6tzvJ/R2U=;
        b=bU9+EbLGZmcJMc0/7AgbEnskLN5Hyrh0/FU1OsnbArDWpiVu9N8BbnrEYCXUjNBlan
         fXJTHGRFdmBE3nuq4gyBCwK+MmHQdtG/K48rPBEN7H1vNx6nWNukioJnqH39q7kZmkWO
         a85dG4gQ5AF5MuhV/cIYA80i9Tb4hGPWIzXqgvix88DEerU928rTrl4HNY+/ezCEWGUm
         V4E90C3+emd7IOjWWDN56532FzEM2fYc4CGfWaMZ3aUHCXxRgbul6qg1yKd+w+yfN4BZ
         nKt+k04pICEGt17kvgzkEm1pATyT8Q/sjGK77mdO3ulsGOiVoZa3b1mx567J8uqv3ynl
         FyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837199; x=1772441999;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrJP4aCMg/pUbxYXwsfCMWIjbqsCGYVodG6tzvJ/R2U=;
        b=cIs/1GlxDE82lGQ4umKSLpr4L09Qid2tY3zgKPA/0Huh+kmKHh2+n4I36oRZn3ZESP
         JOBV9VxJW1+oO46kidZrpECuD36y4SZJPGrTotvNBu3ymmn29dn/kRUw+2cGiFw1BvkC
         SFCQRwXs81oD/l5XST24fKOTGsSmhblodKyzGthdnsAFzzA6WQWIpnVu3coj0GzwBdaU
         jP9VAJfFngwXmczrtEKN9g/64+TsOPf/ewBtD3K6wWHuIlb8DVTksxetYKFOtJHwDdtN
         BKW9E0CrOUGBwdOPmECL2jzjc1dqpcmPXnOtGW1VgJ5JQxwReiJxFTToOmMSteJ9wMmb
         hEsQ==
X-Gm-Message-State: AOJu0YzSj/LUDPOnV0C9IZg4SciGPdTuGiFbO78F2sQrFADuw09x1ygp
	YlblDFIHrMvJSFGNq8VH73N1UxeBnxBCzuWlFXqhqAaANjhPCCvowNpVP8TXfBMPeQ2/PLIO/Fk
	EqPWnHEHqLOL7876EyvCydDNeiNvcGes7RWpQLdc=
X-Gm-Gg: AZuq6aLICLI2a2n6xzSo+CUeCR2K15HIDm0HugQRIxCIMrQTnigAH+j4G3Wwbc/7uFD
	i8VHuoXbYDZgU2vk1pc7k4NuDws/BsqhHosHTRJXBQk5zFN4bU406aXHOzK2AH5Li4nVec8DN0C
	NLNa+7o/bnRo0KU/ujts7azoHiH5kR/WKIB3DOl+z1FZpoXk2lZ91ISpzWH0PDs7zPO8n0wOyFd
	d2jlRjvzlTHxIi+oOugtr0jYLucafUckNp2n5KxrpqSn49kKnuIugHIkL/MQf2DscfBwluYgKGs
	TJ/bnpOm02NpfhRHdFq+v5tyOFqrzxH4WsiNgVnd9SCT
X-Received: by 2002:a05:7022:2521:b0:11b:9386:a3c8 with SMTP id
 a92af1059eb24-1276ad8bb87mr3748579c88.41.1771837199009; Mon, 23 Feb 2026
 00:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 23 Feb 2026 09:59:48 +0100
X-Gm-Features: AaiRm52BQf1HCyz7SZ4dueXv-4TSNcLmk3xnDMNQmnemza9KCY6r6E1J8q4sx8c
Message-ID: <CAD=f0L-X5r8nUeY1Zm-kpjw1-kJa9=U5qX==dn-Y0H8zHFqOMA@mail.gmail.com>
Subject: =?UTF-8?Q?=5BOutreachy=5D_Blog=3A_Refactor_in_order_to_reduce_Git=E2=80=99?=
	=?UTF-8?Q?s_global_state_=28week_8_=26_9=29?=
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"

As my Outreachy internship progresses, Weeks 8 and 9 marked an
important turning point in my project: not just moving code around,
but confronting deeper design questions about how Git should behave in
a future where multiple repositories can coexist safely within a
single process.


I wrote about the lessons here:
https://cloobtech.hashnode.dev/weeks-8-and-9-initialization-defaults-and-designing-for-multiple-repositories-in-git

Best regards,
Bello C. Olamide
