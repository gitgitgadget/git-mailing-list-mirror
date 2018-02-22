Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD141F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeBVSx5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:53:57 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:42106 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBVSx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:53:56 -0500
Received: by mail-pl0-f43.google.com with SMTP id 31so3380196ple.9
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xjdPd08xRYp+areqQSGJvI/2hNOIJI6jMYrjiYQEboQ=;
        b=ZROgCNwDGvRCzCwsR5Q8wG6VDbcQou/f8tKfIa7P/g8mHeyZDd57tadLMfp7yeTOMI
         degntvoF3b7n7McmAsdJwzcLJ0B6pxdse27eFgn1AYQiTwbtwtj2fWGIb6zl8Mr2eEDJ
         Vc/42Gz1+hqQv/UA0fx0AbgzAs5qxgG5Xw/DfXlF2jZijbV7KEhAUkZ5jgGSyCG8lXc4
         OSmZPtdCimw1Lx2bLmDWHbj64+ReaKu0BOla521zmBuc5F4JSGyT76DG4Ot3LJ7c3WXv
         49VU5ep0TndK90s77kDDCGdHro9fUXdsZANKYTgVS9o8DJ30LBmvd3iLAPLpUi3BCUQ5
         bUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xjdPd08xRYp+areqQSGJvI/2hNOIJI6jMYrjiYQEboQ=;
        b=Wt2j0EQIWaF/+YOOrO5Uf3hh2yz9omY0jNgKoWVK0MKUSv3B24Ag1imXxwsRXyiBUu
         F0AlEu+FYD4uiGx4EjMfxxdOoZ2aVscP4npfZp0NvOazia6/YvZNmcI7vgq5L9NZkyOP
         bwVT2L3IwE0yPYDq9iru2JQek7ekYXoILg2DmR6U680/rsGglkKj4yyEiJPSzysYnpM5
         InFv6gDU1F5nib7jxiB+WZ0QKSdeL+qkV53BkWUyLHIt4DrRrOpK9RQvVDMq8OIWO7Wc
         u/3pktMp9joEi2Twe7RQ7mhk5Jsn0sQR7DoRxARAfsOcw323liOLtNj6QML6/Fnd2fZz
         qBmg==
X-Gm-Message-State: APf1xPDHl3u5zyt0YWXPpwWVc8gCjAzu001we/cU2/XLnNY8rjfBD1HZ
        nXRnMXz9JVjgItWtyxziTnRe55rfxyg=
X-Google-Smtp-Source: AH8x225+db7+lDvA4pfBmj7hfZWQ8Ly1lk2u/GwyKxTofUqC71TZ44LkxNTriIIrxMcJMZdqYHuA0Q==
X-Received: by 2002:a17:902:7787:: with SMTP id o7-v6mr7396271pll.395.1519325635884;
        Thu, 22 Feb 2018 10:53:55 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 189sm1136549pfu.129.2018.02.22.10.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:53:54 -0800 (PST)
Date:   Thu, 22 Feb 2018 10:53:53 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 28/35] transport-helper: introduce stateless-connect
Message-ID: <20180222185353.GH185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-29-bmwill@google.com>
 <20180221160116.1619fcc4ffa7e9c13a5ab9ba@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221160116.1619fcc4ffa7e9c13a5ab9ba@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:13:05 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > Introduce the transport-helper capability 'stateless-connect'.  This
> > capability indicates that the transport-helper can be requested to run
> > the 'stateless-connect' command which should attempt to make a
> > stateless connection with a remote end.  Once established, the
> > connection can be used by the git client to communicate with
> > the remote end natively in a stateless-rpc manner as supported by
> > protocol v2.  This means that the client must send everything the server
> > needs in a single request as the client must not assume any
> > state-storing on the part of the server or transport.
> 
> Maybe it's worth mentioning that support in the actual remote helpers
> will be added in a subsequent patch.

I can mention that.

> 
> > If a stateless connection cannot be established then the remote-helper
> > will respond in the same manner as the 'connect' command indicating that
> > the client should fallback to using the dumb remote-helper commands.
> 
> This makes sense, but there doesn't seem to be any code in this patch
> that implements this.
> 
> > @@ -612,6 +615,11 @@ static int process_connect_service(struct transport *transport,
> >  	if (data->connect) {
> >  		strbuf_addf(&cmdbuf, "connect %s\n", name);
> >  		ret = run_connect(transport, &cmdbuf);
> > +	} else if (data->stateless_connect) {
> > +		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
> > +		ret = run_connect(transport, &cmdbuf);
> > +		if (ret)
> > +			transport->stateless_rpc = 1;
> 
> Why is process_connect_service() falling back to stateless_connect if
> connect doesn't work? I don't think this fallback would work, as a
> client that needs "connect" might need its full capabilities.

Right now there isn't really a notion of "needing" connect since if
connect fails then you need to fallback to doing the dumb thing.  Also
note that there isn't all fallback from connect to stateless-connect
here.  If the remote helper advertises connect, only connect will be
tried even if stateless-connect is advertised.  So this only really
works in the case where stateless-connect is advertised and connect
isn't, as is with our http remote-helper.

-- 
Brandon Williams
