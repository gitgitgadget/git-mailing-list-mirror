Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FADC1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 18:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbeKQEnb (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 23:43:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42538 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeKQEnb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 23:43:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so15438504edp.9
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 10:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNQSQbdMVcwJjWuuIbbWcqq8Ts+Le5Tu3NG97M6GxUc=;
        b=KfwmVObhoQ34J1EdMWyrsd3BKtv7yjSqIn0p7Ayaw1G5wUFK2KsX6vxbgcg6y9HMS1
         bsO1Tm3fOl7sMmeO2cqGrACbdRTD7ItasHnvPU0NDveh5rCQ1iXGI+ko17wkS6mh6gUk
         jbzNX5gzxmXQXDPU6O/E1a7+yN+aprfaNWuw8Xz1kfa64j2z4uKNTiHWXdX653yRp6nd
         TQEEDmd9iAdKiREE56hcUqXLO0IRFNW+XoJVkf7UXTt9tECrUomHpNNjSZG/WLKGAw0A
         qpJ/O4FNQ3iMQQNq258uwkJjy8ZVyT7s6ou5k33V1CIFItx7Js13MVB0138cu+YWIoPR
         dp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNQSQbdMVcwJjWuuIbbWcqq8Ts+Le5Tu3NG97M6GxUc=;
        b=Ycii5TsPmKo+vf3/oj7oOvcL97h+Adir4xxioIIL5g64p/BrhqacHO25emGkmKEGCg
         vSHNccDxrKT2sO88SazMPEY1bGE7SBTmSmH27TE4rcVUvu7Ugreqh9dO6RarHQo89+bK
         Isp3DQ7lYx7xM+DYD261T/IUjG5NJcNodBzWxM6HbptDRnOXmqVOSDYszlBGZTfhgjIU
         qvzpFRALfo06HsAhVWAlk6nV10nBG5HiLCqPsKpFDNZ2tVtymvjO5nPQiadwcPcJ5jwC
         +XDc4bVmwhGgXrSvDZp+lOPZNaIh6I6hwy4QewU9spiINcCw4Da4pg7YkGbm2kRpehn+
         sQYw==
X-Gm-Message-State: AGRZ1gI9Zyj54yfnHY/GMlYuhJosNCOoG1DPsQTRryF9+VwhND8VLQYi
        rjitdRZu4A8J0BX4F3KyWqGDXLXwZwyg6q7Q0F8swYDRoRCAhg==
X-Google-Smtp-Source: AJdET5dU52oQYkLauau4TYkdE2NS3kFPJfv7ZjZr+GzuLlyQtQnRrYX3IjRBodug1TKsR+3HlSOgCEn9y11N5ZNsvSc=
X-Received: by 2002:aa7:df07:: with SMTP id c7mr10298640edy.85.1542393000611;
 Fri, 16 Nov 2018 10:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net> <20181116110356.12311-3-phillip.wood@talktalk.net>
In-Reply-To: <20181116110356.12311-3-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 16 Nov 2018 10:29:48 -0800
Message-ID: <CAGZ79kad66BzrWotXKQULG9qX11Yf1zx6_2YU9H4wF8VOhvHDA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] diff: use whitespace consistently
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 3:04 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Most of the documentation uses 'whitespace' rather than 'white space'
> or 'white spaces' convert to latter two to the former for consistency.

Makes sense; this doesn't touch docs, but also code.
$ git grep "white space" yields some other places
as well (Documentation/git-cat-file.txt and lots in t/)
But I guess we keep it to this feature for now instead
of a tree wide cleanup.

Stefan
