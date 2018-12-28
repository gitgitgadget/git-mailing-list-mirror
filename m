Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714DB1F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbeL1U2a (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:28:30 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40869 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbeL1U2a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:28:30 -0500
Received: by mail-wr1-f52.google.com with SMTP id p4so21844859wrt.7
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YjZdqEndY1jcrmGFty+H1vnLolX83+uPQZOUywe8JOg=;
        b=N0DAPqOBGWjRbVKpOzq1XUQNza7LWdiDIUFGCZk7sZI6TZbLrwUPLBjQrDPP6KgrWy
         DNlV/j8fGTpEkIiRKpvzvwgPdmLKcVkyh3idR/8KGooADy4jQcINLksHhMTng1MzzNz6
         qL26TmJxmykrmwK7wubMmWZk+9lLqYiSaem5vTiGJKr4qscFUuIOUZV6TaUNlQ0H+di0
         Ub9bo0wP2B+TJTI/HOO9VWdYarJWHAFJUsvED2uL6ne5Bwk40YNo22XerqvPmHpSwJkH
         h2sBbGwLgKkOCuiyw27Q7fuNLaxSfpRPAEdrwxK5wAwW4yZ/BUJoe/wbWPGe0hRNnvQF
         Jefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YjZdqEndY1jcrmGFty+H1vnLolX83+uPQZOUywe8JOg=;
        b=BAfVjX4wx43VkYMGscvooOgjjmSpz1VjtF4Z4Y0KkwD7L0EzsdmHjhyNOGNSFRk4Wo
         kXTGK2ngsg3jWe4cMTzj2KAkx+6Yyj0W7ZI8Hh41m9AdosOwSQVhC7uqSgic+ojr04qX
         EQmWpW7jDSSu8QWVRTSLorAtoxD17TZBrHYM8VGMj1e0SPmgSuW9rLgrTbch/VQ4VnHP
         anCjVhpxbBh3GzDX04KlGkIw299fAUSXDmqMRFa+nRZqNmNl2vI7jj2gKMcdp6x+MgAk
         lqAp0E6St8p8+4mTB3rRWLFlYl4UKfPe53Ay0asV8cTj7NV8Phy8VGERcGTVJt8HcQax
         5eDA==
X-Gm-Message-State: AJcUukcgAJJ6OXvUMpfanKJFcDk/1glsgvdStZ0Ojfx+b5isKNPiPGuc
        DviqtsPXi2XCSqcXTfhBs2A=
X-Google-Smtp-Source: ALg8bN7oRja1CUnTNoFadC3jnvfmCsNL1ZJnQ6DIur/JU/MD+3yYpbdR78Nlep7LDfbgVHxKsSdUOg==
X-Received: by 2002:adf:d243:: with SMTP id o3mr27208896wri.66.1546028908287;
        Fri, 28 Dec 2018 12:28:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m4sm36685616wmi.3.2018.12.28.12.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:28:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ag/sequencer-reduce-rewriting-todo, was Re: What's cooking in git.git (Dec 2018, #02; Fri, 28)
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
        <202be141-cc57-cf2a-dc15-59647e7bca09@gmail.com>
Date:   Fri, 28 Dec 2018 12:28:27 -0800
In-Reply-To: <202be141-cc57-cf2a-dc15-59647e7bca09@gmail.com> (Alban Gruin's
        message of "Fri, 28 Dec 2018 20:21:48 +0100")
Message-ID: <xmqqzhspl7kk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>>  With too many topics in-flight that touch sequencer and rebaser,
>>  this need to wait giving precedence to other topics that fix bugs.
>> 
>
> Most of these topics have reached master and have been released in git
> 2.20.  Currently, there is four topics actually touching rebase,
> interactive rebase and/or the sequencer (js/rebase-i-redo-exec,
> nd/backup-log, en/rebase-merge-on-sequencer and nd/the-index).  Among
> these, only nd/the-index conflicts with my series.

OK, so now it's turn for this topic ;-)  Thanks.
