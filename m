Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB402C325A
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748897436; cv=none; b=PfpMks3/Dgf3yoVUfvqM4ay9K0+ebrMf7FP02VcLz0wGQranFQsWtJRJVM0/H8o3AsdtXP2tt4VLPzQEzyjxR6TchWHVU7cxtVM95FtpPlkE7qr6B7jQ0uY8hyyg6Qt7/HVGRl4prP1KDPFZscVP3LlCxByzffaKRuBOEEdTT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748897436; c=relaxed/simple;
	bh=Ldjv1Oy5I4D32xJMJdJRy1ClSVRn+GXyZOq+NOuDGLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LogfhBvy+RNHsXjsmkp33q1D26YEhx69LjP5SecatMPovMOsq7oxmZcC9XQRrWD+GBxpVruKxgrmKGEzmNGFQe3swK4LJid+KlQjUn9ihBpNnSkSfmuOU5xQmocIh6lBcPeSg6W0LxfS+6sTguDwvJE3t+ntDJlHi3utbDjCKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIaz9CBm; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIaz9CBm"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e592443229so1416946137.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 13:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748897433; x=1749502233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcNznd8dWk+o2zXuF/kLL5ggwFosBtZUb68dysseu4s=;
        b=PIaz9CBm9S5n6VQ03SwWhhcQDLMa3cVhuGxcC/5b/soKuEydPAMHiHtGpVooLygeHG
         H03bzu0k2a7OamPuu0Mpxo5Gost01L/GQ9rz55jjoBHSXvLurQDl4SSj/FimUfXVzf+a
         cStwMXgAS4tXldbZ9cW2etNF7yjeOgTxuWkCvLJbryGoVB100ThJAdD0DmgLFq+3+X3k
         Q5LhjO2TjZ4/o0gcGypBL0VTcZW2osou840u8gq0x4oRgfuExtMAoOxjdRECuUHIn2Y3
         9Ckp42/epEGCoQwobpLQlAony20DXKBna37IjO+EqvKjiYFjE2y6dEXzv+6TKKNFFS1O
         fjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748897433; x=1749502233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcNznd8dWk+o2zXuF/kLL5ggwFosBtZUb68dysseu4s=;
        b=gPH5hV/H7TkVxb4c6dM4XGwU9+eGJ5gGaM3FzVEKPl4FTWLQyXok+M8rrEDaAM4/wK
         TchxFkHSjojsi1ogOuT56hK2C4mP0b6dhUv5DnhftYI6vscvbSJLRB1pN7UTOongz7Z4
         +IYT9upTqCmHGLFbsefuGNYX/RMoSKCz576KH9foHaHivslc3ML/3a39PjzCNERvrDx6
         BswlrZoJzAEqTLWCxobOb1pxsC9qy4BKU/yDmCiyjELLLVK6I7Nby3IvVpF9oioqmnEM
         ovIchdTR2yEvQde+PgCo9HY65OInzi944QzkMEvoKdWr3X3Z2HLeNMCWXPWff7mBwvbL
         TUdA==
X-Gm-Message-State: AOJu0YwqYdY0KlkgA+FXywbsVUhFswTp+F/4MQRH2wLhONZX3+TkW0DF
	nnBCbYKvSU1hf7+FMQafTPFlDsuLeLbE/fGuWnxSsjqF0x0oF8fwbbzLzojR0Q==
X-Gm-Gg: ASbGncuBSBHiTdbby8GRJQ4l29E/3IYtRoq0jU/qVN0NZmcZRSr7gG+b+JQ8G97fN5V
	ffD4Ptotf5xIBte7XhxERvoC7n2D1NEPa+6ngAhCdW4ObByDyUwNBLqBLWRL4AyyjTX/jwwyRCp
	kzdL8z47uBhnlECWWT3UWyZtEZndFcSv/AmVGRUWndIBqEqLak2QxUNnc86uil242ouLsORrFLf
	itONIvWyur753K1XRmiwk6S3udW8k5cvSCbKDMQYIYXuVkBVYQF3VK8Jz4qRIrbKygyMtCzc+oH
	AhkqSs6n8ogl9e/B3z4HGrzPPewdCAqwp8XYsHz6TfICjjVwvPr6ILFlmx9FcpPYNj8F/Z5RljI
	MfywBVZ1qhhoME7897JcO
X-Google-Smtp-Source: AGHT+IFLmOYPWvsld2GjS5MaVZ5YdZxCHlpjdd9/rpRDqr5pZ4Nx24X9uVMVNvvVNzaZ9AnUOzXIRw==
X-Received: by 2002:a05:6102:290a:b0:4e1:52fa:748d with SMTP id ada2fe7eead31-4e6e410cd17mr12115748137.15.1748897433636;
        Mon, 02 Jun 2025 13:50:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:58:c47c:a673:bf76:10ce])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a2a1622sm6746409241.10.2025.06.02.13.50.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Jun 2025 13:50:33 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v2 0/2] MyFirstObjectWalk: update with struct repository and meson
Date: Mon,  2 Jun 2025 17:50:19 -0300
Message-Id: <20250602205021.4223-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
References: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This v2:

- Applies the suggestions from Karthik to the commit messages and the
  documentation content;

- Makes it more clear where to place the new Meson, as pointed by Patrick.

Thanks!

Lucas Seiki Oshiro (2):
  MyFirstContribution: use struct repository in examples
  MyFirstContribution: add walken.c to meson.build

 Documentation/MyFirstObjectWalk.adoc | 35 +++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

-- 
2.39.5 (Apple Git-154)

