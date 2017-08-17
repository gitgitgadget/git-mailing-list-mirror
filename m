Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95E420899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbdHQVtn (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:49:43 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36942 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbdHQVtm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:49:42 -0400
Received: by mail-pg0-f44.google.com with SMTP id y129so50998818pgy.4
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dE/1l7X5EG0Gps9+zPcFJ8cmqyBrL6Op8+VMpBoJRU=;
        b=O4uM0kXrJSY25yBSEjhD/dUDX/lhOqX059EaCPxheUHW9LrFMok8HqqXZDi5bx9f9C
         E7Dt2ZzGb56jearNU1qEIpXJr8bKqxoVNXmBm2FfIq9cW6tsY/OSepdHbKGA/cnVLQz3
         1w4mDrKQDUmpm9iaPcykaq4vMrEi8Rbtb3+p/2VvR1j/4XMWg73uLOb1vuTkisRbqg7Z
         CODMe3AWNYba/zjijmYhUB4Syj40aqw/HWjfig46QBmqH/YloWe+QrbrcGX9Jjo7K9eC
         juZQWrcFeO99bQ4697+rA68Y0U79EQaC2xBnuz9FfiA0a9ZPMBNKVEZ3SPUJwJXpOAcR
         TOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dE/1l7X5EG0Gps9+zPcFJ8cmqyBrL6Op8+VMpBoJRU=;
        b=TIkWV6bTk0DjYIttR1rf0A5VWnlOyDVC0DAtjjf186zrr5zjZBdXvxeI7fJloGlEY9
         JgnKdlgvnnrIbGB+yoOyWs21woZ7zg/x/Eqe8u94w4QycTbx09CxNRGJaivrxr4hL22Y
         Rapo9TxyjE+Mb/49Xk9yOPzNnhH66AeE9hZRW34wH1cjZoQbhVYs5Ug29ITE1AxnH2ml
         4QC8S3jePkYvYe1RjWC0kMMczTXAttYuDopiC927bYwx6NvcFtSJjm/6pBUJGjbxWYuk
         KrDeuYiSCbgzyaxlzhtTD+G47lxajWbmd/3xMTYUXGUF5XOgSLI4zV9dHoi54ojBzrC4
         j4+g==
X-Gm-Message-State: AHYfb5igAurIA9XrZhv36EvjnMI8XnQI+FsJfrFGCzL2HC8CFrOtMchF
        w+auNPT1Pkpw/Cth
X-Received: by 10.99.142.74 with SMTP id k71mr3043652pge.86.1503006581730;
        Thu, 17 Aug 2017 14:49:41 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:75a4:d37d:bb23:58d2])
        by smtp.gmail.com with ESMTPSA id j65sm8004771pgc.36.2017.08.17.14.49.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 14:49:41 -0700 (PDT)
Date:   Thu, 17 Aug 2017 14:49:39 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is
 unsupported
Message-ID: <20170817144939.72fcd998@twelve2.svl.corp.google.com>
In-Reply-To: <25BB25E4-DD3F-46A5-8CD5-D784CBAB6F52@gmail.com>
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
        <20170815111725.5d009b66@twelve2.svl.corp.google.com>
        <20170816002257.GG13924@aiede.mtv.corp.google.com>
        <CAP8UFD2jLdR7HTi-T6J_xWvxKyoQf_6pUTX1CWsd9v3TXh9FXw@mail.gmail.com>
        <xmqq8tijpkrv.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1H4Pb5e2_pioQ5neROc+64e55RfvRhiyz5Df5AwJg-FQ@mail.gmail.com>
        <xmqqbmndgb8w.fsf@gitster.mtv.corp.google.com>
        <25BB25E4-DD3F-46A5-8CD5-D784CBAB6F52@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 17 Aug 2017 23:34:33 +0200
Lars Schneider <larsxschneider@gmail.com> wrote:

> 
> > On 17 Aug 2017, at 23:01, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > Christian Couder <christian.couder@gmail.com> writes:
> > 
> >> ... but I think we should then emphasize more in our test
> >> scripts (maybe by giving a good example) and perhaps also in the doc
> >> that the filters/sub-processes should really pay attention and not
> >> output any capability that are not supported by Git.
> > 
> > Oh, absolutely.  If you know there is such a breakage in our test
> > script, please do fix it.
> > 
> > Thanks.
> 
> Junio's reasoning [1] is spot on from my point of view.

Agreed.

> 
> I intentionally did not add the negotiation to the test code to keep
> the test as simple as possible.

I think this is the correct approach - the test was testing Git's
behavior, not the filter's behavior. (Although, if someone wanted to add
a test for a misbehaving filter, that would be great, although such a
test would have hardcoded output from the filter anyway.)

> However, I wrote this in the
> gitattributes docs [2]:
> 
>   After the version negotiation Git sends a list of all capabilities that
>   it supports and a flush packet. Git expects to read a list of desired
>   capabilities, which must be a subset of the supported capabilities list,
>   and a flush packet as response:
> 
> Maybe we should revive "Documentation/technical/api-sub-process.txt" [3]
> after all to explain these kind of things?

As for reviving that specific file, I saw you wrote a similar comment
but I didn't reply to it - sorry.  The commit in question is 7e2e1bb
("Documentation: migrate sub-process docs to header", 2017-07-26), and
in that commit, everything in api-sub-process.txt was migrated. I think
it's better for such documentation to be in a .h file, rather than a
.txt file.

As for describing the Long Running Process Protocol in a
Documentation/.../txt file, my plan was to create a new file
specifically for that, as you can see in an e-mail I sent [4]. I'm OK
with putting it in a different place, but it probably shouldn't be named
"api", because those are for internal Git APIs.

[4] https://public-inbox.org/git/eadce97b6a1e80345a2621e71ce187e9e6bc05bf.1501532294.git.jonathantanmy@google.com/

> [1] https://public-inbox.org/git/xmqq8tijpkrv.fsf@gitster.mtv.corp.google.com/
> [2] https://github.com/git/git/blob/b3622a4ee94e4916cd05e6d96e41eeb36b941182/Documentation/gitattributes.txt#L408-L411
> [3] https://public-inbox.org/git/20170807102136.30b23023@twelve2.svl.corp.google.com/
