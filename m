Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBC309EFA
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961803; cv=none; b=kffqeNPFY/bWtWQA5JfKZbxhdSzw3/RX0SgPvhep8LqTVaFOuzO1OOSBLInfYCp6ZL5GLN6SJQ1aEEvzf9Cg7N2f7fRhVbqEaOUjNvs+XDhSzYJqebOmK8n0z93aHyUHXKmx5qOHfso1Q7nLs+t/BsWdY49sv0ul4DAZFwiDDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961803; c=relaxed/simple;
	bh=wZ3oXzeB7tbLCrFO+9XFesNoM22ar5oqAvuniQS8sOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLgLckD3p03TPDjT2aRbl3tsTPYgtzjThT44ztm2vr5RhiY6fwYhPdTTAxHs7ldzOwvwq0voPOBWq/qox8oEJ5BkcJ/wRd+Gcqw7cwdtwt0S+vxk0opOnRWNrn6gPXJuw+464/BmAspDEdrIaUb7el5bJU/TsRwK/njB7k+rOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsIy+sbu; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsIy+sbu"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59dd54b1073so5682826e87.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771961801; x=1772566601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZ3oXzeB7tbLCrFO+9XFesNoM22ar5oqAvuniQS8sOk=;
        b=EsIy+sbuEnp7JAxjukpkp1TOkN6ox+rIGZhwYwkE9ZSwcRyVjqgwLIFdE0xtR+qlVt
         slmdEL8biV8GqRvnSd7YNnfuo0gUe5gTqPbdqUJkNXsGc+3oxtFOGrcPHbJ2/+FIv2ng
         02agHqkKvwnit4Reop+wQJNH1nbWs8r4AciwZK5yZX/nED6r4eVf4bl49+gNqAkKvFu6
         4e5ba9VdMeUnByDoi6g9BKeJAvSqs81/47pD80Lq5dGTQmtfVW3AKRL4m8rp3v+3KYN4
         0gy2PDoshkPZAHwLz9o+Xd0GHZqhjf5IwX5JP5AakocSCcxszeOYMLlANqxF/U0h8IU3
         wSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771961801; x=1772566601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZ3oXzeB7tbLCrFO+9XFesNoM22ar5oqAvuniQS8sOk=;
        b=a3VcCz0Zns8Bgfh+LDasq7Xt5Kz3A3e5pIurfdE+x9cW3DyOyWyIX28udnEqUik/cn
         BUVAuTQoKzCHv7qdbQZViCTRonaXwwrJcKafVwsQLYCKdsmYtZERFlpUgCXS6mpiHtxg
         I/+Bzokg0GctItSD4pmwrWNSO6T0AMN8FoGwjlWG3529KPhT5zPRGnXE5FeqHhC+jrCS
         aQ9Vafeuen7eYoDdfJwDy3rmiHPSZjAw9dk2m7gby/ta5NCk6b3XWaRbIzsNHfNhIL56
         yFq5UTEnDQSkr8+RY+qrZdD4gqmFJIe+lToE12+MHd5Qak2tAN4SPpOijWYZeNU77PJ5
         ROGg==
X-Gm-Message-State: AOJu0YzMef7hdEFArzIp3HR03p32C5wLHo9zo/9BQanuuJDmuyfno0eq
	pEp6TyxtO5oYgbBOH2eO2AfL8v+rtOMHy1HtvynG8rDNVY8y4AzH5Yk6
X-Gm-Gg: ATEYQzxEkNfpWaR9qmRDDMgojnEyoK5iohtUciidQ6lXOdNzRTdLPrGMzuSFHFXiA5/
	cHNCUVmgDsw42zOdL0KcGvp20ZvjbE/Ffo+3PNPENWuyrW952WuM7jvWwDeJMUA0GKNbKE4MK1b
	6jPFJ9zZsPkbEYXC4BJoQ5WaIY2o88EqYD63WFWMd150XlQ5rLMWwhnFn/x+cvw2oy2JXbh5YeV
	AUcZM4ILGCN652epNoyQwQA41NsfkcJ8kvrxu2TSjlwV8B1T8yF2aFULc8AZb0PI7k3SBKDF+e8
	XixQR25UhyUjG+XPUStWFxMR3xZzCjnxaOe+2JDIh+hVvTp8iQvc7dSR0uJBICQKVZOhZcTDKgT
	nKhK3R2r2b7R2D220zucpGMLm1qrSGkXo4+cg/Xii73Qa+hmTcK87Hh6rDb+xYlBmNxYJgqDo9y
	1YswyxZzlOLSv1QNuWComS2UX7EVEy0I9iy6wW3YYGn1yQxN7RJeGZGO1s/1/Fmm+4yWs6TX9Xm
	gBQk38p6OQzWncu
X-Received: by 2002:a05:6512:31c6:b0:5a0:f49a:3534 with SMTP id 2adb3069b0e04-5a0f49a3581mr2134278e87.46.1771961800465;
        Tue, 24 Feb 2026 11:36:40 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7878d59sm24460381fa.6.2026.02.24.11.36.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 11:36:39 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for multiple branch comparisons
Date: Tue, 24 Feb 2026 20:36:39 +0100
Message-ID: <20260224193639.95757-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223133034.GD215671@coredump.intra.peff.net>
References: <20260223133034.GD215671@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I can only speak for myself, but I use this feature every day!


Harald
