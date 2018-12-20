Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9432D1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 18:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbeLTS4m (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 13:56:42 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:34603 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLTS4m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 13:56:42 -0500
Received: by mail-qt1-f180.google.com with SMTP id r14so3019504qtp.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 10:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ZS7hm7vgANlm+uJlgxgll7ro81qCs5a3tfrTxNQo18=;
        b=Og1vd6Yh0EqUn3D5rJvg/iXArVPZ6UYr600NTFLK9pzep1BmbllWktA8WKkRkgrwnY
         KJbadRnsJo/rtnpI0X8zhyndTzyyr4/YO3s3roB4Fe9yEiYSGYo1B8fReb9qpqk1HBAX
         eXZyXWrUuxgz3Tv+EBBVGKyBkP1d4NL/rEZTrBhe4UDp/Mfnx5pbwM9ra1Ex1tdG3AuR
         OUXws8pu5yKFDDxKWNDn1ecXad6eEHZkoiXwWUVqeN4fdEsa/X+cPjt9HosQc9wePTGI
         133BXS2vwXcmmar3YwxEGqLRSz8gvcq3PDjnToJqOUoKcU+n+1VE9ws0VUG/MHNs0xNf
         EqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ZS7hm7vgANlm+uJlgxgll7ro81qCs5a3tfrTxNQo18=;
        b=rAdKniFtdksQk1Sa7z/gqvs/7Gauy6f/MJTYta3wk0J9YJ6g89hNM72R/sZYrHogX1
         Re17NcFBU333A31HLtzGKAQO4wwQELqb5CRHTRWUSP5BklZwSQBEnTKEyuOQXGaxofpn
         2ETIGhdBUTkuTOBO4bBlMhRSoEbjLtmtXOhIZlKc+gCjeYvnDkP0MMH4ji9iT6BbxYr6
         8IqtQvYw1SAPfOFW6fySLJfUrlTYadsPTEd0HkriSjyEpHDKbiOHSUluDUEAILTOaCXA
         IEIBupJhppn01TYC2UYmroL4JCBYA9JB9sYy0vvCzW8UklALnhpOYI+3CJf0DVIXqUup
         t9Uw==
X-Gm-Message-State: AA+aEWZxwkhSAFULTSyug+20+OwtkfQFE76WkqJ1KtSsOh1TZUYETcJO
        br3KQ8gzFkxpstRUYeV8or181zTu
X-Google-Smtp-Source: AFSGD/VbINh2ktDJGgAMWehD8nWZ3pWTIglccvESECxJwl3JaQnxsDEl480prLDWg4DNTKUf3dsbVg==
X-Received: by 2002:aed:2c87:: with SMTP id g7mr26885844qtd.52.1545332201679;
        Thu, 20 Dec 2018 10:56:41 -0800 (PST)
Received: from localhost.localdomain ([187.183.221.211])
        by smtp.gmail.com with ESMTPSA id 24sm4489086qkx.77.2018.12.20.10.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 10:56:41 -0800 (PST)
Date:   Thu, 20 Dec 2018 16:56:36 -0200
From:   Ricardo Biehl Pasquali <pasqualirb@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org
Subject: Re: rebase: Ask before doing anything not undoable
Message-ID: <20181220185636.GA5853@localhost.localdomain>
References: <20181220173348.GA5203@localhost.localdomain>
 <3a7a52c3-3ae7-6e5e-b660-49fb21dc7d17@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a7a52c3-3ae7-6e5e-b660-49fb21dc7d17@virtuell-zuhause.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 07:28:20PM +0100, Thomas Braun wrote:
> Do you know about the reflog? This let's you undo these kind of changes.
> See git help reflog.

I didn't. This should be documented in rebase manual page.

Perhaps a message after the command might be interesting
(e.g.: "to undo use git reflog").

Thank you!

	pasquali
