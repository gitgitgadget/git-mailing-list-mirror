Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126FE2BE621
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773123079; cv=pass; b=crNYIsTUXm7FyW2KVGTjvnaaHOunic/EOiOH0IORECSMMZi7mwoqXaeLJk6F1XvSj7vSndm+xosq0BUxUKXip735GOcY/Snda3+d+A1V6XGxiDz29fRNA++mb2MdCQHyHNFfqh6R+9Z0n/ZQPgSzk9jgqlxhnBM7e3Bjcx99iDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773123079; c=relaxed/simple;
	bh=m5B02/tRsBWahxYcfplFVG8x9qd9MEgnRnOAKW7A0P4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=itczf+foIYR8GDA0rDiXYbY/fluvmkhZ/12h+oOXmYlqlFgudbtmOX0AeHu3MABmAvp/SO1OmGwLWdX5E/cLzcJqWwndG8OFegmh4TG/jetGFqOoHCCB3KpGdl5LwliNFqq6x84kGTT8cWAIyvxdKGV1ubS2bWe1wl7AWNobRyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKgiCrTY; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKgiCrTY"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-466f1c3c627so1727095b6e.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 23:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773123077; cv=none;
        d=google.com; s=arc-20240605;
        b=YMmN1n8P2b4dH5lId1LNrVORLklNQs8IWTiQnfluP5yzkPr2BPAOVHGII4CLUS11VS
         x29v5hkokgZdNQLxQWAzjarYPbOiH1E6LzN5JG3N1i40K8yuTdDlXnVY+pzUmrbfR/KF
         2q8Dv6QBdO0msAEfV6f1cUgLHAh+oLRHOKENoQWObgl9MSkuapxBxDpndKTps2Yyd0Ic
         w8aeSYgPDnml+sFdCjGXyDyiMCVzKQI3zfKSj9uKrfOGGbmpcg/9dsL5WtNbkTFC7O7U
         H/xa0Odl63bd0EYXVLbqOlr4rRxvGrIzLIrwaG9FEphIq+jso0eDvsD/RkDwa57ZsVg3
         wUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=m5B02/tRsBWahxYcfplFVG8x9qd9MEgnRnOAKW7A0P4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=VuotvT/RBPKdNf21R87YYvwprgWPCKp6s9w7Pp967g4gxLRm8QTt9OU/FizcqZQJKi
         8v8WfJxxBijOvrfGLBoLsKL900HLVWkXGFx311nNBGGJGFRZ7Fy7o3biHsFnhwcN0clp
         ukN5TVzNpbmO5txDeo2wyRjM/TS4XJavyDDGWOdBzsJOqHAaUe8gjgqrrBvR6hpNP994
         ey3dK7pe0R8gJCKmO9rIBFJgEs4lY68Y07tsAtwHfj7nF6kjnzug9yot3Upsm0y8XzRB
         Pe4R5f+oa5oOBVQdxEozegHzqtMAkwK2bEG0rUGppn/A3SeO4N3p3J7EUSwcvEbLjwdT
         ZamQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773123077; x=1773727877; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m5B02/tRsBWahxYcfplFVG8x9qd9MEgnRnOAKW7A0P4=;
        b=CKgiCrTYki0/GpmHSA1J8cJzqD5WXifJ77CvyH5IdBd5i/s2uMy18YTIYHJqNjoVgS
         jvTeA+Vmogxu1xk0EtcZcwjUhdFa7jpt6ntPakj+wPh3XA4jBTBzIhozjlP3Pj+U4Y3X
         KZdP2i2637Lck+A+PsykbywWbLeCdvi8/V2mG6tpsunC5rEGNEcaG3TA6h4gC3v4SoKp
         GvhNwcYIysFr/qn3GmcYJpAcIv8AOg1Y6XxaGe150+VedjeZpGMeF5qp57esaGpOgup+
         LcfWIIi4/7hNxKrOuYNPWhCWFH2udleyjiHJcvJpnBR6TSJZctuSdlqmRgOqKZg1r+A0
         PdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773123077; x=1773727877;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5B02/tRsBWahxYcfplFVG8x9qd9MEgnRnOAKW7A0P4=;
        b=ZXiiTq8na1B3XEsSzvW9HFKAciAN4pg3PwaSrvAgIRhHuYepYKJ81KfDQJOlFrTpqA
         03ZMzUnWj3E0yGpq8O2rkqVbCsci4UMtTi3Ms8WAfytya+CEy83RJ6CPzbNt/oJIJW4u
         1vTeyBBoLTAXjBDTdbxm47A38dB2K9rxYTdkcqvM+FH4mmlDkANro7ZuTtXbRDNrzQC8
         pvbzrvVtj8m3P60p+T5ijYUrv/lRc+Kz45PJt5Pe8AXGz2a3zNKQs0zWt4RVUTb3g/HK
         LAP0gmPfu6S8E8Vt35HPVbAtP5hZzSw2i5ygVjpxpLri6Y1ayBkt3qd3hT/KEkZ5nLAm
         EMzg==
X-Gm-Message-State: AOJu0YwYCSaB7zA75SAzPLidEFSan0te4hWDPgpbIVl1D26YcJsU98g9
	emZriRmB1J37xyJqYgLZ6N+To7+kpojKXptCy9tUyxUSBIghTOpnjJRGmN6u1KBkK69o6IOl/ks
	+ZAhYT9abMucbK423gtGSpzgoa0Gr6Aj0laD+
X-Gm-Gg: ATEYQzx2sEe+I6Z4ka3N45AYJUlljUwERmoud/mb/XEwhubhdpVfRz4jD/5jNFenRk+
	VqHjr/z5ZFo57SaFfBPri61w29LDnBOAiE4RgI/YpFWW2obnKhCkLt+uKZRYNC8xsTKRD4hyeP+
	uNtOoLKHz+ymWXTehDUeq8MMPFeiZYwGjfw4jHabTFCiH9makGUEuJOt5PO9HoccR2sG53hSG11
	fhwBpMDPtXLLl3dGNB4VVuPMCqFJtx5uldQOwo2VtQjTmia5gtoRvjF1ui+LmS8xiewqUqCWY3b
	VLR/Sz3Rmz77Rj7V2Sc=
X-Received: by 2002:a05:6871:2286:b0:40c:d8bb:8414 with SMTP id
 586e51a60fabf-416e3f2064emr8096411fac.15.1773123076821; Mon, 09 Mar 2026
 23:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: MOHAMED AYMAN <mohamedaymanworkspace@gmail.com>
Date: Tue, 10 Mar 2026 08:11:05 +0200
X-Gm-Features: AaiRm53ikGvwyRy0mjoYVicdZZrY5AP_GS_RWCQdO5w8p55lkwpDVeskoBrwr3U
Message-ID: <CABWZVhraW4zD132R0iv1uhBwS=uuQZduksCCYN_+4+OcBKBodQ@mail.gmail.com>
Subject: Question about microprojects for GSoC
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

My name is Mohamed Ayman and I am an engineering student specializing
in embedded systems. I am interested in applying to Google Summer of
Code with the Git project.

I am currently setting up my development environment and reviewing the
recommended microprojects to become familiar with the Git workflow and
contribution process.

If anyone has advice on a good starting microproject or areas where new
contributors could help, I would greatly appreciate the guidance.

Best regards,
Mohamed Ayman
