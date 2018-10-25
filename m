Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C47A1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 05:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJYOJJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 10:09:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40366 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeJYOJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 10:09:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so137796wme.5
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 22:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pyfdEKkQ7it6+vyWfTFc2J8rZfw4ok2mYGRGFY1Z0Zg=;
        b=D+ij8jc2MJwKrRShCJLPA9CZIkRKmjBYtwsJuGyWDRqRe1dD6/s32v08zPJyd197nC
         cvpvm4fNSCrPJutnOLWciUAnxy1q/wLi8QsbVo49R06HOHjp7mYujUOo0ziuRVzJrqZb
         2oxxOXw8AMr0NKaHJR+yisXJsS0teiUF1i1zd4fWV3c98NjQLVG6wfJdNKGmhpLGb5UJ
         O5w0u8rnzVe1bt0lXHCIQyRi62ahTHAwh9jxUGfG3wCjJzQx0qdHXx4EkDys2+mP6T9U
         Wpa9+f5LDShEctsrfQJL0cmNhZtD9wgHah8FgJMpliPUOW475zIA3jyMD3l5bDLT8eUs
         vaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pyfdEKkQ7it6+vyWfTFc2J8rZfw4ok2mYGRGFY1Z0Zg=;
        b=Acwz+UoKunGTSI5DB1PdpC8T3LRowH1KQj/EKFq14J70ZMRnbK7DGgjrpxpRMjYadh
         h/YHEIqd1zR6rhkh418prDBaQFQkB/wJ/vVBbp0bSutPahkzLRkEXx/cerrmC3tNRmiM
         Sl6XjcfGQ+U+7hzp9tRC9EuQS+3FINe+Wm2d40tipJNd3iyDNjCW4DgrcShDfUSIP/MT
         UWEHW+CxJ83aRegRbf10L56CEisTEIs0S2UpKJfEg//FXNgbkYp/9CxWMvTvOCrWYe0N
         kIxik+8KI6X4J8Fdh7lhbfek5JP3Kc+Bb/R5PM//5UPMm3nGtWTrKHB4cxNhRNCzBFQb
         DjsA==
X-Gm-Message-State: AGRZ1gI39U9rtMl/Fou9i8luf6E6qRhBrf8PcQqW8H0tuY9qtcCfM/Gz
        oT13DtEwRsGbTb+421VOnB0jhL5QtZE=
X-Google-Smtp-Source: AJdET5eGn09GrnM+lcNbnIhTLaack+jIcRUDXp9n2daACKVOD0G5zCU2qG1Q2eXOuhEta/YGI+M7kQ==
X-Received: by 2002:a1c:287:: with SMTP id 129-v6mr274228wmc.52.1540445880196;
        Wed, 24 Oct 2018 22:38:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z18-v6sm2087859wrh.33.2018.10.24.22.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 22:37:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "lhf635\@163.com" <lhf635@163.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: the opposite of .gitignore, whitelist
References: <201810251039388653199@163.com>
Date:   Thu, 25 Oct 2018 14:37:58 +0900
In-Reply-To: <201810251039388653199@163.com> (lhf's message of "Thu, 25 Oct
        2018 10:39:39 +0800")
Message-ID: <xmqqh8hak2mh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lhf635@163.com" <lhf635@163.com> writes:

> I have a good idea, add a file to git that is the opposite of .gitignore...,

Do negative patterns in .gitignore file help without inventing
anything new?
