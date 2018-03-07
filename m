Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5606C1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeCGS6y (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 13:58:54 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:55787 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754280AbeCGS6x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 13:58:53 -0500
Received: by mail-wm0-f41.google.com with SMTP id q83so6811541wme.5
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 10:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CFZM7ym0rwCYRCt5aqtlJCH7wNIhjSQD8lFF0z4aBaY=;
        b=dzG7LrD5PX0aTLT1DWrWk2VqiNGrSjJygPDzzqhgoGIBG40UDOaEJg8o90OK6nS35/
         Ey98EePqNrMG3cniSnvPo+Kl4dmT5vtE9PKOIIBwwchjJXR1LtJIx9ErsYfoN2wuVm6N
         9bMvmoo7TLs1vNrmhhPuPuNwFkG6WyGIWGJ2h8OYJ4Mgrah4HLMviuzQApPzTvAcDB1i
         LXKkcqRFogHJCBdavJd4K8k4iyMtpAe64xez6S1n5Vvk/G220VZ1wbWA0cyK5evsUpqT
         8U8ZfcDbngVhbsGXiCZ0xHFix6y0r8sUTCj0lGVPquABPGY6LD/l+89MyDE7YB+l5QJE
         TtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CFZM7ym0rwCYRCt5aqtlJCH7wNIhjSQD8lFF0z4aBaY=;
        b=fc4++WMwKI0OHG5/sBln2obTEcqjKhmRHdWdmopVCFZYwo/x+Ke7osXjY1GYiahiPU
         3CEkfXNR5eTW/jw08/hSYJYCyWi2aTgOawdpmotPSXr3PTjgLNyd3GGplAIwELuxgh6f
         wPdXo+UFmU76p51jblawX1JzSfU2NNn2W69g1yRNF6yeylufdxWhK5WOvkU4ATn7k4KM
         NvtgJXxvT0f1GwxEE863CoAa7zaZbplGGl9S2/0RqtXb9llt1YManmxtB2rrpZp/XTaX
         5MhAsCdVesDfYsPmdDiyJFTu7IO22a7to2ujuNvE+Y3UvRkVMSHhXbL3xcYJZZFKPEJV
         Ndeg==
X-Gm-Message-State: AElRT7G+O5eE62NXrY9rwOmZM5BVEstd4c4Mb1ak58/J9EDn6nyEUsYT
        +4nXYk7vgLnMQh+tDCC1QuI=
X-Google-Smtp-Source: AG47ELvW6/7dSWvVQ9xAFgy8YzVz5WCDG6/wDVAZVUIK4rWO4ywLpB2lDyg39tVhNNSgPGIAbnoGQA==
X-Received: by 10.28.218.147 with SMTP id r141mr14421475wmg.55.1520449131935;
        Wed, 07 Mar 2018 10:58:51 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b66sm11289093wmg.28.2018.03.07.10.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 10:58:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Vromen\, Tomer" <tomer.vromen@intel.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: git-stash doesn't return correct status code
References: <8ED425DE0F8BEC45AADD477A8872875788FB691C@hasmsx109.ger.corp.intel.com>
Date:   Wed, 07 Mar 2018 10:58:50 -0800
In-Reply-To: <8ED425DE0F8BEC45AADD477A8872875788FB691C@hasmsx109.ger.corp.intel.com>
        (Tomer Vromen's message of "Wed, 7 Mar 2018 12:16:48 +0000")
Message-ID: <xmqqzi3jzp91.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Vromen, Tomer" <tomer.vromen@intel.com> writes:

>> git stash && git checkout -b new-feature-branch && git stash pop
>
> This is useful when I realize that I want to open a new branch for my changes (that I haven't committed yet).
> However, I might have forgotten to save my changes in the editor, so git-stash will give this error:
>
> No local changes to save

This is given with "say" and not with "die", as this is merely an
informational diagnosis.  The command did not find any erroneous
condition, the command did not fail to do anything it was supposed
to do, so the command exited with 0 status.

