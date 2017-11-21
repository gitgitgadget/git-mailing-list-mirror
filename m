Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2922036D
	for <e@80x24.org>; Tue, 21 Nov 2017 18:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdKUSiy (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 13:38:54 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:37243 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdKUSix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 13:38:53 -0500
Received: by mail-it0-f46.google.com with SMTP id m191so3212684itg.2
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 10:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ThN9LdK+vEufVy9xHkQ7X2XMLmrl+BIPrR7zt5BspeM=;
        b=lFr6cu5oYb7ftqlfMjzqo3GwUD4XMxAp3C/3bPYpWKnx13xTMET5lcrYTOjw4AwmTG
         ai5mWzgWFogBE+EG5cdrVE8dH+T+qnN2qqJBq1DcbraahAiCet7nwG2G1Qhv/yEFvQhb
         mD1wLzI6+0XY024+YXbSdmixswLuz4H93UgG2FEGV2FzP0246HW6DeCSiLDBRdVuSPcR
         Y7Rap9up9WTHPIzJn2iXwP8+H5iZlgu6qW8cUBtAzTcZ0tHWuBNQ1TEHAvTDgFiCkYOM
         HWSjeQCFlrktOh00pgy/35YCEu4Yr+kUeuDFFJnn/We53y5kL1QOExWRAvKDaA3trO/4
         PIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ThN9LdK+vEufVy9xHkQ7X2XMLmrl+BIPrR7zt5BspeM=;
        b=Yp5jVkbb9s9q+0CMBU7fD7bZhRJ6kD7J14ssXN3AIbGIPhJPjnJ+0j6ZlQua3wMaC1
         MI+1dq1dx3KR9qHkpDSsWAlPlUetuUJ0JAhRFQc7cSOj5ex16DeY4bL2YpsmNe2Z8ISE
         ST4JddVSzpJH0yh9pWdffWmWlVMI0hcxWxQcnWurh/jO9bQZJ43aLhb6OqRLQ5/Ydy/Z
         ISHFnHe5MRIkSiWmwWavyPrrJDDG8jYpRvuy6kGNJYl3Yu0WPkXgRinXUEqKQNwpoEfR
         9uOCU3j6dWJQU14p2BHuzmIBMBheNGhe4rLtFBbIptv8RSNfVnHPqV5hZBbGb2ChpaCO
         jtnQ==
X-Gm-Message-State: AJaThX6sB8kDEkiyuJD1QQfzsNwqPwL/vZwZGHB0SNsERawBgzTzKsGr
        PTQKluNqScH2ca5pf4SsIG1q8su/
X-Google-Smtp-Source: AGs4zMYyPYYwVumsRQyxpnuFCucM+3U+zpCXAVs6tMAM/hKX7MLmCRAB/5o8ARS/ESloWm+kDiPhfw==
X-Received: by 10.36.254.71 with SMTP id w68mr3217831ith.24.1511289532679;
        Tue, 21 Nov 2017 10:38:52 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f193sm927452ita.27.2017.11.21.10.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 10:38:52 -0800 (PST)
Date:   Tue, 21 Nov 2017 10:38:50 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] notes: fix erroneous "git notes prune [-n | -v]" message
Message-ID: <20171121183850.GB3429@aiede.mtv.corp.google.com>
References: <alpine.LFD.2.21.1711211156110.10397@DESKTOP-1GPMCEJ>
 <20171121175846.GB27041@aiede.mtv.corp.google.com>
 <alpine.LFD.2.21.1711211328070.4528@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711211328070.4528@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert P. J. Day wrote:

> so it should simply be corrected to:
>
>   git notes prune [-n] [-v]
>
> sound about right?

Sounds good to me.

Thanks for finding these confusing docs, by the way.

Jonathan
