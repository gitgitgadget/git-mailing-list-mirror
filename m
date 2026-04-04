Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B7317141
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316882; cv=none; b=IfwQ/CXXfYKI1mm1qNmbvE7Y96qrqA/X3JLTMhDib0YCM50ALETg3aQT3gjfCOy1ND763V6qBLb0I//lSbUglWRIU9JUupklyCA+dpjZ6iGDHoVBtM4Bko6k8YlHxRJxo+b1ZpUICKG/Mz5TWRZl7w2uqSbIm7OxXpTeMHMmjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316882; c=relaxed/simple;
	bh=4or0kmPziktFLphk/kqnKDQLug/YnS+lrzi4CcYJvgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5QM+j2mrC3WQd0IWR7OPm6bi7eQKUdFqxY9lqoioO3yB+RwedXwn5unalgv6+NknbndHxl1vQd7om2sjMIaJILCrsGxfjGwjqxVCKRf9RiRyDu3ZRGADZ8Kc2wHMM9h54RRhEKyVLO+uZeYmXa/wBkLkqrOe5SUfx+hr0pVE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx+m/Nio; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx+m/Nio"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so2479680a91.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775316881; x=1775921681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4or0kmPziktFLphk/kqnKDQLug/YnS+lrzi4CcYJvgM=;
        b=Fx+m/NioXQwbVpHJDuAIywKZkwlKZY7fyqCtD6S8nH9UVqWW8WHv9qGGhOidlaeIn5
         QTr1AtefVn85Ie4AU7LD4E7w0kzX6VGV/e2YCMBHLbt3eZAARforSOoSfWLNKmNfGeOP
         HezpP6Q12VK1D8+QA3BiH3FfFu46FV0VoOHoksCiaRKiqnjcD6zbUj8Cl/VWYV5K1zt0
         jzG+pRv8JoWMtiLXQYIkUxlUAQBiR6Z3udPN7FizNZfND6aUeHZmyH9eZIdSdkq+Wory
         81SCfNjTuG3Xep5ndaFhwEkpFuvwqOuC5Xo9srj6/bg2niocJ3m5sxZL7HLs0fxlvThz
         EG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775316881; x=1775921681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4or0kmPziktFLphk/kqnKDQLug/YnS+lrzi4CcYJvgM=;
        b=I4JdlBiBZfEiJNQspOYWnCDCxC8/NGxZjSrxY4DEOQ5jCEYelv0RTsqfmmmzG/zqRi
         vEA6QIYndIA46oyqqRdlF22i44JRO1jJQfoKVoVKAQgJxPKOGxIvquzeWRSvBHCF0VMO
         OfHYz8xiKGqvXnPEDByqApYUNVTIucIsjgRWX2RcsVfZ8Tx2kTPkctU4Ssqtw4nr7yqn
         MX6IQunlWs8UPjMIABELKFDa2OAVb4nbKVWXRS0b1jqOS3a7CDnylpdXe9lNiph3VIqV
         0bx84R6tC7ck23KPW6K8VHM0c7NPRHyiZZ1Mst5YIBJgaC/SDHDNM+fBNvI5k3iJr+zg
         gyYQ==
X-Gm-Message-State: AOJu0YyRRTVlOpSmfhYJd/MGt6YsxVYP67mpIUsz6Kfo3IPplMf5tYN2
	rhiofRZrqwe0YSz9Xh/3E9Qixr3p4/zAA09Zjst+OYbQyeUdlW9zlEm/
X-Gm-Gg: AeBDieso+iTbmI5GuSN3VHV7QmXu+IQNLwJ+YVKkvcbo92+wInTfktjIT9LGw1WRlmv
	pN4r2XdbLYLGVWhHePMfdNquR5I2wCp7cQ9l+uBIALa6o2sejr8KRyVcJqDgFJ1c3xGsIZPlrGF
	j9ZNoM7WYFDzupUQm5kXb5DACwoWLgOVSs51lyH/adti3sVVZrB0+pj/O3WHXp6A8Coielxw2kR
	0ghCt89TWz97pa1zS3sn8DP2ozpd7X8dvi/lPKDXYhH6Tgz5tUtEqct7rD7r8k7MzpqlbXVTJuZ
	HQWG7/4nl3R+IPzk+vdyJcFas52Klw1M1SRW1sQQ6Vx8jP+Wnj08NHo90zAuQyUIKwZFBFVLjT8
	VSkb8KNdo3KyFVLsrAgvt5d4Eg9wmcWm2WMtcqQvhA6dv60pBzJuLbqRw07WSVvpom6ZBiB/Ur8
	Nn/bUsMsddhAVbWemJZwRMlLiqvmG9H1WX/uUhBSr/E+oNGlaDQs3F3U1dLSa2nk0uc3XASOltw
	vkBnnqpnPnT7oN/jiPjqfrMgsQkVLFzng==
X-Received: by 2002:a17:90b:3d91:b0:35d:8f3d:c554 with SMTP id 98e67ed59e1d1-35de684a0a5mr6725044a91.13.1775316880600;
        Sat, 04 Apr 2026 08:34:40 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd36a1d04sm11525328a91.17.2026.04.04.08.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:34:40 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: a3205153416@gmail.com
Cc: git@vger.kernel.org,
	kristofferhaugsbakk@fastmail.com,
	ps@pks.im,
	toon@iotcl.com
Subject: Re: [PATCH] hash: introduce support for the MD5 hash algorithm
Date: Sat,  4 Apr 2026 21:04:17 +0530
Message-ID: <20260404153417.14565-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <12070180-b0a1-4dcd-b333-3c42505aeecb@gmail.com>
References: <12070180-b0a1-4dcd-b333-3c42505aeecb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The whole thread reads like
"What if": Git was maintained by Web Developers.
lol
