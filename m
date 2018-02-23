Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E971F404
	for <e@80x24.org>; Fri, 23 Feb 2018 06:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeBWGEL (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 01:04:11 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:40344 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeBWGEK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 01:04:10 -0500
Received: by mail-wr0-f175.google.com with SMTP id o76so12886809wrb.7
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 22:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VNK1IJDod2cNBF7oHP8vHW6N4OdnQa3Xi3NzEMmz9Kk=;
        b=dG/av6lH8zWr8iQXGawM+6aplUtjcDNrOcWyBDBLRFJ5T/GZvDImWDXRp5PQ5xdxe0
         VxPFaSOCkcB4io3tDV0iiJswp6IC7xaSsc0eBpVT2whIH9LkPT+AtkB1K02zQzGhVk71
         XmWTPnDQh2JMcs2OJdbG33WuTr1l44XUna/wByLG1ALilJ+F52ciD+cY+BrEw0VvbDV5
         H6fQp+nSrCGbUEK8YhAg+vXdsbWaIclM/xbXS561/hEhkVBxPjsbiSzQ81yGjmGSO/9N
         3C32n/4bqdgEfraBE+54dyZUeqGIGOl8FzI8FlVkteEr4SlVFK5fz5tqzyYp+Q80DCNN
         G8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VNK1IJDod2cNBF7oHP8vHW6N4OdnQa3Xi3NzEMmz9Kk=;
        b=sLtK8Be4kFhQxice6kmm59xGMbZ2kV6sPTqnh5L+gQsvvO5qfBCaMRT2JM0Kd5S8qn
         dRMH0zgvDXIkDB7AbpzbJ90mhHsB4GTSzSxSOOIeqA+hehyua03/umZ1ljZWCeeHRzcG
         WswhznQt62b4he9eaBSPbdVK3mr2gjKer92i52oVVjdx1pnOkglfF8sRwTa2b7YYYHjy
         M5F/pDXw95r4sTX6neDPXo07lQwePseeqCHnwVqWqR9GnKNRqU/hMWd4CxhR2rrpRIzy
         OQChTn9MB1A5xG8qnW4VwBCyBktgClghFjN08myGQRgzLheIGUWtEFnE94ooGjqpOBhS
         T/1Q==
X-Gm-Message-State: APf1xPBC0adnQgrHFWj2a8NpaV7A2P6u0kax2Uwg6dcStmIf43uEjzjX
        /BNUpoRJHPozkwys/x60ewGUou+T
X-Google-Smtp-Source: AH8x224rKoZs8dtNXwDnlcOCVrNSHZ3wgSBfYFJHN6GQhMQUD4p31NedGtXgSzwfUnBapT5Q01zy+A==
X-Received: by 10.223.174.194 with SMTP id y60mr419371wrc.202.1519365848753;
        Thu, 22 Feb 2018 22:04:08 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g7sm1769988wrb.78.2018.02.22.22.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 22:04:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julius Musseau <julius@mergebase.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: git squash
References: <CAA7Zk=tMMPE_Ov6cSJuzgYwWmTuMTSd_909c5JY3a2k5KFzHgQ@mail.gmail.com>
Date:   Thu, 22 Feb 2018 22:04:07 -0800
In-Reply-To: <CAA7Zk=tMMPE_Ov6cSJuzgYwWmTuMTSd_909c5JY3a2k5KFzHgQ@mail.gmail.com>
        (Julius Musseau's message of "Thu, 22 Feb 2018 19:41:06 -0800")
Message-ID: <xmqqfu5sutrc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julius Musseau <julius@mergebase.com> writes:

> git squash [<commit>]
>
> Squashes <commit>..HEAD into a single commit. Replaces HEAD with the
> result.  If not specified, <commit> defaults to the current branch's
> upstream (a.k.a. @{upstream}).
>
> Rationale:
>
> This command provides an intuitive mechanism for in-place squash that
> doesn't drop dirty merge results.
>
> We call this an in-place squash because the state of all files and
> directories at HEAD does not change. Only the ancestory of HEAD
> changes: its (only) parent becomes the merge-base of <commit> and
> HEAD, removing all intermediate commits.

So is it essentially the same as

    git reset --soft $(git merge-base $commit HEAD)
    git commit

with some icing for coming up with a default log message?  The above
won't touch the working tree at all.


