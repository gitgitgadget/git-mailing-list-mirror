Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD141F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 21:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKSVlM (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 16:41:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39255 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfKSVlM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 16:41:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id l7so25692329wrp.6
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 13:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LTYzY6yHTVPzni57AdGsMk8aKrEHRV1vSw9nP6dXVaU=;
        b=HySNLu7ryrPVPN8a3Hq2M0zFttBuW0dXhs9F+Z5CHe3WlooX2B+fBDz7ZhsrCxgUCS
         v+sH9OgIxJvjw0yJzxaItqmGd7nwhBzcpPwAYNgiIMJv0iG+K5xjyrH+95ehC2zFNqc/
         NMlH5VTUv7L9BcK/YDsw0E8qIcSMWBAZIhfU4I0xvB7xCwpx3RxI62rJkgNgcRSUq4fV
         +iSZHZEvPChP44FRAeaQ96YwYQgfAHddOvgB2GlTAjzIf05F8ekKNThx/kNM0D3N5qJi
         xp/s219qSfisG3okZeqJ2nu+Qx0k3BBAsOSiKfCIhMer0qRP1jy6Q7p1pHXPb44s38eQ
         5Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LTYzY6yHTVPzni57AdGsMk8aKrEHRV1vSw9nP6dXVaU=;
        b=CgHWZ8ElJ/ROL2f0wacv9oUV2WdlII5o3+uLaPe4I/aGaVfd+G4APvF1+Gvp84J5qQ
         ssGUL83T18OLQkuG5516nFI5gsMk97p0X/sQcA+eRge7eSsTJi81gNXrtEnkvR6ioxvK
         uVMONvGI56jYZC7aqTpVd8GYF1R1srrMaAH9Qp/fZRjxr4F1hjaq4r+Tz129lsPYgSWJ
         TUmNCemL0V1e+UzyoKTS4rYYZyBE76tjXYtmFjX0mXsYCA4M3kZ+QP1xdg/kzyus29Yz
         Ra3PKQwFuWyXF2Im/g0FOmMln2UArAJpsbtM6r43c320PzH8ogjuTqKe8t8vJtrDcPBD
         vDKw==
X-Gm-Message-State: APjAAAVebA9hyl5VIsY63oWBAjAM89mQmqcd/+dzo9fU+HeU+otV1iAG
        HAhYdoxZYPhdqilvloxwQag=
X-Google-Smtp-Source: APXvYqxokpBOZoIE5U6yOr2aejFZt/KP5yEdibqOUlIALP9lQUTbr9CYeQk2DLGXVnuDgfVsO4MkQQ==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr29042329wrq.40.1574199668352;
        Tue, 19 Nov 2019 13:41:08 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id 189sm4779661wmc.7.2019.11.19.13.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 13:41:07 -0800 (PST)
Date:   Tue, 19 Nov 2019 22:41:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
Message-ID: <20191119214101.GN23183@szeder.dev>
References: <20191115230637.76877-1-emilyshaffer@google.com>
 <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com>
 <20191118214519.GH22855@google.com>
 <20191119184919.GM23183@szeder.dev>
 <nycvar.QRO.7.76.6.1911192227280.15956@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1911192227280.15956@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 10:29:43PM +0100, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Tue, 19 Nov 2019, SZEDER Gábor wrote:
> 
> > On Mon, Nov 18, 2019 at 01:45:19PM -0800, Emily Shaffer wrote:
> >
> > > I don't mind the idea of pushing folks to ask on the mentoring list
> > > first. It's pretty well attended already - just now I count 16 list
> > > members, a pretty significant majority of which are project veterans.
> > > I have no problem suggesting newbies ask their questions, which others
> > > probably had and solved before them, in a space separate from the main
> > > mailing list.
> > >
> > > Of course if you want to encourage newbies to ask in any of these
> > > three venues, weighted equally, I can change the language. But
> > > suggesting the main list as a last resort was intentional.
> >
> > git@vger is the ultimate source of all wisdom :) and it is openly
> > accessible for anyone for writing,
> 
> ... except people with an @outlook.com address (all of their emails will
> bounce) and people who do not know how to suppress HTML in their emails
> (which I believe constitutes the vast majority)...

And I believe that that "vast majority" will never try to contribute
to Git, and thus doesn't matter.

> > reading, and searching.  Therefore these three venues cannot be weighted
> > equally, but git@vger should be the explicitly preferred venue.  Only if
> > the newbie has some other preferences should the other two be
> > considered; e.g. if more interactive, chatty communication is preferred,
> > then try #git-devel.
