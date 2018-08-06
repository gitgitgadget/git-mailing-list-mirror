Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0242208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbeHFRct (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:32:49 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:54550 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbeHFRct (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:32:49 -0400
Received: by mail-it0-f42.google.com with SMTP id s7-v6so17920615itb.4
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8sTWufGDdQq6cqLzqUANePW5R52L72XsDQqDoblYa4M=;
        b=jBRt+RhMoqfKzBNffFmusp3rem3dizg74DVEoI4/yFN90TqHSv5NM/ljYXUEJj4Z0E
         4Idj/pMXEGnbtBDw9CdeCVplaIf4hTWUHchI026fF0glhDYbPyX17NhNXWJ98RMdBSiX
         ElyUAgKkJ2KeXZD4AI9nRbZQRNN6oPrSgzipKIHPa5bjTnKTzcPwFn4wnLLEcMUmRAlH
         NRm3H9knI9C73BwwyLz0wdHl63B0NCDIswcwypAw37OXR+ysNDrFUZADYIasznwEzvw6
         K6oUE172ccBEs+qfIuKEaxzNlAvHFS2WOjITbB9zbmi01WxGeXcZ099cZrCqSSAAtDcA
         Y4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8sTWufGDdQq6cqLzqUANePW5R52L72XsDQqDoblYa4M=;
        b=V3Npi2Y2NAt13PHKi2ZSZ8KvD4Qx/QvB9goB/cTvETuaQPDAWBD+OqYRn+21uNYEDD
         YTWzm7lFnrgq417j9xnJwbaycKQc8wX7qV2NlAdMbznq6K4LzyH2w4Oj8d0FXmxu5Zg/
         yHWY/yf9J6zX2oxyH2b2AdsqVDIuZ5EnHJ9jGMThv4Twhdc5d+8s6KI8Wsd/xWZa2TVI
         Nliocpy1Fr6UfF+3KnN3V/thg9YgCeK0r31Sn8KP7W2FI52Fo/SzApc9j/uM17C0a4My
         b0VbR4XhStYx0QVQ5MHj3Do6KAgqb+Hw0g9fk0c/CxW6LWwGDcmdo/PtDgF7TMQfdwcX
         AMxQ==
X-Gm-Message-State: AOUpUlF3zvJffbyuTMboTCr+r+d4D1RjCpvr4QC1Gi0yoPw6Qtb994fN
        NpZ4JFpCcaKq5k2ZsnTRGYit4KJV59iAdULCAJc=
X-Google-Smtp-Source: AAOMgpexmi22SFH085CclfEVtRtA0RWChQ9cnWgy1LdG4QxhGjFJDO/YvcHNqyg6MUvqIdiE1/sKpH7pxAsNEJ0sjqY=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr14952011itf.121.1533568993703;
 Mon, 06 Aug 2018 08:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
 <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
 <20180805014631.GD258270@aiede.svl.corp.google.com> <CA+KyZp5i0EXPJ10v+SXmHWCYvZ7=XT8K8gcka0qxCBYXq=OevA@mail.gmail.com>
 <20180805061312.GA44140@aiede.svl.corp.google.com> <CA+KyZp4Yc4_Xaw3v+BPwxi_PW75=GXmj=Re7EpsurXi2_hMc9w@mail.gmail.com>
 <20180805081116.GG44140@aiede.svl.corp.google.com> <CA+KyZp760a3yTF6ghiNh=c5FoU36MN3cdQU5J8NF2Ss+nwRqyQ@mail.gmail.com>
In-Reply-To: <CA+KyZp760a3yTF6ghiNh=c5FoU36MN3cdQU5J8NF2Ss+nwRqyQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 6 Aug 2018 17:22:47 +0200
Message-ID: <CACsJy8Dh_u+8VkyCW60PBvieH-L5EMA+DvUDqYMHfbC1=q=S+A@mail.gmail.com>
Subject: Re: concurrent access to multiple local git repos is error prone
To:     alexander.d.mills@gmail.com
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 9:38 AM Alexander Mills
<alexander.d.mills@gmail.com> wrote:
> Yeah this concurrency problem is real. Not only does it happen with
> `git status` the same thing happens with `git rev-parse
> --show-toplevel`.

"git rev-parse --show-toplevel" having this same problem helps. This
command should never make any update in the repository, not even
taking any lock and very basic access to the repository (I think it
just needs to resolve HEAD, it does not even access object database).
It's so "simple" [1] that makes me think this problem is something not
really related to git. Perhaps the process is terminated abnormally
because it hits some system limits?

[1] well the repo discovery steps are a bit messy  but I think it's
unlikely we have any racing issues there.

> What happens is that I get no stdout when repos are accessed
> concurrently (and no stderr).
-- 
Duy
