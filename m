Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99DB720989
	for <e@80x24.org>; Tue, 11 Oct 2016 05:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbcJKFGk (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 01:06:40 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35479 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750976AbcJKFG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 01:06:29 -0400
Received: by mail-pa0-f65.google.com with SMTP id qn10so839997pac.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 22:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kFdUzyh0Dg+xRYRWMwzkJSDRRG7NHSafRFugiumpsHs=;
        b=wULq/5FAlWyUJfJ83q4x9MMO8YcMVd5lvjr2bgRT9clqMPtZCahQ4vfG+0j13eOuQh
         ZPqHL7lZpRQZjOziZzHp4XfyeO1lz7DRq+3/xoxD/aGMKTOEeVpKHfpMYyagT6FAp7KM
         n7aPT7bS36FQIyfGCNcmlk48B3yht3aJYDMY98SNAkss2CWM0frodrKZBQK8UNTfQcZp
         SIhxKEWAb5aoEA6jnKqSMBGJcfnL2R/RLjtn+2l5Bjifn4+qWvM/VYHjihlmRqWIybYB
         eK7zM4zXowBi2bZAWG8HHSEHgvDZiLI2+SHk2cs731h/bwAdM3jERIDS/7DQf1hPQTJg
         Nesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kFdUzyh0Dg+xRYRWMwzkJSDRRG7NHSafRFugiumpsHs=;
        b=FZ1YRsY5LoIvz1YIGnRx0nw3cW2akQ1ej9vMUsSQDWUbUspe7Ybmz+jmNn1jIUdGMP
         BZSPXvqS1VOnFjRShN/grwqMi0CDry6vy3iZfYV7b1EwQ4TUHlbZQYZM0/IQw1SA0ES1
         P0ZFVL54AVRfmQUZ7PosQwBMGCvLpFXbUHGnSQ8D/nylL5bQ6peNBowaXk2ABNNRwLi1
         Le9PMYO2exYpiJFNe0OKoQEeqEviHFl93wCQwOeS2zceWv7Bo6sOtzNY+NJr+JrHHxDD
         ypqMNqyJeCIUT3t0+uoDJ+b8sJm0uNqgbOs4YSQM0hrdpuCzOAQlYS8C4hzKIJprIrog
         lKHg==
X-Gm-Message-State: AA6/9Rm2vQSxmol671WJxWP5xIuaBdHiGnbPTsfKn5OqqVg1sGuMc6G+G6Zqavz5Os0YUw==
X-Received: by 10.66.11.104 with SMTP id p8mr3645173pab.202.1476162388834;
        Mon, 10 Oct 2016 22:06:28 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id a78sm1554729pfj.44.2016.10.10.22.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Oct 2016 22:06:27 -0700 (PDT)
Date:   Mon, 10 Oct 2016 22:06:23 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: Re: [PATCH v4 4/4] mergetool: honor -O<orderfile>
Message-ID: <20161011050623.GA14278@gmail.com>
References: <20161008000130.22858-1-davvid@gmail.com>
 <xmqqa8ecf48c.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8ecf48c.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 11:28:35AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > Teach mergetool to pass "-O<orderfile>" down to `git diff` when
> > specified on the command-line.
> >
> > Helped-by: Johannes Sixt <j6t@kdbg.org>
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> > Since v3:
> >
> > I missed one last piped invocation of "git mergetool" in the tests,
> > which has been fixed.
> 
> I only see 4/4 in v4; am I correct to assume that 1-3/4 of v4 are
> the same as their counterparts in v3?

Yes, 1-3 are unchanged since v3.
Thanks for checking,
-- 
David
