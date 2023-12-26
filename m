Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB736B
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THVS9rGZ"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2046dee3c14so416349fac.1
        for <git@vger.kernel.org>; Mon, 25 Dec 2023 16:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703552296; x=1704157096; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmjUHAO6NK3Y+aU1awK26ZLu6pDWfSKJVhUzK50rFY4=;
        b=THVS9rGZcAms/MV8ZtN2o1vYM5/VxOgLVZFc9Sh9aiPETnX791/bteoftaoMEmfl/I
         f75gFKR1ER1JAZ2N/kGQXBC4CI6XVJwIIeUwBbxqCZj8DvobdZ8lwe5Qv9D2wMyoURy+
         GmQGi0JKQGINrpACFFtsnKOB/ciILvwvTMUidkD/Vu39w4rup7r9Y2SgIYCkl+pLOpKC
         kNaX/3wyyQTuXueNeMyqRFS27hUMYqZmYygikG+3qFTg2TIODcftwS0R/pF/s9cvBTYS
         E4qz4Q33iIUgjyM4Mqt+usgxUMiTFyeXhT73MSSyZYSUxDwppUlxleM4bzpV1SdFgtxc
         CuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703552296; x=1704157096;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmjUHAO6NK3Y+aU1awK26ZLu6pDWfSKJVhUzK50rFY4=;
        b=RrZBEHbbzSa/6vfxpKFy2bbY+TXQOXy7g7YhxFQuOqvne99AzocmdcXDJY43pOPywu
         U1YDn09YOZzI9CwS5ZTjkfQZaQ1PdCE6C6DoagXLAOksIg+O83SiqcOWl39p9tSfOJGc
         wVxcSFYY/V6NxjJzMv51Jolcyxu1IIud6vAd0E8GAhA9U1OBd1WGnekYY43GdhziW2yr
         9GQfFvl4BnmWbOk4NLE4Bbx+uylhENyg1jHPD5juTN9vwg70tGCuiQkzNxaol6rY8fAU
         IOhx6SuMOUMSpr5o2LAnMtAjUx2EzmLLfKykwm5Lz1J0EB5VoEVmZOWwFk/nP1E2aygj
         cRgw==
X-Gm-Message-State: AOJu0YwO7oYoSWUspcFOo4sdSrLSldjcOOTT6ubVWOmPo36eV1tDImXu
	aDRh1DJl1TSfFLnHYL3rItQ22qzHJMU=
X-Google-Smtp-Source: AGHT+IFTBQrq4U2TqZUr2uZOHx1qBZCXR+BYkTlYOljUpPnB9W5mNfXkL+IYks0Wwp6btAbrH21EsQ==
X-Received: by 2002:a05:6870:1c8:b0:204:20ed:6d28 with SMTP id n8-20020a05687001c800b0020420ed6d28mr4142378oad.22.1703552296265;
        Mon, 25 Dec 2023 16:58:16 -0800 (PST)
Received: from [192.168.1.89] (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id gs11-20020a056870ab8b00b00203ee39e653sm2512195oab.3.2023.12.25.16.58.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 16:58:15 -0800 (PST)
Message-ID: <6de00946-9c5a-4854-9e49-069a22f8a782@gmail.com>
Date: Mon, 25 Dec 2023 19:58:14 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Eli Schwartz <eschwartz93@gmail.com>
Subject: subtree split after deleting and re-running git-subtree add, fails
 with "fatal: cache for XXX already exists!"
Autocrypt: addr=eschwartz93@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Originally reported in https://github.com/eli-schwartz/aurpublish/issues/30


Given a subtree that gets messed up, some users might naturally
gravitate towards deleting the subtree, and recreating it again via
`git subtree add`. This can result in a difficult to solve situation.
Any attempt to split it seems to produce failure.

Reproducer:

git init testme && cd testme
mkdir foo
touch foo/bar
git add foo/bar
git commit -m ...
split_commit=$(git subtree split -P foo --rejoin)
# Added dir 'foo'
echo "${split_commit}"
# 42517e4b9fe310a64be2a777ef08c91bd582b385

git rm -r foo
git commit -m deleted
git subtree add --prefix foo "${split_commit}"
# Added dir 'foo'
git subtree split -P foo --rejoin
# fatal: cache for 42517e4b9fe310a64be2a777ef08c91bd582b385 already exists!



The interesting thing here is that in git.git commit
d2f0f819547de35ffc923fc963f806f1656eb2ca:
"subtree: more consistent error propagation"
the git-subtree program got a bit of a facelift w.r.t. proper error
checking.

In particular, in find_existing_splits, `cache_set $sub $sub` will fail
here. But before that commit, the die did not propagate. It turns out
that actually ignoring this was "fine" and resulted in successfully
splitting (while also printing a "warning": back then, the word "fatal"
did not appear anywhere in the message; now it does).

As a quick hack, this seems to restore things:

```
@@ -499,7 +505,7 @@ find_existing_splits () {
                        then
                                debug "  Prior: $main -> $sub"
                                cache_set $main $sub
-                               cache_set $sub $sub
+                               (cache_set $sub $sub) || true
                                try_remove_previous "$main"
                                try_remove_previous "$sub"
                        fi
```

So:


$ PATH=/home/eschwartz/git/git/contrib/subtree/:$PATH git subtree.sh
split -P foo
fatal: cache for 5f662c163282b3657604c789ae639a98c211d5a7 already exists!
5f662c163282b3657604c789ae639a98c211d5a7
$ echo $?
0
```


Thoughts on fixing this properly? I haven't looked at the implementation
before so maybe there's a better algorithm for handling this. I suppose
I could submit a patch that adds a `_cache_set` for cases where you want
to allow duplicates, and use it here.


-- 
Eli Schwartz
