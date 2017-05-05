Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59D0207B3
	for <e@80x24.org>; Fri,  5 May 2017 16:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbdEEQIR (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 12:08:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35643 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdEEQIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 12:08:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so1295020pfd.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=obJRyNUQo3ma6FJTo2IxcAlVjuZn0CV/2Pc51XXKvDg=;
        b=LJB4hfGFC6TJYEh+JWMYx9ycUoR3E6tMITNbKYo0vS14R1AXFQCfL2yA1wAzU/U8WK
         AfGs1J9kIO+n6PHYABHmEbcyc6YHnbDd7jXSZuas3v7BspnYPESESzfb4+M8HMnVrTA0
         24TfhVV9CUVDlmOaHEcsoYG8U4TROKKt71ZvAINXybPNx6GNzRU2vA/fvnyubGpmkXSK
         XDsjhWv2r3JCEmEc0+6uh/Ql4s3FNzMKbjMJQgPiSYyW8gtHRSkdjyWplvRHHjQL4BDL
         cfxxtpxHq6mGEG1777ipV+rHx8FRPvWXUubb6m8jS7KExO1AxI87M+7Y/MNoaWcQK062
         ZwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=obJRyNUQo3ma6FJTo2IxcAlVjuZn0CV/2Pc51XXKvDg=;
        b=jfCq3NeSHXfFR1t4xOda9LUtCwtWEjDG8Tke+72qgSX3LcIjcH3GRC2bpPlAncT7GY
         5Y2u+VojrVBM4gWnwxNpS3p1RxtOl5gkpteatXwlz6J7ESBJDrl36oiC96dMjWDKhvx4
         z977LJWDXn6QwIeCcYVgLzznUCRDZWJcMHzsVixOP9fO311Vp7EkgmJxECyc8VuCoYAe
         5ZoezGpDtPux8mKPHCWQ+i/4KjFFjC9xig/HoJoJlxIVVMXSmPa8xXkfZCsXqklL4Fkv
         +IXqU0Dyv0C3RM8ALcG9l9dJPqoJmdO4ZapM5ggXit1CzPmiOschpy8UCpnN9zL8pTuy
         IN7g==
X-Gm-Message-State: AN3rC/5U9AWARDXNjJ1tC/CJYZRrNM3ZdgP0mAJSeBOHiotOM2ucEcO7
        19Orhuow4MmQ0g==
X-Received: by 10.98.198.4 with SMTP id m4mr18214146pfg.160.1494000495826;
        Fri, 05 May 2017 09:08:15 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:5d98:2d3c:6099:849])
        by smtp.gmail.com with ESMTPSA id 7sm6448939pff.36.2017.05.05.09.08.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 09:08:15 -0700 (PDT)
Date:   Fri, 5 May 2017 09:08:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v1 2/2] travis-ci: add job to run tests with
 GETTEXT_POISON
Message-ID: <20170505160813.GH28740@aiede.svl.corp.google.com>
References: <20170505154053.58128-1-larsxschneider@gmail.com>
 <20170505154053.58128-3-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505154053.58128-3-larsxschneider@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Lars Schneider wrote:

> Add a job to run Git tests with GETTEXT_POISON. In this job we don't run
> the git-p4, git-svn, and HTTPD tests to save resources/time (those tests
> are already executed in other jobs). Since we don't run these tests, we
> can also skip the "before_install" step (which would install the
> necessary dependencies) with an empty override.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  .travis.yml | 5 +++++
>  1 file changed, 5 insertions(+)

Yay!  I like this.

What I like most about GETTEXT_POISON is that it verifies that
translatable strings are not affecting other functionality of Git.
It's a valuable thing to test continuously.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
