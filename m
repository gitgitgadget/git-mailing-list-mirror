Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9E34BA28
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021125; cv=pass; b=TDAfan1MinUDi94NB4gPe/JfeeJg0JsKuwEri4ithew/2lCLOyPaa7emWldkFQ7fxK3vxqIPhTSUodnUVFxDxmL/LgPqtSR9RJzoVHzy285651dbSsPjVpUZTqHL6BkfBXv+Sg7dAYgJWUyF0YG0L7652O59HHGuT2My2c/QKDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021125; c=relaxed/simple;
	bh=MJVHzR1Du6sLHVAmFXN0G1Mu91oinT/1f+eiNL5XbKw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mVoIA4d+BDMF13j4EwiomqUAF6p9PX7IX7YZY3PDKrS4iYFfehvLcdVFb4+T6Wvgf0WlhaWT6YjbEb/PgkptvBFNzfh4i6WStJPCTyuxMI0Rzr1lx1mXNQFLOClYbO+jsCTXbskaqNQg4pHvIOBow0abSnOigzfvA8WUWRRLC6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iebAC2/o; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iebAC2/o"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso435490a91.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 12:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783021124; cv=none;
        d=google.com; s=arc-20260327;
        b=EH1NKyydpnwVG4QYCg13/rncBRD8NOi20ClDisWswNDCm7BKp30qcTrfWsDpC5pabI
         DBbqXJm+SNCsStK6z3SZ4rsJjJxhTKU96cADerPlFJg/twR/niVkNm711ALi2Tqx47mm
         /HOaJkHFkxHZqNQLTND5NEDSaeq39b8NuMkMcl36wa8vySHgBYYMGelqOaWhURlUG6v+
         frth4Agz3JSWyw7EIe/3fzTi1q9SYkaT0kIjy/f58GwhrN504ex+lx8lYCgWNaSHb5tp
         J5E5eTbbjaj4fJ5rffW/3MlBTGJK8yd59/5sgd+yOpyqsz9fw8W/eS3gUgagdQG/gZm1
         7ngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=GFxX8Na+LanluAw1oWJ83+596gnGKsKiN0h7TyrRHpU=;
        fh=40bXScZZmEmxRoC7GNSV5vm5LeSoSpBKkH11ToWLub4=;
        b=LgR3CjqtO4oqSNvc2wzGjsweEnEEXxrUkOvEyejc/heoNoqjtMlqMy26ZHUpDchjhP
         L3x1K/i/wR7S9TKH0uIhE3mO2eZBFNFi/s9wI9xx9H8hZ7uBlEke6NtVNhdCxvgPae6/
         l/xUWpsSivPNA8LsqZ9Pzjc36IVglz5eF1fr4ZMktLR4mEhEaqMcLy9o+64csflwioca
         VkiWLQsxFZIey72dvZYXlQbhFbc76gpFNCExtB2VAEofkdfOFUCtODsuVvIVyw0VbMyT
         sDvgjZKsNBWCfBjuXlO23ru1Lxf0YJsy3iQmCTsWhEM4zLg/qMClOaHlmnVo0qejxG1M
         7u+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783021124; x=1783625924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GFxX8Na+LanluAw1oWJ83+596gnGKsKiN0h7TyrRHpU=;
        b=iebAC2/oDeiXVZ1DDFGff3dbIrOtGV37PpoADtsu3QAX4rcmrtYFztqHnmHneLWfmd
         OmomMv12NN7k8AjABiFYHylyxPobv0Xwv0VTjI8F+zHv5uvjkS29zzLPxLH6IM8Eofwx
         McA2lVOR6FIdlmuJ+ekaWlJ0Jt9C7UPKw6ILp1LyHvVrpqhRiVOJklqmT6X1+40FtFml
         HTZyBes66cNWSO7O2JRmfCufxuZotQyRCKokSX3jc+6JbXks8UMqg53TphNr/v9bhrHe
         yb8T2GvuBpHCuIqaezIVnzww/xhlu+Zhcp2LGOEYDlhAwuJ0SmzL2aHUbv2qSulOfxjo
         ImMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783021124; x=1783625924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFxX8Na+LanluAw1oWJ83+596gnGKsKiN0h7TyrRHpU=;
        b=mBNRyO0sQV22UG32tPO0d6h7B0G+8dfqmlk2os6kpWD8itARTFETtrCB9EgXSMVpZg
         01HehHLQ5MGlEE/uWBJOKog4b1LLrmDgFLyt5XhkrND5u6cYNA4CvTr1HiPZ82RvrtMb
         NGCQESV0VKbrWSL01fpUDZpmT/+gtDbzTux+8g3Carv88ADhj5Ho2Bj+mbK/J62N/mqG
         6ryJRBrl45d4BxOv5nXyJFwRAPofu/gTeeCICa/ehY/G6+FYzjtw4vfAXFL0v6RogRJv
         dT9kGs8im0wvx+AkOk7mDnEtS/6lzLLl73MZS7LtFKu9ePgwsnG4gRqeSWpEv9pXfu9N
         +Yag==
X-Gm-Message-State: AOJu0YxK7B6m+GJuaEzsX8HaEQlfa0sEGJ+PMM/t+XlhGJhT7x2/5SOw
	VMG5relLGYzXyOwOei1QSeHxDRM0snCnD2ub5Nx8p/U/t72d5jhMoyoPRRqcULzbGCIx/6oFbPm
	cMEKzT5QtpaNWHnVz1/8jCc2dNIDwT/S+q+YORAw=
X-Gm-Gg: AfdE7cl/1yCqu6NZukryOVT+C1/xVtda9PUyxSZZ/Yjc3VaZvcOo/0LGYmn30UH1SFP
	RxX9mGqRj0F8dplJ3MgNNboNQIOlnfbVLsv0ENfOya4Fk5iMywFYt+G8XK84kIY5dBtRbqgq0uk
	Oltlh2VpGbztzDUZdExLwTk3RNxx37JQ1/5mE7a+SC6dEudZmtJZZM+3mCVEyd5QkSy6lHnksZe
	ZTC6S83RT4LJNaT9mU5+7JhuB4g6xWwtudC67fBvPEEScuLCdEk4tOXiQ1lsiSWLarqulArdejP
	Qo4PvvCUuSckA4uVIb3Q4dJx6FEw8Ao3HwIjpYufAmcZHUI2THuw13paiA==
X-Received: by 2002:a05:6a20:431d:b0:39f:82bd:298 with SMTP id
 adf61e73a8af0-3bfecd4ca55mr8713205637.0.1783021123549; Thu, 02 Jul 2026
 12:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Jul 2026 21:38:32 +0200
X-Gm-Features: AVVi8CdYfyOZPazJk8zp_UbLp10f0W2An0kbNnqgLLziTqpRXJEW_9GRMhzrG6I
Message-ID: <CAP8UFD25T7hiGocyU2VFoRF2WYaagmgk4Tu52cyQtiaNpTSJJw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 136
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
	Paulo Gomes <pjbgf@linux.com>, Phillip Wood <phillip.wood123@gmail.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 136th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2026/06/30/edition-136/

Thanks a lot to Toon Claes, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec and Paulo Gome=
s who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/853
