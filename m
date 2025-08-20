Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB136CE01
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755717671; cv=none; b=Jx3PIaSTNTPv63bgyVJO5ruX4DEvfJW5WgW3JC62fvfbiLnsgLC9gXrHMZHao+2Sw36GxAqIBeIiKkWrYkBF4oAKtyUE1CUU3Vv/TsA98ZnZWpgvjtMzleCPwuGiJrY+qkO4X7C44+RBrrAUbORGUsnVi6nCGBXQcBBygYTAkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755717671; c=relaxed/simple;
	bh=aEqia7q6zhlLl8brWZIJY2ChjRNiJqtwIpBdVkPyJOk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=WgfHvc1426p/ao/91XLUpddK59KBlAfTxJmxluRFaL+HnJYqAmi01DJcUINg0gjDhR9KsseQfiVGVNscTUAXqGunFqC2jO3yYa+et2GkULvc53xK7Nrvo9N7qlJfB905XMN8YWm/zyNA/VwPn0kliQvL9sQtaYszHlg3a1jFAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1bJWQP7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1bJWQP7"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b474e8d6d01so129439a12.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755717670; x=1756322470; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OCqK/I62XYMEM+d2+UBLf0Ls79ndgGuzNTT5xLdk+A=;
        b=i1bJWQP7nBFMbXdFGdbCRX8j/44msSNhDHFa6GzynJt72SlbxMv223Bm+HcDjx2iEm
         8H93XZEi3U/HTRSG3PKuzAud3kUzbk2o735si3Z4DPzKarMz6OmbWC1wyDAjwRb2ee0b
         5c25RFsv9LZkeknmPjrEUkmmObjJ6Qse7xVjjsC5A2hP4suPHrWtTplZ79TzocgzCr1b
         EKzwl8oH1iF0WiSmbVYNrny4AJtXBDLrPfl19hh/jBnkWWVN3gyyy3HG1WOm+c4ccbQW
         1QFpsbVQKqMwGOTHAOyOrKCaF9CxYpUf9CivvFGjlkmrR0Fyo3vbbrEjHfBF3WqBhOY7
         XxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755717670; x=1756322470;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OCqK/I62XYMEM+d2+UBLf0Ls79ndgGuzNTT5xLdk+A=;
        b=oLqscqVJ2ZL7d/TSnY6ZrXqD8SyrMs7EKAQEmySlJOasFbL3Zci48DqHaqaAvXLyJz
         w1ElLGwxDji9wJLT81TCwa3bId78mjpvu15FGT+cZezwDbR4Co0z7gliKP41yrWeequo
         jK6ADPFOaQ7vzhxLL2VHWqEBCPknyR3l5gi4JjNsJ/h0zTP3k3bsKRyanRoI/wg0Z909
         AidwVewo5FZTbwMgZjKWTQRq6+i72zoEY37gNSM6U73Pczz/G+WTMNCWuewagFVor8oK
         ZAeoXwrjv4a514/u1zjfTEhNL6HiOkmzS2lJdQFmAuaFpPbixvXc6UTnBLFZCHRqkWZT
         TeBQ==
X-Gm-Message-State: AOJu0YyX/RKY0pUe0qL0X8Em6Mzj9axkHh3i/3K0ljHZLWunvkr3kCxr
	Z6pHTfmnBecLKRQAWAHC9AuEYlrp8do9b2e0/IK1FxcDJk319+s/J+Gs65EA7g==
X-Gm-Gg: ASbGncsmUZY4tycbL+AO361QdT/hASoXLuLRVHqZSgIeY4Cxhrkf9n45NqBf/mhdL6k
	yk93as4vh8lEmhJzBvmanXrjWrBWxh4J8iN7S8m0GpgabtDGat181Wa1JW8Ap3/Yi0u3pCPeD/6
	YNbDcPkrJ61na1vFFkpAjAjxehsziuYiZ7jf+HLvHBDwA4pKCetckGCh6JSV4SUopDTtX/TvzMt
	/WUow24n603wPonKO7d27BJIJvmpM4VpSwjWZvzbCIwC/OGS4/lxx1jRj60Q3N6dOKhbsahhK92
	XMREm1w2MSOeMI8jaNZ/ZOyh6EdLyBa6enP8Bhisa1Jrt0if6Sa03Q309XuniFQe7SF1SFgSqve
	3WAOOzkZTiKvwgWkRw5+GLymv1wT8/CVTtMtq1WoyB3DZ9aB4HcI5qXre
X-Google-Smtp-Source: AGHT+IFHTLx76H0W/1ZNcdn6EEFDH/pRLaZXd+bN+A8DsNGpXHVynp2xIwy7JZeBZITIhfnixgE++A==
X-Received: by 2002:a17:902:ccd2:b0:245:f7f3:6760 with SMTP id d9443c01a7336-245f7f36a94mr25323335ad.55.1755717669550;
        Wed, 20 Aug 2025 12:21:09 -0700 (PDT)
Received: from smtpclient.apple ([65.129.145.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed21c104sm34255475ad.0.2025.08.20.12.21.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Aug 2025 12:21:09 -0700 (PDT)
From: Dan Allen <danallen46@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: I use whatchanged!
Message-Id: <83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com>
Date: Wed, 20 Aug 2025 13:20:58 -0600
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)

I just updated to git 2.51 and got the spam about whatchanged being =
nominated for removal.

I run an important python script that uses this to set file times to the =
dates of the actual git commits, so as I browse the files I can see =
their last modified date, and not the date that the file was last =
synced.

Now, if there is a different way of setting a git repository's files' =
mod dates to their actual date and time of last commit, please let me =
know!

The exact usage in the script is:

    git whatchanged --pretty=3D%at

Thanks!

Dan Allen
Idaho Falls, ID=
