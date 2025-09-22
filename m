Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BE3A1CD
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579105; cv=none; b=cw12Pziqa1u5Crz2xr2scasQ/rdY7sfTmVHEDhnMhloqDzyJ4tGXX82J5SRJe9xVvNw5+u0wyk1CTz1VN3MHmQhr9gbfeR/2otMIvdDM+wJ+KXntjl3ee1CVmojXO4ih7MzzaIiw8faLkjjqdswQiHCgyH6JOeuoZVp0caTWAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579105; c=relaxed/simple;
	bh=w0kVvWtbNaun1X5UkK4RXZLBEiccD1rgNUWQeJPingQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZGVD4Jrvbsb8D/k6kg505FUBlN9vdQu1A9iuZYKjBZ5BpzxulMNJVQazwwMlS6x+eTG/Q1CHdt8lr2gAWCcS5RemEzetqBhgk8jF6GkyVwNAPfKhzI+qpLPEXh2pM03eDzLW2plDg0qbm4ZXEmqFIGbzM7ujj8fz+09g2FHhJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digital-mercenaries.com; spf=pass smtp.mailfrom=digital-mercenaries.com; dkim=pass (2048-bit key) header.d=digital-mercenaries.com header.i=@digital-mercenaries.com header.b=Goz61iTD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digital-mercenaries.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digital-mercenaries.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digital-mercenaries.com header.i=@digital-mercenaries.com header.b="Goz61iTD"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f2c7ba550so1710951b3a.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digital-mercenaries.com; s=google; t=1758579101; x=1759183901; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/otNnZaQ8ZlxnMCgQ5vDxQxdlgZ5lnU7cExXNecifA=;
        b=Goz61iTDRBko2wWPNI/8NG87Gwh1uCyklxbZHIyBHMjuzbRkACOEFFP+kPVbOS6ClE
         Z6lmwBke/NCiozERJYNdyNLbc8GjYKVzJN/qlbHKVR6yMt7YDzhPw1IuIPOiIZGzGnvC
         A8k1PGx8vCZCtR+uE46ixksAdlJ83NIxnMM/G1PnnC+BtfixCETE3rgCJbnxYNwVJl1e
         j4ZMJl+FcuLna9C+Qud9KtQRJTaH5irwRJNdyGbc24nGUBYmOResAd8Z5hYYH1xO9HE8
         ZN3lEOpMj9boFg6RKV2J0daEZiv2QPhVC+Qq+FRPzndJd0KFqCjuqJva9G0LyHXMnOPP
         XXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579101; x=1759183901;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W/otNnZaQ8ZlxnMCgQ5vDxQxdlgZ5lnU7cExXNecifA=;
        b=H1vtFaTgjMcxLVgZ+EZ0HZEotVxrKJJMEHcWzcuviuEgJWYjAdNO1fdUD6BrFz+KD5
         CFlaBnuUtRCNpLFaq4iPYcENrt8oaHDX1zoChPujyJ4kgjiGWrNkGZxDe8SEmR9JbEFP
         vnQfzg2/A/iSBdIoE7aN//7Ji9l3rWw9sPEWBPpLmiHrMoVnZ6G+5xGo0vLLuXfIn57G
         1HLZsBx2yncVxo9DvAT1PbMwYgKIzB4T6c4Ora+Wgon6cL56qsJSGE9mJv3h5XBh1AlO
         aXbn3mSc7ShZFUySegs8YXGxSQEoU5tw4hqCgPVcYOA/AS99brZnvjQcD2aaGqW9W/+J
         bW0A==
X-Gm-Message-State: AOJu0YzHHxdJrBE4srRXGQgCdI6ESCY1s1/2DbYbRb3KYDDga2MEI3hZ
	552t8RiWkFLGAx2T2AdMcAw+J8pjDaw0TqAk68ShC6NuZJIVl4Rf1vtJJKC7bofOqKGOflnO84/
	27culxMc=
X-Gm-Gg: ASbGncuwlcdtHuYt0yr3gtiSfq2lUzbuwZzzUqoGPca4+3abHLBuvJevTJWHYTyV8se
	9SzARzeQhizo4CQHEkEx3yXaSunfuAIMDvIQf87SqihYid4Rw9GtFFr5MJq6vIrSRHgqOjA92BE
	6oh0K9p5PYJFcEqn8pQEqIOhYfK2hQKSGo2bJuCHojAWrm+znVeJjLt6KFSoTUf0bI025LXuoAi
	ZqUqhlHaprA+GSvnfcHNa+9nKvoG7dKFsHd4lUOXBkKe+EqGrpAnxxzDZkj9mtbmQW1xSG51e9T
	dNKJ35fdr+1ZjD7LbVs0pDH1Ou9wXDWiFyj+accwWzKdwkbtedqnIvehR6mck4D8liq2/NhOum/
	h4/Du5uCL5Rmd1fHYk4NikkL9vybu1FL+zkMSOzY=
X-Google-Smtp-Source: AGHT+IFIeU6ErJFEWWPIjk7ZQGFF5iQyIf0VXbBOVv1hp9CSyA0uD5arK1bqQ5ZYF13UI8ALbzUiHA==
X-Received: by 2002:a05:6a00:17a3:b0:77f:2ecc:8c9f with SMTP id d2e1a72fcca58-77f53b08ab9mr560550b3a.18.1758579101518;
        Mon, 22 Sep 2025 15:11:41 -0700 (PDT)
Received: from [10.0.0.22] ([174.127.235.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe669a58sm13887637b3a.52.2025.09.22.15.11.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:11:40 -0700 (PDT)
Message-ID: <8f201082-07b5-44a1-88cf-d6db551a598c@digital-mercenaries.com>
Date: Mon, 22 Sep 2025 15:11:39 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: S0AndS0 of Digital Mercenaries LLC <S0AndS0@digital-mercenaries.com>
Subject: I still use this/these
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Howdy Git/Kernel team!


Recently, as of `git version 2.51.0`, running the following commands be 
popping
warnings;

     git whatchanged <path>

     git log --since="$(date --date='-2 weeks' +%F)"

...  Warnings stating those using certain features slated for removal should
email y'all about `--i-still-use-this`. If there are alternatives I can 
alias,
that will remain functional, please do let those like me know. Maybe via the
same sorta warning system.


Wishing ya a magnificent Monday!
     S0AndS0 of Digital Mercenaries LLC

