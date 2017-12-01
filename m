Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBDA920C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbdLADkO (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:40:14 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:42983 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751846AbdLADkN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:40:13 -0500
Received: by mail-qk0-f175.google.com with SMTP id a71so11627028qkc.9
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UZ8CPBxB8q0ex/sx7TaWTKJ3wseBREFCsc4oZL59xuk=;
        b=eA0iPF2KRvMR5869CnTu2xsuPkVU05LUGwv1CK0tyipAQaSb2EcyPo+34/zRmBwJJH
         E5vfK2+8Z1HPe3Y7MXofQ/000LQ4o2DPqBGANSRPt1/fYdKmVELNa53o91QQ2kXMFDfw
         o6NG5u8+TFFJnUvmWTWnf0fZCmTCATrn/81PhhlDQyKf21UwFPzEmcDMlklf49PgS5v1
         pNogbS4dYDJxYdm9ac8mYvACK42XC7wK0Vug0f3k0bQJydSTzNkJuJscg4DkavaT/Mrj
         SvpmU2yRK6sSJjDSJdB6Z6UXybZ0YqOY2F7zS3Khmbg2yJA4d3gaXtmy5LssMR+2JwtT
         P8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UZ8CPBxB8q0ex/sx7TaWTKJ3wseBREFCsc4oZL59xuk=;
        b=baIQf+LlWoRJTYdCAcJqiOi6L8DRL0F1lbUuYNCPs7kqF47Z4mZ6p8o14I46EKb6Hb
         6UfEQJyprdCUHQLguLXM4LITEKDzyTcEwmJK0kgQ0aTn46RebxaZ4gnKK8oq7O4Hp5Hj
         pbU2F4GOEGe/9Bz0WHT7+0VlAzTuu6faphsaUV1Yjc0ous61CPWK3gc+wTCpq3PnglDZ
         JCIG/gaJbHXyVHXTvYSHiVP1BRAnxU0HqSh4YQBtjpYwX3aIdbACx54divPfxc+xNxZx
         ma8KAAyN4ccqXoD7s7wFSS6JmNNSuLdXQIGsgiG5lIkwJI8E8SXWRPKiJn5JqH9q1lJG
         GYkw==
X-Gm-Message-State: AKGB3mKB0B4xoeXUJQTrtHcXTUWN8YKGaM705Uwan9VnH5GtRguiU87x
        6d/437+QGx07E59EbLSzNtguNVve
X-Google-Smtp-Source: AGs4zMb5N+ynXgMfRFcI7+p9HDZmm2jSA702cM4LYmc5+4wZxEei+KOH9WSc2RrtSCXT4sWyXxUixA==
X-Received: by 10.55.168.76 with SMTP id r73mr5866184qke.202.1512099612848;
        Thu, 30 Nov 2017 19:40:12 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id d205sm3933492qke.21.2017.11.30.19.40.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 30 Nov 2017 19:40:11 -0800 (PST)
Date:   Thu, 30 Nov 2017 22:40:07 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] t/lib-git-svn.sh: improve svnserve tests with
 parallel make test
Message-ID: <20171201034006.GB3693@zaya.teonanacatl.net>
References: <20171201023239.26153-1-tmz@pobox.com>
 <20171201025600.GA29213@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171201025600.GA29213@starla>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Eric Wong wrote:
> I'm fine with this for now.  Since svnserve (and git-daemon)
> both support inetd behavior, I think we can eventually have a
> test helper which binds random ports and pretends to be an
> inetd, letting the test run without any special setup.
>
> It would let multiple test instances run in parallel, even.

Indeed, that would be a nice general improvement. :)

Thanks,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Suppose I were a member of Congress, and suppose I were an idiot. But,
I repeat myself.
    -- Mark Twain

