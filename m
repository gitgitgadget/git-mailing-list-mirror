Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60D120281
	for <e@80x24.org>; Fri, 15 Sep 2017 20:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdIOUy4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 16:54:56 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:47152 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdIOUyz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 16:54:55 -0400
Received: by mail-pg0-f42.google.com with SMTP id d8so2160961pgt.4
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+45i+PAel8g97yGYKXJ1GTAEEB3IncfPP6gF5KHVs8=;
        b=AXZF3bjxZHgaojquS+YSj/c8SVTvoJDI6PZPrgxDmzoCkaCWWLGR9OWoU0ka+oIedc
         FFE9ro/zJsGetJrbpOoZx9lXsK8ehbjFuAfBH6AwFD90x25ZfmO+T5DelOIRXV1E1+Va
         E97u52v0Sz57qgc5955Jmn6sTd9pADkfOxaG602HS3d3hXeAOaW339s+gFghmAcW+ZS4
         ngAI1SHID5kRD5lo/O1f/dxcl/ZJbkMATwWHAL9L7Q+WI3zgSZbqaikJIOETilJ07Fo6
         o6z5TTVt/cY9+M5l7P9+z64szKl4ua1PRCZvrTGqq91p/xvQhLzDiAramnQtYXWAWDkR
         o/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+45i+PAel8g97yGYKXJ1GTAEEB3IncfPP6gF5KHVs8=;
        b=dXHMxYiYaF/d1+MM6BWw14sojlhW3XFr3bacGnrPQdTYVUDh/zU7SAEgWQEHmLnUUu
         4fEenx5ChkYWwUOwBfGWw00m71Gnp2uF4M10TB+e+DOsn4lxs0sQpeUVig7brQZjIoEP
         L8d41kc0f2fLjBWVHrQTxU4FbnNuaokyrAjlTwMjuuA3hnqbcw4oScGCsMiXX8MXXpb3
         OGNLv731x0zFWh6EDPcbDmTfV99F0vtdC1Fp1IA+hwwDRng34uKueW17wtz4MXMEROgK
         L/auopyV3hmlgU7Ae0iwpzxPajL6+IQ29hSaCLc5t04dmWDURGKnWVWkF0fUJtizmjtk
         oFrQ==
X-Gm-Message-State: AHPjjUhpgidwACvrj0qUTftveMSJi6/aDFy83louq+R1McJ3cqVQWN7V
        pn7HztYFh8Z+Q2f9
X-Google-Smtp-Source: ADKCNb6ZN8KuRz3I5gc5/Kaf18D0fts4ANWbyKALNaa26B1uv/Dd9nkZ0/Sv4lg6EmoVKt31SJtsWA==
X-Received: by 10.98.219.6 with SMTP id f6mr25828737pfg.59.1505508895000;
        Fri, 15 Sep 2017 13:54:55 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:48c5:a795:146c:44c6])
        by smtp.gmail.com with ESMTPSA id b66sm3179848pgc.29.2017.09.15.13.54.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 13:54:54 -0700 (PDT)
Date:   Fri, 15 Sep 2017 13:54:52 -0700
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
Message-ID: <20170915135452.4289d591@twelve2.svl.corp.google.com>
In-Reply-To: <CAP8UFD0-myJuhBQhZoBiQ6cE4FEkzzuro-sZeDfCN-HK_LxriQ@mail.gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
        <20170803091926.1755-26-chriscool@tuxfamily.org>
        <xmqq4ltowcrz.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD36yZEU4OM_+u6HkC=Ep1JifXm-ir0+CeJ3=dR44QceoQ@mail.gmail.com>
        <20170914111945.62741763@twelve2.svl.corp.google.com>
        <CAP8UFD0-myJuhBQhZoBiQ6cE4FEkzzuro-sZeDfCN-HK_LxriQ@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Sep 2017 13:24:50 +0200
Christian Couder <christian.couder@gmail.com> wrote:

> > There are still some nuances. For example, if an external ODB provides
> > both a tree and a blob that the tree references, do we fetch the tree in
> > order to call "have" on all its blobs, or do we trust the ODB that if it
> > has the tree, it has all the other objects? In my design, I do the
> > latter, but in the general case where we have multiple ODBs, we might
> > have to do the former. (And if we do the former, it seems to me that the
> > connectivity check must be performed "online" - that is, with the ODBs
> > being able to provide "get".)
> 
> Yeah, I agree that the problem is more complex if there can be trees
> or all kind of objects in the external odb.
> But as I explain in the following email to Junio, I don't think
> storing other kind of objects is one of the most interesting use case:
> 
> https://public-inbox.org/git/CAP8UFD3=nuTRF24CLSoK4HSGm3nxGh8SbZVpMCg7cNcHj2zkBA@mail.gmail.com/

If we start with only blobs in the ODB, that makes sense (the ODB will
need to supply a fast enough "list" or "have", but, as you wrote before,
a mechanism like fetching an additional ref that contains all the
necessary information whenever we fetch refs would be enough). I agree
that it would work with existing use cases (including yours).

> > (Also, my work extends all the way to fetch/clone [1], but admittedly I
> > have been taking it a step at a time and recently have only been
> > discussing how the local repo should handle the missing object
> > situation.)
> >
> > [1] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/
> 
> Yeah, I think your work is interesting and could perhaps be useful for
> external odbs as there could be situations that would be handled
> better using your work or something similar.

Thanks.
