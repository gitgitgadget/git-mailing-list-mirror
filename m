Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B1BC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A528206E0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfK0RbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:31:05 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37254 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0RbF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 12:31:05 -0500
Received: by mail-il1-f194.google.com with SMTP id t9so2082865iln.4
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 09:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klL4PbCPFtcyjX9YXWdjWBKpUXnBMAOjQkmR9R0LWwA=;
        b=PnuNaoDhOpRukicFyQetqHQuVRr6zD3RSXDQ5j2h6roz4eb5SYaxXYV71x7CGD0wi0
         cG8lI07KxZ8IuaMUnKpieyuwZ5Cow3VX7pUqVih/jjvYdMGd49vNKr030rqhn43v0FKo
         5xm6dBzzFLoR3JMeY9sKQvl0SEGIsWWHv058NNRXsdNHsrWTYOmMirhOqN8K4n2OKQ4K
         mx6LwBSV89FtghI7O/28JMoaGyn5c3qeBPKzJsChXITQeWj17V/NrC6KaIqJShRU2pYD
         b3CgN1ZWx6tK2vHkVxElaFXBm4qeZlHogQoMZrQ7wllgDJFxIZAdIdpSYWEsQfgWcdLr
         ZHhA==
X-Gm-Message-State: APjAAAXPcEYSRxgW3g7X7csPGg8mfg9rKgVJ/6uTj/QxG/JiVvYrwSY/
        poY2ysktrnmKdt0vGfEukybeKhXUrctKGzIF9mIqUFRN
X-Google-Smtp-Source: APXvYqzFXh6PBR4bCTRz3cKG1CM8B7FAIuZ2QlId+s8GNqnQU6DiuKN2c2DcEsnRxNOOykRuo/5i0NztvPmeqxZTWok=
X-Received: by 2002:a92:3ad4:: with SMTP id i81mr43461346ilf.18.1574875864664;
 Wed, 27 Nov 2019 09:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20191127151708.50531-1-emaste@freefall.freebsd.org>
 <20191127171507.56354-1-emaste@freefall.freebsd.org> <20191127172035.GB1123@sigill.intra.peff.net>
In-Reply-To: <20191127172035.GB1123@sigill.intra.peff.net>
From:   Ed Maste <emaste@freebsd.org>
Date:   Wed, 27 Nov 2019 08:44:31 -0500
Message-ID: <CAPyFy2BEADNbk8ZjWvTdVu1WtU7Gtxs1Psri1aFzYD358rDRWw@mail.gmail.com>
Subject: Re: [PATCH v2] t4210: skip i18n tests that don't work on FreeBSD
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Nov 2019 at 12:20, Jeff King <peff@peff.net> wrote:
>
> On Wed, Nov 27, 2019 at 05:15:07PM +0000, Ed Maste wrote:
>
> > +FreeBSD)
> > +     test_set_prereq REGEX_ILLSEQ
> > +     test_set_prereq POSIXPERM
> > +     test_set_prereq BSLASHPSPEC
> > +     test_set_prereq EXECKEEPSPID
> > +     ;;
>
> I scratched my head at these for a minute, but I see you are just
> covering the bits set in the "*" case that we now no longer trigger.
>
> It would probably be cleaner to set them ahead of time and just unset
> them selectively in MINGW, etc. But we don't have any way to unset a
> prereq, so lets' go with this for now. :)

Indeed, I'm happy to help with reworking this later on - perhaps
informed by finding other operating systems that need REGEX_ILLSEQ.
