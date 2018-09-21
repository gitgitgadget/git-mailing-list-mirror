Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62EA81F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbeIUWLb (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:11:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35496 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUWLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:11:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id o18-v6so3952132wmc.0
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GsqI0FjS7CAkGvWULTTLK4DKrNhcBOeGw4OCLTEkJ3c=;
        b=YbSed6v/gKUYRMJTeor4jhp670PCRXoqzZnF5mhw4/Ae3ZEc+Ua8RGaMnEN9vJRR7Q
         9BZ36o9kyR0zp/O2uA3L30aUs45q3RRf2Es0v6TRZEGB1W8eVnwDwB/c8LsrEWQzhqAS
         Aa3/5ttssKOyPd26UUI5kZRv1cqJiXgb0Zg9+ffB9sTK+wCGhlMiGSzRwzkImQlMno7n
         jiIt0HUtBgZN0lsLhgfBMM9B1ZPgqVhZa6K8IzxXiSTyq/2NE7Z33eSiVA6T38+WgFN1
         4HEA4I/cTmz13ikOoDB4jLN8X/+7Se62QxLulhhr6bFkXFY1vltHHKqJg5XNERqlOXQ0
         c1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GsqI0FjS7CAkGvWULTTLK4DKrNhcBOeGw4OCLTEkJ3c=;
        b=cYxBpctgxeEJNQmrm112hYIDI61XxmypUxMG3KNEEmqfIowUrSelGelLrMdKZVefLX
         puVhjNCL30oD3tZmIc4ogAUr8j2T4hVCWoln9izMftER0AhVR3xN9FYsYpsNQ8lFJCSZ
         RhBitiYf3DhuKIr3JgJjHA/EUF0ElwvjDhzdYVfCaJfv840sP8iCr4yx0aaboJCe1NBz
         au6SISCE+fOVejeRGOTMnBhsx7FVZU4z2nxz3yvcbQ9wDez9p8UVkruYNgl07JYOvNSK
         anDBe1Mbzs2MW7iLy0dG7cV6njsS7p2NA6p51Cst8ZkPtgDzy9o9HQEYFcWn4Kz8beFb
         DBFw==
X-Gm-Message-State: ABuFfohWJqDpYRuk8oCoB+2CzK+jvGlVAizhsiBfnJP+lB5uHySlge0H
        7m9GxTNlDDdJoPiSaZhzXP8=
X-Google-Smtp-Source: ANB0Vdb4hs7ccmYuwOOCt22mH8R2MX+s0pf1ZGofhy5iQrZT4fYvt00RKVn9Gs+A8tnDpbh/6Zsu8Q==
X-Received: by 2002:a1c:aa0c:: with SMTP id t12-v6mr8279044wme.109.1537546913758;
        Fri, 21 Sep 2018 09:21:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v16-v6sm35458205wrw.12.2018.09.21.09.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:21:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-object.h: add missing declaration (hdr-check)
References: <12cd9928-d04d-d208-a1b4-ceecbdf79432@ramsayjones.plus.com>
Date:   Fri, 21 Sep 2018 09:21:52 -0700
In-Reply-To: <12cd9928-d04d-d208-a1b4-ceecbdf79432@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 19 Sep 2018 01:18:39 +0100")
Message-ID: <xmqq1s9myg67.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> This is the patch I needed for the current 'next' branch to get
> a clean 'hdr-check'

Which means that this is a fix on top of jt/lazy-object-fetch-fix
topic, I think.

Will apply there.

Thanks.
