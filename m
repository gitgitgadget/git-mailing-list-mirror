Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F2D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 17:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfA2Rrj (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 12:47:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38131 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbfA2Rri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 12:47:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so18882774wml.3
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 09:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HHzSBubZgoe7aCy9YWfjBjNMeWFmkDrWC8oPkLdGZ5U=;
        b=GbKxmI5WHts8zM//5qojE9xI8a29XokttwFAYT3id5bumaWFvM8SRoEIOFa1GY5HJn
         ts4/k2Duy2z4/F42hUHxTd7dDBF9MQIo2bw6sn3wXSUZQiAqpyZd4ypNLOdEV41cF6zj
         TVMjcd6raIplwRi9ZTL1XTVT4VUQ6mE1PdxRRZpKUOlXSyVTzf5LveT3RZp8ofu4qjZ2
         WkX8oGIEczhz0rPlSQLnbesP34YUX2XFRTY66qphJABHLGBKsRG6ZuqfyWyUaDrL3WKq
         Fz/buuGRWh8FS56qOCKIn4ZDsJpnZ6fa2jfnjL3GlacH+dowY40CSTVOw4t6jZ3dfdn/
         rReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HHzSBubZgoe7aCy9YWfjBjNMeWFmkDrWC8oPkLdGZ5U=;
        b=QHMY3rX8vYKZ1Ou4398eC7T1wQaa9fSuAFDFTIKLmCQ3Z5lDjuvyAJaiD9Cb6/ey/9
         5tSvFOajxP0NRpBrm0oUzSXr7F7p6BeLYMMJ/hq/nb0hwoAVYdS8VlVrJiuTOSe0xTVF
         2Z1VE2qhR+/tpuAZSqpCR88rM3HG+fSX5uvr5CPsiULvmFlaE7DZF6pVntlHp80GDAwU
         V65O2gFGZuYIrWT0HwrOWSYdvNsYBA6dgs9M4V2ubIzWns2oZWzmJlGGSWB7/r5mVcbG
         w3sDhaMCuG9q3u2EXaehk/ZnEhER/iKl9Hg+LEGJjBMaBgGf4JRXozHLq8znWUvtYDyC
         /rjg==
X-Gm-Message-State: AJcUukf6SiPq/QcGJwyIBwLIh9ckhD8FoTR/Gr54lZVxIXCCef7eehxn
        uFlnLJulGRMLJ7N8hU/YArA=
X-Google-Smtp-Source: ALg8bN4daSZ00eJKBSYc2an/pyIz9VM4tesGSpzLqxc2JWX+5yn2Bhn7OWeRThQTjqn3ZqQh3AYoDg==
X-Received: by 2002:a1c:8b44:: with SMTP id n65mr23025725wmd.104.1548784056765;
        Tue, 29 Jan 2019 09:47:36 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h131sm4417121wmd.17.2019.01.29.09.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 09:47:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sebastian Staudt <koraktor@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/3] Add tests for describe with --work-tree
References: <20190129051859.12830-1-koraktor@gmail.com>
        <20190129130031.GA22211@sigill.intra.peff.net>
Date:   Tue, 29 Jan 2019 09:47:35 -0800
In-Reply-To: <20190129130031.GA22211@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 29 Jan 2019 08:00:32 -0500")
Message-ID: <xmqqmunj8ifc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The usual style is to put the whole snippet into single-quotes, and then
> double-quote as appropriate within it. Like:
>
>   test_expect_failure 'describe --dirty with --work-tree' '
> 	(
> 		cd "$TEST_DIRECTORY" &&
> 		git --git-dir "$TRASH_DIRECTORY/.git" ...etc
>
> Those variables will be expanded when test_expect_failure eval's the
> snippet.

Good.

>> +	grep 'A-\d\+-g[0-9a-f]\+' '$TRASH_DIRECTORY/out'
>
> Using "\d" isn't portable.

True, but not just \d.  I think using \ before special characters to
force an otherwise basic regular expression to be ERE (i.e. \+ at
the end) is a GNUism.

> This regex is pretty broad. What are we checking here? If I understand
> the previous discussion, we just care that it doesn't have "dirty" in
> it, right? I don't think this regex does that, because it doesn't anchor
> the end of string.
>
> If that's indeed what we're checking, then an easier check is perhaps:
>
>   ! grep dirty ...

Good.
