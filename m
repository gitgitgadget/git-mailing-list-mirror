Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC346BF
	for <git@vger.kernel.org>; Mon, 13 May 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612870; cv=none; b=ELH6poHD00FBFcMf8F7bUedjR79HGehjihEl6bGyTbckmRFSjzEg98jcg61UoLzRYQ+rQgmkBMpBxWK6wkYmFkcQDMU9ddy9R/AGKIOJ9HR8QeWnwydgYvfEe2hkI3MXClb5gbINe0wEH6UizKEdB91JkOfqBmK+/50JODtYSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612870; c=relaxed/simple;
	bh=voEI1+yW3BUeYIbJmBheYuIe2KfA/MmVIvawaR4thvc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KE512uqbzFVC27UPUc1anKzfIkRLqi+h5K17G4iosRFC+JdOL7qieh0QhtXWMKxq0UOCDfUMIfhJwedyAY6cTGrgUE+rfeaxlv5ZadwqIrIrmr7mWbVSYOBQYoMQ4qtpRX+FQ5HjRebpAru6uHVBVB72MIP8IjD9qClcludK0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrPtXjle; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrPtXjle"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso4001103b3a.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715612868; x=1716217668; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=voEI1+yW3BUeYIbJmBheYuIe2KfA/MmVIvawaR4thvc=;
        b=WrPtXjleTmKakruc4wnl4ZjKTtsTjpIlzG5OIMEVKGxpyPO9ig5iKiww7ZHAoUt6xF
         la0HTfHcIgSDQrc6mCY/NZbDkRLm1kSyShnPumjK8qbStAP9NERbdqUGACgBGG/xPfNA
         Lwd1ZmH+Z/jOs5C7yJ41RWVJUOd7apDNI6v8qSndE5UYGBVb5u3IAbksrG5XVF1MGO/v
         5TE/z5QlB4Fyh8gwAH9okZWhikcsDzwSvOhVF4AzlrGei4NZbrsJf2NmvBqNO90cEduI
         lZ3NRMsu/+OoyRKXjqGOiiLtLEsCwIF+EJ1UoyTo+Ga4F6yQ+m2L3wCge6JDux+EiL64
         Kfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612868; x=1716217668;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=voEI1+yW3BUeYIbJmBheYuIe2KfA/MmVIvawaR4thvc=;
        b=xAj2lUhXR8JX1mEfxGDObltdlbE3MGnQgBApDB6mzrGUkwbDDTUVCPHonVKToSgPzo
         v++IziJolnXYhiQSoM0Ci+QDU6Z5D0Mraqor2n46oa7UKUlVuqk8naOXg3ydZ/o30NMj
         lCJVjzPwDEaAFVErsiFyGuWF8AtBfvNlK59MoUWvFyN65ynvWMBFeFcC3NUvk47bvPgi
         rJvufypszbzFomwvSkF2trmjIWEJvJNaExOFWkiAKk6ZPfIozurEnu6xumeDT2R1HR5V
         8tcXbLzCG6OrAX0S4G8PcJW0F6OdGpvA5n55dM21fJ+ozLgvjTYTbKEvy8eE5zhOD8gd
         9C2A==
X-Gm-Message-State: AOJu0YxDL48ifmavK7EtPjFiVgaKkZs7oND/8AwAf60MGyBuvlRB/kO7
	xtq9UxSYYwGtIjW2N8fulmwVueWxtik5ZdooXX50MnzV//p3BiSjGaP3cRiO
X-Google-Smtp-Source: AGHT+IE0ecsCPwCs7DMPu9glJt4wI1kqjmlra3luUi/kS9ZSMTF00FSj57abSOVIUY9N3gJgRbTQFA==
X-Received: by 2002:a05:6a00:1ad0:b0:6f4:d1aa:bbe7 with SMTP id d2e1a72fcca58-6f4e03bf5f8mr11840056b3a.34.1715612867995;
        Mon, 13 May 2024 08:07:47 -0700 (PDT)
Received: from DESKTOPI2S1NGB (99-58-59-125.lightspeed.austtx.sbcglobal.net. [99.58.59.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f399644fsm3752787b3a.100.2024.05.13.08.07.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 08:07:47 -0700 (PDT)
From: <lbdyck@gmail.com>
To: <git@vger.kernel.org>
Subject: git client enhancement request
Date: Mon, 13 May 2024 10:07:45 -0500
Message-ID: <02f201daa547$503df630$f0b9e290$@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdqlR09lNiRS1Ci0Q3W3I0RYf2fOnQ==
Content-Language: en-us

I would like to see the option to allow the git client to request the
creation of a new empty git repository on the git server without having =
to
open the web interface to the git server to define a new repository.

Perhaps something like:=A0 git server-repo public/private name

Thank you



Lionel B. Dyck <><=20
Github: https://github.com/lbdyck
System Z Enthusiasts Discord: https://discord.gg/sze

=93Worry more about your character than your reputation. Character is =
what you
are, reputation merely what others think you are.=94=A0=A0 - - - John =
Wooden


