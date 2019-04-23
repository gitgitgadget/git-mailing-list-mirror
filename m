Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5981F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 22:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfDWWMD (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 18:12:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39351 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWWMC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 18:12:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id e92so6399356plb.6
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OPcoh6hA/sIVc6MrudONPUxuGjDaec2622NOZ/z10Mo=;
        b=MyrI7X7v2VN49YHyXhAgjTHJgwgbkt7qYfQ96N0X5hq3zajKV+xzlHZb23G6Bw/Wwl
         vCFKHbFXekYXW3Y/6OjCWBRmYRyWn5UTUTRGH5djoweZa/W5vZ5XebLwhFqs3cTANc9H
         sZubmovyZNzHXRiyQTvZCO6JE6sIJHZJzmMwwfbhVegf3tTW5xV/8/gWgSCztuB+RhEz
         sLcA62BMTZ+Hv1Lm1TrXKaNUZxi499gXqXg1EnFAtvYkf8EOQCp8cMgp7RzjcNsM4jc6
         NAwnOH+tW8n+qfIOgcWvwq7olAJP9WntPJRrSXISoxCg8kmVLB/5Hyf0AoH5SRnHw0PC
         UkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OPcoh6hA/sIVc6MrudONPUxuGjDaec2622NOZ/z10Mo=;
        b=MZdVRtGoZ+Lr+nlXqYoSFyiLh263kzFnUn2eKRWVIZv7dROTc5KXK3jUQ6Nld9hpE0
         UVI1UpavZZWFBsEfD1jBJbdysuRBj4zuW0gxZb6T4HXL1nV3Q+pekuGaN4UI+Rg1vw2P
         agoh0I4QhmioS+HumaDd/bUPEF/mYMxSaZFg1d51KpjIYYNaDGQ/oguyvPyOXUtaHZCY
         pNt4JAQ2TJPdrND2XW2+Whn39jJScOHXSkE4VFKXMwZOk8qG6B8t+/GKKC4vkDH8okC0
         DOtXB8ic7l0SL4vNLg4TV5Kvwc3jyTNNcamOPXpts38Va6d3bUszJQMxP2HZiO3CB3dn
         57HQ==
X-Gm-Message-State: APjAAAV3cCSPJwCV3/sLjMSIhL4OYtNg+1GFmwvYxbF+5yj1TXoKvkCB
        CQ6J3pcNHQO6xJk+askgHx0=
X-Google-Smtp-Source: APXvYqyMWiM/Vn0PK/2y/KHPObBWznCxrXh2gp4vaiyyrlLwwCSkIzieIhHqOUld/+SBbrWuC+eiZg==
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8mr19321244plt.21.1556057521889;
        Tue, 23 Apr 2019 15:12:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id e4sm934967pfn.185.2019.04.23.15.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 15:12:00 -0700 (PDT)
Date:   Tue, 23 Apr 2019 15:11:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
Message-ID: <20190423221159.GA98980@google.com>
References: <cover.1550963965.git.jonathantanmy@google.com>
 <cover.1552073690.git.jonathantanmy@google.com>
 <5ce56844d3fb740e29d2f3d4be2ade0b2ad5f7fd.1552073690.git.jonathantanmy@google.com>
 <20190423053130.GA13162@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423053130.GA13162@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Fri, Mar 08, 2019 at 01:55:17PM -0800, Jonathan Tan wrote:

>> +If the 'packfile-uris' feature is advertised, the following argument
>> +can be included in the client's request as well as the potential
>> +addition of the 'packfile-uris' section in the server's response as
>> +explained below.
>> +
>> +    packfile-uris <comma-separated list of protocols>
>> +	Indicates to the server that the client is willing to receive
>> +	URIs of any of the given protocols in place of objects in the
>> +	sent packfile. Before performing the connectivity check, the
>> +	client should download from all given URIs. Currently, the
>> +	protocols supported are "http" and "https".
>
> This negotiation seems backwards to me, because it puts too much power
> in the hands of the server.

Thanks.  Forgive me if this was covered earlier in the conversation, but
why do we need more than one protocol at all here?  Can we restrict this
to only-https, all the time?

[...]
> The problem I see is that the client doesn't get to vet the list of
> URIs; it only gets to specify a protocol match. But there are many other
> reasons it might want to reject a URI: we don't like the protocol, the
> domain name is on a blacklist (or not on a whitelist), the domain name
> can't resolve, we can't make a TCP connection to the server, we can't
> successfully fetch the pack.

Christian mentioned this desire to vet URIs before, and I'll admit I
found it hard to imagine a use case.  Why can't it work like e.g.
<frame> on the web, where if you don't like that domain, then you
don't get to access the page?  From a server operator's point of view,
if you want to support a second URI that more clients support, why
wouldn't you just always use that second URI instead of making clients
choose?

Thanks and hope that helps,
Jonathan
