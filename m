Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E1D194A48
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856772; cv=none; b=Mo7riIRoJkg2d8wea6P7g25GozUS2/k7214Jj5HZI+3wkCxqJDNeIOYqeTmtG9FbKzhWun6wvauSIZCs/b+DdTjyqwP0ZooXLy4aaK/Najory9Ry94yOu6UVWxmksCqOlXiyT9EtvMh4KS64fQl4q0FePF//v2bNLOtHTUVpGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856772; c=relaxed/simple;
	bh=DgLaa3ZF8qOptCjT5M57zt4YX28EavSpsFafNpNqW40=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Z40nebR0szsn9wZq67GOEakhp8e1vfK2D46x5BJmQj50D7en8fcrYN5T3RGLM/UOvlcYvQv+x8Lek49aL52iHuPhFkcj6chQ+W4T0yosxJTMVaUTj9K4vWBvbjckusYlG+xzv7hkuFV24a/PpPQdFtuuFFbS1SteXHXZFtNVGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyZo58YP; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyZo58YP"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5c88b5c375fso5214708a12.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727856769; x=1728461569; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DgLaa3ZF8qOptCjT5M57zt4YX28EavSpsFafNpNqW40=;
        b=FyZo58YP1Qmflw/jltvA4fVbAsVInYB0iHqxkcPv8XrUOpytQ+BNr5p8L0cYgjXunw
         J1b56/hPnJQ8nKrTjuMI6V5F2dJcyHN4A8v5pVwKgVPo+gQYwak9JtEPlbuNEoyQMlxb
         OkViGorXwKGvme34qDi+wPX0Bucvvc38A+yjkeONqOXyXqvl80Y6NTvEt1sLPMDAatNM
         4Sqd5s526ikoLQUG3qeP9OF2qyK4uvqVeO+iDNg+3FP8QLYGOEJN1XES888F82+PqC3g
         rDVrmJ1wBxhTUVcwJn5LqTBjIT/cfzsqfCEUSmR03mXkPXjF2+a7BBQeyKWgCgukmiSq
         Ha1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727856769; x=1728461569;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DgLaa3ZF8qOptCjT5M57zt4YX28EavSpsFafNpNqW40=;
        b=q9tKrgpuahjXH0K9o/xfAl1ymmY4y3Dk6MtbAbncOfPQVD7rB917/9x19g7VSLjXH3
         3Xov9s4oXz+MbkOK6lhwLs4eaGjBOeBhHPfYl8LuEGhUkm28ou1zFEaVc+emWnbVxTnF
         Wx/nwBt/BAXLk6fMiVS54enN1MPk/ES1pXuu3gk/k/J00Q+7yQSr1jpnq+q6jlxu8snm
         gTQ3V9U8x7mEKWSooApNSj5JfcH97n7TKU3R0STaXps3kZeEQxtno5ymkHwuJaP4LzXB
         sB7FmMb7K9R5Yje31JPNrtYje2r/Ntd1luHw7c5FXovwLaKyRe9/IzRrmqaZclB96Kt+
         M/XA==
X-Gm-Message-State: AOJu0YzDv+IOHilIEutJf0lRsnXjW+702O9Tc/ML/Q8Oq7DESKiOZdUd
	d/1yhv++N1vQJBWW3IteZRftYeFEbE2oLkhK5rFn5gpABdAZ+YBRbk9fJD9JI3mXzQsLKxt9pBj
	KhRfGWEh/dx9SylcaA7UVbuKWijVHCdWE3Te0NEMu
X-Google-Smtp-Source: AGHT+IHNy+kfhT5o6J6NmIIasiVfj26lLm7iEBLBpwA7SbfMR/u/zUv5Y8cm4dpxEEeYtKZakogbe6pkllKPC53MbrM=
X-Received: by 2002:a05:6402:2110:b0:5c8:8fe7:739c with SMTP id
 4fb4d7f45d1cf-5c8b18e1379mr1426541a12.7.1727856768402; Wed, 02 Oct 2024
 01:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ekikereabasi Nkereuwem <ekikereabasimachine@gmail.com>
Date: Wed, 2 Oct 2024 09:12:37 +0100
Message-ID: <CAK83d8pwiNEi4TcnhNYCtzaVmEaPtud4jwLHTVvnrM3YrZq49g@mail.gmail.com>
Subject: [Outreachy] Intern Applicant
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

My name is Ekikereabasi Nkereuwem, and I'm writing to introduce myself
as an Outreachy intern applicant. I'm very interested in contributing
to the project "Finish adding a 'os-version' capability to Git
protocol v2."

As an aspiring contributor, I'm eager to learn, collaborate, and make
meaningful contributions to this project. I believe this opportunity
will allow me to grow my skills while helping to enhance Git's
functionality.

I'm committed to putting in the necessary time and effort to
understand the codebase and contribute effectively.


Best regards,
Ekikereabasi Nkereuwem
