Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B189420248
	for <e@80x24.org>; Tue,  5 Mar 2019 13:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfCENVQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 08:21:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42758 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCENVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 08:21:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so9430346wrg.9
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 05:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ieFo4Pn4Nx45quQjmarC19Sd4zhHafJFkSjeta32H0A=;
        b=LcW6qILOP7r/BdEjgqFmSwv8IfVnzw93Z8ylWJzrhLubyNvpFLYGTcLTPNa7N7EWTW
         HxzTbxaIbebz5EEwmhTRQrcdEaBNxIEeQUeWOCwQqWcQclYyQEfglF97pi/Q58j60pvu
         qqjJ6+/rQAZ67QXeRS3IZcur1yYznZTEC7+o+8sBip1r2N9dybNoS75R/IIrTt0MxvWI
         R/Q+eEmpIpW2GvCDBqR4Z1nL5WK2IgqoH1nLE2Sw411Nd7jDWAvp00FJhllVYNnR7Cuw
         NhkFoIDdDNM10qlrauywOEaRGO6YvYKFiThuOOAs/Y0kx3LLAPZR/Y64jUs8AqjQl9fz
         SJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ieFo4Pn4Nx45quQjmarC19Sd4zhHafJFkSjeta32H0A=;
        b=Q3RLs3JN7VWhg4IudbI6PDzoimfeDc696Hqxhhq7/8Dn7CAY4Qg7cvrO6GCSaD1JS9
         k51FLgewxaOLLUvW/JfX5tbyjf6a77vK+diMjWP4dXTl7SSTpV3LNlEaEmZ1F+LC/9km
         iG1SbQ8LHmvJjkkzHiYe4pVM4MeCi+f5qspKsGCtnCv1ANXf6NEzZC4kKHUMEPGv5UHH
         3XLYHYr4chF5BlTveu28E+YxvjBHbwfgHPcXswZixnEQKXhlL2bTs8LjmoOBrZ/uHeZV
         sQbTlFBhzI3UvStP+D8RYe+O+V2l5QbJkb4ZXW/wL+3OoG8jKqsMKliHAUBlxR2d3nk0
         0MoQ==
X-Gm-Message-State: APjAAAWmZHhLFkxxvF5BT7l/dADPzvEl46glxOxnJLJd16MBhAXFLz0x
        oQWxKslb8/leXZ32WUWjR+I=
X-Google-Smtp-Source: APXvYqzP2bf5cPJSrjroaNpVxi/5YiCVnlLd8tG6wfFlE7zmc77Bjwer3kDwgbrZkhC2h05IXExrWA==
X-Received: by 2002:adf:9c85:: with SMTP id d5mr16227574wre.68.1551792074311;
        Tue, 05 Mar 2019 05:21:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v10sm15759961wrn.26.2019.03.05.05.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 05:21:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kenneth Cochran <kenneth.cochran101@gmail.com>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/4] Add alias option to git branch
References: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
Date:   Tue, 05 Mar 2019 22:21:12 +0900
In-Reply-To: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com> (Kenneth
        Cochran's message of "Mon, 4 Mar 2019 09:45:45 -0600")
Message-ID: <xmqqa7i9v4mv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kenneth Cochran <kenneth.cochran101@gmail.com> writes:

> From c1bad54b29ae1c1d8548d248f6ecaa5959e55f7b Mon Sep 17 00:00:00 2001
> From: Kenneth Cochran <kenneth.cochran101@gmail.com>
> Date: Mon, 4 Mar 2019 09:40:22 -0600
> Subject: [RFC PATCH 0/4] Add alias option to git branch
> Cc: Sahil Dua <sahildua2305@gmail.com>,
>     Duy Nguyen <pclouds@gmail.com>,
>     Jeff King <peff@peff.net>

Avoid using these in-body headers.

Reader's MUA won't show this "Subject:", but instead show the same
"Add alias option to gir branch", among hundreds of mailing list
messages, making it very tempting to ignore these four messages.


> I find myself often using git symbolic-ref to get around work requirements to use branch names that are not very human friendly.
> There are a few problems with this:
> 	- There’s a lot of text to type
> 	- Mistyping certain parts (heads/refs) will do things other than create a branch alias
> 	- It will happily overwrite an existing branch
> 	- Deleting one that is checked out will put HEAD in an invalid state.

Meh.

All of the above are problems _you_ create by trying to use symbolic
refs.  If the project wants to use an overlong branch name, using it
with "git branch" or "git checkout" or whatever would be a much
better solution.  Command-line completion will complete long branch
names, and "git branch overly-long-name-of-an-existing-branch" will
not overwrite an existing branch (without --force).  "git branch -d
overly-long-name-of-an-existing-branch" would not delete an
checked-out branch, either.

