Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694F7211B3
	for <e@80x24.org>; Sat,  8 Dec 2018 06:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeLHGYg (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 01:24:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60315 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeLHGYg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 01:24:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD86B26FA5;
        Sat,  8 Dec 2018 01:24:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b7LvbdmksamINK19AwFZoT7dYVA=; b=X1gZMC
        5B38jJNjFbOoV2WVX85+twOq2/QMR6hWhZYqrfsS9V/ZmxV6yJN3uyHU7sYfNT0e
        3bg8hZr2tMA2P6px16RTa+B+AHASFnWaBdvj+JXLdVHrtodGSEXtBKlmiXXN0goI
        gqFs6Rwae7LDd+V79jET2jfPSWmUaoMWT90NA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=birNFR19TMwAUV8rDEsbgk92jfKXmRAY
        +8O1tMmjvYXwHadZkhNy/xRAarSwRbZG6I6lVQGUpWj9MdBC9ZKsZEPhRdHQrg0T
        VjBWlQDY6IU7dYY+Z5M/UoLql5fontsa1E+YtVneX5ClRw5rmn+tyEYJvrdeHTbT
        L08djbpUqjk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D488A26FA4;
        Sat,  8 Dec 2018 01:24:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ECD9826FA3;
        Sat,  8 Dec 2018 01:24:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Subject: Re: [RFC PATCH 2/3] Documentation/git-rev-list: s/<commit>/<object>/
References: <cover.1539298957.git.matvore@google.com>
        <a1ddae16bae563dd904555661e2e916536f388d8.1539298957.git.matvore@google.com>
        <xmqq4ldo861m.fsf@gitster-ct.c.googlers.com>
        <CAMfpvh+CDc_jToDmZaAypqwXvrhJMO-_4sUWRcjXwwz6OHhAHA@mail.gmail.com>
        <xmqqo9bmyb56.fsf@gitster-ct.c.googlers.com>
        <CAMfpvh+6r65OqWpY-geOYHizs526A1004vakKSdxnO=fsahdAg@mail.gmail.com>
Date:   Sat, 08 Dec 2018 15:24:28 +0900
In-Reply-To: <CAMfpvh+6r65OqWpY-geOYHizs526A1004vakKSdxnO=fsahdAg@mail.gmail.com>
        (Matthew DeVore's message of "Fri, 7 Dec 2018 14:55:25 -0800")
Message-ID: <xmqq1s6s8rj7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBF81718-FAB1-11E8-8516-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> $ git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids
>
> Where observed.oids contains all the blobs that were missing. It tells
> the remote that it already has the "refs/heads/master" commit, which
> means it is excluded. Before, this worked fine, since it didn't mean
> the blobs were excluded, only the commit itself.

So 'master' has some blob in its tree, which is missing from the
repository, in this test?  Which means that such a repository is
"corrupt" and does not pass connectivity check by fsck.

I am of two minds.  If we claim that we have everything that is
needed to complete the commit sitting at the tip of 'master', I
think it is correct for the other side not to send a blob that is in
'master' (or its ancestors), so your "fix" may (at least
technically) be more correct than the status quo.  On the other
hand, if possession of commit 'master' does not defeat an explicit
request for a blob in it, that would actually be a good thing---it
would be a very straight-forward way to recover from such form of
repository corruption.

Fetching isolated objects without walking is also something that
would help backfill a lazily created clone, and I even vaguely
recall an effort to allow objects explicitly requested to be always
fetched regardless of the connectivity, if I am not mistaken (JTan?)

Anyway, thanks for a thoughtful response.
