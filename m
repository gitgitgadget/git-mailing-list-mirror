Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ACA41F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161722AbeBNSLx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:11:53 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:44400 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161664AbeBNSLw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:11:52 -0500
Received: by mail-pf0-f178.google.com with SMTP id 17so4265127pfw.11
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2+iHQzHcUN9wAmyuSstWgIXRyNp3/upNYgeBCiNHJQ=;
        b=cdHo4eVy92MWs52shIdB5RnNhLb5sWAhe6xYJyzDVBtnldp3TNdib6phnz7FN7lMy0
         WKvhFCj0/EWzlwJiEfapJNyk4PB+nDsqIpyPD4BrQsZZS/CTDu52fEOryF64ZTa3a+5g
         BAyenA1mLps9HLaRIUNE/7eGzUCbAYsAqyy17/ylyUKhQBmMAnTtOF9gLE/RJCAlv0Ba
         6C4PnIwq0zH5uHKpTLkRIJCduDQEOKiPkn9M7bp9INgfA4fzZqtYKxE6A17WTU00jafJ
         mTON/+KmOehLsypJQxqHsD85bS8oCvcMMqo5mTB2u9po6bILf8Obx50OOgwrEBXJT2yG
         gYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2+iHQzHcUN9wAmyuSstWgIXRyNp3/upNYgeBCiNHJQ=;
        b=cnhobRlm9HD88J4rzj//90UW9UCCEYW+j9+z2O21W0FLtZtXFffnGRVo8kFIgOv/kp
         zXSBlZSYwbVW3RXwnx0lx2GEC+lTS6v+0vQ+jDrxmyZMyKvGW3BRZrNv+HFM9KZupsDh
         NdXZUoeo4eP8K1ZPRFlHooF+XlnrNxASpuHMY0sl7ug42ileN40kEOKgrhoQMDk4zugI
         ZX8ltqz8JLVYaglGZj/qA9DcuCkxOW6ecdyymoci5tHFl9GXbSwYHB10TjbewKt5Y4O1
         qNARCDqGdmohIIrwjLIcqYCc7oUKTTd06SKO5JBOFwdbtHWTd554yv4ScrBu9V8vXen1
         4L1w==
X-Gm-Message-State: APf1xPCPYppSvWzeq/tWj9OBRc4WuvKnlq5N5jE/8Rp2dKiebhE64B1y
        cbP+XJMZX9apgaWiU34LWZ7o+Q==
X-Google-Smtp-Source: AH8x2278Jwh1/9WwzRy3Bw17JQj1PBHHIQMmkXS8Wx3ARizJipP6hKcbjnfOuuTfVoL0UPSIGPcrZQ==
X-Received: by 10.99.125.92 with SMTP id m28mr44006pgn.257.1518631911692;
        Wed, 14 Feb 2018 10:11:51 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a13sm39547673pgd.1.2018.02.14.10.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 10:11:50 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:11:49 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2018, #02; Tue, 13)
Message-ID: <20180214181149.GB139458@google.com>
References: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13, Junio C Hamano wrote:
> 
> * bw/c-plus-plus (2018-01-30) 37 commits
>  - replace: rename 'new' variables
>  - trailer: rename 'template' variables
>  - tempfile: rename 'template' variables
>  - wrapper: rename 'template' variables
>  - environment: rename 'namespace' variables
>  - diff: rename 'template' variables
>  - environment: rename 'template' variables
>  - init-db: rename 'template' variables
>  - unpack-trees: rename 'new' variables
>  - trailer: rename 'new' variables
>  - submodule: rename 'new' variables
>  - split-index: rename 'new' variables
>  - remote: rename 'new' variables
>  - ref-filter: rename 'new' variables
>  - read-cache: rename 'new' variables
>  - line-log: rename 'new' variables
>  - imap-send: rename 'new' variables
>  - http: rename 'new' variables
>  - entry: rename 'new' variables
>  - diffcore-delta: rename 'new' variables
>  - diff: rename 'new' variables
>  - diff-lib: rename 'new' variable
>  - commit: rename 'new' variables
>  - combine-diff: rename 'new' variables
>  - remote: rename 'new' variables
>  - reflog: rename 'new' variables
>  - pack-redundant: rename 'new' variables
>  - help: rename 'new' variables
>  - checkout: rename 'new' variables
>  - apply: rename 'new' variables
>  - apply: rename 'try' variables
>  - diff: rename 'this' variables
>  - rev-parse: rename 'this' variable
>  - pack-objects: rename 'this' variables
>  - blame: rename 'this' variables
>  - object: rename function 'typename' to 'type_name'
>  - object_info: change member name from 'typename' to 'type_name'
> 
>  I do not mind refraining from using these keywords in a foreign
>  language in our codebase too much, but at the same time, renaming
>  must be done a bit more thoughtfully.  When the original uses 'new'
>  together with and in contrast to 'old', renaming 'new' must be done
>  while preserving the pairing (which may involve renaming 'old' as
>  well), for example.
> 
>  Backburnered, i.e. will drop if other topics start to conflict with
>  it, but will accept rerolls.

I was under the impression that people didn't care too much about this
(which is a shame but that's an opinion :). If people were more
interested in a change like this then I'd be happy to go back through
and rename the 'old' variables too.

-- 
Brandon Williams
