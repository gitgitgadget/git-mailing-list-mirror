Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E181D2023D
	for <e@80x24.org>; Sat, 20 May 2017 02:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756688AbdETCLt (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 22:11:49 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33889 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756614AbdETCLq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 22:11:46 -0400
Received: by mail-pg0-f66.google.com with SMTP id u187so11347208pgb.1
        for <git@vger.kernel.org>; Fri, 19 May 2017 19:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2KN4SYcZdQjTC9a4EwwIjcxDTOAFDUKUDZ1EIPzN3Xk=;
        b=YgFBfh7LiQpQIPftwdCfqFqBnRMElReTVGyzQtRGH0p2e3zRzw1cKx0EnlfCZzPdFz
         FWlxKgJ3cmy9V9j06GLHBqIkydqeQLrVUIjBB3cOeKMUoSRJ9z/F0alk1qn/PzdNqKyt
         wjRRDk42THDOLOLGvuVz2Mhn/6zVOa71E8eTJRQIglaewlGDYg0z76fnTOa8Iojyf6GK
         aXwQjkYv8hTdXDvEWRFPsm/uljqRFwpRnWNGz6UqulNr6OfORPyzpnRhJqRFGOFh6Xuz
         sMCcpzquI6huC8OsHZjZocYbx/fC2oFSVDw+5dEYZT5YsbH6YfajxQcOyUls5wCVaK9t
         Le7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2KN4SYcZdQjTC9a4EwwIjcxDTOAFDUKUDZ1EIPzN3Xk=;
        b=nsS6rfeBVPeOzYBziTMn2zEaklUAgRwjNIAE0Rpy+aIgADx4gLOGYrZPQpVdlIYYFt
         1GdHiMoBj4ZTP0CfBez+Z1UWcuKZcw0GSuEFy0Amkvzj+exru9BugMUGPf676+nR7RcY
         X+zzNITBU9KhdqRICDefjrDyxqqPbXgA9eguVOlYvJsFkI3n+Eql1vRjwG/L7DgfYlrH
         QTBLe5wdYlT+Js3s6JKzXsy3RaRfYyAUlfB4rw97SyQRQUai8qqutYVg3eHmd6k1HjWU
         0GO8zMT52zmUV3juICBwu5rHTCRjyDupr8PcbUwa3GlA+SYZ+rvqQeTBfWOCqglPThGe
         5IDQ==
X-Gm-Message-State: AODbwcBhTJ6TyaYfDITeagiS0QHTGYgkbHHBH0M32e5jz0k11T/uFCmV
        lyUFCHSuwMIcwQ==
X-Received: by 10.98.16.215 with SMTP id 84mr13413067pfq.210.1495246305517;
        Fri, 19 May 2017 19:11:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4027:806a:d2b9:807c])
        by smtp.gmail.com with ESMTPSA id 62sm10485373pfs.113.2017.05.19.19.11.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 May 2017 19:11:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Caleb Evans <caleb@calebevans.me>, git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git log.decorate can't be overridden in global config (v2.13.0)
References: <15c2318a2c4.1100a44f3621653.6175207833450352995@calebevans.me>
        <20170520012950.GC25542@zaya.teonanacatl.net>
Date:   Sat, 20 May 2017 11:11:43 +0900
In-Reply-To: <20170520012950.GC25542@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Fri, 19 May 2017 21:29:50 -0400")
Message-ID: <xmqqo9uotgyo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> I believe a patch for this is on the ah/log-decorate-default-to-auto
> branch, courtesy of Brian Carlson (Cc:d):
>
>    https://github.com/gitster/git/commit/c74271aae7
>
> The relevant list thread is here:
>
>    https://public-inbox.org/git/20170512213407.46251-1-sandals@crustytoothpaste.net/
>
> Cheers,

Thanks.  

We should merge this (and other regression fixes, if any) and tag
2.13.1 during the next two weeks.


