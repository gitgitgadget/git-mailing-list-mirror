Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205E720188
	for <e@80x24.org>; Fri, 12 May 2017 10:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757092AbdELKFq (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 06:05:46 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35929 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757063AbdELKFp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 06:05:45 -0400
Received: by mail-wm0-f53.google.com with SMTP id u65so15888112wmu.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 03:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smarthead.ru; s=smarthead;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=yXeZPGXE23MeO4+bt+2AgMUMo8z69kjnH0a2QvE7MnE=;
        b=RAAn+Fh3Kj44WAo7LtBeMD0vIfO/Dj57ez5C6bqedxv/Qg7OkZo59lF1uSiOQhkzgl
         HHtMjpM3q73mySKX8oL1OkDRqt8uv/veZmA6ZnlBSoVUHKXip6xvs+5Rca0J8fhU1KwF
         OB6+v+cN5eIa3voJoRwPKBBbVLWhnxgVbYYfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=yXeZPGXE23MeO4+bt+2AgMUMo8z69kjnH0a2QvE7MnE=;
        b=teCxIjnQqh1xiy23Hy5HJz7KLCafoyvfi0FVipdOAcN/+j8DbKOt+NpiAxuxhyW6HQ
         t/N5N1vfnwh8amLG/JFyFtGbRwB1LjME6wOYOGIE2QGrgtFH99fkZhDZlpHgAuU6OUXn
         zgeYJ/WVH6Ijf0FepnywwoSsEYY7ShrcB0VVowPO6ixfYj+Isnr1s2ZxBZjX6Ar1OVUH
         iP0/TnJvt5QZ97Q0tZDwsg3zHzmS8nokGGR7zAgP40dhVgel/AYO1q/HpSO0rFDP2+Rd
         ioQX7cxPvT88p0InbWuXN8JRi2gZfG8ZHs3eRvMuB0kZB+5j7G62TnIH03qhJl9p1bAC
         lsvg==
X-Gm-Message-State: AODbwcBdWjMOGWbC4wNmx+0JjQ6l1tgFzeQrgND/VyWnh1aIOXeIJgfT
        F5V25r8BSG/FWA==
X-Received: by 10.25.4.149 with SMTP id 143mr974543lfe.144.1494583543419;
        Fri, 12 May 2017 03:05:43 -0700 (PDT)
Received: from [192.168.155.40] ([77.72.250.174])
        by smtp.googlemail.com with ESMTPSA id a1sm496431lfb.15.2017.05.12.03.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 May 2017 03:05:42 -0700 (PDT)
Subject: Re: Git credential helper store flushes randomly
To:     Jeff King <peff@peff.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
References: <cdedf063-5f53-04c9-5ac0-2acf7e26696e@smarthead.ru>
 <20170512082058.ivvsmzc44cildp7l@sigill.intra.peff.net>
 <vpq1srucwj1.fsf@anie.imag.fr>
 <20170512084513.duj7sesylo7jdd3w@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   =?UTF-8?B?0KDQsNC50YbQuNC9INCQ0L3RgtC+0L0=?= <anton@smarthead.ru>
Message-ID: <55d2b225-1f12-eb26-7333-131538b519fa@smarthead.ru>
Date:   Fri, 12 May 2017 13:05:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170512084513.duj7sesylo7jdd3w@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

12.05.2017 11:45, Jeff King пишет:
> On Fri, May 12, 2017 at 10:24:50AM +0200, Matthieu Moy wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> The only time it should remove an entry is when Git asks it to. And the
>>> only time that happens is when Git sees the credential rejected by the
>>> server (e.g., an HTTP 401 even after we fed the stored credential). I
>>> don't know why that would happen unless there's some non-determinism on
>>> the server.
>> I did see a case like this where the server was broken temporarily and
>> rejected one login attempt. In this case the credential store deletes
>> the entry for that user, and when the server is repaired, the store
>> still has the entry deleted.
> Right, that's inconvenient if your server is flaky, but is the expected
> behavior. Git has to throw away the credential so it can stop trying it
> and actually prompt you on the next try (and save the result then if it
> works).
>
> -Peff
>

Thank you all!
I've found the reason and successfully fixed the problem. Here is a 
description.

Most of repositories of this user were on one server EXAMPLE.COM. Some 
origins were configured like https://USER@EXAMPLE.COM. And they worked 
fine. Git just searched in ~/.git-credentials the 
"USER:password@EXAMPLE.COM" entry and everything was good. But some 
repositories' origins were configured without username, just 
https://EXAMPLE.COM. So git tried to find just a EXAMPLE.COM in the 
credentials store. Then git took the first entry and tried to connect to 
remote origin, got 401 unauthorized error and deleted first entry from 
helper store. The randomness was manifested due to the fact that git 
rotates the records in .git-credentials every time it connects to remote 
origin, it moves the right account string to the top of the file.

I think it will be good idea to add this information to 
https://git-scm.com/docs/git-credential-store, especially the info about 
deletion behavior, when git gets 401 error.

Best regards,
Anton.
