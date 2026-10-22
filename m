Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694959;
	b=v7JGu2FSrTDfRmzaJtSeiKGo9U2MYI3YHpS1muq5+Twx51f5ZOxihC0pIA3SnruO6x8k
	 9PAJ6gpQ5bMT6JCGgWA/FMHtIsyw/h3PW6EciJcIOdU7Y/RfyJYjtZug04Uv3w2XUOP0n
	 XQNFdkrJLk9kvPd9hjmKvGuGI91XrkXY0+YtRsA1d5vAepQD5ksWRV1iLsahzQNfKnUn2
	 wt288+RAOZQ+HrBEBfAc02cOkZ2BWXK57E/ANNdg/WodB6KPcHUDfquS7htrxau/HGK42
	 j1kEHZ2EyopEGKZj/wIdokn1AwVuBCRc71/EdP9L2zPIoXNB+69Br5vln6E0+ur+/qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sn29qIKlhSZHhVwP+WStFTa8oHgZvfZceHl0MthOD5s=;
	b=ZolIMo1igCYRuFCS6WQqEfNJl3jtQTGFbWwDW+S/i483mDhHAOJI5L89M6Fnfkd0hSXO
	 iW+jALZ09JfnsDgSRi8xE2yyzlvgNOsro2AgYG/EJNQlmocH8eEZI10ka1x3qWb92Rgnx
	 3A3HOpJkyHItrASdZJCwRKgkfMy1fpsJC1ny6qBTTKRQQswSnKYSKUjwEzQlDRF36eynI
	 raK/lDM+ZWxm5jAJeMUKNQA9dlZzuiWYesiJacMXuE/1WRpEpdoY6vMibuG7S23B4OryY
	 8IT4GPJ1A+ZanY5yPwN6mNu946GatFMmp44EExmn6k8NtrN9M7x0w3nKzMMmgMYfnZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beA++BFo;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41F606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 18:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E41F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beA++BFo
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-536717a4d83so230841cf.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792694958; x=1793299758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sn29qIKlhSZHhVwP+WStFTa8oHgZvfZceHl0MthOD5s=;
        b=beA++BFo+kToUqeHAzd+X/E9AkXUiwZcNdaB1lxFu+c1Ss4nQmcJuSp+0J8UuGyOW1
         IBO3eDNqPE7rsyWrvicm8pMYeHNisbIITY7BJ3o/Dmdryhc6qTbAqBgzz3EdYfZUY53M
         m0k4Gsr0YB/xilKmzkAVoL0Sr89Jx+h+nQeEDBOwlCBATEgupOtNWs6yIZmgql8thLJx
         cmbrQiGurRhElRwLDwS/+GkM4epkscKwWRdz0E+gz8GiRIM0UfKvgkea/92c8//XC8OF
         ApWaCUIBGzf5vdDNP2dr0R1loay6yKNg8IPGJqwS7xPyeCPnhvZ4IpAPxED9Lji8ZLmm
         JOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694958; x=1793299758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sn29qIKlhSZHhVwP+WStFTa8oHgZvfZceHl0MthOD5s=;
        b=pxopfe6rTiHbv8y7ubn6vVlH+Vb5fDhOO3p2ftHKO/5do1Rx4q7XblkurhposUHxX2
         NVI0T/Ie42f47q5i2/pnlQd1o5zem55NmJFsCSGQvZ7h3/xiLxsUHzuK1stK18+t0wlm
         5xL8BZcj/n6vRdWtAyK7v9WDVi38dz3Y8qTlYEsU4kF9YLYjSC1+C0USJ4IRXZ/mcqLC
         IWVkS0Q3SRBfR8QY6KZxKx2h85n7dDzGXUcg/ibEPJLbLJPlbXbqpaXmZJwSY0ZnyX4r
         WsFALc7DYUqILLxqzK7Zzsy5qa+Na5hEsFuNrZy6z8hJt04r1xLc3jjstJQ8J0RLMt3a
         cpqw==
