Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E7C3A1CA
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747596; cv=none; b=KlTopAo/ryvp+YpMzNE1hpBS15jg1nwXmBGhOrWUJ2sG1Nso/acm6ksftWR/lYqm1BBn1QZgxrPVjoeqTKc4PKnQyecCVkLiGofb+sFmVAVulETzippgWWn+xLtk61Qx3FOu0O+ynXZNpHvWPIhhc+/LIXrYgv++OwXX57iLdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747596; c=relaxed/simple;
	bh=jvpZwk6m/wEhkVLhFZFN4LMpbLcmmdbm47SWzObjT2U=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=jkh/KOXol8vSx+C4ILdeB/R4VOsrcqqyUCDpzV5L2PGkbuovHHc3DsbaBRHR9ZNSIjAaKR3iWek7Mwwaa6AY/HsbaK5RnxRv1QVZ0PBZs2gqTmt4nfmOXg6R0maQaMQYidEmqbbJSlzUSObbBvZDntkKVLv/GrvqQyTPtRoMb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK3Rf6Jh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK3Rf6Jh"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51167e470f7so3883354e87.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 06:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707747592; x=1708352392; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jvpZwk6m/wEhkVLhFZFN4LMpbLcmmdbm47SWzObjT2U=;
        b=mK3Rf6JhGtzWSpr3RSCaBC4DNkkeICjc9N94mkNfqw3jkepboLU+zE0KI0rs6af8b/
         uPoMpkABbJ5fUF7dweVwJ0lAtDFoktEShY86uzZQp9pxCYquqI+0DjaKfqhhYYZEYx9P
         QF2P44KEFrbEb9NFs2D10WbbGk0qxc2VRRr+AFpWULAKWPGKxbDiuxCSVdSNoycPHtTC
         9jySMwTBYJfVUbrh7u7jkCZWGiWOsGwTnG/pm5JbRhtL0/1L8YZzb3HqiKsfEnl7MhyG
         F925TA56S2EZ/mjfnEb0YiLVYD1f2dUjY8V+jehhDOoun0WidyC+Yy0RbGQ85NInZgj4
         6dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707747592; x=1708352392;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvpZwk6m/wEhkVLhFZFN4LMpbLcmmdbm47SWzObjT2U=;
        b=QNK3Wc/vx64klOYti67SDf5svZT6+6grs5bM5/icmvEKOwZ2XnHZSy1KgusX+rjDad
         Mxeu/AWxWlSOw0aw42B5SNvY9sCV0pOuMZz9XXWZKDe3rA2UJbz3a0KfFsb0r8XdVmJ0
         /o9+41jW2fIIkgD8TRoDtFtQw/JVYngAYSVXtkG6fN3zP4QXPXnSxo+ps6e7QjAHTTVP
         cOInuJrGHoXEoGYD7dE06DtxCyQ/ngCnBrL2XioWFkWcoePwqwaO4J3C2+35lHKIfKAk
         S1VwcjRUxVIKKXVCizhW0U8VVVNMpJsusmV65vB2kU/VFD/7v3yuVA0Ug6AxN1uwN+31
         MqKA==
X-Gm-Message-State: AOJu0YzH2p0WuoWz8bedorymZUFWamMBY0RWI/gwNFKANqlB7LFgWXNE
	U5L5GlT3hLJ10bu8moStqplCOpt9ar4Qwlnr47rB6TeXTK23+YhtEKV00lrw
X-Google-Smtp-Source: AGHT+IGDnexXHNbJNMxjfkl5pQPOrEnwbgGqPWz+cNjNgSu0a8A8KfI5NCDD3BRVBGkTQA/GnaZlYg==
X-Received: by 2002:a05:6512:3256:b0:511:8dbe:4339 with SMTP id c22-20020a056512325600b005118dbe4339mr1755985lfr.27.1707747592480;
        Mon, 12 Feb 2024 06:19:52 -0800 (PST)
Received: from DESKTOP-MB1G5MF ([39.49.135.25])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c470500b0040fdf5e6d40sm8919120wmo.20.2024.02.12.06.19.51
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 12 Feb 2024 06:19:52 -0800 (PST)
Message-ID: <65ca2908.050a0220.35091.a320@mx.google.com>
Date: Mon, 12 Feb 2024 06:19:52 -0800 (PST)
X-Google-Original-Date: 12 Feb 2024 19:20:15 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: gonzalezterrell618@gmail.com
To: git@vger.kernel.org
Subject: Bids Take-off
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi,=0D=0A=0D=0ADo you need a reliable partner to handle your cons=
truction takeoffs and estimates?=0D=0A=0D=0AWe are the right choi=
ce for you. We provide accurate and timely services for any proje=
ct size and complexity.=0D=0A=0D=0AAll you need to do is send us =
your plans in PDF format and we will give you a quote.=0D=0A=0D=0A=
Sincerely,=0D=0ATerrell =0D=0AEstimating Dept.=0D=0AClassic Estim=
ation LLC

