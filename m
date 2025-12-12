Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A332F6167
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765562646; cv=none; b=t4cfuoFPY5tPMTSGKlw3+KyRdo+7BQxCKOjzzF7ITf+wMyxtj1wg9JLeySShC2yGPD3THh/pIf1gIf5FaDB/Qm+DldlJ5eWu8ksuF8P/rdwM87ws1G8y6R3HvS/nxMGbIqGIJ2cNKfBObgiz82dWSWAPY4ySCUfjb7SNnXPBt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765562646; c=relaxed/simple;
	bh=T7PfFszL2lgvebItpAapq+dN4S4UYgQ34hnMKHiSt/k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pUZoDn+8yMPeaAQCZjY8camFkRw5hTsgczGL3iTg1EfDjeKOAaownEYtolLT6qBafJ0gidS/0WJfmhA3O0A0J7AJLLXxXRna3j9LHOcQM7H/w1WD+WPPTTOZK/GjjjyDUftDmpvOYBod8AInW5aUb1ezRnV+DMRqmhBEvbKnsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGWj5FG5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGWj5FG5"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735487129fso261986366b.0
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 10:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765562643; x=1766167443; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DU3q3tR+Joh8KiADOm4LiaxDKu6ES/9FIjV0E+gDelU=;
        b=DGWj5FG5WRPHve/w92wGUjLIvEG+x1oY6o4DV+8UPtPRFgRRdmGBxOQnfajRTDnrrY
         /eZiKMvPHLXdZuV+NwOQH1uuzgmFE/S+ZQytZFIS0bfBWQ78rCCIp6HdUG3ZWWrxR8OJ
         B4Fj6Iu2KR6n8rk0gKTLxIaQO640OOBaDnU902uWXdh03KHhcFcoDyfCQ7w1sQUPOF13
         pd+uvHDZf7l46zmL8maT7TimL24Wy4O+NxLvJYKb/jZqP+bsZrW82YwKjriy8UNqB1b8
         4EivyPvaqezaXnhXMKqxfMv1KE6yCQ3ZR8SG/m7Zpx7MyOJ9duNgotqST9KN+jZfXJCG
         S2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765562643; x=1766167443;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DU3q3tR+Joh8KiADOm4LiaxDKu6ES/9FIjV0E+gDelU=;
        b=QEGV5kVRuXz+p8YLz1ncOMp9VSkOvhRqyVR1akaPn+M1eAio+7mk1nbDNbJ91Tu5Up
         WZ/pLrR0NIoxHsH1ZrlkJ1aunQ0+em2AiG4KbGt7RWCOCdny90nCLebJafJFPE6lpF6D
         VXyqTRphr5SRbUrM2fyG5XZ9i0NGwfuHnBU1oN5DCmBt1JYjFRSzWO+LeYqWf3ZgYLIr
         FYHDAdHyrWGz4HhCfZ7itD7SSQ2TXvnmwtKT9HH/o04oGjpqbRQx57px7cVrUitrjdh6
         4TuotNqYaUE2ZJ3lShlPxNs9YpT1QmLMaKJ6lCPD3pnD8zTozZoVINTXqxnQcEkiWXKr
         iKPQ==
X-Gm-Message-State: AOJu0YxifIRP1/BHMPoCxyCOMt18vaoT9y/Sp5k/ziXX6cE4p2UtyNlI
	t7jCtud4ZLnPPOTitO3Y37obsY+6KwIKKH7ycrnlbkVoFi8X2vubnL7ZMzz75g==
X-Gm-Gg: AY/fxX5C118MLbYqrjrQDwLlFLdTCK1/P9K7JmBvILNvdc/jT/liGtYWGxaIohrfVTP
	38Y3hbgShdu4sME7AbLp2C+hWqd+QBuglNu9rNXCp6ZI8e51uJgXXiqNbaZKMEuI0neb7/zPcvY
	5P0NZJEIhk26V2teqqFJZ2BFv8ta/+ysu6JmZNbpGcfOy56wHI/o91hzEOAEnv+xmOc6Q3nkcL8
	4rwHxlxU9Zv4OQhotsGc6F0cthSjtlKUsDHw4tVWL+gr7d0r8q6QKr6IAunjGi97d04GdlOdj8D
	45ZSJGZ1mfkWtzO/aDKXzviVYImkdSZsS6ceikEdar+6+UsnuVrAuuPyaKKgtP+2ovms/m+gEj+
	0pzhCptgvMoNxcQ+ScJRcH5MNOAp5SNeB5XOa7nFvo/kgO9p0Rk22RNbQOuzUDvUsuodr2Sn5el
	ylXHx8xxNKpGcCyOtwtComWV0=
X-Google-Smtp-Source: AGHT+IEmkF794dK8PGUFRZi30oUi+JrK1F6MGAnTFl1WiP3gyj/vMFMBVB/k6YujoLI8h9QS+AMIAQ==
X-Received: by 2002:a17:906:ef03:b0:b79:b910:fd45 with SMTP id a640c23a62f3a-b7d238bb08emr309082866b.38.1765562642496;
        Fri, 12 Dec 2025 10:04:02 -0800 (PST)
Received: from [10.29.112.243] ([193.204.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210fcf6sm5803400a12.27.2025.12.12.10.04.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 10:04:02 -0800 (PST)
Message-ID: <3742e7de-7d88-4e77-b711-9fed867a8c23@gmail.com>
Date: Fri, 12 Dec 2025 19:04:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Luca Balsanelli <lucabalsanelli@gmail.com>
Subject: Different behaviour for --find-renames between git diff and git
 merge?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

   I'm scratching my head to understand why on the following case `git 
diff` and `git merge` give a different interpretation about a rename.

    git switch master
    touch aaa
    git add aaa
    git commit -m 'aaa'

    git switch -c branch
    echo -en 'A\nB\nC\n' > aaa
    git add aaa
    git commit -m 'A\nB\nC\n > aaa'

    git switch master
    echo -en 'A\nB\n' > aaa
    mkdir dir
    mv aaa dir/
    git add aaa dir/
    git commit -m 'A\nB\n > aaa -> dir/'

The `|merge.renames` config variable is true. Changing `git diff 
--find-renames=50%` (the default) or `git merge -s ort -X 
find-renames=50%` ||to something lower does not change the following.
|

`git diff` prints

    diff --git a/aaa b/dir/aaa
    similarity index 71%
    rename from aaa
    rename to dir/aaa
    index bbd2b90..986ad36 100644
    --- a/aaa
    +++ b/dir/aaa
    @@ -1,4 +1,3 @@
      A
      B
    -C

     that is the similarity index is 71% and it detects the rename.

`git merge branch`, instead, gives

    CONFLICT (modify/delete): aaa deleted in HEAD and modified in
    branch.  Version branch of aaa left in tree.
    Automatic merge failed; fix conflicts and then commit the result

Why it is that? I always supposed that the rename detection was the same 
for `git diff`, `git merge`. Reading the documentation I do not find any 
hint why `git diff` and `git merge` are behaving differently.

Thanks,

Luca Balsanelli