X-Forwarded-Encrypted: i=1; AKwUvByOeRMP2mRcUYBth1xxICTy9IfLyY+FYbHfo4KDEEe1shVq57180DFg1/QPziitXYP0JOM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyAdHimq0a+TrE9upyMpJZapJINQ18GK4hHQyIgJeHI9/uMvyr
	KUItspBhd2DS98fH9RpIiVvWkVYfyHt0E/M3xS6uYc0Sr+IGkCvd/fED
X-Gm-Gg: AYBFou2W5xm6OfexNzzGsK5Pu2xif+tKRG13pq7zUS4A1GxEFeNlGyCiExV4d1VEcep
	dV+qqGcZmdPJc2SKH3wrDoxIMXPHAxGFN4j98plEWMpEA09NfiBzGrvsZcAmFZBuYLaT9HOfV+n
	6HWvrlmMlNBEw2IF6oqVvSOJM1w7XlfQhyKkkmwn822iICu2gAJQ/ZQlvuhzb+NmOiXozMDdtM9
	AKgGHNteWukhOLyX6B3wbb7oZ9J1zH/LmTwqpfJ0DbZjqnWSeA4R40ql4hTkS5VNZzIrwPYVkdN
	zHz242nuB9sN3Rmz5ALTha3G95MiZkvGUXgHu/ZppmNecDCsj4L5nizvShrozwiWvOLFxQH5iRA
	qtkM7eu8OsrjcOEF+ws7nMP3qRlm6mGnuY8QAxG5wc1FgVHYvRR4KCD2J0QaipB9zXRyNs9sniw
	2wadeyXLoPJ9vu5UcG84LZSM2Zq+Hz6VkqUzdvMrx0wde1ZFPg8zxmnGz4hHG3b+ed6268fu8u2
	vpRAg7SqP0Cnd4mQIujmo5K5fBGI9sXRu/XvJJ1K1rDeYZy6YFX7RKNStU9vs9ms++cUFBVj7On
	uLSQurrRxGchX6GqWEJ9N+PdEDIRMqjaRv1qY+TzKXmJTZGdNE76fY0XZNVukau1bu4DUvWpTDj
	ArSBSUUw=
X-Received: by 2002:ac8:5a0f:0:b0:535:f182:782b with SMTP id d75a77b69052e-5369b8d6cb4mr99170751cf.74.1792694958291;
        Thu, 22 Oct 2026 11:49:18 -0700 (PDT)
Received: from 3950x.home ([76.69.137.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab98c48fsm33144391cf.27.2026.10.22.11.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:49:17 -0700 (PDT)
From: Mihai Cosma <mcosma@gmail.com>
To: quark.zju@gmail.com
Cc: Mihai Cosma <mcosma@gmail.com>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/4] Wait for the index lock instead of failing
Date: Thu, 22 Oct 2026 14:49:06 -0400
Message-ID: <20261022184906.3679783-1-mcosma@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017073231.3357477-1-quark.zju@gmail.com>
References: <20261017073231.3357477-1-quark.zju@gmail.com>
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

Hi Jun,

I've been working on the same problem from the status side and just
sent a two-patch series:

  https://lore.kernel.org/git/20261022184420.3648771-1-mcosma@gmail.com/

Status takes index.lock before collecting and holds it to the end, even
when it has nothing to write, so it's often the process "git add" and
"git commit" end up waiting on. My series makes it lock only to write.
On top of your v2, in a gcc checkout with status running in a loop, the
slowest of 200 "git add" runs went from 1020 ms (one hit your 1s
timeout) to 160 ms.

The two only conflict on the lock call in cmd_status() that your 1/4
renames, so whichever lands second can pick up the other's change. My
first patch also makes repo_update_index_if_able()'s check work under
index.skipHash, which the read-then-lock callers your series leaves
alone rely on.

Thanks,
Mihai
