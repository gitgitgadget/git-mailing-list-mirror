Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB61220281
	for <e@80x24.org>; Thu, 14 Sep 2017 08:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdINIji (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 04:39:38 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:43039 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdINIjh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 04:39:37 -0400
Received: by mail-io0-f182.google.com with SMTP id k101so15819671iod.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 01:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s47JOuUe5LIQ0T4qCFnWp/juSN/o58QnOi54LAtPp+c=;
        b=qeaborH9KZBwyN/V7YrTZIhL8MYmrGUQYb0D/utW1LQAPttSR3cHmQWoKIuEeKhQlu
         B3jonYPjEZecbGbZfICRQ6GLL74b+4HIZuE/JPKhyF5MZyUY6IWZh++kIu9dM6UPiqIP
         bI8G7eg1Qt8N+Fj2SoHSw/bXwhyNdSLPL8ntprwoEaEy3vmeFUxIPqqb8M7ndDjAsJpN
         2J4dQzBaCLT2ozCvK0fZyiUMW/Eh918HEG4uEXYo8ViWElOU+kI8Wf4/nBChIsgF6GhC
         j6s4RDs4MK4gXbjcmJ3XOTOpviTY8oRV/Cwv5tRckEoJPxmIbwsa3b0A6b9BTy1gJqyz
         AR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s47JOuUe5LIQ0T4qCFnWp/juSN/o58QnOi54LAtPp+c=;
        b=TYcHMiQp33B415fX82dvdVwbJW8DXNwTtShdMlZtoL2URlZqeu1KMMwFRXTA8yTmXL
         Q3wE92++YAr2Gbd8B7JfMul4M70OilsyQu6dUATLcPhaiIg25GqFGdssjmeOT/BeLBDO
         q8R6CWG/MqDFYLIuosEqPaT38ogXONyLYtP55vAdO4D0wv8vK1zhM1mxxJ4QKSQuiuzb
         8i+6CwS5C7TUupitysR1pNn+SUMnn1OVEB20J4tzYgZvI+ooJjsaOHF/fyPAR0R4mpBL
         x3QWq+cC84EYgQP4LbVLHeaR03WdduRarWYK8uddIIGZSX2PYbZwqdMFDaRI4hFCQbts
         T7/Q==
X-Gm-Message-State: AHPjjUgXfAcGag7rfl82sQNBAjGAKM+uvMbBc0tLJR9Im0hF4ldlzO+F
        QsCneN+u4/XkDvRahnxC4yz36D9yTEtW5jmA0kY=
X-Google-Smtp-Source: AOwi7QCB7jSZulSWk8qQL9cva4hh7c+i0ny71rkNOB/S7XckHCsnGMIuy/W/5DIs69w3Hwv5QOuzBxLlJzCGVFPJzdg=
X-Received: by 10.107.153.145 with SMTP id b139mr1579742ioe.231.1505378376458;
 Thu, 14 Sep 2017 01:39:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Thu, 14 Sep 2017 01:39:35 -0700 (PDT)
In-Reply-To: <xmqq4ltowcrz.fsf@gitster.mtv.corp.google.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-26-chriscool@tuxfamily.org> <xmqq4ltowcrz.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Sep 2017 10:39:35 +0200
Message-ID: <CAP8UFD36yZEU4OM_+u6HkC=Ep1JifXm-ir0+CeJ3=dR44QceoQ@mail.gmail.com>
Subject: Re: [PATCH v5 25/40] external-odb: add 'get_direct' support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 11:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> This implements the 'get_direct' capability/instruction that makes
>> it possible for external odb helper scripts to pass blobs to Git
>> by directly writing them as loose objects files.
>
> I am not sure if the assumption is made clear in this series, but I
> am (perhaps incorrectly) guessing that it is assumed that the
> intended use of this feature is to offload access to large blobs
> by not including them in the initial clone.

Yeah, it could be used for that, but that's not the only interesting use case.

It could also be used for example if the working tree contains a huge
number of blobs and it is better to download only the blobs that are
needed when they are needed. In fact the code for 'get_direct' was
taken from Ben Peart's "read-object" patch series (actually from an
earlier version of this patch series):

https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/

> So from that point of
> view, I think it makes tons of sense to let the external helper to
> directly populate the database bypassing Git (i.e. instead of
> feeding data stream and have Git store it) like this "direct" method
> does.
>
> How does this compare with (and how well does this work with) what
> Jonathan Tan is doing recently?

From the following email:

https://public-inbox.org/git/20170804145113.5ceafafa@twelve2.svl.corp.google.com/

it looks like his work is fundamentally about changing the rules of
connectivity checks. Objects are split between "homegrown" objects and
"imported" objects which are in separate pack files. Then references
to imported objects are not checked during connectivity check.

I think changing connectivity rules is not necessary to make something
like external odb work. For example when fetching a pack that refers
to objects that are in an external odb, if access this external odb
has been configured, then the connectivity check will pass as the
missing objects in the pack will be seen as already part of the repo.

Yeah, if some commands like fsck are used, then possibly all the
objects will have to be requested from the external odb, as it may not
be possible to fully check all the objects, especially the blobs,
without accessing all their data. But I think this is a problem that
could be dealt with in different ways. For example we could develop
specific options in fsck so that it doesn't check the sha1 of objects
that are marked with some specific attributes, or that are stored in
external odbs, or that are bigger than some size.
