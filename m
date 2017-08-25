Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0B4208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 21:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934679AbdHYVXK (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 17:23:10 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:38523 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbdHYVXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 17:23:09 -0400
Received: by mail-pg0-f48.google.com with SMTP id b8so5056044pgn.5
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtMdhjWUegoa2ar2z8ZLjDL4GG7UWCTOnTpv5lK2wLY=;
        b=TduHUyEu1N8pplW3G0zRKY/R/M7Q4Onz1GbdD6Y5qfO2MLFiGxwtz1z7tkW+Rz46Qz
         YHEhKhUzRw6RkdagevGaz+VnyNwSRkojUbFUugueXeoTmkk5g7l9SIyqNzvCbuh9KGCk
         RMTIQzPtJXjjv9yFxL8KM3MPX8u+a+kJhNDYSDoX+6E5X9GDxJleRUROqZzwoa0aIX43
         PfiClswb3yHkgBe6vObp9YmHVLEE4+YXtFus0aX4yV/FjPjlL/57LDVad5BQeO451VJY
         0az8K6sygV5b8RWHiMxkiMZZBmkEJN6lyTtpVmpt4LCVQQi/8IJksJW3u2OLTcnKotju
         YBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtMdhjWUegoa2ar2z8ZLjDL4GG7UWCTOnTpv5lK2wLY=;
        b=MQuoGTEX/j0BtPWrMpO/ydTUw+tu+3Z7y/zUblHJkI8a/VHH7CaBHfJ6dR5w9Exwkr
         ovH/1qU06Yiieiw74zkMzU3yTeMCXiq+1TA/a+luX3AW/78yYb3S88JwVz59z6cn0H1+
         m10NLYCa59XFj/SLgFoSERk6wA3OW9w7Rkhi+t3v/fEi5VRxCAN3SGcyV8KQYLK498v0
         I1zz7aS5KJlrAKlIK7b7sP+BxJFdn79SmSORYpBXfQkA4lw4a0JCdE3xd0d1g/jWzayF
         WxK8J1TBM43JMYuLAoS2m6wfsiiltVdNk1Vi92MdAuXeDtCG08YYSOnd9aDc6yy31LVR
         ksvg==
X-Gm-Message-State: AHYfb5i3eSQed3KsJ9wUGR52IAqkL0D+0kzo6ri895XO//BB8UWlSW7W
        BBnvJTsGOpTNjhZt
X-Google-Smtp-Source: ADKCNb6Kay6Q8RRW4AaTUkKQwN5RK4eb7wY3GZq+IALHOQp46KtsKs/I+yH4bNh11eX+xbL0c9weDQ==
X-Received: by 10.98.34.208 with SMTP id p77mr11079992pfj.315.1503696188634;
        Fri, 25 Aug 2017 14:23:08 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:d1c8:e472:b952:ce78])
        by smtp.gmail.com with ESMTPSA id g2sm12867322pgu.86.2017.08.25.14.23.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 14:23:08 -0700 (PDT)
Date:   Fri, 25 Aug 2017 14:23:00 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 35/40] Add Documentation/technical/external-odb.txt
Message-ID: <20170825142300.01b15d6b@twelve2.svl.corp.google.com>
In-Reply-To: <CAP8UFD1oONnj93UKf=nBzgOQtY2E+ZVvoLGDNGLsZVobfiN90Q@mail.gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
        <20170803091926.1755-36-chriscool@tuxfamily.org>
        <CAGZ79kYhUJ5mmTEO3b9G7M6onuCusBUTSsD7KeCmeMpfaOvroQ@mail.gmail.com>
        <CAP8UFD1oONnj93UKf=nBzgOQtY2E+ZVvoLGDNGLsZVobfiN90Q@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 25 Aug 2017 08:14:08 +0200
Christian Couder <christian.couder@gmail.com> wrote:

> As Git is used by more and more by people having different needs, I
> think it is not realistic to expect that we can optimize its object
> storage for all these different needs. So a better strategy is to just
> let them store objects in external stores.
[snip]
> About these many use cases, I gave the "really big binary files"
> example which is why Git LFS exists (and which GitLab is interested in
> better solving), and the "really big number of files that are fetched
> only as needed" example which Microsoft is interested in solving. I
> could also imagine that some people have both big text files and big
> binary files in which case the "core.bigfilethreshold" might not work
> well, or that some people already have blobs in some different stores
> (like HTTP servers, Docker registries, artifact stores, ...) and want
> to fetch them from there as much as possible. 

Thanks for explaining the use cases - this makes sense, especially the
last one which motivates the different modes for the "get" command
(return raw bytes vs populating the Git repository with loose/packed
objects).

> And then letting people
> use different stores can make clones or fetches restartable which
> would solve another problem people have long been complaining about...

This is unrelated to the rest of my e-mail, but out of curiosity, how
would a different store make clones or fetches restartable? Do you mean
that Git would invoke a "fetch" command through the ODB protocol instead
of using its own native protocol?

> >> +Furthermore many improvements that are dependent on specific setups
> >> +could be implemented in the way Git objects are managed if it was
> >> +possible to customize how the Git objects are handled. For example a
> >> +restartable clone using the bundle mechanism has often been requested,
> >> +but implementing that would go against the current strict rules under
> >> +which the Git objects are currently handled.
> >
> > So in this example, you would use todays git-clone to obtain a small version
> > of the repo and then obtain other objects later?
> 
> The problem with explaining how it would work is that the
> --initial-refspec option is added to git clone later in the patch
> series. And there could be changes in the later part of the patch
> series. So I don't want to promise or explain too much here.
> But maybe I could add another patch to better explain that at the end
> of the series.

Such an explanation, in whatever form (patch or e-mail) would be great,
because I'm not sure of the interaction between fetches and the
connectivity check.

The approach I have taken in my own patches [1] is to (1) declare that
if a lazy remote supplies an object, it promises to have everything
referred to by that object, and (2) we thus only need to check the
objects not from the lazy remote. Translated to the ODB world, (1) is
possible in the Microsoft case and is trivial in all the cases where the
ODB provides only blobs (since blobs don't refer to any other object),
and for (2), a "list" command should suffice.

One constraint is that we do not want to obtain (from the remote) or
store a separate list of what it has, to avoid the overhead. (I saw the
--initial-refspec approach - that would not work if we want to avoid the
overhead.)

For fetches, we remember the objects obtained from that specific remote
by adding a special file, name to be determined (I used ".imported" in
[1]). (The same method is used to note objects lazily downloaded.) The
repack command understands the difference between these two types of
objects (patches for this are in progress).

I'm not sure if this can be translated to the ODB world. The ODB can
declare a special capability that fetch sends to the server in order to
inform the server that it can exclude certain objects, and fetch can
inform the ODB of the packfiles that it has written, but I'm not sure
how the ODB can "remember" what it has. The ODB could mark such packs
with ".managed" to note that it is managed by that ODB, so Git shoudn't
touch it, but this means (for example) that Git can't GC them (and it
seems also quite contradictory for an ODB to manage Git packfiles).

[1] https://public-inbox.org/git/20170804145113.5ceafafa@twelve2.svl.corp.google.com/
