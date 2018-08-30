Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07381F404
	for <e@80x24.org>; Thu, 30 Aug 2018 04:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeH3Iy1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 04:54:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33499 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbeH3Iy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 04:54:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3-v6so2117274pgv.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 21:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QrWXLm5EJhypIBnHCRb9y8ltQMoY0iOSNRoo8v62UoA=;
        b=ofK3vp+NiJl2xU8ieUq+bceI4qDUOZcai4Rv3mmnD4AXI5xABVE8SSlOgCRUGdhVIu
         Jj7QfiC1gVwOyUqssKAlyBM/8wi4j8Dl4I5YbTjk+AToF4utzc4fnB7QDB2KuxInxiHs
         2TzFWJFr2tec8lVLiGBVvRaBCo/ewYp7jfY9H+rePdiqHBoyWlq7AQJzlXEjmLgppFfu
         cKGO9oBlN+a2FmbdOEa7OMn+3aoNiNCIfcqyLEoQds/wFpJEsSuNgLn4YnKaC2cRrmkU
         ATxt8+ZJHr+Rd7TqkZ37+P+57CcgdOQ57UvlS6y//hkPtihAGGXwcrctdQM6z1xMaTlc
         /Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QrWXLm5EJhypIBnHCRb9y8ltQMoY0iOSNRoo8v62UoA=;
        b=EY6g6o+0UReN73h4wfFzDSg6RN/sjZDpfZsQlum6OLSRgEZdDrJckojbJwr+vsPtde
         ps2cBHrtOyFq1Fcl/D0ZxvDkt6DrI1a455/7upFZ7T391ixvpl3AVsBniOguk06kWk85
         Rjtr97sXfO+xE6Q/iG0bdS24I7HwqmqOaHBjXIuPFlhhgkDvCCc8HH8A/CcDLvlM/UqB
         JWjrwCdOYWkHTdN5RuepePVzFncCEs/j25Y7V9hOnDXh6HHeINDdpOVkm/CzMkUfCsGv
         UwO6oUoSCK8wl2zgFdcL7Y/f0iJtNdbndYQpiMRUJ7ZWu52FlPCRrJWzuZb7NzKbUhC1
         oPIA==
X-Gm-Message-State: APzg51CRnWPiA5eLvRAGdxRQFbsyUIxKJFNJy5Q7lgZ/YvCC0/+wkLKq
        BIexshVeRdUN2tlLWA+kx2t1GzqO
X-Google-Smtp-Source: ANB0VdbwnX0Ah7cAWkG9Q1zOauHome3lYMx5jGKBZplwAyiZl/fke3XJQr7N9STnE+jU0D/+9V2ueA==
X-Received: by 2002:a63:1250:: with SMTP id 16-v6mr8131207pgs.299.1535604849727;
        Wed, 29 Aug 2018 21:54:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a20-v6sm12939095pfc.14.2018.08.29.21.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 21:54:09 -0700 (PDT)
Date:   Wed, 29 Aug 2018 21:54:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: Automatic core.autocrlf?
Message-ID: <20180830045407.GB140348@aiede.svl.corp.google.com>
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert Dailey wrote:

> Is there an 'auto' setting for the 'core.autocrlf' config? Reason I
> ask is, I want that setting to be 'input' on linux but 'true' on
> Windows.

Others are exploring your question about the configuration language,
but I want to emphasize some other ramifications.

Why do we still have 'core.autocrlf'?  Do 'core.eol' and related
settings take care of that need, or is autocrlf still needed?  If
core.eol etc do not take care of this need, what should we do to get
them to?

Thanks, after having run into a few too many autocrlf-related messes,
Jonathan
