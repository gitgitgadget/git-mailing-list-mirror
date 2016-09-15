Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761A22070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbcIOSQ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:16:56 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35224 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbcIOSQy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:16:54 -0400
Received: by mail-it0-f52.google.com with SMTP id r192so108846441ita.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TmTzMz5pjxFJsvQTY9krzWFLajkwfg6S/3umsgByXps=;
        b=avOQJJgKlZVEYqoheg9NKHWkSsSngkf3H9umGcvToBLvCCXlAqZ+EP3L3xzc8t/uwM
         HvNrCisS/ADQyy1PXLvcR7t2x7YxfBptVMUH3CwJno5YWA2d9dGTLYnE0JE1RbD1qLTf
         VUaFRy4ePDCC7WMxMwdeVOwN6x3qr2Dl45zDb93MBr7b1ZBGc2e3yhshHvtTDqZIZHtz
         S4tAhhY+rTyZzoYv91gjx2C8KBdtIms6jEjJhagdTnpVFo1qNKzeelu0AtXICm+QhSs+
         MMzQ78PGmDthg9M70x8lCpXU9kQdgcOXOtRhsHg3RC2Z7IA96jcyAM/lFllnOI8ZmT0S
         ogSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TmTzMz5pjxFJsvQTY9krzWFLajkwfg6S/3umsgByXps=;
        b=dD6FfynINz1CQm0bsa+kaT8E/MHwAcvhfdZwAlG1KgGE9rgwGqxbsV5cGk53DPjSg7
         hlDz5gQjfwM5v8k/+BNOgotVBlpUGLCm/SLpB4cHm7ThfTBnZhyaCjepFi7vX21MkUc3
         DxC3FZl/kiGqtTYaWFRRLj9QmCZ3S2I6l3swUxneDsXOE2aQFjHH5VeELWD8ScG70lzl
         EE7fdj4Bj0/kPwQXTIdKdxholh8qzd1srxnWL1C95E8fFfHJUIWdYdAVduP2aXL+EJ35
         9Ths8P4gxbH1Gh78yyoW+PTk6FOJhZQXVeFylVTuUpF2AnSa6QRaFo5hXS6eGbfHPUXc
         fY2A==
X-Gm-Message-State: AE9vXwMxvc1/aRV60YD3K8LBxqp9xUYNKI6Y4+JgOo28a6ojpB9WUlh+Oc8Ex78yfi0+aXU6/IZHYMoIuNfnDlnp
X-Received: by 10.36.6.1 with SMTP id 1mr947616itv.50.1473963413607; Thu, 15
 Sep 2016 11:16:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 15 Sep 2016 11:16:53 -0700 (PDT)
In-Reply-To: <20160915181254.GN9830@onerussian.com>
References: <20160915130233.GC9833@onerussian.com> <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
 <xmqqwpidniry.fsf@gitster.mtv.corp.google.com> <20160915181254.GN9830@onerussian.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Sep 2016 11:16:53 -0700
Message-ID: <CAGZ79kYrFnAM97AqRN2e8s411wniT8QGqopC7vsZ=7ZJV=zwMQ@mail.gmail.com>
Subject: Re: [wishlist?] make submodule commands robust to having
 non-submodule Subprojects
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 11:12 AM, Yaroslav Halchenko <yoh@onerussian.com> wrote:

>
> do you foresee any unpleasant side-effects from above manual editing
> .gitmodules/submodule update --init ?

I think that is fine, but un(der)documented. So you have to figure it out
from experience what to do exactly.
