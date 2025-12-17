Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F21428F4
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005393; cv=none; b=ITC4cbx6lFrqxZVKMJIvw9umY+Zb4FdFSHyRdNA5qN1bsr0J4ilYL5G3W+QKzZK6U6XfBdDw2bcXTfq+FK4Vev48bj9UU4vr0lEuQPZy+vcgRjjuqAEXIzdQLVLs69JKRZElz7lxAdbi9yroId28Pp//ILaHcr/Du+UzVkyux9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005393; c=relaxed/simple;
	bh=PPt1tNRFyEI7s6fLeX7Xap1/+DglMPAQex5MHyK1mvw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=foUf6j50RHfykGJ6iOR8cXYvpYpxS16fty8er2CrUwKD4Ui5l1thL4falC2/kxwvCo6kNl79BJ1+gGMUIRDPN+2BDATSerYSSbKOMxpFYAK7lkkxuAFCPoYcL4XQHJOOlnYT//+EPpVeYyBOm0iF0mHFb1VaGoCcKtpb7ESo9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEFyU8+z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEFyU8+z"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so37552275e9.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766005390; x=1766610190; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PPt1tNRFyEI7s6fLeX7Xap1/+DglMPAQex5MHyK1mvw=;
        b=nEFyU8+zuHFUJoijRQx4FYMy/SwzdtNGRvWzn+LJAkgdirEHWhniK/L7Fw5kheV6Y2
         vzeDIZ1oIYhd1blKTY8hQsjYDsRDmodQvx28qDBoq4kvtdQK7rPaKco8yqVbOe3RqQrj
         UbBDzrXPlgOggyTJUqnReEBXaGba4wJmrc26DL8X9fEtIXCARUJ3/EmZ1+QwLkmZ8pmC
         yil4pNhfM9KYNORljUtc10U7t5GPOmPTa0UNHlbUvBSbxmjoIc9Vro9mjwjXTe2v340s
         KufrjwCVsRvHs7jOBFVseYxNbr7QtbxBQXuD7bNd6N5dpP8ZHKfkqhshZAiq/1Xl1D5y
         nVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766005390; x=1766610190;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPt1tNRFyEI7s6fLeX7Xap1/+DglMPAQex5MHyK1mvw=;
        b=GKJq9p4h56UapJ2ccp5UVkNoFIxYtEkyes1I5QdBISL9psvpQ2Pn7Hrf2tZDy8cJE0
         goEjy/NZMJLOYgKps/86kvGvjTyrKg/G+37BfVw0wN2Yj9FMpVKNiTccndLHD8cBTm7g
         PlVrVpGNB00e9wjOtirpf/WsqRf6IxwFJ8qK8sFRGr2QN7U4Lq5xGun8DI1oI8ozRrjx
         zBgQMwBY+oy1WgnJbsa7SAth+yYPqwRjMAZkzVrOm9lBVpIyAcNd1eiHst1oGEQOeyXh
         egFJpemHrYjUikX6VLp4XFJGpvJaenycFAgIcvIuuSEG10x2BAEkvo4ej6dX2SeScnLj
         ERgw==
X-Gm-Message-State: AOJu0YyzjoBjzhQc1b0xGBmhptOG2l0J4a2SZU+Anm/DtcqxKwt95fNT
	ph0V1gv8akv0MaA2uNbV0U3DvdTjzg6qw4sWwD/HCN0bywRS0n9cW66E42VVRFB72F5c4WlVtSl
	9dn0NtpIYnPlHNhjFX5BLL+fPH8QO1hVfNUyPnU51KA==
X-Gm-Gg: AY/fxX4jcfTyxMa0pnqfnPps0YVDMeNnsNv6qVMUoS/pwQb8BZk9UoeJfZUruJK1OCJ
	ygsK0OQoGWJaQ0kSrV3xa/yEzEGa7/1EYCSj7tiXdqpOlqLWJ/krZ1v0aZn5LUE2ZlCEgSPYkXv
	n8ccZUyT5UxnYAzHZaYIjz9ztbooYjgZ1vONCGtXEc9TJGu0NhyN1Vf4p04z7voKLDaYWMl7Hsl
	qlTVbCX4VP9muWQRs7wexDmIM/3gqhCWQiujGDuMG3j87XsaawVsOrnCR+L5M/U5mNwyxZtnE94
	nan5bxce7l4dkJ8=
X-Google-Smtp-Source: AGHT+IGMbtWdvrQakVsXb12/Gz1ESNqxkaplrHO13+NIkrSt1nD0tXEgTGhoQGYpp6wwx+BaxsAYLjYkk++VDFSiXKM=
X-Received: by 2002:a05:600c:3f10:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-47a8f710100mr206448095e9.0.1766005390291; Wed, 17 Dec 2025
 13:03:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sahil Shahane <sahilshahane.dev@gmail.com>
Date: Thu, 18 Dec 2025 02:33:01 +0530
X-Gm-Features: AQt7F2qzDxLbm1WJre8NwNAbFF5jUP64ej6xFCrBWiMKEXTPe1TDHiNak4G_HYA
Message-ID: <CAPzEfgBfR3Mos19SLtgWZq4eMHJLcZJctJgF28mJGid0Y71LVg@mail.gmail.com>
Subject: 
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please Cc: me,
I am not subscribed
