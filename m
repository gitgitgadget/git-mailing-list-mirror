Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F289A211B5
	for <e@80x24.org>; Fri, 25 Jan 2019 14:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAYOeT (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 09:34:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40848 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAYOeT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 09:34:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so10530417wrt.7
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 06:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PgetKvvG1lt2sGuF+hV1fm04N+EpSnu4xnhb/bTdyBo=;
        b=SHiRxP4L7TPxTb5n9F8TCoU2D/QZUyVMDo75aIWpfotNwKBOerPZqwt8BVUWK5hTRe
         2kR2eu6K9BNt6438KfMxUCbX1PljT4a+XM6xfn28/HA5ikY1x3TbIaHxNKaJzeDPMGmh
         uCFRUHZw3of8pm+0YVskYmvvvYpjCsmaZtj8pUzvX1+qJkdOoGU0qBLnYtKB+AkpCies
         whOvroU28LeidIP6Yxm3g0ZmKB28kaAk80k/9OD0VCwHsF8CWfH5tULbpGq7Vq0B8bbD
         LEhUGa7diPSOjNPkU2Hw3nKbnU1558RgGQoWU2WiBuu4CJh0o6T6T0OFo34gXv7ccke1
         Heog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PgetKvvG1lt2sGuF+hV1fm04N+EpSnu4xnhb/bTdyBo=;
        b=UHJhQPhm2rR63dU3NxDOBvfjw3zNF1dgCSuiVik6zzTzxgJkl/djgfuqvx3YpV/hzF
         CE83npWsFef2IdTFWiBvkXEKuEnd/3M5D46CB+ujohkhu4ID8j40jVaoq4OlYeI9YMZY
         65c6N+pqZcYfnbOJnS62uDM4wjjEZteMECuaWNQi5zWHrVUx8RgPBAn5FplMwzmO1GUF
         Thb/q/T0xVPywIJ+MI4EBfaP7xNFK3sLvfwZABAE9H7tOgZvK9a0kak1mtJA7fs4IbVe
         TWZgrK7YAqmk1bIjVivhhY0xR7PLCsy6Cs5V1Yuqs7VVnzj26ksuYkxiQnZdKIVVF1Pf
         sO+g==
X-Gm-Message-State: AJcUukc+TsfxomnHniD9GKibywt304DEJPfpmp9GOYH082zcTsct+sXG
        M1n6oe4qgt1HoI555pppTjI=
X-Google-Smtp-Source: ALg8bN4Dx/7HHYuW74G4V69H6rIYlE7kUM0L01zcoWb5yp4BStVRwpMMZfB2ibN1c2fiaNRRpNf1vA==
X-Received: by 2002:adf:9521:: with SMTP id 30mr11135309wrs.192.1548426857480;
        Fri, 25 Jan 2019 06:34:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t18sm39908691wmt.35.2019.01.25.06.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 06:34:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Arti Zirk <arti.zirk@gmail.com>, git@vger.kernel.org, e@80x24.org,
        peff@peff.net, jnareb@gmail.com, flavio@polettix.it,
        wil@nohakostudios.net
Subject: Re: [PATCH v1] git-instaweb: Add Python builtin http.server support
References: <20190124161331.25945-1-arti.zirk@gmail.com>
        <20190125020451.GU423984@genre.crustytoothpaste.net>
Date:   Fri, 25 Jan 2019 06:34:14 -0800
In-Reply-To: <20190125020451.GU423984@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 25 Jan 2019 02:04:52 +0000")
Message-ID: <xmqqva2cg61l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'm glad we're using Python 3 here, but I wonder if the name "python"
> will lead people to think it will work with Python 2 as well. There are
> people using up-to-date Git on systems like CentOS 6 and 7, where Python
> 3 is not generally available.
>
> Could we call this "python3" instead, or provide some other way to
> communicate this to the user?

Sounds like a good idea.  Also would this be _the_ sole http server
implementation Python3 users would choose, or is it just a possible
one?  What I am trying to get at is that we might need to be even
more specific than just "python 3", but may need to convey that this
is for "http.server using python 3".  I dunno.
