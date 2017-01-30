Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D5AC1FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 16:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbdA3QV7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 11:21:59 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36936 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdA3QV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 11:21:58 -0500
Received: by mail-wm0-f54.google.com with SMTP id v77so54070313wmv.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 08:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Vqu1PD1VtTesG1nrJbb+Kjpw0o5X5IpeDnSBmwNF2V0=;
        b=ctIjv2R9RlLuunQlptP4F2V/LtQ+BMU08QA1raWFetrJAZkYsXhH8LSxoa2Fy8jMDN
         Z+W08Jc5dYgsDqbM+9nOp4Czjb6lGgAkOqN0S/xhjRII0mB9Cxp1ytMvbhL0p+ZqPRJ5
         HVEVoSu9JuJfCnOGqQjz9/FA6OCkwXqkvTfKQ5oPHmqpLLbh19p/GGD/calSMrPt1fMR
         LlwSctLOsR8QBodQL7gLsXACwyJ30wCOQ1HRjdFMt8mXL5FkXwNqFxSg9bgIpJZ7Rgmk
         4sO4uuPH2CItNtw4LQ8i+Emz+za2D+BrrWvPQceUfN0HeN4yXBGG+BEEcrc7blPWq8WH
         7AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Vqu1PD1VtTesG1nrJbb+Kjpw0o5X5IpeDnSBmwNF2V0=;
        b=Q5p8Rx4CqDMRNqM0Jzb7UREJELlojq2cmEjsZjyBdg0r/aIM6QFLK5qDwzlRUG2NUM
         bOmf09pV+uPuxLlRc08b0ufOyGdMhuVjuJgnkWPPudGDUjdSezavv3g6JbNfV6IsOnju
         MUqoSHFeo8Js9KZmANIH3OLE0CsVT2sodGfzieoG0CZTaOWxhOOgdcrb4dbgK7at1UMq
         Z6EcN4EmcxRmWWUveRfcGo+vd86DhrJmi0pVq0ywjns9ZQVEn8wNdSY7zfJLsEhITQKJ
         eaeu1/gc0nm+jjHMvhOjJwPUqlIPWGp3eJ76IYOFGVa8+T07pNu2LIwY9V5TTuo9k/Fs
         GH8A==
X-Gm-Message-State: AIkVDXKaNsE0CLFsdo7nk4H3mGFsD5IJavCKQYa/WJyZ/Uoh1USTADe1r7A5wFoEEZ+x3Q==
X-Received: by 10.223.130.111 with SMTP id 102mr22711955wrb.59.1485793316409;
        Mon, 30 Jan 2017 08:21:56 -0800 (PST)
Received: from [192.168.141.122] (27.21.202.62.static.wline.lns.sme.cust.swisscom.ch. [62.202.21.27])
        by smtp.gmail.com with ESMTPSA id q5sm23638497wrd.32.2017.01.30.08.21.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2017 08:21:55 -0800 (PST)
To:     git@vger.kernel.org
From:   Benjamin Schindler <beschindler@gmail.com>
Subject: gitconfig get out of sync with submodule entries on branch switch
Message-ID: <0f14df64-1aa2-e671-9785-4e5e0a076ae6@gmail.com>
Date:   Mon, 30 Jan 2017 17:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

Consider the following usecase: I have the master branch where I have a 
submodule A. I create a branch where I rename the submodule to be in the 
directory B. After doing all of this, everything looks good.
Now, I switch back to master. The first oddity is, that it fails to 
remove the folder B because there are still files in there:

bschindler@metis ~/Projects/submodule_test (testbranch) $ git checkout 
master
warning: unable to rmdir other_submodule: Directory not empty
Switched to branch 'master'

Git submodule deinit on B fails because the submodule is not known to 
git anymore (after all, the folder B exists only in the other branch). I 
can easily just remove the folder B from disk and initialize the 
submodule A again, so all seems good.

However, what is not good is that the submodule b is still known in 
.git/config. This is in particular a problem for us, because I know a 
number of tools which use git config to retrieve the submodule list. Is 
it therefore a bug that upon branch switch, the submodule gets 
deregistered, but its entry in .git/config remains?

thanks a lot
Benjamin Schindler

P.s. I did not subscribe to the mailing list, please add me at least do 
CC. Thanks
