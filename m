Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7F32B990
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770680600; cv=pass; b=o/6zfd26tCJuo1X2GO6CaToLgYnYc2QyswzJtdkn9qU6VffADKGPJ0PEJAyR/9bgf3lkAkLzl5asDZ0oB6D2Qyp9ooD2nmXBlngLbCKUej2VWVw+uHTRqdqhAt4hxEEs+kGhRwAFNYfa6X7HTKbCnTH0a8BHtbf/akxKQVJS2Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770680600; c=relaxed/simple;
	bh=VzvuyWGvabhj1xEWPTBaegL00kuALLAwZ8gWoyUnSkM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ot6efOhDR8xIj8m8Le/DM/apSDnUaIqQnOEZgmw8mk5up8MLtUf936yYkF1Ad9cBsHDGoyYxyeB9MmzOR0DaHe2lQ+ZhTp21rVHk8qTsS3PeyGVAcbQ7qqnfLOPh5227FHqP8kyKPzwxSzvTgbtG3AiLtSIXGUIQekCKzggJv1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLr8CjS7; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLr8CjS7"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ad019bbd4so3102784d50.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 15:43:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770680598; cv=none;
        d=google.com; s=arc-20240605;
        b=TXWJHuz4SO9iF9Z2llp5Mf/7rUXATtLx2H0yqKZCSh8uSSF5fVt1rxiEvIcO+bLuJS
         gOkXiV8gf/+7L9ZMFe9c8srqeHkWiE2QxkmseFUlADbDYq4ZbJ2rsbWRKcE3zDlVuKVf
         bM3o+RrmfrwBkzD7eVo3EslFYDwUzLG7eu9pGJE60+R6QpUmalzY/Lo6W9QA7iLQyJ8q
         jczLBVwXp89C1olesgqmQ9bZKLe7GG9lVjntJoWzIdrwmvfcWjvN2tHxz4yxuFqoLW2L
         RkVdj52xkCijU2ks3G59BYKlKK1uSkHTpEkr8kRqcwEzDpP8iNfWAJ8ZV5KtH7R+BHCv
         Zywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VzvuyWGvabhj1xEWPTBaegL00kuALLAwZ8gWoyUnSkM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=OVqHgLo48qkQCtSWgYkAzrN6hfM5J90cmMCrQExo4TzMfO7cO097+bU5lxzxwa5diM
         GqW5zurSqJ5SYQ1Dj5QfVicr/cbeTBMbIA8eQJrYO/NtipNNtfknqPUjvmoz6f1FTSbe
         ptDUq+ai8yBgbikBKpPvBXn3y9FbPPsRW67mNWeT/dgEzUrqosZ1nEohiI9VPf9E0X/O
         a9xNOOr7EpJxE+ST/4Ao8tCXupFoocygB7+LEB47oMo1i1QXXTxhLYvvu4NZ80WgGx/l
         azMM4tHMPGb1k0Ltf02DjBDVfVnLe/BPJSn4a8ZTCGUhqHONMVEzPawwX08Pclx7AxA9
         4/Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770680598; x=1771285398; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VzvuyWGvabhj1xEWPTBaegL00kuALLAwZ8gWoyUnSkM=;
        b=gLr8CjS7bFw+UTLLunaso4nAKcjyphyld94jGxZ0FlGFwlHDtXhMm1XtycMLXmadtd
         Xm07Sa8ODH9ri4DVq7X25nYJ4c9C9lRsOQ2SHRE+dZlgsnQu+lq8s2FlOttJXTgjA30r
         7Vpvexi/pPSg6LyJSkvW+ulz/VbNrWiW5vO1CwdWZpXhFFpxk1zWOVVeIhaQKYVH2uhf
         4N1ezp6b1EiEJYc3RavAvMJ6zcCci0cv2V95enoIQf4UMHZQplfF809KoNgS9/zHBvZY
         4w/3RhbKj+K13s9JqmFV1inufjkQxNsUeM4TrrCYfaS2juVzHL9T+stoqjFqPFO0neuj
         9t8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770680598; x=1771285398;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzvuyWGvabhj1xEWPTBaegL00kuALLAwZ8gWoyUnSkM=;
        b=uHmBg2h5IwhbtfScAQXeRiFPphpScgyqu4pRVP1K/1CpSmzrRTAalgNXjwj37bb/e2
         gNYtrtjTQcXRetP2+o/KXZk7b5ilW+yCy8JDMv+H6Qv/eRtIoiFcIfUN+uhhdl2834Hs
         WGtUCjtgHPO5MZrtatIGEOHxxqYyYpVifVLWvnySD6/jwNdk+zW0BxkTmHwOkevqce00
         CfRYG44HgSA/sFmKTexNposF9VXKSL2KHDUu052om6agvJpaT+tkuI967j4LhIX5CFVa
         M1HiIve3ysaIAM2/uaJl33b0nVnaBnaI+D14PZvprxgXexDwHPZRWRRTtukiPRIUhw22
         pXpA==
