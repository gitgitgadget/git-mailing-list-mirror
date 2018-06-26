Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3645D1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeFZVkd (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:40:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44901 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeFZVkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:40:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id p12-v6so17015025wrn.11
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BXDBSpArHSGVRrv1zPJY0iDPO9rtGgbDRWQ6iX4/vY0=;
        b=R6KPCLkg4ITWO7Q/lV9KYBVJY/a7E/Z+vH2TkIKAq/htOkiiXYh4CypEyCsIY8XO9h
         DeDnFXOzr0PnJmK/a83u34rlLBrhkcR0QcYp9VjjJJbrHjoE3Pp4eG1Jb91ICNE481n5
         jddNZ5idcqLBai55m47QlZcSciQp0nWgn0kcjyNe4EP77Wk7phWIDd8GBt7NKJ82M7M9
         v3wY/y7LNgCTn+nK7yOejoMyKTGI27+O+NB5eSihguIEg4Nv0ilO8/5McR8VnkDI2SzZ
         ef74tc54rxsltQAtEwfca2aD7NxTS/lqD2FX85IdwirsyAfuj6hMxeByjJOOPXXjciBQ
         Oxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BXDBSpArHSGVRrv1zPJY0iDPO9rtGgbDRWQ6iX4/vY0=;
        b=koHIcP4X269cVrkwHGB4j14RECBVMtpd65s5mHeP7Y56Zlil6T08yyiOZubmsKPKCH
         9SzClx8+4Geu2G5EZyiYiiz7QPxrNEykU/CKeFOF08Xwfzt6dftzBiVh3y0/BzV+e65I
         p2VN6TA7nXTuQdcNEQCfb3ECnL+zcMlWA9aCSWhq7Lj2lehefieWr9ZGjHnKrKxMiYcr
         PJpwU94WbRcZKI560GKWaQzdC+STPZyYoClWotIPPSqJE6xd5WaM6ovavzaQ7XnpUGyq
         VDKoCkpSwfPEGbltuLP/xCa+8prB7p2rFWjCiSvmSKgw63lSIJlDL6aqGHXjbsNLnp6N
         Xqrw==
X-Gm-Message-State: APt69E3b9ZB8UOpqWTzKU1HlT6CMdUlEVwIYmeWN9B3Pdgy+QNyitFDm
        JbpHQPcK7A3d5VZnU/a90CQ=
X-Google-Smtp-Source: AAOMgpfZgVt9LoWSRNLgT/hEfynStEPwEOB0ZZYqnQEYKo5gHy8Bu/1U3DfclMSPWEC4131LhUBNyw==
X-Received: by 2002:adf:90e9:: with SMTP id i96-v6mr2894159wri.93.1530049231067;
        Tue, 26 Jun 2018 14:40:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j131-v6sm3549549wmb.25.2018.06.26.14.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 14:40:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 6/8] fetch: refactor to make function args narrower
References: <20180625185332.164142-1-bmwill@google.com>
        <20180626205438.110764-1-bmwill@google.com>
        <20180626205438.110764-7-bmwill@google.com>
Date:   Tue, 26 Jun 2018 14:40:29 -0700
In-Reply-To: <20180626205438.110764-7-bmwill@google.com> (Brandon Williams's
        message of "Tue, 26 Jun 2018 13:54:36 -0700")
Message-ID: <xmqqk1qli5v6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Refactor find_non_local_tags and get_ref_map to only take the
> information they need instead of the entire transport struct. Besides
> improving code clarity, this also improves their flexibility, allowing
> for a different set of refs to be used instead of relying on the ones
> stored in the transport struct.

Makes sense.  One can argue that the original has less risk of set
of refs used for calls to this function vs calls for others go out
of sync, but the objective of this series is to allow them to be
different ;-)

I am not sure if I understand/agree with the split of parameters
done to get_ref_map() at this step, but hopefully its benefit would
become obvious once I read later steps.

