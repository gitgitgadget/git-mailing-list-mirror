Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74102095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbdCRTcv (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:32:51 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34803 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdCRTcu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:32:50 -0400
Received: by mail-lf0-f41.google.com with SMTP id z15so43641478lfd.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 12:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=i/qik5Oz1w89HfgmwUQD6tiUfesaSR811iXCyI9K8qA=;
        b=j2DNOeXgwMHIzy8AJNSrO1gyG0q3DrlQuIVcdEm6APHHKMcRyNhgXa3TCheKjkfpPV
         xatUSEnuuWfLdm7ccyTngI3lZwrgYJsNbctBmyle8M3PfDGXa+fgvNn92GbIo988hPb4
         fcXuaRbVhCHcvOsXYBrJzXGreuC/mQyx32bzShUDG0MNg2/C0BCmYG5969ya4M0ykjO2
         AiNhhdC0mtZkW5JYlcxBrqKb7gFHHh2IkD1xUTXKX3lGmJqOYo9IJHP7OXkOw67tgZIx
         J6VvnVfofWFPVBj+Y6bbYvNU+ZXcVnB7DvT2TkwWkZSRbW1X7mAqp6BUPbTG2d4OTrdz
         S5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=i/qik5Oz1w89HfgmwUQD6tiUfesaSR811iXCyI9K8qA=;
        b=Thyy+qeR2geqtToVzelyny7SvoIwLBdmyymYLoffcYMLUzFqTHzRd+pDW19fVKYUtt
         sDhpY/mjJea0OMXkLnM2MIJVpx8oCHmZ11z6bdJVGKhB4s3kwv+QmTZAMhHkCZs6BIDY
         K//+QFZRKMYlrOoi9sgk2Vw85ikGVsEuEaPTh6s6WRTbnrj2bXXsFWBTIByiPy4UUYc/
         JVYm4cKJn9U+duFqmNow5TwqNJ0ZXua56VZIKlahUdbxvpCr+urcGdTu/W4cjLpBRBQE
         vunYKSK/8eGt8fKOOQci+oWocZBDwpS2vQ5cx3jchbbV0izmxU3Fy4GTXMV8wHdomjlY
         Mqgw==
X-Gm-Message-State: AFeK/H2zoS99SuvOW6TvVNZ10PRRaNeJKA6W6pke2mrlNbB6fx2sLZ28jZt0IHo4PoK/cQ==
X-Received: by 10.46.9.129 with SMTP id 123mr7212691ljj.61.1489865568409;
        Sat, 18 Mar 2017 12:32:48 -0700 (PDT)
Received: from [192.168.1.26] (dbf73.neoplus.adsl.tpnet.pl. [83.23.31.73])
        by smtp.googlemail.com with ESMTPSA id u26sm1206171ljd.34.2017.03.18.12.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 12:32:47 -0700 (PDT)
Subject: Re: Shared repositories no longer securable against privilege
 escalation
To:     Joe Rayhawk <jrayhawk@freedesktop.org>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
References: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
 <195b30d7-9ea2-7a9b-79ca-41b7bb890a30@alum.mit.edu>
 <148977072642.2144.7040206366650087348@richardiv.omgwallhack.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <726ef4cf-db9e-991b-5df5-168c7e9a41f6@gmail.com>
Date:   Sat, 18 Mar 2017 20:32:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <148977072642.2144.7040206366650087348@richardiv.omgwallhack.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 17.03.2017 o 18:12, Joe Rayhawk pisze:
> Quoting Michael Haggerty (2017-03-17 05:07:36)

>>
>> Thanks for the report. This is indeed a problem for people who want to
>> set restrictive privileges on $GIT_DIR. I'd never thought of that use
>> case, but it makes sense. Is this practice recommended somewhere or
>> required by any Git hosting tools? (I'm curious how prevalent it is.)
> 
> I had to work out the practice for my own management engine; I have
> since deployed it to around eight different mixed-use multi-user
> operations, the most significant of which is Freedesktop.org.
> 
> Without this practice, core.sharedRepository is an enormous liability
> of a feature. I can't speak to whether anyone but me ever noticed, what
> with mixed-use multi-user POSIX environments becoming increasingly rare.

Is there a reason why you rely on file permissions and user groups
to enforce access control, instead of using public-key based solution
such as Gitolite?

-- 
Jakub Narębski

