Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5922AC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 13:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbhLMNxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 08:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbhLMNxn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 08:53:43 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A46C06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 05:53:43 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 132so13882728qkj.11
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 05:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fYXFIW/vVm5m4rQi7XVJrEOJ/EDeNMfZG4OFLRymwhI=;
        b=UzKPus5tQONubGZP3YFpv50CKSsDwdWbQblUT6jne9vxiNOYWmd/sh8/bAu4ke4ieI
         jBDIaZBlJJKnS7ndkDA0bK1JeNuGOlPqdrHbXzNjnjL49pCpkrhT8SdgfHLEOrB5CwzJ
         XynfqGzVC/fNDf53KCO9nxHwQr1gRd1yAzdJXZKqr8rwOF/ZHqYSuLojWX8+Vt+QBBgI
         vI8d/O3WB8K/SwAqcHW+d+zPWz4jy5rlg0GAIH0gJh7olqRPo2tRdlL3uKaEH+WIsUSR
         F2Nf/YywTwylCT+QQHcHI/hgbK+KlrkBXiTm54B6Arq8Z/By9Es3ciQ+4GhXDkzCJstX
         886w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYXFIW/vVm5m4rQi7XVJrEOJ/EDeNMfZG4OFLRymwhI=;
        b=r3Gv4yXpetUOTnbW8R3rk0u2ePL9zna9wlLMBj2NYLoYmePH9MsLGqvNNDuEvb50qn
         1muKEdhovIFdgppr4Fhcx8E+9wrTCyjNgXrkYDRKLqQoiun0MuW3jMMCtaD7VqxYTfFR
         Ev0V+TmJsGSbXicGgnJzAEDH3yL8WqeWSzoLxgMNtx1xoPm2wwvonn2YUxHU5AFbK6rV
         cOoQZAZqE+KOLlU7EfpLHtK2KZafVjt0PaT19+jEoegljKFpdMf63DrWgX2kzM/qZYNq
         fLhZp83iDe/NsvFJnnUhNPgeoXUfFCCpMk+sKhFvekj+AxcucmRxMbiiNsBLc6HeyUTl
         Qm0A==
X-Gm-Message-State: AOAM5331h6ccBDwWtMtelK7FXAlVW6tunzTF1aZQT0VtRqIXyONmv2/p
        a15w5bWO4A6sEKYj44JixDSFZHQvi7s=
X-Google-Smtp-Source: ABdhPJzRP0KMql8XD2klyyJFODlUtrG3Qg8LCvs/0zi9XQNdMHxYYn2sVPblT3O8x/6TEkYdZfg8kQ==
X-Received: by 2002:a05:620a:4011:: with SMTP id h17mr33258597qko.564.1639403622094;
        Mon, 13 Dec 2021 05:53:42 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id k14sm5831328qkh.100.2021.12.13.05.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 05:53:41 -0800 (PST)
Subject: Re: I tried the latest git (was: A bug or issue with "git rebase
 --autostash" not popping the stash automatically)
To:     Henk Smit <hhwsmit@xs4all.nl>,
        Git mailing list <git@vger.kernel.org>
References: <763856358.299504.1636971571656@ox-webmail.xs4all.nl>
 <2018444639.308810.1636973639331@ox-webmail.xs4all.nl>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <9b2c663e-9637-63b7-f42b-69a6a0b6531a@gmail.com>
Date:   Mon, 13 Dec 2021 08:53:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2018444639.308810.1636973639331@ox-webmail.xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Henk,

Le 2021-11-15 à 05:53, Henk Smit a écrit :
> Hello Philip,
> 
> I just cloned a copy of the git source code.
> And built the "next" branch.
> And tried it myself.
> 
> $ git config --get-regexp alias
> alias.up !git fetch && git rebase --autostash origin
> 
> 
> To my surprise, the stash was applied!
> And changes/conflicts were merged in.
> However, the text put out by git wasn't very clear.
> And the stash was not deleted by itself.
> 
> Created autostash: 6c072c0da335
> Applying autostash resulted in conflicts.
> Your changes are safe in the stash.
> You can run "git stash pop" or "git stash drop" at any time.
> Successfully rebased and updated refs/heads/main.
> $ git stash list
> stash@{0}: autostash
> 
> $ git --version
> git version 2.34.0.rc2.399.gc874808226
> 
> So there is progress!
> The changes are merged/edited in.
> But the stash remains. Imho it should be deleted, if the stash applied without any problems.
> What do you think?
> 

The stash was applied and it resulted in conflicts, so the stash entry stays in the stash
list. The rationale, I think, is that you might not want to deal with that conflict now,
so since the stash is kept, you can 'git checkout HEAD -- .' to remove the conflict and
get back to the file state recorded in HEAD, and deal with the stash later.

> If you and others think the stash should remain, maybe we can add a flag or config-option
> to force the deletion of the stash, after a successful apply? Or would that be too risky?

I think that it could be reasonable for that behaviour to be configurable, yes.

> Could a simple non-git expert like myself do those changes, and offer them to the git project?
> Or do they not trust strangers enough for such changes?

Yes, the Git projects welcomes contributions from everyone. I encourage you to
give 'MyFirstContribution' [1] a read :)

Cheers,

Philippe.

[1] https://git-scm.com/docs/MyFirstContribution
