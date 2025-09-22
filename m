Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581F2AE99
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536173; cv=none; b=uEkVlDwzHScjXuNz0KQsMJpteYk/Db+Sg9kcJ03TYd9h5qp5nPvZp07fSU8rS6d7rCpkwLBrYUUtEHQanoXyKhNrAwejI4Wd5e7UZFULEFVTHvuOem1h2A4cgJSs3zNggU5Q2qlBT0brMYwY+SkJYjW+T1NctN03t6zritNdhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536173; c=relaxed/simple;
	bh=EC1ck0pQvIbNxNBIOINa3dGme/+qEiXDjJi5XH1SlcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gP79JoQZTC4NUYIbQoCUXUEYH9pVUkvEbrjc9rZsb62MYiIYiga1GZZoyBL+MXdfo3slIvcpPRxnkRuXrtqIP4R5A/lC445FKNpF/YsFkhQfvIn0AafQCH75sYqVNgxIxTGaeut6T8nb3X+JWrWAxLpEuFVklHZA2sHyq7pabck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTv4H4or; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTv4H4or"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4d01b367f7bso3905231cf.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758536171; x=1759140971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjH8elYs9dfh1b5VXXuemQqZ81StAsudWQNbcM4PvBg=;
        b=WTv4H4orAOOsWc7WYkOS5p1WVRaHuUmhSTaC2iTNJKscVS+ElO9Wenlty3gn7iQ7Fu
         o4lLF+31L3BE4gvDIpBEkXH3kO0a5z1t1xWsatvIjM6jeysub5ljG2dZnBthv+cCCBzh
         lmKYN4Pv1pW578GoKZ2YlUSnhi6vDedj6MnZ9Uk/WmifwAthIDKKM0hCtuW6/9gg2boQ
         Vbcxd9J0iD2cI6IQfY+lKn6sX32m13M9Ib1j1GkXKpI18FktBD+9BNHlhvhExPbw/EMi
         HjUTbX5zB03o/2ZY7QI0GLPKs8u/Op5JvZgjZaFmdssmztVe0p1dn/hIW5Vw79/8UyQ7
         g+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758536171; x=1759140971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjH8elYs9dfh1b5VXXuemQqZ81StAsudWQNbcM4PvBg=;
        b=Fbgd2Z7KWLkl+MPe6CxPcws28fjV89fbMTWO9QEqkLy5AKmLxSAQvwqpIozefN5OBC
         gF1/auU8WYB5o6W2hhIG3XFIoU20fus8VbFX71tU9Fg1dk45GTiK0E4bqRKZwS499M11
         Rg08dTdvu8TdKqq9Q2vk8wwzFWiXBFUhLJDo/CBmADYHoAjj+muY+O1zHBbEZeYKQeTc
         qp3L1nfJX1JO5epWBBeBow5bcnhNJ+zJROZzB7N9G4BTzewBTFfIUeE2xFfKVudVaQYd
         PQFKjiyPgumP6q220I9cXn2gAPZtWwGeiE0DNaG9KfED6IrbaKx+iUHJE3jKvtF6lS8s
         Dbdg==
X-Gm-Message-State: AOJu0YwTxTfIoseuxhvkgm9hrE0IuuK6/mgbpSP2N+RoSi5+kAty2HaP
	x3v0gIhMLUjhSKhW4iMnG65NRQFJ+mQkXN15SBU5M+tFmo3TNPFz0DuUWMLxkw==
X-Gm-Gg: ASbGncuysq10zieMuPx79WoGwo4UVu9XC6r9ET5RMrg/0N+G0hc72Dmct1FQORy2cGi
	DYunxbKjbio8RcLozPwOVV0UleCjKqm7qvyjhv8Fg/I4vw8n+1zAPFSuTZIq9bNKiMDr6V15BjX
	tI8+N1ZVk3X5Gbf31Gfmem9xnmoia6TnQAqw5ZLGE1j2tp8y1n8bm7XafOX0mfaKC2HlZHbHok+
	5hQoxMKpoBIK7i2Q+DuCITKGrFpzCTk/WTIhzUaDShS7anQBRE0NbT8FvmyZ8hDjUDSrat2P0ZW
	M0gf+AFHTd9DAVX5VOai9Wo0jWeCM9Dxi6s+q4Yu9gupDwOfu6PAaZApHcxj25r+zY68MqaMwdH
	wPRQBadQwxDr7UFMskx9kokAlEkhBnfckMwuQ6/qdzFRchV36x7du1MdyuRrl6M9EMyOJs7Wipw
	==
X-Google-Smtp-Source: AGHT+IFBXzCDXsnpZ917c1nr9pkIa8Lv0t3QpWl27n+a8HRNf9Ac5tAbYgMHQBFL9bRcxkC3sgUBkA==
X-Received: by 2002:a05:622a:5589:b0:4cb:57b4:4d6e with SMTP id d75a77b69052e-4cb57b45322mr39066771cf.56.1758536170517;
        Mon, 22 Sep 2025 03:16:10 -0700 (PDT)
Received: from [192.168.8.183] (pool-173-73-185-17.washdc.fios.verizon.net. [173.73.185.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4d1327ade98sm549381cf.31.2025.09.22.03.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:16:10 -0700 (PDT)
Message-ID: <7995c79c-b763-4a6e-830b-fbe29bf252f5@gmail.com>
Date: Mon, 22 Sep 2025 06:16:09 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] gitk: fix the position of the main main window on
 initialize
To: Johannes Sixt <j6t@kdbg.org>, Michael Rappazzo <rappazzo@gmail.com>
Cc: git@vger.kernel.org
References: <20250920184007.26183-1-rappazzo@gmail.com>
 <20250920184007.26183-2-rappazzo@gmail.com>
 <199b7665-910a-4f44-a734-ced99bc8cb81@kdbg.org>
From: Mark Levedahl <mlevedahl@gmail.com>
Content-Language: en-US
In-Reply-To: <199b7665-910a-4f44-a734-ced99bc8cb81@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

No longer relevant. Cygwin up until 2011 used an unsupportable port of the Windows Tcl/Tk
permanently stuck at 8.4.1. 8.4.1 has some bad bugs in its layout engine, and forced
changes in gitk to be compatible. All this became irrelevant around 2011 after Cygwin
gained an X11 server and switched to a supportable port of the Unix/X11 Tcl/Tk (it is now
on the current 8.6 code base).

On 9/22/25 2:00 AM, Johannes Sixt wrote:
> Am 20.09.25 um 20:40 schrieb Michael Rappazzo:
>> The main window geometry was only restoring size but not position.
>> Use after idle to ensure proper timing on OS's where that is necessary.
>>
>> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
>> ---
>>  gitk | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/gitk b/gitk
>> index 6e4d71d585..95469a8fae 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -2775,6 +2775,8 @@ proc makewindow {} {
>>              }
>>              wm geometry . "${w}x$h"
>>          }
>> +        # Restore full geometry including position after window is mapped
>> +        after idle [list wm geometry . $geometry(main)]
>>      }
>>  
>>      if {[info exists geometry(state)] && $geometry(state) eq "zoomed"} {
> I have been carrying 22d37f865268 ("Revert "gitk: Only restore window
> size from ~/.gitk, not position"", 2008-05-26) since, like, 17 years in
> my branch j6t-testing. Perhaps Mark can tell us why b9bee11526ec ("gitk:
> Only restore window size from ~/.gitk, not position", 2008-03-10) was
> needed...
>
> -- Hannes
>

