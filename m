Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A2C1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 22:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeHXBni (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 21:43:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35267 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeHXBni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 21:43:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so3519080pfh.2
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ODCMr/bV3A81uTfimlIO1GWSpcwsxMdQ4s7yFZax/Mc=;
        b=twq2m06BNp47FsB0RozjxQt4MsR/XrcEyMUk296AQ5uZBf8aWUanQBTkKWhXQZh4U+
         J9bgZdVjO7t271jH+x6GPVVHpPNnMg9h6RaXVxYgUdzu8UYQ/F7WEj5ij8Xui2ao4UBP
         cvFXpht20IiBqJE7v1lsHyDu82jRnW0JTNiP9IabWb1BvnGvOIYuqIr64jVAERNnQ+O7
         01Jzvn7I8kXV6u8VU+6XZV2weQxj3x6ZTyyrBFaxiqiyNTjiohHHVdtDwNdag21bRHD3
         op0/Jj+L2rRei9wmdsfOApu9WHvG69aw57Quc3UrDMW6BvMseQhwLUuWlkGC5YlZFA68
         YGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ODCMr/bV3A81uTfimlIO1GWSpcwsxMdQ4s7yFZax/Mc=;
        b=QJvJ4mnHDTEMpI6k4iOeWFRYbBNGuKeuvI9YYy/rN81rpzasyvXc04tiKnea+exSI8
         CVCCL3RI6ISZjkgxDIOMYV8cDglwXxXS4nswGsqYgeKrpuUjsx1O3FXKjWrKWEKAiTT7
         LzH2ys2IKWOLXGbdeAWSxFqXMboXymMg/EnFm5xvnGXhgEZ1wJy7cZdOOANf4rT4zpiQ
         au37AIwibtbWFgbtL90c8luM+Jt385aiTFlaK32QidRsQfoCdOzL++0P321ESH+gQirI
         eLmNEkBLtbZjN8rheeN5r5SCt0yk53PWQTAeef4oFHQhGlut8K0y5bL03b90q7YNGjCo
         dwAQ==
X-Gm-Message-State: AOUpUlFz5fycVjdsLT/1/Iv2QdYnRmYnKWxl/RhiWHNCZ8hkttWH9eqj
        jYU1KpDtEGRNOig0YD8akTY=
X-Google-Smtp-Source: AA+uWPxKLTTygDUaEPdE6gKGY/8gfNegGcNDBtAy8LMVODPNfqAiuBb3T+JsxIJMVX3niNi0rhfJSA==
X-Received: by 2002:a62:6c04:: with SMTP id h4-v6mr30147608pfc.113.1535062314515;
        Thu, 23 Aug 2018 15:11:54 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u83-v6sm18693012pfj.37.2018.08.23.15.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 15:11:53 -0700 (PDT)
Date:   Thu, 23 Aug 2018 15:11:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3] range-diff: update stale summary of --no-dual-color
Message-ID: <20180823221152.GD99542@aiede.svl.corp.google.com>
References: <20180823211028.GA99542@aiede.svl.corp.google.com>
 <20180823215748.3474-1-kyle@kyleam.com>
 <20180823220207.GC99542@aiede.svl.corp.google.com>
 <xmqqo9dshh1j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9dshh1j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Kyle Meyer wrote:

>>> Subject: [PATCH v3] range-diff: update stale summary of --no-dual-color
[...]
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Sorry, too late.  I'll revert the merge of the previous round out of
> 'next' and requeue this one, but that will have to wait until the
> next integration cycle.

Thanks for the heads up.  Sounds like a fine plan.

Jonathan
