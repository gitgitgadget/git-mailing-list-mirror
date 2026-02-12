Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264D35BDCB
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903546; cv=pass; b=Y2fHEWGr5R5JILH9NUQRf3yvUXJN4wTb9tMKd/cW36P2/eebMeSal2kv76GBLEUG+97dpuOiaBY+lbSS9ua6U8wVAv5S6wkjoVGVExG6LqNJF7G8Ay2JXPGefzCaph0jTPWoQ57zgCxLJ12DRtEs/Swplv2FB5bBN4ttqkvODO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903546; c=relaxed/simple;
	bh=zoxnbDK4xRJH/q/P6DnLYe8/Y7JgIQvb6FQ/kQWrNG4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=o1ia7U/os2fqXnnp+Ib0XO5cmSW1+cQYDk/H6E+laUkVw7DcNWDjCyKzoe0D8C4BeSShIuwfES1wWTWeeQ0pBRZrwNh494M9vC9/lCwNj509W6JwmHb1iTmq/+VxJwV40bNjOEadiuqYYFc+4XgM8Ctpv2pg7t5KtIj6PtNX6qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCCkxtqD; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCCkxtqD"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5674cd243d9so1001342e0c.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 05:39:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770903542; cv=none;
        d=google.com; s=arc-20240605;
        b=DARGusMYi94eR+B2n33Ouhw8Q9HW12V0MUe472f7+wJQ+MvSi/uzID2pnMQCMofZOx
         z6ovPaGtmdKkRYSp7E97E9xZ0CvlEmiTCkltXr7xwqVTVa+rQuhPoz5csOUFK9dbd2YM
         ChjjG0OSHTJq6tF9G7TcJGUmSLhdZgyKR8y+k12ndKuy6aoN/JaANYCB/EXjd4TcRYXA
         anfpqJIepe8ibEeLKgqJV82dRzvJAM6/TKE5ypgAubFk/2+9G3x5/lkfg9n07ydbKZIR
         IsEaMANInMzXrxpmUl8EsijC8Z8HVdg49qBjL3+msZBZQm76u2gqo4YJfMREhJvH9TEx
         tNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:dkim-signature;
        bh=zoxnbDK4xRJH/q/P6DnLYe8/Y7JgIQvb6FQ/kQWrNG4=;
        fh=WfJB1YkHjfxkSMCsogHMbYc3pvCTmQRpLXh1eGJSZoM=;
        b=PxTHNTbFH++FRZJmlRs78Bt9eoZOiNCUCUaBF4kuRzmcFHk2VokZB2ourRiX7YMwZf
         7gVMW71Lgc7vVBmqJD334n7vdiix2FuSFGN9VOWdo4nhTpO47hueFloqgqMUT1Sz6GEG
         XueB491d2SifF6OKJAQQ5zdRW/5EiGdGUJ+a3f4EGNyvsejZAZhZH1IJ1qDGmMtG/h99
         XNTxVndurFOvWdmZAODDi1YTrufQ7nv+NOLCYGaiO2jN/ujYb36Q3ZviEDEdLU0Fjm1e
         kzoj/BQ/v6muTuskRIMdWjiTa4X4OAMEEHbK8ur5stqjxuX4jwDeNsScoLcSDusyR17c
         w1hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770903542; x=1771508342; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zoxnbDK4xRJH/q/P6DnLYe8/Y7JgIQvb6FQ/kQWrNG4=;
        b=cCCkxtqD+zteGUG8aVGBjBl1U+GDmlEsilGtB40h0fOvDDOpsXuM2sSlj/Wz5s76UM
         CQd1wsKXmAr7HGcRPcT9BU97wUbUiPRyx+ZtIhPzjWASgXogIoiwR2WUcZ0ETnrkumNH
         lcAlK+gOOB9GchqcQvDau+xDHdui2yCuBMerCWYC1QI1uaMBQiBFUy2wJgL5zSS993Gl
         oo/K0KSPxutMz9Ld4UmCSNXQ5UkUwKLEWDie0MwfXjV0/WiIXTrgrnKMz+Q++xSxX/zB
         7G9F2y8hzNJpiDeBdlkL68RHNjzhLSJoQgYrhabvwBVq6hmBh7wUZp2fW/34cpxk14lb
         IueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770903542; x=1771508342;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoxnbDK4xRJH/q/P6DnLYe8/Y7JgIQvb6FQ/kQWrNG4=;
        b=M6QvPEpRLPFEc5lHpvneENGQGY3TcYKPmR09fJuI98LhJwl4apEzfEsa9HFvyAPid+
         N8u6ubtlXJqzgk82BE08HSLS1tgRo87YP6JC+kMD2+oYNEVfuAc4m1o7bOVC1v7OM0vT
         nKy2MGK2Sl/1Eyuxa0BSVIrWRrAdbgV41lcMeJP14lqU/susj+mTsNQMBKqVW8iAYdrt
         lPvRFWPvbManxxsjm6oZjEDQ3w0LWlf0KCwCA/zPeQ93ZCPpsA3fWVEQHMr4gAx9pZkw
         Q8BXeu8ARm3Ovs0TIikDRFLlKAxm5vK9wHQKrL0ZL6ShieOUyCUiMJYHpN5DBweRM18v
         FpsA==
