Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E711F744
	for <e@80x24.org>; Mon, 11 Jul 2016 16:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667AbcGKQyx (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 12:54:53 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34882 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645AbcGKQyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 12:54:50 -0400
Received: by mail-wm0-f43.google.com with SMTP id f65so71008411wmi.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 09:54:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=nmZCLxyMCoTwl38diC5tKAp41uefXiyZRvt+85qwrgw=;
        b=KcZMVzbAHKHTuf3scklV76vgnYtReZTI1lDD80f2nGwoIJ+INXziezD8xVwUnpu+XU
         OIYS6h3f6GV7Mvox6aI3AasnacbY918lBs2qgRZzzcfq1jzOWeBX6rIXHtiPQbGTMxXh
         aLdQnxLge6vURoJGBX124WtBzxjLpxEhsKTe4atfZ+Hdrt2o38qm9I96P4snVw8+x6Sk
         jsYuKaeUuP11xvOrVU871fCWUQcMORrx0yaYdtlXdU7vHG8V7Q6JGflrHkVTJMQkhIFy
         hAyhCRjhJqqDHBCbFXPN1T2/W+y0NLWYFO6qSL7lQjbOVXO/G0PW5f1mmBFz92azYFxJ
         Kn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=nmZCLxyMCoTwl38diC5tKAp41uefXiyZRvt+85qwrgw=;
        b=ZckkrGbdlDEJRnczjlgTJPz6ObEM199obcBwQ4gZc8Ho7hj17k1Nas6rDrmm682Y4w
         UrW7ldqh3N08HoemN9R3YVu96ZbPwXN8nCpW6qG54c/kkYtqjNkTDnl2Bt9iBzM13mNj
         DFepjQduUIiPxtxDbqSceBrt2qXxGyVpCHa1FdwQXAyFBVJ3z7Z8CyaZtF5t47zMFywG
         a4UrvoIlcYxkjujdhj39b++SuH+nz/MRPUhC8fj7lLawZ0qivZODDboc8Pbl+3XZvWx0
         8ueb8DWHZIlIaE8tgKjslkJfdKYxhau/2bYbCbZIn6eExY5HaSkobMyF4cxUd6VYUIu/
         55ig==
X-Gm-Message-State: ALyK8tKW2rBP8rxixFvhnQDAVIt7ig/nZt1WTd2t5o8k7MncESi/Ehi6K+JMtvyMsoAt5g==
X-Received: by 10.28.199.4 with SMTP id x4mr5273516wmf.70.1468256088751;
        Mon, 11 Jul 2016 09:54:48 -0700 (PDT)
Received: from [138.38.103.116] (cspc-lin-03.bath.ac.uk. [138.38.103.116])
        by smtp.googlemail.com with ESMTPSA id m5sm24007391wmm.10.2016.07.11.09.54.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2016 09:54:48 -0700 (PDT)
To:	git@vger.kernel.org
From:	Garoe <garoedp@gmail.com>
Subject: git push doesn't update the status with multiple remotes
Message-ID: <5783CF57.1010105@gmail.com>
Date:	Mon, 11 Jul 2016 17:54:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

I'm using git 1.9.1 in Ubuntu 14.04.

I have a repository on github, a clone on my desktop and bare repo on a 
private server, in my desktop the remotes looks like this

all	git@github.com:user/repo.git (fetch)
all	git@github.com:user/repo.git (push)
all	user@server.com:user/repo.git (push)
server	user@server.com:user/repo.git (fetch)
server	user@server.com:user/repo.git (push)
origin	git@github.com:user/repo.git (fetch)
origin	git@github.com:user/repo.git (push)

If I commit to master in my desktop and run 'git push all master', the 
github and the server repos are correctly updated, but if I run 'git 
status' the message says:

Your branch is ahead of 'origin/master' by 1 commit.
   (use "git push" to publish your local commits)

The message won't update unless I run git fetch or git push origin master.
I'd expect the git status to give me a updated status message after 
calling 'git push all master'.

Best regards,
Garoe