X-Gm-Message-State: AOJu0YxKtBiM4V3VewdpsZJb0qx8vpeyxUbT4MaJt4m93GZoku2YM/Ej
	YaPFBSmykLhnlNmTSUGdEz0R2jpM1JpXUfVr0WBXLEnxVJqwwrvn+3rV/3wU5J/b1+58czuf9Do
	F2rUXUN6mqGQlhsee/TwOtC+B5QXuprWghthl
X-Gm-Gg: AZuq6aJ3+jgpdVefAzs87vk/A55+Q2hzsEpcBojOLr/9MC2gjw7F7cchDJF2Gz8gKb/
	rVmHLyQH5fKnmnTfM1r4FYTICrGbPHm30FtyT9K1gjxfvXcdHhur9i61/S9hq/pRo8uqc/FrMQD
	kqKuSke6fRtaX+Y+jA98Y5I+KS1b/TWo6x4FMVpiN1R5RbYj0MhmcfRkJFZuNrxNz2+YTdcF321
	Fv3LG9aJ2zUOnPvF8sjGMNR0GdU6Al58o95B0oA50vgYlg3ZsImiW+d2TllUNMof6r8Aezx96A0
	lQCa
X-Received: by 2002:a53:ccc3:0:b0:649:6a9b:9902 with SMTP id
 956f58d0204a3-649f205d7c5mr7637217d50.65.1770680598499; Mon, 09 Feb 2026
 15:43:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jim.cromie@gmail.com
Date: Mon, 9 Feb 2026 16:42:52 -0700
X-Gm-Features: AZwV_QgYShoJVW3Gyy58xMVHJWlj9CcfP7Y8ZaY-3qmfYKFcYHw1n0CWRS6uWeU
Message-ID: <CAJfuBxwJ_=4mh4gBd3Y98rVRWNZ=xyJAiDxMXb+2TEn6uJM_6g@mail.gmail.com>
Subject: --suppress-* options error out, apparently passing to format-patch too.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[jimc@godzilla wk-test]$ git send-email --to=$trybot --no-to
--suppress-to --no-cc --dry-run
0001-dyndbg-fix-NULL-ptr-on-i386-due-to-section-alignment.patch
fatal: unrecognized argument: --suppress-to
format-patch -o /tmp/tXB5tLINzc --suppress-to: command returned error: 128
[jimc@godzilla wk-test]$ git send-email --to=$trybot --no-to
--suppress-to=all --no-cc --dry-run
0001-dyndbg-fix-NULL-ptr-on-i386-due-to-section-alignment.patch
fatal: unrecognized argument: --suppress-to=all
format-patch -o /tmp/Y47eIqlSDG --suppress-to=all: command returned error: 128

--no-to --no-cc also doesnt work (as Id expect), it still wants to cc
to one given in patch-file.
