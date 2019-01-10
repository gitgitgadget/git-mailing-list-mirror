Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42BA11F803
	for <e@80x24.org>; Thu, 10 Jan 2019 21:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfAJV3E (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 16:29:04 -0500
Received: from mail-ot1-f73.google.com ([209.85.210.73]:55844 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfAJV3D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 16:29:03 -0500
Received: by mail-ot1-f73.google.com with SMTP id w24so5089003otk.22
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mTeah9L12v77W70FsX3mRqHr9fU3qvaut2B7zeUAn9s=;
        b=KGD9LFlQxgnLp6T8O8lnAENDVgn/FisLBaQ8PFXgtb4qIIYAxUc5+4xKvmNkg4SrO1
         CsCvZJqoAhF+yS4vCQzFXf94l2jS1tXLUWpGYisVn7ficP7pWLW5fnhvRWUSQIEZ4Yxl
         Q8rFPIiVQu7ou/XlEFYgOc/4aJ4en3WBPSX4oTidJNgzAn0T5W+OFtW03aotYdPav1P7
         Memt6GtmJEojMhgLos6m64a3pH3sZbHFf+GQKlJiRWv9nhK/ARtrTX9l1eAFb4qXBPXa
         4EpMyPpThJxV90+HPzr6dA6+XCn/DTR16SFd8E85yJ5NGJcvTQzlBRDv5qyAl3eTtzuH
         3CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mTeah9L12v77W70FsX3mRqHr9fU3qvaut2B7zeUAn9s=;
        b=RpLJNQW1n1QvIEcLkHWMq4Wu+El/dhM/x3JPaENFSZQ2mNXZ5jC+Y3kgFd4dhQZDk5
         VSU/zi6CsInv4bEtYazGH/ih+57mdQejx3i/z3GXa1eHU/jGfyXd52TTqhcUSU8tY24J
         StIIBfJbfi9cQaOM5aEUAgmET/8BLCBJL+UQH/QAQdrq+cKnbVndd0F7IdkDfQ2NoH0K
         oGBoS95/SySVxKOn79RPiIgLfo252C830IczJV52MROZZUqjCRSpfeA94zG17z26M4O2
         PpAUGzpQjawqY8nNCT0WeCMmLjNgQX1Kvj+wfsJjCdLUE3TBTQ1Xwmx0RyJ3WB+lwtOI
         nHjg==
X-Gm-Message-State: AJcUukfVFPf8tVrMEtru7LwVJKCaqZKpaSaiSun3/6Mf3vI4pxWD47r8
        wBTaGCA/IHmEM0u7CfV8gldWXHkWedgaFCQOSO5s
X-Google-Smtp-Source: ALg8bN5+K7wWF6iaJYKNPoDrV09ebz7lIFPH0tHeA7prjvypKIzRuUtF6Ns3csThBGpsObAqpMKEshjbHEe1X359BRPv
X-Received: by 2002:a05:6830:d4:: with SMTP id x20mr4746009oto.38.1547155743046;
 Thu, 10 Jan 2019 13:29:03 -0800 (PST)
Date:   Thu, 10 Jan 2019 13:28:57 -0800
In-Reply-To: <xmqqr2dk1bxf.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190110212857.58772-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqr2dk1bxf.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH] upload-pack: teach deepen-relative in protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     steadmon@google.com, jonathantanmy@google.com, git@vger.kernel.org,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Josh Steadmon <steadmon@google.com> writes:
> >
> >> Looks good to me.
> >> Reviewed-by: Josh Steadmon <steadmon@google.com>
> >
> > Thanks, both.
> 
> This, when applied on top of ecbdaf08991, seems to break t5702.30,
> at least for me.
> 
> Tip of 'pu' in today's push-out will be broken as it has this patch
> merged.
> 
> Can somebody take a look?

I can reproduce this. I'll investigate this further. In the meantime,
feel free to remove this from pu.
