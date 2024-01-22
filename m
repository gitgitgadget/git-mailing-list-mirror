Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4B38FB7
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913524; cv=none; b=ffLHHEK7oPVl0Y7lfS266LZfeZdKScqpjNoy/4ehYvvyQhlhB8NElglBOgUg7nOby+9PHbIZ2DEU4c7+/d278fJgWSZ346yLi6uEgR6kENZ/dgnmMaMMhFmL33jf1uKMF/rhoPo0ibnjkl6q72V3kLr4svbfqoDLI1ndPdvq+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913524; c=relaxed/simple;
	bh=75RNxMklKqRa4pJaZk9DiMrKXigVQBdyACAIJUP05Jk=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SWKHNPDTL6SFZs+/mk6NM272xTVbLCkRxZGMm87t7C7e6MEKIt175yvYO/jfZlFsppsKCCknSCWGohrMXBzqAoH56X0pDoVAuVj/NgNXRxhy47JaVdOMEil8RPGY4Dllyu2scz1dHPVSJTJCrG1M3MWIzxCAEQLyFqrMF7FPpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0znvBJF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0znvBJF"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3368abe1093so2460415f8f.2
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 00:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705913521; x=1706518321; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+YrSfp4N0e/JsU5H1md3dsxuwt3MnCDClwbwTYhpqPo=;
        b=l0znvBJFPL1DwLCoyfC1sOeGtuoMvJ/hgILJwR+3dy0f+icKjBwF7LAuqAUTCihmIs
         IxcQrJt7wA5YaqiIJsxqvOF7P/4XGQF8w8GJ2IO9hclLkzo+M4GIs3cDMibVRXOFw7ki
         yEnKFPGEZP3w4PdHLZVdK3q9qjrFBgUxZmED21MxEf+ekz3jPeWKp8anxV2onttNBCMn
         JD8ItO4sXXZJwjTu1YVNHubzJgKxNoGFyaaRrvC5Dn7i5acp1KLqjAa/VQ/Mvc3hVp9r
         LZTWpQs3+chcquFJlq6FiCjFtiAyggSHDwct3A3EwIAOIlCehQ8lNwcIDK3WaozFACZk
         3yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913521; x=1706518321;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YrSfp4N0e/JsU5H1md3dsxuwt3MnCDClwbwTYhpqPo=;
        b=rsdhf85SYgJ4BpZVO6yK9WMH5sbLlMyp4gTUEUcPSDg264i4VxNJjFwariD2jA2nWU
         vyzvHQIIIBh3fNXhaHxn8qK1yKeLmPdRniSKwaxS+bqLAyGP6S9lhye7F57sAnSJ6XFa
         ee+xtu7xY/mhDm6w+epdS3NKBvadi8/rf9CP8V6FAiprS1Q9cYaO7VH0dA9DTeeGwn+R
         tntRAs+1KBnSWlrpJqzDjXR+inqjjeloidTZJkEG4E+n4cx6UwCSlolr4uwpXj3exjfB
         16aAXcq7qLFSKF8o6wm/wXdfRclTvVjFp4e2pnxDEWd0pCyQaCr47PqXHb5oQ+UMcAvz
         UQ7g==
X-Gm-Message-State: AOJu0YzFuBIJZChct5APz/OVvMdJiicaGNR3EenIef7+eBGNwdTjOk0N
	ByJBgm5XBqQrSgwoDm94bydKUxDUGmMUZh/oyZSDzq5A9amLvuNPRX9sYYmJ
X-Google-Smtp-Source: AGHT+IFqsfZBoKIClOdkZIKShW6eR9SDp0wKLxLwhJiVVeG1bQEAXfnKZunEoVMYcbw7p8+utAWSyg==
X-Received: by 2002:adf:f011:0:b0:337:b6f6:adc7 with SMTP id j17-20020adff011000000b00337b6f6adc7mr2203548wro.99.1705913520520;
        Mon, 22 Jan 2024 00:52:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18-20020adffdd2000000b003393249d5dbsm3106452wrs.4.2024.01.22.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:52:00 -0800 (PST)
Message-ID: <pull.1646.git.1705913519.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jan 2024 08:51:57 +0000
Subject: [PATCH 0/2] Replace atoi() with strtol_i2()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Mohit Marathe <mohitmarathe@proton.me>

Hello,

This patch series replaces atoi() with an updated version of strtol_i()
called strtol_i2 (Credits: Junio C Hamano). The reasoning behind this is to
improve error handling by not allowing non-numerical characters in the hunk
header (which might happen in case of a corrupt patch, although rarely).

There is still a change to be made, as Junio says: "A corrupt patch may be
getting a nonsense patch-ID with the current code and hopefully is not
matching other patches that are not corrupt, but with such a change, a
corrupt patch may not be getting any patch-ID and a loop that computes
patch-ID for many files and try to match them up might need to be rewritten
to take the new failure case into account." I'm not sure where this change
needs to me made (maybe get_one_patchid()?). It would be great if anyone
could point me to the correct place.

Thanks, Mohit Marathe

Mohit Marathe (2):
  git-compat-util: add strtol_i2
  patch-id: replace `atoi()` with `strtol_i2()`

 builtin/patch-id.c | 14 +++++++-------
 git-compat-util.h  | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)


base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1646%2Fmohit-marathe%2Fupdate-strtol_i-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1646/mohit-marathe/update-strtol_i-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1646
-- 
gitgitgadget
