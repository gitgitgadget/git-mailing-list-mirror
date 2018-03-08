Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CFE01F404
	for <e@80x24.org>; Thu,  8 Mar 2018 19:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbeCHT6a (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 14:58:30 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33445 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbeCHT54 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 14:57:56 -0500
Received: by mail-wm0-f49.google.com with SMTP id s206so587413wme.0
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=PJgSoPj0fywgU7NB7uuHYdXYMck/xI7AKR7lmorPdH4=;
        b=a+26r9/q6S7NnDsF7uIvgvyeeIPwW/K4w80mo8018Hx1MARMjBvzPeciiER9l9c/Qj
         DafPVsujyjbmQB1SQ5wxogGsAhHeYECplXPWdidgF5+lXvp0rdMrlUUFmjEXqHy7At+0
         odPloYz46t91SR88HRen2xOi+Axmh+/ldCP9bpQFNDnO9VMgbh2DQJvVwmhDw6POD3GK
         h6Xb/pF9Cl+fb2jn/13WTkIwVeRyfAk+xd6UCBPd0yMO3GsYY4zTn2c2bWceqycyi4vL
         FFzw8zD98iwpXeHKFqpEKKU5TJz/Psapt6WO3/COZ3vLs+fAjQT4vtVU9WRBGUT7kulX
         o+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=PJgSoPj0fywgU7NB7uuHYdXYMck/xI7AKR7lmorPdH4=;
        b=CECts1IF7qvZkMt2B8ABI/xA+w+ppKlcmyxR93doXkxLlI9qbTUSFyrEDbCCYGLghs
         86QvvS42eemKzGeXzkAidtUofPJaWE8VR5dC8hMP1axGgbVQnGD12Y5mtTnYx4nbDfPY
         39pzNEtzGgbgdMREVTxZ7GLXU62ibw9RrP82eaBCMYerW4TCgNwN6m/3H2YqwxRt36Gq
         N3Fx74CXWwCq7F9GFseT1Z7HyAIe/HKTsN31DZPkSttopXV2Y6DQ6XDwttfrJfZ5xGbN
         wqNR2im+aIL5QwBKx8fLIgRiIl3+uYZBgpf0T0EFrf8geDwXLABZpOneB/2bO1vwbcWR
         3a5Q==
X-Gm-Message-State: AElRT7FSefB3qHfXlJMPSMmRnKw2OAHfI7DB58Qfk0MmKY1/cEEsCfRl
        dUvg2jZQyvjSxqX0Blysb8A0QA==
X-Google-Smtp-Source: AG47ELsMdpLie+O9KbkNVRXSWh95VTn+lNpVKmLY8F6oxxO+rR2+YYcsg9pvgaaFrW7MIKPey9aDQw==
X-Received: by 10.28.87.75 with SMTP id l72mr25498wmb.48.1520539074954;
        Thu, 08 Mar 2018 11:57:54 -0800 (PST)
Received: from [192.168.0.40] (mut38-4-82-233-116-4.fbx.proxad.net. [82.233.116.4])
        by smtp.googlemail.com with ESMTPSA id o94sm32049842wrc.7.2018.03.08.11.57.53
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 11:57:54 -0800 (PST)
To:     git@vger.kernel.org
From:   guillaume weybrecht <guillaume.weybrecht@gmail.com>
Subject: Case sensitivity when deleting a checked out branch
Message-ID: <420c2cd9-c38b-8f90-0fec-e070b19efb49@gmail.com>
Date:   Thu, 8 Mar 2018 20:57:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
X-Antivirus: Avast (VPS 180308-12, 08/03/2018), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I came across an odd behavior in Git related to case sensitivity when 
deleting a checked out branch.
I was not able to find much information about it.

$ git checkout -b foo
$ git branch -d foo       # error: Cannot delete branch 'foo' checked 
out => this is expected, nothing happens since you are on branch 'foo'
$ git branch -d Foo       # Deleted branch Foo => this is not expected, 
Git removed 'foo' from .git/refs/heads

Git removed the 'foo' file from .git/refs/heads, but did not update the 
.git/HEAD file which still contains "ref: refs/heads/foo".

In fact, everything looks like a "git checkout --orphan foo":
$ git status              # On branch foo. No commits yet (the working 
tree is staged)
$ git log                 # fatal: your current branch 'foo' does not 
have any commits yet
$ git rev-parse HEAD --   # fatal: bad revision 'HEAD'
$ git fsck                # notice: HEAD points to an unborn branch (foo)

You can run "git checkout <other_branch>" to get back on your feet as 
you would after "git checkout --orphan foo".

The thing is, you get there unexpectedly without any warning, just with 
a case sensitivity mistake in "git branch -d".
Even it is seems unlikely to happen, someone ran into this at my job.

Tested on Windows 2.15.1.windows.2 and 2.16.2.windows.1, and on Mac OS 
(I think it was a 2.14 version).

Best regards,
Guillaume

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

