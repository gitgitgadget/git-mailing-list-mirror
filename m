Received: from mail.hq6.me (hq6.me [104.236.142.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A61DAC9D
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.236.142.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187216; cv=none; b=AjLK5pYKJiJST3XabuzRQm9xnZk/h58r2nWpRnJak9Du/UoF1TegC/Zgs6hM6F9t94mkLhCqaD53hetE1za5//Sp7p/qgiSjME/YCkmmYtYK1xLDKIymYwTCO1LcmM2ANP5quGKSIw9cKrUEKlNo9GynBX+CkVSCoNiFL5+PhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187216; c=relaxed/simple;
	bh=9oDy2EbER/Kf80k5bTxw7TMU/WGNBF8MfqxTZQfc/VQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lR4SxkLHz4Cat7JsPctsWdsZgiaQpYU1jUyuyx343tLGYH6vHRjK5wAA/d19kdTwwPpSJA5tGnKWsuLl9hi2wg0wRtQGHNbi/i05cwtJ8DgniytSh9B8Q1xY1L9fMabD4Vdjx6gbyTlkg0U7o7aArJ5dzHYoQREkA01GQMoSAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me; spf=pass smtp.mailfrom=hq6.me; dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b=S7nEfuWL; arc=none smtp.client-ip=104.236.142.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hq6.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b="S7nEfuWL"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hq6.me (Postfix) with ESMTPSA id 1B7A7120986
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hq6.me; s=mail;
	t=1729187205; bh=9oDy2EbER/Kf80k5bTxw7TMU/WGNBF8MfqxTZQfc/VQ=;
	h=From:Date:Subject:To:From;
	b=S7nEfuWLzrJZZ7eTuxSWgMyurp9MyriFz8+bSG4YtKOqv8oPrg3d6l0yaPO+Pt58j
	 r/LWvt20e0TBl0QbFGkVMLLrsPP6N0mXJ14CAJ9SQ31fBvfpGfnHvc1DUil+NcT/36
	 bSeuHs63E6VqM0FMqOPV44MWP1ElMg305gFnwRka0ZC4BLYzaW/nCeCq+qLQgsikQH
	 Pc/tZICoZ9p38chzB9fv5oygfTlsK9cjrUxsx835OwErwHF/J9xIQQMD4eZ43xs3hY
	 bVTLsvuQAis9GOS5hV63y5k6C/JFZVEUh6oxAj8qQ89yiC4jfN6FfRSf+QRnJK2lbU
	 aRzO0FOQfICnw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2888bcc0f15so148898fac.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 10:46:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YxDVhtYBg8cpNK38bJbqUd4OGDES3j6EiAJSE60veUlOOfLgmXA
	/o6v8UBSOTrudto0Hf/Y3vvXaeHnBJM/p5OSqhLUvz9PsuKP4sPIhA1jTjt/GudnO4JRABnTTUG
	PvF/xmVkvmBN9wsA9sTmBYAY8sWY=
X-Google-Smtp-Source: AGHT+IG13n7XLMuxfPQrppoXCR38FxgBp1hFyoR4cf4XmZSZMhTIOlCH94pYLX6WU5WZBfMMGnHiM89PX8AXD+S0Ua8=
X-Received: by 2002:a05:6870:c081:b0:278:2e89:18ef with SMTP id
 586e51a60fabf-2890c7e72f1mr1107261fac.10.1729187204412; Thu, 17 Oct 2024
 10:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Henry Qin <root@hq6.me>
Date: Thu, 17 Oct 2024 10:46:17 -0700
X-Gmail-Original-Message-ID: <CAO8bsPASzxoEwiYd7ABf4YZuyTexFnf2B2DXap6xsA6d98DAAw@mail.gmail.com>
Message-ID: <CAO8bsPASzxoEwiYd7ABf4YZuyTexFnf2B2DXap6xsA6d98DAAw@mail.gmail.com>
Subject: Why is git log on large repos slower when outputting to tty?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Details in my Stackoverflow question:

https://stackoverflow.com/questions/79099095/why-is-git-log-significantly-slower-when-outputting-to-a-tty
