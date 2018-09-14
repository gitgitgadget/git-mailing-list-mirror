Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B0A1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeINWb0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 18:31:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39136 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINWbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 18:31:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so11348746wrw.6
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X23IeeDkr4OR01cJS5fgVPsvQIbjXfOmAlSPhvZj+DQ=;
        b=Bg6TVSzi67Jlcqn/5E3EIX20Go317MdQpkqUnXrdyzg6m3D2NKUnPWt+q4bOJp+zrS
         zkq0gxujwr/CyLmBl0Tf2PkhiT3CEUiAYXFZMqGWjjuKscNNv64zxhWrGb8M4c3ArGSV
         5l4zU72VZveieiA1UqgPa0muKAjqETvb9CrWyXAQSMyhZuaAp/07C1q9C54IXgpo7iik
         ULTcQSRUBUppFrP4C8frZ4OCk0guSFCEVIn2FAb+HR0oySE/9FfrGuciSQKIXrOU2Qqq
         KZ+rz+2Um15iTxSmMMu6bpugPNg5QOzRQrqVsRMVszJyqJ8tbcGPcyvpCsQniKTIhavC
         8QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X23IeeDkr4OR01cJS5fgVPsvQIbjXfOmAlSPhvZj+DQ=;
        b=tFBB7wInHYzdZo0q5LUL/GVLtZSmGiomd54FrY7rqrsfG1wG4jJqCCQfoim1I2x+IC
         Q9+qsh6nrUhgkEk4f+PQkE/zLWnl0k9EieaJklRNKzvL55PIFbv7B5RVnszVWLMH7wEh
         Gbk2JzJOyOTaBsdWL0CYmx7QOZ8GpMNmfE7eUyFlczf9Ky0qbK8hpVbWwnt63tRz3qgV
         LSpopqOZEeEiMiwDXFrbScugOOWuXTYaezZ70POElkuxIszm00q0RT8xk8X9QwyArstB
         /Cq/hFY9IQ/AnDQhledh3XCaJaFoScx+V8AMOAMQdJ2DH4W63ybfxRXDIv/Oh905SbmC
         i5hg==
X-Gm-Message-State: APzg51BZZt6IOOafwwanRTw4shFeU9Im3O8e/y0RZifLtZfJOmjqBabE
        2uzdFPNBpeHT/C5LUNs/6GA=
X-Google-Smtp-Source: ANB0VdZQVhWyT23W/3HJoe3G4z5ncXUYgJSPae1Q/4ivAw+EUKxrdfeBLQAqSR+ZlLx41Nc+05/ffw==
X-Received: by 2002:a5d:4152:: with SMTP id c18-v6mr10648424wrq.61.1536945359296;
        Fri, 14 Sep 2018 10:15:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c19-v6sm9016849wre.86.2018.09.14.10.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 10:15:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "t.gummerer\@gmail.com" <t.gummerer@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1 2/4] fsmonitor: update GIT_TEST_FSMONITOR support
References: <20180914143708.63024-1-benpeart@microsoft.com>
        <20180914143708.63024-3-benpeart@microsoft.com>
Date:   Fri, 14 Sep 2018 10:15:57 -0700
In-Reply-To: <20180914143708.63024-3-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 14 Sep 2018 14:37:27 +0000")
Message-ID: <xmqq5zz8c84y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> diff --git a/config.c b/config.c
> index 3461993f0a..3555c63f28 100644
> --- a/config.c
> +++ b/config.c
> @@ -2278,7 +2278,7 @@ int git_config_get_max_percent_split_change(void)
>  int git_config_get_fsmonitor(void)
>  {
>  	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
> -		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");
> +		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");

Sorry for not noticing earlier, but unlike 4/4 that changed
getenv(VAR) to git_env_bool(VAR, 0) "while at it", this leaves it to
getenv(VAR), meaning "if it is set to any non-empty string, it is
true".  Is there a reason for this discrepancy?

I _think_ the renaming should be done without getting mixed with
other changes like the git_env_bool() done in 4/4.  The idea to use
git_env_bool() in stead of getenv() may be a good one, but then we
should consistently do so when appropriate, and that would make a
fine theme for another topic.

