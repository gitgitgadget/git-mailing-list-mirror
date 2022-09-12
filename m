Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C5ECAAA1
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 00:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiILAl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 20:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiILAlX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 20:41:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5982252BF
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 17:41:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y127so7091834pfy.5
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 17:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=WarhEJGq3/dKI7lBch8mK9vBM8az0O8v5mTz3t7gXjg=;
        b=aoMIzRyvcyop5K5ekiKzFmu4xuQVqUagKMQTxCNCMHh1gk8uju5NG+29Ebn/HrmPnN
         k40fweSvlCS1E4H1CW49+j+hlgQcvTC91p+YdDtx+LmyY4sgwdvwmm0tNLU9ZxzP0a5f
         FGWDrpcx+Sz57pcEcniLCjyMu2r1dAfw4HA/qBWLK2vQGdLGY33kF7yV0CnBXj9dWcFq
         gJYB2jDbZVyH3l2RwI70xlDA5uQRCfOdKGEhsj4PxqWGsWb8+2Zpguo4MJEFhgcfqy0J
         nU2xVnqL6T1J5o8cjnbozgevn0prRsv/E4TULSiqK+NFMPb8bdRhDpk5GVZpLYz/oTm1
         zKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=WarhEJGq3/dKI7lBch8mK9vBM8az0O8v5mTz3t7gXjg=;
        b=60VQbimw2RSFDB9qgtj/Esg4ALJmnOWjLaeCXrtZnpANpMK7BF+erdCsFqebYIlxL5
         l7nPR5s5ni3hDsrYAWtgZWHKrYQmtoBCv/ljax1V2qV8CO0RaRTnjPlP31Nkd6dSyEvV
         ob2Dh7iyV4XuI5m1rWzeZuL+IEtTNL9Ca2HkZEoERN02tpC0glXXsOjA93u7dFfo9Z0W
         fmne3hCBX0m/7nLtCX0K4slct8J216td8peuHOtNPYKqcMAl1Q6oFhfOkwpwFZP0HXIy
         R1YtvXUwRhlEQqe881TDvsArz+3DfH+INZPZ+AdrhyupIENMrY7vwPMQPCkU0FZS+vJN
         v++g==
X-Gm-Message-State: ACgBeo2uo6Tn4FIZl9WQ/O3zYP91hUCHePxAHEFiDhPUc0dFsNGmPGLj
        kC0Ej/KtAlnDRTdNkc4NE/EiG1t2U4A=
X-Google-Smtp-Source: AA6agR6DXgSZ7mfqZdbFVfEseLBBLXSAzT9DsE3D2EXFVg2L8ocX4WX4U6wAXNFVcYg4xomleXbACQ==
X-Received: by 2002:a63:2ace:0:b0:434:ebd5:e18e with SMTP id q197-20020a632ace000000b00434ebd5e18emr19778441pgq.79.1662943282027;
        Sun, 11 Sep 2022 17:41:22 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w7-20020a17090a4f4700b001faafa42a9esm3919589pjl.26.2022.09.11.17.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 17:41:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     git@vger.kernel.org
Subject: Re: Newbie contribution idea for 'git log --children': input requested
References: <Yx5qjPhZ5AHkPHr7@MacBook-Pro-3.local>
Date:   Sun, 11 Sep 2022 17:41:21 -0700
In-Reply-To: <Yx5qjPhZ5AHkPHr7@MacBook-Pro-3.local> (Jacob Stopak's message of
        "Sun, 11 Sep 2022 16:09:00 -0700")
Message-ID: <xmqqillth1am.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Stopak <jacob@initialcommit.io> writes:

> I'm not sure if this really qualifies as a "bug" per se, or if
> there is some way to do this that I'm just missing, or if it goes
> against the way Git's rev lists work.

As it goes against the way GIt's rev lists work, you can call that
"working in the way it was designed", or a "design bug".

> But I'm wondering if it could be addressed by simply adding a
> discrete check to see if any commits point to HEAD as a parent,
> (only when the --children option is used of course), and if so,
> populate those ids into the log message.

In a history where all commits and their parent-child relationship
can be enumerated and the links can be reversed in-core, it would be
trivial to implement.  The challenge is to make sure it works
without wasting unusably large resources to do so in a real world
project.  Having a commit-graph might help.

Thanks.

