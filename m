Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C133EA
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720336568; cv=none; b=TYD9C0Zl6SMgJVUia3JtaH1rOb4GnR7IGaT83nqOocdQtVHbH/eKOLBgB4LNZSwgN532r4v2z7Uyq90q7mw1PODyp/HFJfOeLsauCQMrdlFI2XBD13c/9JtCioyHJzI9eTlGzCdicPZnVp39fdrQsmG9fB5DXmIy8VRe1gNfqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720336568; c=relaxed/simple;
	bh=egIM29KJH2QUcWsY5GPqA4DnwZV5g0d++K4VCkJnmmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfuaK6OfN2+OOmGzrXkTH9cVEGUzmZbflS0vVgRlD6pHF7wrj0yiOvt2rvghTE5Ieeed2R8YKsOxKlWco8FrFhlNJw//F62BieMj31iIK1PEn5OeMqT9m/dVVhBun2w0YPuKXG69efkRMaUBXwf5ssjWQjB8Ew1xXC60bovwtRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBom4IF1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBom4IF1"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso2956178a12.3
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720336565; x=1720941365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=egIM29KJH2QUcWsY5GPqA4DnwZV5g0d++K4VCkJnmmo=;
        b=iBom4IF1gu9uvifrbGyicW6/pe//iSAIS152zaofDGGYKPvFqVC3CSDmrsjqusrrZj
         SQ6KkderIrM/GjHRBAg0WYKj8y/LI1V0qlorX3Gkrzs9TEZHwK8vicz6MFM9lwFtgthN
         xmWfz/oXm6zl8ZzTLUsnemx1QlW74o+QtbAXshxoNgNq2fKf5f8e7uMNfP/CYS/HvuLN
         VikApQyFFD+MTEyGcSxFo3Nm4tr/wkfnbztOGYxqfZirFlIde4dWPKStZMrAqOp29wfo
         QspxuaK5cKQ5beWIbWoU33MCQyFK4zr00gbOkWjNP/Hc+OGnQzdtmPrctjOwn77xMuKl
         7bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720336565; x=1720941365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egIM29KJH2QUcWsY5GPqA4DnwZV5g0d++K4VCkJnmmo=;
        b=YpHBevBaR+onziFj47DiSv2oD25FHVauNInco+KSBZ+EhX0RziSa00pfw33I3971Cw
         7DvBNZeAUTzGfZQW9dqSGis8IoOF3Q2gDcii+malG9Ac0jSPS/vY1Xn3E/grxIar+8Mi
         TH/z2KAc/JntliHibSDvl+bkREReiV9bqu+lRmXm6bQCvri0ZH8wOHfF0hNXKu0AGB1l
         WNxH5iH0p7+/616bZlzeiq5ljXOMkW1sLgAkOUENxVuxv4T1bTLcX/g278R6IEu9HTWP
         Jg0oJjSuOorlCyZ9Cira3vYriTd5RJNvYI0WhAhtwteVCuvBHU8zHh0/B3H+3gC1NAjw
         gxQw==
X-Gm-Message-State: AOJu0YxIJzVEnNTgwxliyE0IQKXiwM8vgc4l6nzM3ozAfJVYt92ymSEn
	panqgKvRCmqmFGGKBjEXe/pv4o7no6HuccZ/Te8Cg+Ruh3Ysb48HcLyLUN6vcWCk4guGMD6k5y7
	lCxsGz0IDX6kkOuWhJ9at5SDBsz9mkFmt98Wfcw==
X-Google-Smtp-Source: AGHT+IGtXqshNi10Fqv3wBjlKwuo78BmSzKALnT7VIFdq3XfATG4VHTY+QHuIyU8yvtd1U8RdBfnb5hseN1N9Eg+3E4=
X-Received: by 2002:a05:6402:4409:b0:57c:b7c3:99f1 with SMTP id
 4fb4d7f45d1cf-58e59557a55mr6548127a12.11.1720336564579; Sun, 07 Jul 2024
 00:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
 <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com>
 <CA+J6zkRzM33MbMr4-U56M1SFLykx029+SzEeo8vBicBd9Xs8RQ@mail.gmail.com>
 <CA+J6zkSFCUYLRTRE0Gwug4-fF9f9-YbfRz_atArmMLLCtQDr1g@mail.gmail.com> <CA+J6zkSxcogPXdAdr7VL0B3MnQxQNYwOT5Kw2iK_YfPLW7CMcg@mail.gmail.com>
In-Reply-To: <CA+J6zkSxcogPXdAdr7VL0B3MnQxQNYwOT5Kw2iK_YfPLW7CMcg@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 7 Jul 2024 12:45:53 +0530
Message-ID: <CA+J6zkTyVDJcOoZC-thRAOYNudVWB1wgye0Ezj3o1AO_5HOS6A@mail.gmail.com>
Subject: Re: [GSoC] Blog: move and improve reftable tests in the unit testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, here is my blog post for the sixth week of GSoC's
official Coding period:
https://chand-ra.github.io/2024/07/07/Coding-Period-Week-6.html
Please let me know if you have any sort of feedback.
Posts for the rest of the weeks can be found here: https://chand-ra.github.io/
