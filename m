Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCD520970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbdDKRet (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:34:49 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34371 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdDKRet (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:34:49 -0400
Received: by mail-pg0-f47.google.com with SMTP id 21so1853441pgg.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yfEdujfatMXhjpmuGC++jV6zYELBq3iWcnoUiAzaeDg=;
        b=SeCplz3G2IpZH3wpIpVtKaWofa9BW0dAMRpWfm56PQMoPYbwXQNpzV5eQpvqonGKwH
         8gNJrTTwDI4x6eou/DdLVFzuLSmTAGfuFCHErkCEwLywx0CdTNfkjFfBzFObAnlSQaNj
         wfHYyDqH0m9g0b6WnZvdhduOnaAjVaIwxsDOUiBbE/AUmqsn0SJv6hqrj0KV378ywlCQ
         W+wqWttshTYujrv3kYDeKmF6wCZUe7G+Ff42w40tPFc9RgOjynj2wBSe0mZUQZL5MLzB
         5zJraKVJQysaKespBjAN+EpDBI3Rf1ZwUhfjBiJwnnXcSAfcO5fx6T2YHat9k+0sC01u
         BPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yfEdujfatMXhjpmuGC++jV6zYELBq3iWcnoUiAzaeDg=;
        b=LZBsLVKI+lf8YwAW6d/TmOuztMLonKmAGl3LZyGl3lZb7nxRfT/q6AYfPPTjhemY/G
         Dk7D4t2u28QMLcoAiFPSyo1v5BrNLfEskCqVLXudyY7p0soJ/M9tWpbJQQrADVRj9fX3
         NAQ39KqV6d+PyLwgsKK7bfue4ejiWkehDdSzZzQPjwB61YffE9RIaILitTKflBiwecq6
         dz4LIusIScj2lMB8YwMAl8N+VLnwu9au6l0TN+jRlcZFHO91zTo1LXPQB50u726GlhgV
         Yd20ZmfI+GuPkKyKew/CjcQR/kqzGleM/q80Yv1y4T5WJufI7ZRfPckmnMEzT/vxSo4w
         RwPg==
X-Gm-Message-State: AN3rC/4tYJUWwOqX8yKM2mBQIHBZkyiyFhB8t+Mre5/ARf9vZUANTkz4RKR5m7qMJYMBzZ4N
X-Received: by 10.98.210.2 with SMTP id c2mr1129612pfg.83.1491932088173;
        Tue, 11 Apr 2017 10:34:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9591:6d62:26a:6d59])
        by smtp.gmail.com with ESMTPSA id k88sm31769797pfj.79.2017.04.11.10.34.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 10:34:46 -0700 (PDT)
Date:   Tue, 11 Apr 2017 10:34:45 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] run-command: add note about forking and threading
Message-ID: <20170411173445.GF36152@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170410234919.34586-6-bmwill@google.com>
 <20170411002606.GJ8741@aiede.mtv.corp.google.com>
 <20170411005348.GA30913@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411005348.GA30913@starla>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Eric Wong wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Why can't git use e.g. posix_spawn to avoid this?
> 
> posix_spawn does not support chdir, and it seems we run non-git
> commands so no using "git -C" for those.

This is actually the biggest reason why I didn't go down that route from
the start.  I didn't want to dig through each and every user of
run-command and verify that removing chdir wouldn't break them (or add
in some other way to do it).

> 
> > fork()-ing in a threaded context is very painful for maintainability.
> > Any library function you are using could start taking a lock, and then
> > you have a deadlock.  So you have to make use of a very small
> > whitelisted list of library functions for this to work.
> 
> Completely agreed.

Yes it is difficult to get right, but it seems very doable to just do
all of the heavy-lifting prior to fork/exec making it easier to just use
async-safe between the fork/exec in the child.

> 
> On the other hand, I believe we should make run-command
> vfork-compatible (and Brandon's series is a big (but incomplete)
> step in the (IMHO) right direction); as anything which is
> vfork-safe would also be safe in the presence of threads+(plain) fork.
> With vfork; the two processes share heap until execve.

I haven't looked to much into vfork, one of the benefits of vfork is
that it is slightly more preferment than vanilla fork correct?  What are
some of the other benefits of using vfork over fork?

> 
> I posted some notes about it last year:
> 
>   https://public-inbox.org/git/20160629200142.GA17878@dcvr.yhbt.net/
> 
> > The function calls you have to audit are not only between fork() and
> > exec() in the normal control flow.  You have to worry about signal
> > handlers, too.
> 
> Yes, all that auditing is necessary for vfork; too, but totally
> doable.  The mainline Ruby implementation has been using vfork
> for spawning subprocesses for several years, now; and I think the
> ruby-core developers (myself included) have fixed all the
> problems with it; even in multi-threaded code which calls malloc.

-- 
Brandon Williams
