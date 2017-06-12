Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837AA1F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 18:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbdFLSIu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 14:08:50 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36095 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdFLSIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 14:08:49 -0400
Received: by mail-pg0-f44.google.com with SMTP id a70so48187651pge.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A22pAnDUWX7OCSPPiLPwY1TOvqlEMn4M2EhGhBzAm9I=;
        b=CJ4mlLF/5g9az2plz3b7dC99DxxJWRtAL9JZSnHVgBq3j5rqLLR4p2tqfKFo0KWx1Y
         0uL4saiqi3GrTITVv+u3Xe6ESX5SU1MMR46HfDgliI1XR0klH1pJknm5MgzjUOa9Txnn
         w90r1Xodor73E5dO7gp1eqt9uaT+uDA4/pjDu9LZmot1vdU3Owhi3WaG9xREnC8H8A7w
         /rQgaFsTWFsy1XE7FUkdxJnoN8Zz2i1OWIdek2q2qRfbnsRLui7nmFqeRGijp2ke5VJS
         mcEiXHziFVxCZDrFSm2yAVRnD3aa9ekmkAUfb9DKlDICMmNg6T4arhWfk2rcf7yuEx4/
         FSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A22pAnDUWX7OCSPPiLPwY1TOvqlEMn4M2EhGhBzAm9I=;
        b=AIoKkJAk4wbcZLYAKiFUf3/IZUnGq0hmu9BDlTMHirpxnJuFnUNzwaYJ503Ilg+IjZ
         w6XEj1QznURrUXrnUGXlDdr4Kvi1Nvtz+Pni0IeJkLzaBJmRITi/cq7urP4BQXodJfn9
         skwJ3SnysMS2Qsmy/ewAmM5Uw2fRoxwKqe1m+5Ld5srg0hTUPan4Bbb9FxEKzU1BKNUd
         fHCw8WzdwHglE26FcJ4dLgh7+/QLvpRJVRy5fyrgKHo2+8K5I89dDaNb2kmhVpuriTsM
         RJL2mtfnEFs4nYC38zojHWhrlaL+4zo0+WmKotUTERMkcCk1WCdmIlW/bEefxoOodL2F
         43ug==
X-Gm-Message-State: AODbwcA56NDmG+ouJrnNwEtIN5jVD4Jn6aVnKXa2iXznxH64BHX+6CF7
        3qXvqsE77ZtISxkhhK0=
X-Received: by 10.98.198.130 with SMTP id x2mr57208316pfk.232.1497290928970;
        Mon, 12 Jun 2017 11:08:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id h67sm19932867pfj.55.2017.06.12.11.08.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 11:08:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug? fetching from empty unnamed remote repos
References: <b3d0d39fe9d443fd8202b8b055d31f86@exmbdft7.ad.twosigma.com>
Date:   Mon, 12 Jun 2017 11:08:47 -0700
In-Reply-To: <b3d0d39fe9d443fd8202b8b055d31f86@exmbdft7.ad.twosigma.com>
        (David Turner's message of "Mon, 12 Jun 2017 17:50:05 +0000")
Message-ID: <xmqqink1nknk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <David.Turner@twosigma.com> writes:

> $ git init empty-1
> $ git init empty-2 
> $ cd empty-1
> $ git fetch ../empty-2
> fatal: Couldn't find remote ref HEAD
> fatal: The remote end hung up unexpectedly

The current repository does not know anything about empty-2
repository.  It does not have [remote "name"] section that points at
../empty-2 and it does not have a refspec to fetch.

Hence "git fetch ../empty-2" tries to fetch HEAD from that
repository by default.  It does not exist, and it fails.

> But:
> $ git init empty-1
> $ git init empty-2 
> $ cd empty-1
> $ git remote add other ../empty-2

You told to your current repository to have [remote "other"]
section, that points at ../empty-2 and fetch with refs/heads/*:refs/remotes/other/*
as the refspec.

> $ git fetch other

Hence "git fetch other" tries to fetch refs/heads/* into refs/remotes/other/*;
not having any matching source is not a crime---it is a simple noop.

> # this works

So there is nothing surprising about all of the above as far as I
can see.

