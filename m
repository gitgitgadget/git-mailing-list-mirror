Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758021FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 08:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbcFYIjn (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 04:39:43 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38469 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbcFYIjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 04:39:40 -0400
Received: by mail-wm0-f41.google.com with SMTP id r201so51928870wme.1
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 01:39:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dVL5nCrvEyyJ/3APsiQL3ezNfq5PctPfr24h7SSd9f4=;
        b=SAo15zxJnyOD5Hl2digKb9IEkfZ2QGNOncsyV8N3oI1KtL/ZV1MJ2H3nWjw2tJHu/W
         Ms1WtM+5y18OupnL9lKowBP4t9VUs/hQrVTEaf8WsnZqTmGp6dDoQIMDqH4NgpxicmtG
         sGtfbTXTPIE4c1bCkUeEL5vx2IcYXHmGTlLe6Z9XNoeznr0hpt+rj4XlXzkJxaJGysBW
         maXTM3DruRz+spCfcOWPmqQsHScWI2+ho8IMHsIR/e+FVUE0quz8j6tg+RTMDwxx8M33
         aANr4OFszpBQ446nDD8G3KTWPmu5U2vl1FqZ099pVDbZqO54nSEOexaJVYVca5IIe7oc
         hU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dVL5nCrvEyyJ/3APsiQL3ezNfq5PctPfr24h7SSd9f4=;
        b=Gs5wxfkecCkWR5EHFdtyBaQ1ml8Fh9PuEEgqezuCQ6xW2FazqZStAGr8hxz7p3FvhE
         ukYDVhQpKPx2OfgobvSy33t6o68XWxpdcOY91s1XHKGJmPMKa1FbeJeqpv9kqgTUO9tt
         wNpfzZiwjvhT2JxZBTNPk4mfIuzApohfWIDEFQUQZh3Ve5ldEhHdVJltYBcFbiZMlzVx
         PmYj9QiTFQl2cAWf/DcUkuxSfE8rtdLBKnXBSNDZE76v57hBln9tQUTWVxLxyq+sp5Fo
         qusLZUf0T2IGbcLx4kK+wdQAN3pvWk8Qs0WlvQUApbbBEG82q54vA42u1mLuQ+SQMGun
         LLYA==
X-Gm-Message-State: ALyK8tJYS79pvfN1S4kxW/gf88Wwc7r+IE8FdI+lNoXXHsrj1rr+h4P2s/5d+eRflOVGJ4yBD3w+KK0wMSvHEg==
X-Received: by 10.28.129.208 with SMTP id c199mr1794312wmd.79.1466843971422;
 Sat, 25 Jun 2016 01:39:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.197 with HTTP; Sat, 25 Jun 2016 01:39:30 -0700 (PDT)
In-Reply-To: <20160624200603.GA28498@dcvr.yhbt.net>
References: <CALi1mtc8zmOzk-qv4XAg6N=ENasnMAENdJSLHK7EcpxRUk1nTw@mail.gmail.com>
 <CALi1mtdtNF_GtzyPTbfb7N51wwxsFY7zm8hsgwxr3tHcZZboyg@mail.gmail.com>
 <20160624193548.GA22070@dcvr.yhbt.net> <CALi1mtc6Byb39kbAv16vmkUVu3JDdGG4-yVrLroDVraPDxGFng@mail.gmail.com>
 <20160624200603.GA28498@dcvr.yhbt.net>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Sat, 25 Jun 2016 10:39:30 +0200
Message-ID: <CAP8UFD0+vG3i26=w7WqjYcpOLj+V6X35_W6DAiMmTpiC2kxRWA@mail.gmail.com>
Subject: Re: git-svn aborts with "Use of uninitialized value $u" when a
 non-svn-backed branch is present in remote
To:	Eric Wong <e@80x24.org>
Cc:	Jacob Godserv <jacobgodserv@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 10:06 PM, Eric Wong <e@80x24.org> wrote:
> Please don't drop Cc:, re-adding git@vger and Christian
>
> Jacob Godserv <jacobgodserv@gmail.com> wrote:
>> > Christian (Cc-ed) also noticed the problem a few weeks ago
>> > and took a more drastic approach by having git-svn die
>> > instead of warning:
>> > http://mid.gmane.org/1462604323-18545-1-git-send-email-chriscool@tuxfamily.org
>> > which landed as commit 523a33ca17c76bee007d7394fb3930266c577c02
>> > in git.git: https://bogomips.org/mirrors/git.git/patch?id=523a33ca17c7
>> >
>> > Is dying here too drastic and maybe warn is preferable?
>>
>> In my opinion this is too drastic. It keeps me from storing
>> git-specific data on a git-svn mirror.
>
> I tend to agree, but will wait to see what Christian thinks.

Yeah a warning is probably enough.
Another possibility would be to default to an error that tells people
about a configuration variable that could let them decide depending on
their workflow if this should be an error, a warning or just be
ignored.
