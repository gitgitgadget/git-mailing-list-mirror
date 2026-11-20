Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195469;
	b=zGruZ1q8VZpdF86fKS6ZZfkp4Z/f2bFQ/Yxo/Bnea+vvHutvasgH3/siqk7vRK2xCvmW
	 VKnAwmXT3Uvy9VknF+UTeGKZCigeFlgveralPNkn0dOGkJ8koeuug+DLtXX7sCjycogGb
	 61NL0wV/ezCXtcDdDv4T6L+Ln9bedhHgQ3+0zG8fzxOwfwJsM8h2nR0PY6dj7Jl836Fji
	 uqIN2jrdEZa2CqanNpqpSiTXH3yLnqAw1dJqHVzy7oGxM0ZnHUuJv1VmuB5VEiHsN3eM+
	 ONU+UlozjwkoE9ERkyS9D/8uFMjBKIEl7Skf8VuZHkoNnW0VonEQiHdgueAMYRxiErQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a2s+YiFhEz3qCysVTj/ouzCGZ3ME36BSorTyLJg/oR4=;
	b=ssqF4Vt1Jg1UYoX5PYID56rqA5XhclLp5BVGeceD6vuzI7I0SiVjgnmL0gs2pb8MXVxp
	 1mxRVlvhzvM+T4SdDk9/iPEBfyd1xj5j+fyT48dYsPN47kMVex7e05a6Q3MW19eUj9AQP
	 q9Nl+8zjHKlinJNy4fjUrNW0t0BXqZ5KrGI/glOlNUlfaDFV8cJrGT/CsvujD3iZvBeh2
	 JNd54kQMw+M2peNDBvqeU0aaZOYItnQoOHi2p4BtROHxHqQoH1AcwrOmb8ZhEkBqQJ4lT
	 8LgtAn8bSaS49x+iTrY6U9e76lKch79Z49uq4kKU37fK+eZikpZsiF7Fg/9gIYDSjnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S18wvXMI;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA70606A32C
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDA70606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S18wvXMI
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so569143b3a.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795195468; x=1795800268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a2s+YiFhEz3qCysVTj/ouzCGZ3ME36BSorTyLJg/oR4=;
        b=S18wvXMImVaLeib78UAWExrqsDTxFQrr3z8t3z1mpN209i6+ZoCY0ZdIpKlqe6Y52l
         KHCrGaQHX9IauMIUas0QUqqvodeCncOzSX3YMvbUIIagiP0E+xGrKiI2TQe6rqExth7Y
         FPosia40YuuzVlXWwsROq80NK4RBd4mR+CA3QrRmxTueDwGjb4PDVCVfalJ8sXNK9nnI
         s8JKrsTnAeA6B+lrq8VkFi9OPEVl+63xtWX/jI+1MW4HkDU9brrI6T47FODgwubIoDOr
         xr8pHlI0p/vUtF36oGvbZRXL3vTKGwRQnoWk0sxbSTvdrs8lr5qBorg3WYCjwnEuxWE/
         2rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795195468; x=1795800268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a2s+YiFhEz3qCysVTj/ouzCGZ3ME36BSorTyLJg/oR4=;
        b=kuRR2cHJZQVgQYJAlf2ObxJbdZPFeRXubqtLKhFb0Oa8K3kTnggglRTvbM6tYrsia0
         cMUV+a9fdImSjzFo7UUK8XRM1uwhxY8rVBwHlfBWdl5qW4934u5+QFAbZTRYMw7Q/B73
         DbW9xhRWh03i2RdylcnGQkTHHgc2YN/suc8qwnTQZFQWVEaqlehfc+gcVgTaG/W4dEM7
         ch27bg2fUO74GMzE+YzVW1oCKovQgVyldUUpIs/7XD13zLQPmwGN2axTY+tsjU6Cx+JQ
         q+6QzFuoC4sbHjlZOqGMKo2c77MaHmn9sILZnl0lYLqYRkDOIAU+fPlz2wg6tSF2WUF3
         xnOg==
X-Gm-Message-State: APuU4Z8BDrEGdqJv15IDh+ii6F87dNOxL9h1nci5q8Ejc2rpqyNr21ZU
	5G/8eVp4L3Wi0C06hqYtMQGn/lF/Yz5Q3TXflNkSQdcf0FAhpqIqb9W4
X-Gm-Gg: AZFdTZfST23XpbpvWBeVUV/PpB0VMIdJ+23DofB3Ta+kWWdbeSjpTev+povHcDzbQFS
	lQ3uQAseAVfawrxkm7i36ZqehuGdvjA4onmKcMz46S3LfeFPR8UmKnmDw7ub3IZfPoo+BGzdT01
	h9JLAUZcMcUL6HdktwCChnW+sdPvQKuczdsSTubxYbnVTs3Uy+4sD18YzbbgBkyG4QNbD0TOeCn
	m/gzeLosrgb4cAHeb4VCaIRVuLZk4nkFoITKDlSO6p97zCbct+IwqHhH5bDt4CW4q8jG2VQZGgK
	Q/hpHevW7vAzRV1YmdvyzgSx3h2YWWRhhX8wUmqgpDPM7ZzbiUdT2nh7YGV6DwyPRJNnk5dcaks
	boYlG2dXlHhKZtz6EcDkhZ5UPdN9E6/k4/tdTbsXmz58e73LeQcTg9uMu0on5l8fZKS/GPCGrBC
	z1Jmf83oWFlHfS5wvWVNb4WFBNL3KZ1CIIVJPuWaUceUryutOIiSmwjuZhwOHzX2AvEcg5AcPnd
	KeUIGvPUa01l2jHcCZGJbMUwPAN+xnmmxiiIw8HXvw5GcF/TGlKMivQTLYLvJfJp6neiCxf3z3l
	T/0dDrX8km2Y8HPUhMbZ1WxnedDigctPJOXYwAmgvNRVRd2r9fdVwNy2qOBfVJF164qTls7WoIz
	guviPZQ7re5x1g2WzLwdk
X-Received: by 2002:a05:6a00:130f:b0:8a0:7ba9:93c9 with SMTP id d2e1a72fcca58-8c87b9d0a17mr3499854b3a.15.1795195468044;
        Fri, 20 Nov 2026 09:24:28 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87420be40sm1807675b3a.57.2026.11.20.09.24.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 09:24:27 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: tamird@gmail.com
Cc: git@vger.kernel.org,
	tao@klerks.biz,
	gitster@pobox.com,
	newren@gmail.com,
	peff@peff.net,
	avarab@gmail.com
Subject: Re: [PATCH v3 3/3] ls-files: use and update the untracked cache
Date: Fri, 20 Nov 2026 22:54:20 +0530
Message-ID: <20261120172420.47728-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023-ls-files-untracked-cache-v3-3-292260e95f53@gmail.com>
References: <20261023-ls-files-untracked-cache-v3-0-292260e95f53@gmail.com> <20261023-ls-files-untracked-cache-v3-3-292260e95f53@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tamir,

Thanks for working on this.

> +	 * With index.skipHash, the checksum cannot detect concurrent index
> +	 * changes. Lock the index before reading it.

With core.untrackedCache=true and a cold cache this holds index.lock for
the whole scan, so a concurrent git add will fail. With 60k untracked
files, a background "git ls-files -o --exclude-standard" and "git add
new1" 30ms later give

    fatal: Unable to create '.git/index.lock': File exists.

master doesnt do this and cmd_status() locks only after collecting. Does
the lock need to be taken before reading? verify_index_from() seems to
handle skipHash and locking after fill_directory() is working except for
the t7519 skiphash test.
