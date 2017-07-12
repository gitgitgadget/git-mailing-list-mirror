Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719DF2035A
	for <e@80x24.org>; Wed, 12 Jul 2017 02:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756610AbdGLChR (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 22:37:17 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33306 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756607AbdGLChR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 22:37:17 -0400
Received: by mail-pf0-f175.google.com with SMTP id e7so5335648pfk.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 19:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=voxFyOshn3FuWSMELJpLxbp1KKYU51wcWLf+uM/xi9c=;
        b=PcICyU26kDTefCq4QqblLBkdl2DCajdGIIbFd60wi1FaHCjCshBK55MT1tjwVbt21w
         VLUbpu/AgIY+WGv6rRtHAfhH07TPO2VzWzDmitA8ZNgHNYWRSbEzm3XjDDq3uFhqKfJr
         ghShwCQFRtbOamZoA2M/LsXlm6CpnCks5ax9xWokqL2GIp1rCaNn0Ji35jFdlp8nDb2w
         LhO+WIcFSq/MH1Wv+RIkrPuUzAhp1oq38p6PyHfmLFZarbXlDkGEaSQeroZLj1X9VTA7
         /IoTgTgniNFVldkuE5F71mnJ/oUEWl4Mr1AnhNMf5JGwvF6AAY1gLoLUWOZGAyu4cA7G
         L8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=voxFyOshn3FuWSMELJpLxbp1KKYU51wcWLf+uM/xi9c=;
        b=VWYhO6xEQeZ/2/SQiA6NXdkn0mZ10PlGZJp3FnWLR/qxxcg9z1OC6uKQBMkgN1AAmS
         TeufsWolNIosTjGAhtIa58E9WftMAB3iPCEf6XO7UZw+dPr9sq5kLI+ntqEkJ0NOsPFs
         YEViAW1t+WRl7ZFEHTrrTIe+N+QoazrHWQ6mKMTXXwcGNss3mtC0RGHA3a3S+7uNkWiK
         q3gkF/ZyN4PEo4lwwzaRPn8izEAuYS6sYzt7V9F8MaLdNuwbkS2LLbjcrfT4n9MAGdB7
         7/dDwIYB/yw2uqXrLAK0z+a9auI0hKNApiRrrZ8Hkv16lZ4JtNPI9OSoaCgdZdmzu6ar
         uVkg==
X-Gm-Message-State: AIVw112w0cGilmMF7aXEaQDohUC2LgePKF3cRLaqW84N+YtgyfgDHFML
        9xu6BFN7WQtEzw==
X-Received: by 10.99.143.21 with SMTP id n21mr1529258pgd.145.1499827036245;
        Tue, 11 Jul 2017 19:37:16 -0700 (PDT)
Received: from lenny.localdomain ([136.24.158.154])
        by smtp.gmail.com with ESMTPSA id 79sm1061245pgg.46.2017.07.11.19.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jul 2017 19:37:15 -0700 (PDT)
Date:   Tue, 11 Jul 2017 19:37:10 -0700
From:   Kenneth Hsu <kennethhsu@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: bug: HEAD vs. head on case-insensitive filesystems
Message-ID: <20170712023655.GA15598@lenny.localdomain>
References: <20170711033236.GA11492@lenny.localdomain>
 <20170711071234.bj3kzfn5xii4e33w@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711071234.bj3kzfn5xii4e33w@sigill.intra.peff.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I was going to point you to the recent thread in
> 
>   http://public-inbox.org/git/87ziclb2pa.fsf@gmail.com/
> 
> but I see you already participated there. So if your mail here is
> "here's a summary of how HEAD/head don't quite work", then OK, that
> might be handy. But I think the ultimate resolution is not "let's make
> them work", but "let's consistently enforce case-sensitivity in ref
> names, regardless of the underlying filesystem".

Thanks, that makes sense.  Perhaps it's best to just view my original
message as, "here's a new example of where 'head' doesn't work".
