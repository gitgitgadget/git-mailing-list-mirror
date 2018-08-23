Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252921F954
	for <e@80x24.org>; Thu, 23 Aug 2018 08:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeHWL4A (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 07:56:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39122 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeHWLz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 07:55:59 -0400
Received: by mail-pl0-f65.google.com with SMTP id w14-v6so2080417plp.6
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyvcZWNal8NQycfJYBAWL894Tu52iPgYQOQGLLNp4yg=;
        b=s0m9S0amxjUOx0KH5A1mO6uswy3s19vwJ7QoT/BBzR2LAQeM4MLiZxVmoyp0kJU1d9
         yI5lheiHnkfLGRe5zn6iFXb1I8HbMKFUOFOUPUQ0kvd3MByxLn6x7k6wnetHnLtSdu/E
         Bvhn0ArQ9USPNSS1eH0yMUlWe2fuoisnIkVEqW/a3OnB8qQL6sLCahDSJKt3Ywms+fXu
         oHoiKzfFeraD0c360KosfeLwZTQKrWlgE7yT4mwoToshEtTCG8E8bMvDtC799CCREQau
         ZFU4eWl8pLEJjvERZOAnQajmXBWtcAgmeAmnlas9G1NbYrFushykj9usZ+eIaDRMCPTO
         cBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyvcZWNal8NQycfJYBAWL894Tu52iPgYQOQGLLNp4yg=;
        b=CmmjH4Gc7kyZx0peJadxONH5oSJAbxin8EwrPDGj9KRdLkDV7Jq28u1uC60LZ8uXz9
         0l1GH1RpbI6Uhi+bMKm1DgFIDJmoJABkOfCWFHRqzekGciFDF7SQ9JOn6M8peA7b5sZp
         titrrtwo0nB0IOcL4meAENNl/uncMtG7GwgaNDVeSw86mKJMuZco4GdDQ+SFH0KULvsq
         o+RZ1VqklyoVEAHJ74R0N4QF2V+hh6IEDQxtHUwlcZA31UhxCNp4JkoOfCjbksNH54Mx
         w/EeYH9Iv11VRJilapcbBtQOuSdzVbZdV3Ykn3/w44/kt5n7wyDhWOePvAh+b8j83rGG
         Sgcw==
X-Gm-Message-State: AOUpUlH04U6cHkO3FavqmbDXlnRKBrBnEENruFUoBFfUR62ARFwJNs2M
        2yBJ4Mgc2cnZfOOr7U6GFPI=
X-Google-Smtp-Source: AA+uWPyyO9Ccha3+nldM8xsAvw7OmHjyrYEGn4oQ4aEJXuNpQS2wWjtUDXQueauyeYfkRc36dlmm0g==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3-v6mr56898982plr.242.1535012847863;
        Thu, 23 Aug 2018 01:27:27 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l70-v6sm29991pge.36.2018.08.23.01.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 01:27:26 -0700 (PDT)
Date:   Thu, 23 Aug 2018 01:27:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
Message-ID: <20180823082725.GB160081@aiede.svl.corp.google.com>
References: <20180823023955.12980-1-kyle@kyleam.com>
 <20180823024719.GG92374@aiede.svl.corp.google.com>
 <87wosh7pjj.fsf@kyleam.com>
 <20180823032238.GI92374@aiede.svl.corp.google.com>
 <87d0u9ybhk.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0u9ybhk.fsf@kyleam.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I think what you mean is something like "color only based on the
>> diff-between-diffs".
>
> Yeah, I that sounds OK to me.

Thanks.  Want to prepare a patch along those lines to finish this off?

I'm off to sleep now, can look at this again tomorrow morning.

Thanks,
Jonathan