X-Gm-Message-State: AOJu0Ywdhepoxvbp823yfv+414DhtdKyRKtTfi4UCSYTBVzQFbxoba0a
	ab0HhDd6iz5tikF9SFRMm0DjEZyIX0J7/ej/YedZE2QOTZVpJZcqtyN+OTR0nmNOjIO4VyLV43Q
	m0j8KQ4EaSKqsm60ojip7yUPo+Whm6MFJu8E0
X-Gm-Gg: AZuq6aKRTqbhv8ok5yOjbbfxggTxQh6VfVj5/udK421lYTP2YFriifBEWTcxmwg4e1k
	1t8sFBSWM89XxKX/OZ9REz9Sb/QqdyQqvc/oP6fo4FuGbCiZxd/qwA5qKW15mL6F0HxCkvsZGm0
	ADFShZekf4T4EH6XbNyF5zyZUgmTqY15t6fOfH+ZzerBcx94Y2cSXutUPP6WIhw9LrMb06vNqOw
	RuurXIgwBlPL5wAGB4YLgya2q2naRPc2wI+r/GaNmLg/HZNxDKHA4oGGFjX2l3vnUiQ8iCExZzL
	hUv9nJHmDgz4+A4Cvsqwo7Ndrp2oI8aLT5nj/bZ+ZxZwmGzw3HNnJEGAKlLAqd+5PdQNvWxvxBC
	biN196tYNYMZyiyyCahBe61fW+vI=
X-Received: by 2002:a05:6122:1a09:b0:566:eb71:73c9 with SMTP id
 71dfb90a1353d-5675a2ef563mr541866e0c.5.1770903541925; Thu, 12 Feb 2026
 05:39:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: s.celles@gmail.com
From: "s.celles@gmail.com" <s.celles@gmail.com>
Date: Thu, 12 Feb 2026 14:38:38 +0100
X-Gm-Features: AZwV_QiZrAAZ32Py6O09STrvYFZqitmoiZes02n7DJE9HHLZSC4i0KE86ROBj08
Message-ID: <CAKz5CKRAKOmAYo+qsPxrozMrRy1cmC9E415FiVsw-CeEc4rpHA@mail.gmail.com>
Subject: .gitallow
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I wonder if the concept of .gitallow have been ever considered... here
is a proposal for comments

https://gist.github.com/s-celles/754728bbbe5312300982e2f2045f5f03
(sorry it's partially AI generated because I'm not an english native speake=
r)

Is this a topic which have been discussed previously?
I went to Discord and it seems it have ever been discussed according
to someone who answered me but he can't recall what conclusion come
up.

Some help on this will be great.

Best regards,
S=C3=A9bastien
