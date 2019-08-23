Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41C851F461
	for <e@80x24.org>; Fri, 23 Aug 2019 08:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391062AbfHWIew (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 04:34:52 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44481 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388643AbfHWIew (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 04:34:52 -0400
Received: by mail-wr1-f43.google.com with SMTP id p17so7825698wrf.11
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mz3AOKHWmcAlc6aUiBKAjg7VxdzqhGyTqWPg756ZUzo=;
        b=TUXLDd03dsKDefaBp5jCzzk4GHEW4B0QGvD5j8sF8nTbTzWcjalzFvjX8jNXbt3gwl
         2wDLK0Kf+mIS537luRJBXcubyL7kWIi6gpilHot8EkZeeAOa8djlT/zh3AuUIMppVQO5
         gvxYRz0YJ0XybR8ClLR2gZ0YSNBb0iCzyIQAi/6C3B/G4o3POhMb9h/Md/Lr8d08YWPW
         pkQpJsDrcKSxMoikpFrnte4WnXAfYzeUDUXxLFFgewmaIw/InVjtGIvXAle+QTHxC2DT
         l1jx+LblELpIxYiEehzw1eYvA1aqXsHt3PGKMPr8ot9wBH2xtFLVnzS6jLdMvddzsokQ
         1rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mz3AOKHWmcAlc6aUiBKAjg7VxdzqhGyTqWPg756ZUzo=;
        b=GEoPInobgzyOqlDhSaJ1MZwjICe/jGBlnY0BumozRtt7YqlqHBGcFQz7S8srYZsE4M
         MU52QNkrfCJEAEovAu0XwtDGlsls5P+TRxf1LnHGwKXTFu96UaJeY63YPrBdXZ9N1ZBP
         tp7jNYf4fZSCZ5u+CY50cQV2Y5r7XzCtF52rBySNc3ErgVtdhYXe4pqetXRr/yMonYyT
         LGnNEb+v8b8PEZKgd9ZJJe0RXHlKtSjxRUi1ku4VprCC5v89GUzlkMNrea6dz9aCBVPd
         hAX1AWwWB0BkNmd0emGqIPzvD2rgXpNwoGz5W9FkJTmGTXzcSMygceuIGCf7YJhutEuD
         G3vw==
X-Gm-Message-State: APjAAAWF25B8NIrAFtt5m+1DaMoqD77kThAYjr1qqcWEpK+sXjPRyYks
        97nygSdUEQLtxElm/uPE4zw=
X-Google-Smtp-Source: APXvYqxu4oEAmzEvb99hHVwG7bPjOQyagpVbJABQcFjd+7UTbbFXMPTqlAsOwhEvvehpaAzaPxnYqA==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr3907735wro.190.1566549290087;
        Fri, 23 Aug 2019 01:34:50 -0700 (PDT)
Received: from szeder.dev (x4db558a2.dyn.telefonica.de. [77.181.88.162])
        by smtp.gmail.com with ESMTPSA id u130sm2861425wmg.28.2019.08.23.01.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 01:34:49 -0700 (PDT)
Date:   Fri, 23 Aug 2019 10:34:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        johannes.schindelin@gmx.de, larsxschneider@gmail.com,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t0021: make sure clean filter runs
Message-ID: <20190823083447.GH20404@szeder.dev>
References: <20190820065625.128130-1-t.gummerer@gmail.com>
 <20190822192240.GA4077@cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190822192240.GA4077@cat>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 08:22:40PM +0100, Thomas Gummerer wrote:
> v2 adds the comment as suggested by Szeder.

> +		# Make sure that the file appears dirty, so checkout below has to
> +		# run the configured filter.

Yeah, but that comment only really applied when setting both
timestamps.  With a simple 'touch' it's more like

  # Make sure that the file appears dirty or is at least racily clean,
  # so ...

So the next reader will know that right away, that the author didn't
overlook racyness issue.

> +		touch test.r &&
>  		filter_git checkout --quiet --no-progress empty-branch &&
>  		cat >expected.log <<-EOF &&
>  			START
> -- 
> 2.23.0.rc2.194.ge5444969c9
> 
