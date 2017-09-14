Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB2420A21
	for <e@80x24.org>; Thu, 14 Sep 2017 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdINSTx (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 14:19:53 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:47331 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbdINSTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 14:19:52 -0400
Received: by mail-pg0-f54.google.com with SMTP id d8so97424pgt.4
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BHX3FlBse0DB1nn/g80DpS7f4ay7haXFr3v8zpomzZ8=;
        b=SnI3GmtUg5o3lkYiLZhmRIdnxEzxRjvL/etvB09jsu+pxFzNzubM2E5LNjUQ27JvXT
         zrF336Ly48qnjAf2b1YintjxptcwhOrrNCBxk7YAC+30e3TCu8s4GNqDIUYwY6jP38xv
         pfji5HGxQkK8zzXYXTfJC97/orzQhiK8xXU4MiePaYDHsefoZtR87mhhRLHtDp9DschP
         hDBNPxk4RY7QaVPCLIyzB2m44rv9m9LMqPiqe/ykIO3m3BwBnKkA+1/XQzYbyoR6ivuh
         QusBL/58hlS1soZy49nOVuFcuRz1x2Gta5hrO/OxPjU6RO00FPUbBSGkhe2KeK3Gevv0
         kItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHX3FlBse0DB1nn/g80DpS7f4ay7haXFr3v8zpomzZ8=;
        b=UCcz7qvcyArIkzNO68MZgeQzQRr/976nGzAUxBzI0PUQgN8tSfEiP8VYzBQ5iNNSnC
         bx67YI74n1lqESf0kcrb4KeycC6JsIko6ZYSvikNDaMh1DPcIQCYTnibAMHhgyKKkZvF
         WU7u8vM6qvZOxgXEFAkjgjuBBQ9ZpgrWCHniHVnVU6/gNLMqdtxJIk6Yvh6AUKLPU0yc
         l7xW3ntzpB1YNMu+Jif/KRxytocREeJk/ecJbB7TEKEz5qS89XynWiarvmhDUl9IA2+O
         IwDteJP0PniQcDJ/H9tehDqtX9ysEjB1h9j+Tyq1DcirNbICyMSgeLUcZ8i7E1NSZXRG
         J9Ng==
X-Gm-Message-State: AHPjjUj+PXb2i7DCTBhPapRC3r5+3o2g3BqOiQGLZh6E+sLZOPXtY1sc
        PY7+x/mIXYCF03ph
X-Google-Smtp-Source: ADKCNb7itAra0a6Z1PKzmes0GzGaBnP6pHBS5U+ICQpYzc2zZEo/Jc0mt0JGer7JP6mHJuHIqbjHRQ==
X-Received: by 10.98.223.210 with SMTP id d79mr21506052pfl.67.1505413191807;
        Thu, 14 Sep 2017 11:19:51 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:39ab:24e5:6492:2945])
        by smtp.gmail.com with ESMTPSA id s62sm32922509pfe.91.2017.09.14.11.19.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Sep 2017 11:19:51 -0700 (PDT)
Date:   Thu, 14 Sep 2017 11:19:45 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 25/40] external-odb: add 'get_direct' support
Message-ID: <20170914111945.62741763@twelve2.svl.corp.google.com>
In-Reply-To: <CAP8UFD36yZEU4OM_+u6HkC=Ep1JifXm-ir0+CeJ3=dR44QceoQ@mail.gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
        <20170803091926.1755-26-chriscool@tuxfamily.org>
        <xmqq4ltowcrz.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD36yZEU4OM_+u6HkC=Ep1JifXm-ir0+CeJ3=dR44QceoQ@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Sep 2017 10:39:35 +0200
Christian Couder <christian.couder@gmail.com> wrote:

> From the following email:
> 
> https://public-inbox.org/git/20170804145113.5ceafafa@twelve2.svl.corp.google.com/
> 
> it looks like his work is fundamentally about changing the rules of
> connectivity checks. Objects are split between "homegrown" objects and
> "imported" objects which are in separate pack files. Then references
> to imported objects are not checked during connectivity check.
> 
> I think changing connectivity rules is not necessary to make something
> like external odb work. For example when fetching a pack that refers
> to objects that are in an external odb, if access this external odb
> has been configured, then the connectivity check will pass as the
> missing objects in the pack will be seen as already part of the repo.

There are still some nuances. For example, if an external ODB provides
both a tree and a blob that the tree references, do we fetch the tree in
order to call "have" on all its blobs, or do we trust the ODB that if it
has the tree, it has all the other objects? In my design, I do the
latter, but in the general case where we have multiple ODBs, we might
have to do the former. (And if we do the former, it seems to me that the
connectivity check must be performed "online" - that is, with the ODBs
being able to provide "get".)

(Also, my work extends all the way to fetch/clone [1], but admittedly I
have been taking it a step at a time and recently have only been
discussing how the local repo should handle the missing object
situation.)

[1] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/

> Yeah, if some commands like fsck are used, then possibly all the
> objects will have to be requested from the external odb, as it may not
> be possible to fully check all the objects, especially the blobs,
> without accessing all their data. But I think this is a problem that
> could be dealt with in different ways. For example we could develop
> specific options in fsck so that it doesn't check the sha1 of objects
> that are marked with some specific attributes, or that are stored in
> external odbs, or that are bigger than some size.

The hard part is in dealing with missing commits and trees, I think, not
blobs.
