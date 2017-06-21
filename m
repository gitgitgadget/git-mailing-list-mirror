Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD1320401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbdFUSi5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:38:57 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35837 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdFUSi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:38:56 -0400
Received: by mail-pg0-f53.google.com with SMTP id 132so46915586pgb.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=46yGgbzuLXS69/YcgbQRcDkn5PUQvd0K3LxPtXuZZ00=;
        b=bWiyQFkc7rjY/ZKhqK3VDrzIO+ETxNnfv5ks6vOXaxoRJtj8PQWOfsU8XhKThulXcS
         E6oyw4McLIAp6jR6ZmM/rHI0TtQ+k7ADRTaLQNMl5vfJiYqVIIeuma94Jiwq2a0j9H3q
         VVMcACkNe1AjYybWb51WOMwqWYf/Yy5YiPVVftgZPR5x6LfbedlKwZhiqduJW8+jCcRU
         uMK3Hvl4KQHErXoB4P7oI5Aswykz5BRSjy9TDYNWCVNwfKEUxha6eUIJvUJ1Xm78kdgV
         4K8zmdA6rrET8Zfn3kNXwESCAbxaM04JXUJl4XIK1ciqd55Vq5yk1WmAm8VoshqRQHT+
         YiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=46yGgbzuLXS69/YcgbQRcDkn5PUQvd0K3LxPtXuZZ00=;
        b=AQJn6hJZQyowSV2K9vi1x4t09fJxCS+vSOiDzyZ1s0ZSwvDhPJL9ccIc8H0ebpvD7X
         pSOcYqD9gFQaUXz5gBsNqDT4+qckcHAM/lCa/N31OjKTQ//J9If6olCkpLIX33E8PqdA
         spVE0DHcgCFnl7/5RRB41K6rVeQ03h2EJriUO+hag4PxYHFH5hTO+OlguWzjSDzHfQ8S
         ZzKn8VvwMrDbTogHFmpTZDxxee2U6fLfxOlcWU3vMMYeTJ5MRz3FXV1LliT8R3dfSZur
         1ZvGz0iSoSshOppk5ZkCUp/OP5I9MLX52V5B2ho4ZnbRrMsDgIUpOKXYqjiRIputMU5O
         w0hg==
X-Gm-Message-State: AKS2vOwC5CUnMPObERUYv63lxTeMN8/0kM+oYxanE52vEvDR80IOoQPU
        pt4kYIp01rDWjQ==
X-Received: by 10.99.2.146 with SMTP id 140mr33560481pgc.56.1498070336114;
        Wed, 21 Jun 2017 11:38:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id g10sm33165707pgr.18.2017.06.21.11.38.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:38:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        David Turner <dturner@twosigma.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] docs: update 64-bit core.packedGitLimit default
References: <20170420204118.17856-1-dturner@twosigma.com>
        <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
        <20170621135130.6724hnoovcjfduto@sigill.intra.peff.net>
        <CAGZ79kZLcNdN0TsrHwm8YoAXx7tjWoWV29j=xyQFgUuNPouUOw@mail.gmail.com>
        <20170621180618.6yc433nwpi4d5wof@sigill.intra.peff.net>
Date:   Wed, 21 Jun 2017 11:38:54 -0700
In-Reply-To: <20170621180618.6yc433nwpi4d5wof@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 21 Jun 2017 14:06:18 -0400")
Message-ID: <xmqqvanpp4n5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So the other direction, instead of avoiding the memory limit in (4), is
> to stop closing "small" packs in (2). But I don't think that's a good
> idea. Even with the code after David's patch, you can still trigger the
> problem by running out of file descriptors. And if we stop closing
> small packs, that makes it even more likely for that to happen.

I recall that when we notice that we cannot access a loose one that
we earlier thought existed we fall back to rescan the packs?  Would
an approach similar to that can work to deal with the "closed small
pack goes away" scenario?
