Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D81CF5F9
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667917; cv=none; b=L/Z11S6p+sL3hctRIrPVQhInsoX4PBXcqB/rcvb5l7hk3HSQQ8mtPqPxGmWGZVHjxtxtbX0kVDzVVaD781wx/IDu6rznzsGaFEZhnjHMq39QeNsmolu9mSxpdP9NV0V4jWpK/zr73q6Xe7cWmYKuXRlh43uE4O6xwKPu+24VQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667917; c=relaxed/simple;
	bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=VWaJFnmKAECjzRibQlZVRGR3b937MHjdYyur4CyJ9F65E66t1Fjq/CqRvOUX8uMorLu4Z1xk7Tjwy6b/0pKCOQ8hZ1+QJrKoFVlfHxWV2RHubfx80aD9e7t5DC50EQ6hmva63Pq0teKT6cy6Rxufx/DLM2nYsDcGxqiLMCqAWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTDRh1yw; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTDRh1yw"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20cb89a4e4cso2280795ad.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728667915; x=1729272715; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=mTDRh1ywAaWywf1FEbGvWi4VCZ+PGTdWlAHfVMUjwFmlD2CDfebeJ+85AaqoN3CgYY
         7CKpapgKUywEmLm7GxQ5Zo+UDVZU3NMv0OMR4zggVHqkv5ltJlPeTibim8xth9a/2LH5
         z70qjOaNZ2/AmknSRRt33rLmK8bC0JeoaRr1xNRI/0RP608Q/z6FZzIRNeExaFmWfka6
         dv4RsSH6zbeyJap3kE8iGy8xqMdYCUYWeCeDhJXq2j4uJVZ+/Q5UopXvdVdEMn6AcBVs
         rjvK4po2VnDUk4rYlKzDljZOQoyZiBxVv1zQxKzSYEoS5IO6VlIGNhpDnoSsDsBggF6c
         JBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728667915; x=1729272715;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=kMR3M/zyI/fArfiqqXg2FqTT61HvU5ddkljmcACeKiXZ0OsvY8mK2a3ek9IzR1TeCs
         D/ylZ0fVljtTVXEBMzv00T8nxfqqyG/tVR9kTkkxbphtGcNWb+tMIP5wKB+zz5dWGqSR
         rPY9dqUNEUysHpo3LKis+7AcG4p6hm8Folk22Cv5oGOzU7g+txF83CTW7ISMeiGU5n+y
         wPqrWyPmvXfXvFxKZWtUJmNNQS0eiwHiMe0JT6vDMPr+4HuuG9E8ftSuNEqLNA+TbhcO
         FmHw/ELcE8CrcttM4qKJxklyu9OqfDah3h5ESuIaepZZDTpfayHnmMan5uS5LfM7muVs
         uAZA==
X-Gm-Message-State: AOJu0Ywqaqy3GLB0Q5DW7wJS7CHvr+VAGKb1GNd0fh4bQBMIn1N3c6hy
	2bMjhynXntk8Ixr3lBuqidPuN/Dp2ROibZ7m1jgXivVMYdz9NbQjpkahZiFK
X-Google-Smtp-Source: AGHT+IFOeA2YkYZrFbVDoHowqBGY8rbSJVXy5snVngqPZYepIGtbxf/NsQw2MY2GKj1rM9GyrFo7Rg==
X-Received: by 2002:a17:902:d2c1:b0:20c:9821:69b9 with SMTP id d9443c01a7336-20ca1426578mr44515855ad.5.1728667914977;
        Fri, 11 Oct 2024 10:31:54 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c212d40sm25744965ad.195.2024.10.11.10.31.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2024 10:31:54 -0700 (PDT)
From: Josey Swihart <mdsalem309999@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <a18d6325f8f703cd3d472478d1a45d0b47982d80268322c3ec583bf8decdaf7a@mx.google.com>
Reply-To: joswihart@outlook.com
To: git@vger.kernel.org
Subject: Yamaha Piano 10/11
Date: Fri, 11 Oct 2024 13:31:53 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I?m offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please don?t hesitate to contact me.

Warm regards,
Josey
