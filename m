Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220AB667
	for <git@vger.kernel.org>; Sun, 25 Aug 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724580581; cv=none; b=EXoK841shV6cu1sazFp3KdxwfgVyJ3Lx68saJ9jwdZfob1JouzCXb+9t1jWFTtDoSQnkLS3v+E/P/f9Fz27f+YXFEA/oQBlsFOSMASsYlRdMLQ3PsZOFAOsXoReYmZAlSYHVoY3eLZZS4VGK6ouXS6rY8yO4lSOQDqUTzXVj3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724580581; c=relaxed/simple;
	bh=PMY1qGnxFrY8+LN1cII3z6oSw9EivM+HWF1RHMhgjQ8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=usHf3UDmGg3eyBq/A7EhLFXsg1vf9ouETXYbzaUcO419O32qne5n+VKlx2qeuVMI7d/R8FXDWDytElIP9Cf/Yavc+l9/1rQ3624e3caprflr6ZvYDOIDmacAfUEAJVw7YHsNvOptCv+I0GOoYjU1b6Ud6MPB3mdn5EGY1QCjZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9dljLMF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9dljLMF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so29299695e9.2
        for <git@vger.kernel.org>; Sun, 25 Aug 2024 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724580578; x=1725185378; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUHrKV5yGxhZrVguFNLlxZRZTp4B1Km/7beQ31NfgEo=;
        b=Z9dljLMFV2fSCSBw4Zz+IE/K3xMaV4erh/TxGbUTsbqfqhFeAXH/aelfdQaCOQ/4w1
         bsrR3q0Etdd+cqn8ZWahU1QX+ybhTpYq7FmdfO+Pe02w5Y/t2w6nSyHCJOlZmQwsTgsA
         e1cZAooWOGm0Dv0UNPHrHdILBrLReJAgyeA6Zt89DcLuk++S1ywr+ea/6TPyYDGXmoJ4
         1Tsy/unkrYu6sZ6vHWYOTUST71ba0cpZhACSk7xm4guuWGJi8QjH9TPrQqqS7YQW4eCF
         dgJ8zKc2OGi+EBtcUvikBeQdDA7cJEmkLnNNLXmVMbnRng8Rex7H7j1h4AK/wY1cqImL
         C66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724580578; x=1725185378;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fUHrKV5yGxhZrVguFNLlxZRZTp4B1Km/7beQ31NfgEo=;
        b=kYA/E/iFw1KtSQUTVUZj2iN+rb8KlX/xjl4RoBDDDWq33GUjIcq77Mvq+e8KpNDqt0
         znk18Xf65pFVyfLVEHfYziJdR+IHDf5Ufs0gLtU4LLQGvZFd9kj7XD2ZGP81hRj37CsH
         nTwqWvhJzqtKV5hK966KUYKyWu8ia6GKu5KNE2p43ZrfWspm8C8TAX9obhKlQ3oOJwGh
         gXU/xVgUJj6/j1o2BaoGO63D+l71WGxvmDln9JBB7O+fUnSV7vbEIWJEYDF3V4aHJTYx
         0LQHOA0DmsMx0DVJaXwPWH+fJoyFQzTNaovUjPX21mT78wNBwp512yc2Dg2f1i2okWFe
         y5uA==
X-Gm-Message-State: AOJu0YyOQ6qe7AKcAA9susQggFS6MdPlSpRx1C7vtHm9hsn+jTiW0jSn
	dznQeejM+fZ3N5hP9jioOwJz8JtnWMsyY4pLWQ6G3Hw+Ui2Oxwrj0zAIGw==
X-Google-Smtp-Source: AGHT+IGNHk0EznVEx0xQEgTPzedGmfalyHdWPNiUidV90RvXDBj3+PhXyV+sNjeVR902g6qU1iEVVg==
X-Received: by 2002:a05:600c:4f14:b0:426:6f81:d235 with SMTP id 5b1f17b1804b1-42acc8dcb19mr52600775e9.15.1724580577958;
        Sun, 25 Aug 2024 03:09:37 -0700 (PDT)
Received: from gmail.com (107.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefd9cd1sm156731095e9.38.2024.08.25.03.09.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 03:09:37 -0700 (PDT)
Message-ID: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Date: Sun, 25 Aug 2024 12:09:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Subject: [PATCH 0/5] `--whitespace=fix` with `--no-ignore-whitespace`
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When we see `--whitespace=fix` we don't consider a possible option:
`--no-ignore-whitespace`.  The following example produces unexpected,
at least for me, results:

    $ printf "a \nb\nc\n" >file
    $ git add file
    $ cat >patch <<END
    --- a/file
    +++ b/file
    @@ -1,3 +1,2 @@
     a
    -b
     c
    END
    $ git apply --no-ignore-whitespace --whitespace=fix patch
    $ xxd file
    00000000: 610a 630a                                a.c.

`git apply` should fail because the context line with 'a' doesn't
match the line with 'a ' in the file.

This series aims to make `--whitespace=fix` strictly match context
lines even if they have whitespace errors.

Adding a new `ignore_ws_default` is intended to reduce the blast
radius of changing the behavior of `--whitespace=fix`.  Perhaps there
are better ways to do this.  I'm open to suggestions.

The last two patches [4-5/5] contain minor code improvements I made
while reading the code working on this series.  They can be discarded
if anyone has concerns.

Thanks.

Rubén Justo (4):
  apply: introduce `ignore_ws_default`
  apply: honor `ignore_ws_none` with `correct_ws_error`
  apply: whitespace errors in context lines if we have `ignore_ws_none`
  apply: error message in `record_ws_error()`
  t4124: move test preparation into the test context

 apply.c                  | 17 ++++++++--------
 apply.h                  |  1 +
 t/t4124-apply-ws-rule.sh | 44 +++++++++++++++++++++++++++-------------
 3 files changed, 40 insertions(+), 22 deletions(-)

-- 
2.46.0.353.g385c909849
