Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E1CA1FA21
	for <e@80x24.org>; Sat,  7 Oct 2017 09:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750952AbdJGJff (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 05:35:35 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:49670 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdJGJfe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 05:35:34 -0400
Received: by mail-qk0-f169.google.com with SMTP id s14so6710993qks.6
        for <git@vger.kernel.org>; Sat, 07 Oct 2017 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NvZOqL7LJcADG4WCFiIlsNbuwtTRy+9H3l1NB6A10cs=;
        b=n/iZXXahP0oE6IID9/WAW5O0xf7UNV8Y7k8zKTY+sTbEnlMwrs+NqFSURrfg7/9YrK
         hQNMGclHCR2DN1TQ19wlfm2r1/RUCkXxRxPY3/L8D9gSSJm4nGgiIiOD2DZLv5DPyRPS
         QwZ3BFQUsiZt/HipSlSU/2+hUxlCViH+kdwTt+fpyBhZRWEQii3aC7zl/BEqYwcU9ZXe
         BVRQpHV2ZoDZMqrvNz1nauAIqPykQzH98Xl2QccW7XKinvAKhGntAIaaTQ1mrIbNadao
         JxxT980pST8/YrpWqacXIQm10nBykdjiMGU9BCNYFP/vePCg9dy43jiGbR0hQitcVMVx
         6UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NvZOqL7LJcADG4WCFiIlsNbuwtTRy+9H3l1NB6A10cs=;
        b=BbMPIxcnIrV7MEV6jbTtCjEGz3IP9qLrXb6xMV5bI3ZOHI1gCTyQUmwgBeqf3XjWq2
         CQ5yHkDlddoir2XuTE37Kp44amt3GlTtsNMJMxvhyhRpPYCEd+7l5CHCdBNRHW8b/+2+
         hFf4YT//fSVBfW/1Rejdb+FAkQvFMFQKdfEbb1SXSyevc4pCkvVsjuj8+d6aSoLiODFP
         ZpvAGpf7vNvX6wshiaigHHg+GWMGbn9UMmuRLVvU6L2OhX5kOYZ7QcHinmxPnM+Hp1tp
         6rMf+iP12j9xj18Yb2gcKxiF5u7jcrhi1t34K2AXrI/iu40JoHQ8DZ9oCJf9kFlc+skj
         +f+g==
X-Gm-Message-State: AMCzsaURQa+GJB68Eb/TNY2gFjceENC5lygDTNE/oyPr50506QuKUWt2
        qVd7tHZZN3lDkHUPDJfEmg+Z6G6+t7G9s1jHnu4=
X-Google-Smtp-Source: AOwi7QAKBbfu+nZr2atjFyBQ3ZLoKPrgAo+rHOt8yH9krU5fegRistKS9UJyvADd9Vtnwla9t+6/6ofvcwFh8WC3URo=
X-Received: by 10.55.151.196 with SMTP id z187mr1702601qkd.135.1507368934049;
 Sat, 07 Oct 2017 02:35:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sat, 7 Oct 2017 02:35:33 -0700 (PDT)
In-Reply-To: <xmqqshevtk77.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3ouqruh.fsf@gitster.mtv.corp.google.com> <20171006132415.2876-1-pc44800@gmail.com>
 <xmqqshevtk77.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Oct 2017 05:35:33 -0400
X-Google-Sender-Auth: 0_frSw6L4eMBnXXO8wCpO_yA7fU
Message-ID: <CAPig+cSCRyfs5_6kbcy87rAVBZwg0zYs3JGkzxAO5MMmznfEpg@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Incremental rewrite of git-submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 7, 2017 at 4:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> FWIW, the previous one is at
>     https://public-inbox.org/git/20170929094453.4499-1-pc44800@gmail.com
> Hope that helps ;-)

Thanks, it does help.

Having scanned discussions of previous versions, I see that some of my
comments do indeed overlap (and sometimes are at odds) with comments
from other reviewers.
