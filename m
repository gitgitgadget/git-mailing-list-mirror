Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8900A2036B
	for <e@80x24.org>; Wed,  4 Oct 2017 02:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdJDCX4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 22:23:56 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:54825 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdJDCXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 22:23:55 -0400
Received: by mail-pg0-f53.google.com with SMTP id c137so5738012pga.11
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I3rrYqef1JHfDDSanlhlm7lwazZm+DXNA4Q7sO+5iMA=;
        b=NCVddNsY+zGoKeGRrnhHZjAKVJbIBw9wuPbhW+V9eVKtINsKulYUj+ysvML04MKHq5
         DB9Ux1NAEObOMpc9SPSNUNGz/Y4OB5LGkl48KlqeyzN82a6btXh/EXu5udWytVAiR8EU
         5krLA2BMZW0iHGZrHxONDup96AzQF16G6GYwh56CYOub8TtN3mKCUJBUK5y8rjjGV1sF
         VthVZCBZ4kxFoNbdPvi6IQxpx8tLg8IV0BQ/khtlHuuLm1MvK6I4RbJ1HJob3vBgBQTG
         PUmET+X8Xc02tTLfGa1GR0KC++sI+hK08h6Fr9VpGVvZMEw+SopZmYTophnZPjo3pkpG
         N+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I3rrYqef1JHfDDSanlhlm7lwazZm+DXNA4Q7sO+5iMA=;
        b=TZajjpixqumA/erzOyPdQaLPsgMtGU7bEqDJMblxK0BH9v+y1GIWhAGN3VyapIzDk4
         k0L68DghA5gagp2zTE2KZJ5Yun7F9eCH6ccz5i9Ht+D5bYVM+TvxgpDdVIgv/RorfvQ9
         oKFAJCzKb7wV5cfyySs+CIIw9i7h3YjNROhjXNsg8rrS0qXPymDi9TrDEfE8mTAEkE9F
         02b3oIq6/qJScg1LmEp/ynEcM/t0e8CqMzotkuY12IjqzF4tjhCcaogmMp3djAThViSO
         oqFPLMx0t2u16gWppV1sO/XWbpOksJ+4TFvh7+SwufNo9OSdY3H+nIxff0+Y2lZfSMEB
         5+tw==
X-Gm-Message-State: AHPjjUh8/t9jzLIWlJjTnRrmSjXrCJlBLMA55hYX4aUdWeHn7dUa6gXj
        mfBk2iWgiVl39dZ+fNc7/uE=
X-Google-Smtp-Source: AOwi7QAAzcEmJwTTc0E0l6ys+ea+ZFXDbUeiOneiDHdoCsLnnG1xiXg5Ycw6jdVsgoGpFZesW73nLg==
X-Received: by 10.84.129.193 with SMTP id b59mr18614540plb.24.1507083835067;
        Tue, 03 Oct 2017 19:23:55 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:e14c:b8fa:a887:14e1])
        by smtp.gmail.com with ESMTPSA id d12sm2982695pgu.91.2017.10.03.19.23.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 19:23:54 -0700 (PDT)
Date:   Tue, 3 Oct 2017 19:23:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        git-for-windows@googlegroups.com
Subject: Re: Git for Windows: mingw.c's strange usage of creation time as
 ctime?
Message-ID: <20171004022352.GJ19555@aiede.mtv.corp.google.com>
References: <08983090-07d2-cfe4-dd90-ab4887b83893@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08983090-07d2-cfe4-dd90-ab4887b83893@syntevo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+git-for-windows
Hi Marc,

Marc Strapetz wrote:

> compat/mingw.c assigns the Windows file creation time [1] to Git's
> ctime fields at line 591 and at line 705:
>
> buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
>
> ftCreationTime > ftLastWriteTime is actually possible after copying
> a file, so it makes sense to include this timestamp somehow in the
> Index, but I think it would be better to use the maximum of
> ftLastWriteTime and ftCreationTime here which is less confusing and
> closer to Unix's ctime:
>
> buf->st_ctime = max(buf->st_mtime,
>                     filetime_to_time_t(&(fdata.ftCreationTime));

Can you say more about the practical effect?  Is this causing a bug in
practice, is it a bug waiting to happen, or is it making the code
difficult to understand without any ill effect expected at run time?
(Any of those three is a valuable kind of feedback to offer --- I'm
just trying to figure out which one you mean.)

By the way, do you have core.trustctime set to true or false?

Thanks,
Jonathan

> -Marc
>
> [1] https://msdn.microsoft.com/en-us/library/windows/desktop/aa365739(v=vs.85).aspx
