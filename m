Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369FCC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiGRQLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiGRQLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:11:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB4F1CB1F
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:11:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j12so9447600plj.8
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=UrGGRgSkxPC2UwBNZSjcLaBBkpSlem6lKf3n29Z7beE=;
        b=B2kmXD/QowM77T93uEkK7bxZmrVczrXZ0qUafUepfUVQQBFkJ7iYHVI0GASrZqysv/
         X0KhS1e5DX9arYRORjkfZQLVU0iuAAWV4FEudX42ply/TObDf0gzLg+i+8aaERYgu2LY
         m9x3KXI9u89tYH5saWFbciJGfkXjayky8vEy8p+PqINMzp8ShRm1kKhRLQ6xwGquTF5R
         piF1fPpEcVkKb4uOyc9g5A6wKceZupyueqY6Ry2obfXow3TafMa/ThWc9KzjEWnoY5Eb
         nQ94ohjrPUk+ZHG7UEQ64JCd/UhDVDZrNQtO/mbKAHSKGZkOkbw9f44jqbiFVx31dSmZ
         wizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UrGGRgSkxPC2UwBNZSjcLaBBkpSlem6lKf3n29Z7beE=;
        b=DtzFgIC1kwumM6dIrlem/HNWVgaIEorwqKfqHcOviKho8AUc61NYpW9EUPaq0jCzzP
         ezAs18tKj6yqHyFs92CxZyhC2gWaY7SVbwT4zgonODU/GIKtIyR2cde8btOnXhz4amYi
         f6C9zM1wmQW7I/eiPxtV9TBE8rZI5blxZqd+g8NA+d14drzii8Vwu/grwh9QrkdrJ/QM
         PBgQ59lKp28Lb7n04M6CV4IJ28Czh3IC59HflmZuCflt+1l4St5zBGMenaDtkm/EtI2E
         6pCgqTW4BLrU8S3cEES6nU0KDb2395E/embd9F/7X07Poqe0PhokdnasiC0a0oFZdf6f
         alZg==
X-Gm-Message-State: AJIora8QRJmmXajrwYPPTPaLd5w5EW99HZ2QA6zuOluPV5fv3PWHNrh0
        F8xPwQVnDXjbzvH3hoAB1XBhiwdRADVQ
X-Google-Smtp-Source: AGRyM1u3fkDqgwrByFSFUG7gFIlplCWAM9YwKIRUVzeOy/XQu84WNQhqAvUDJLZtDIpGdl7Q+WHzpg==
X-Received: by 2002:a17:90b:396:b0:1ef:99a4:3737 with SMTP id ga22-20020a17090b039600b001ef99a43737mr39500057pjb.106.1658160705260;
        Mon, 18 Jul 2022 09:11:45 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id je18-20020a170903265200b0016bd62bc003sm9648571plb.141.2022.07.18.09.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:11:44 -0700 (PDT)
Message-ID: <07097797-40d7-022d-a41b-1d219183b4a5@github.com>
Date:   Mon, 18 Jul 2022 09:11:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: What's cooking in git.git (Jul 2022, #05; Sun, 17)
Content-Language: en-US
To:     Junio C Hamano <jch@google.com>, git@vger.kernel.org
References: <xmqq7d4bt8n4.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq7d4bt8n4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen',
> and aren't considered "accepted" at all.
> 
> Copies of the source code to Git live in many repositories, and the
> following is a list of the ones I push into or their mirrors.  Some
> repositories have only a subset of branches.
> 
> With maint, master, next, seen, todo:
> 
> 	git://git.kernel.org/pub/scm/git/git.git/
> 	git://repo.or.cz/alt-git.git/
> 	https://kernel.googlesource.com/pub/scm/git/git/
> 	https://github.com/git/git/
> 	https://gitlab.com/git-vcs/git/
> 
> With all the integration branches and topics broken out:
> 
> 	https://github.com/gitster/git/
> 
> Even though the preformatted documentation in HTML and man format
> are not sources, they are published in these repositories for
> convenience (replace "htmldocs" with "manpages" for the manual
> pages):
> 
> 	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
> 	https://github.com/gitster/git-htmldocs.git/
> 
> Release tarballs are available at:
> 
> 	https://www.kernel.org/pub/software/scm/git/
> 

...

> --------------------------------------------------
> [New Topics]
> 

I have a topic (formerly RFC, now a two-patch doc update) [1] that's had
some review, but isn't tracked here yet. Would you mind including it in your
next update? If not, please let me know what I should do to unblock it.

Thanks!

[1] https://lore.kernel.org/git/pull.1275.v2.git.1657584367.gitgitgadget@gmail.com/
