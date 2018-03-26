Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568EB1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeCZVAn (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:00:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38624 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbeCZVAm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:00:42 -0400
Received: by mail-pl0-f68.google.com with SMTP id m22-v6so12725163pls.5
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7doUIsYBYGgFtr/mUhU0Y9u2cpaK+Lv3ysQCMAay3P4=;
        b=bysINN/DnbcfbLXrCcw6ADamgwUS+vvgKE/YYHmDMc/bTbxyKf7L5R8CSy/h+ZKRjo
         E1eRXeKPmWs1vuEmGeSkfb23SN0NDEvNWRjfed6B95m2AXHAa/D1hfzJHfwZ6nhCYADZ
         rous0pvX9BSNP4jkmeGLR3v1z8ugQIDC3HTphObZhN9aUpcBheuRqExqPlj+EItPzWNY
         WYv4EBdbWjRua2OUDjdFzeAMFQ5Xeen/pSJfATvlqFdX6FRelNXKEkJ6z6z8nd25n7/E
         Yr7FLUHuPuXI4TEH3LjrmW18RpvFxFZNue9fs5lQvUPkoklyj1GNztjLcVzgdgwxOwaI
         PhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7doUIsYBYGgFtr/mUhU0Y9u2cpaK+Lv3ysQCMAay3P4=;
        b=uSyFsZOJYK/7zJt/Rp5mCD79ht2j6xU+KGUtVX/GzXbYEkBpt2IAmmSTA5FgLxUz7I
         Iox46XMpfL7s2kkPn6L35h3o9gO3s4Wa0uPdsYEY8NdDAb9y+4DflRHPYoLjcK0MnEd4
         e7igYIPoEO/DNMoj4IhE5WWJn3YDorSp+6OH/mNGdvy2nMM1N4SaSdyDm8cQSlJletBf
         CGuku7pTC31vkZBaI98a2t/PWYcU8EArfYkpkYNAqi4v1RndSRd2XVkOaobJD1W5NBeM
         7Wg6yLgYGplXTHBCvZFjjHkp8XNw3OOVdT60+p2upATqhjpnxeB6JuLcNYww1gwtVENt
         /pzA==
X-Gm-Message-State: AElRT7HePHkxHfOFhVDKROepwDH2dIdG5WqQFL+z6ImYikGVBUqQSE5B
        Sp2BHvR8hVT7fVdu+loKHZs=
X-Google-Smtp-Source: AG47ELudYD7AVTFSK2aLvRZEZMtdX7vk7Vzj3gH8RqCzRuiYKLiOcrR6nvdGUHnBERMAm+yfOIBrTg==
X-Received: by 2002:a17:902:5957:: with SMTP id e23-v6mr41235937plj.323.1522098042042;
        Mon, 26 Mar 2018 14:00:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v12sm26432351pgs.21.2018.03.26.14.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 14:00:41 -0700 (PDT)
Date:   Mon, 26 Mar 2018 14:00:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        jonathantanmy@google.com, bmwill@google.com, stolee@gmail.com,
        sbeller@google.com, peff@peff.net, johannes.schindelin@gmx.de,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Including object type and size in object id (Re: Git Merge
 contributor summit notes)
Message-ID: <20180326210039.GB21735@aiede.svl.corp.google.com>
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
 <874ll3yd75.fsf@evledraar.gmail.com>
 <0c3bb65f-d418-b39e-34c7-c2f3efec7e50@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c3bb65f-d418-b39e-34c7-c2f3efec7e50@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(administrivia: please omit parts of the text you are replying to that
 are not relevant to the reply.  This makes it easier to see what you're
 replying to, especially in mail readers that don't hide quoted text by
 the default)
Hi Jeff,

Jeff Hostetler wrote:
[long quote snipped]

> While we are converting to a new hash function, it would be nice
> if we could add a couple of fields to the end of the OID:  the object
> type and the raw uncompressed object size.
>
> If would be nice if we could extend the OID to include 6 bytes of data
> (4 or 8 bits for the type and the rest for the raw object size), and
> just say that an OID is a {hash,type,size} tuple.
>
> There are lots of places where we open an object to see what type it is
> or how big it is.  This requires uncompressing/undeltafying the object
> (or at least decoding enough to get the header).  In the case of missing
> objects (partial clone or a gvfs-like projection) it requires either
> dynamically fetching the object or asking an object-size-server for the
> data.
>
> All of these cases could be eliminated if the type/size were available
> in the OID.

This implies a limit on the object size (e.g. 5 bytes in your
example).  What happens when someone wants to encode an object larger
than that limit?

This also decreases the number of bits available for the hash, but
that shouldn't be a big issue.

Aside from those two, I don't see any downsides.  It would mean that
tree objects contain information about the sizes of blobs contained
there, which helps with virtual file systems.  It's also possible to
do that without putting the size in the object id, but maybe having it
in the object id is simpler.

Will think more about this.

Thanks for the idea,
Jonathan
