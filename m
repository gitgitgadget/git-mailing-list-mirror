Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34BA9211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 19:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbeLFTRm (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 14:17:42 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34389 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeLFTRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 14:17:42 -0500
Received: by mail-qt1-f170.google.com with SMTP id r14so1839634qtp.1
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 11:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LAzFgQPqsoPqoYtjb3RQ03bU36J1tHL8UAlyCl0ZJdM=;
        b=fsZ/eaVaS2Ef9aalqpG31rS810Wy4W4+AMWvEbl0v+/unESW0jxekU0XEd9nQ2ZH9A
         PZJT0SVgC8ZKqIhgOnOLc7IWEcg+nsMxlMXQl8LmjWTM9Fl1vpUivOqGTB6LXYUaHqTX
         WiveoVr3GTVEDlh1Yjmo8zAvSGsxJ7hO5WqvOiK4GIFZPyE/uM9Gq2kyb3HVpsNqlnP3
         87aXXu4XOBP1lK5hfemYn3KunStFRpn+FoGkrAgUCtGWHaUPbHTKBprhBNLBzHhrUit4
         3xOmgxtnfD7D3BSd2xWfOch2Smpf7qgnBhU1MerT2eQqbgi6eFNavNnVyffg7PIikxN8
         GDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LAzFgQPqsoPqoYtjb3RQ03bU36J1tHL8UAlyCl0ZJdM=;
        b=sZez2+X8y5TaSADfL0xF7g17F2egEQJgyljcH2sWtXMBof2uLSrH9bW1yoiMtJLel8
         aBjrN2ll2tQXZfHgqufcjqIAXy2Es7Xp01w/7nnWjFTU+Q96j3oBQ4c5uFSLv9hDHZZd
         ysysOjTtHMvJODzoCPcMHhcvR4R0oDREoYj88VjykyTKwUd5ZsGgRzpKZxbWuBTS+b0E
         IWutZivlWJctHLSb/yosNyWal2FOAo3tge9OLDOBR4QJM9obNWCcQfnzGOmnVT99hOU9
         IQM39UXt3XOxQvIZSGKnGiQzsr+vH73KwE6N2ceh0tUIjWvYc5RtWvaPk0w7l6ZiuU0a
         bFng==
X-Gm-Message-State: AA+aEWaHskCDc8VouvunmiszmxKWOgFMF0RAoSbg4AETRPO6qUCYegUB
        GWEDQ9Oo+k5A2HNoEjixc5A=
X-Google-Smtp-Source: AFSGD/X5TqLe6oU6BBKczf//vofKqO4JS6VGqpxdIU+eqDX/cEZQB1XmtgCVIuOyNnHwAmRRUf/BDw==
X-Received: by 2002:a0c:d0a8:: with SMTP id z37mr29318190qvg.86.1544123860184;
        Thu, 06 Dec 2018 11:17:40 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id m41sm1143358qtc.58.2018.12.06.11.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 11:17:39 -0800 (PST)
Received: (nullmailer pid 31292 invoked by uid 1000);
        Thu, 06 Dec 2018 19:17:37 -0000
Date:   Thu, 6 Dec 2018 13:17:37 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, chutzpah@gentoo.org,
        williamh@gentoo.org
Subject: Re: enhancement: support for author.email and author.name in "git
 config"
Message-ID: <20181206191737.GA31091@whubbs1.gaikai.biz>
References: <20181206181739.GB30045@whubbs1.gaikai.biz>
 <CAN0heSp2g0A82YYvMw-RaERESXFtj3TgPKA3RysC07Lf=tHBcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSp2g0A82YYvMw-RaERESXFtj3TgPKA3RysC07Lf=tHBcg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 06, 2018 at 07:38:08PM +0100, Martin Ågren wrote:
> Hi William,
> 
> [...]
> 
> This idea was floated a couple of months ago [1]. Junio seemed to find
> the request sensible and outlined a design. No patches materialized, as
> far as I know, but that could be because Eric suggested a tool called
> direnv. Maybe that would work for you.
 
 Yes, this design would solve the issue.

 I'll take a look at direnv, but it would be nice to have native git
 support for this. :-)

Thanks,

William

> [1] https://public-inbox.org/git/0f66ad7a-2289-2cce-6533-a27e19945187@rasmusvillemoes.dk/
> 
> Martin
