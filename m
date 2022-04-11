Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB61C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 15:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiDKPXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347818AbiDKPXh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 11:23:37 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A53B2BC
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 08:21:23 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z15so7266299qtj.13
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODoPm7ocdNL6n5xvfHOv1OIYb1DMDZi+UixPwVfBaW8=;
        b=HVK06XOJh4CRi2/uew4fyU5kWUxtbv0Wri9LoG8VoFJEn7bUmbC7jy76Pws8R2pYXC
         D9Oy+mGZITRMqPQOJ/DXni9gJ52Fuf+DXXFGK0/+vR/Cwcy8nPUCE7WbkGYM721YYYwa
         r9sCNJYv3/QImbY8A1spY68O1jplnLG/PoJ40NiweylbTw3JChmVyLXPRjjJqtDONQB8
         oDo1o4zEw5GivAOZ+ciCo3p4Vx/ptxocNi/FDmyQ8nyplpSRgmwnrhqIgMexQc1ls7uW
         udreyMW4vmc11eumVa/WX+S+loLTYAqGgG63N9DAlyIofLKpZXn5cgRNUO/htlFssTih
         katg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODoPm7ocdNL6n5xvfHOv1OIYb1DMDZi+UixPwVfBaW8=;
        b=KWym7TG8QPmv65ZZQA0f5nWDcRe3e+70BzcTnMtfx/N5A0SCtNJUx2GLKxXbICgdM9
         ZWlmw/5wudB3loCxapPGt4HWeBFkRewGPGHe3t6Z7LzCsdIc0L5g3vC0nx/F97cZYghX
         WCO3tWTtA2wf++PcsQmy56PFtUneI9TxjZ890K70zNc8kHZvCmupU7Wj7weo5MYA/+oo
         +gPh0yzyCYVQXZ4GoF+ZLmHNntrsYO0OFMYaamyQNKXZuNxanWunmAs9064ukeVm7OPx
         jqWv2Jn5ku9+xI2Lo8GxDZ9JDV4ZVWPOTDpdpI9w8TNGmfsSqpIUea7h8cCSiun8sURI
         sd4Q==
X-Gm-Message-State: AOAM532MK9V+3pLRkhYgXusXtEZYSKrunn6RtGKk69rAgIkcB2r9chXe
        Uwlfrmq3LjMOeSKN1zpD8+R0uL7D/UVL7BnB
X-Google-Smtp-Source: ABdhPJzRGei0cpUwaorMN7H/JyrtkK4uh00fjbhVIC2+Lt3s7ETvq1T/8tqwSplu+sLksEPOcSLOtg==
X-Received: by 2002:ac8:5c90:0:b0:2e2:15c0:a5f3 with SMTP id r16-20020ac85c90000000b002e215c0a5f3mr26405185qta.332.1649690481845;
        Mon, 11 Apr 2022 08:21:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n10-20020a05622a040a00b002e315b9f08asm26932288qtx.35.2022.04.11.08.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:21:21 -0700 (PDT)
Date:   Mon, 11 Apr 2022 11:21:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Dan Moore <dan@fusionauth.io>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
Message-ID: <YlRHcHBrdyUPAu4z@nand.local>
References: <YkcmtqcFaO7v1jW5@nand.local>
 <Ykt6lPF0JC1Mg2Tx@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ykt6lPF0JC1Mg2Tx@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 04, 2022 at 07:09:08PM -0400, Taylor Blau wrote:
> Dan: thank you very much for your gracious offer. Does anybody have
> objections to having some external support? I think the only change to
> the site would be adding an entry to the "Sponsors" section of the about
> page [2].

It's been a ~week since I sent this. In the meantime, a couple of folks
have responded that they would be happy to take Dan up on his offer to
support our monthly Heroku costs.

Any last objections? If I don't hear anything soon-ish, I'll work with
Dan and Conservancy to set up the logistics and transition our Heroku
billing off of our project funds.

> [2]: https://git-scm.com/site

Thanks,
Taylor
