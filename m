Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77EDB1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 02:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfJZCUo (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 22:20:44 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:43648 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfJZCUn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 22:20:43 -0400
Received: by mail-pf1-f182.google.com with SMTP id 3so2881834pfb.10
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 19:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oiuTbhGCmIgyfVGtsZZidjkuJNucUhUo7kS+WxGGdRs=;
        b=GZY32QuR5PnS9iaVhTvGj61looxnxT8wiWRDrr9HPfNOPHLj0z2ZQX+CdUeLQvDL+z
         IUYgEunkHrv1tlhNp0V1bv2edsDdYefSrqY8LMA2BF2IqsX4HxsBxE+hWeCefYcbjE7q
         LL6BWdexotU6ydQA7nusy0QCsh5SaaDeHaaFzRr/+qbbSlI3JfPJTVQwoNznWj4gMf6h
         qsTCVGd+VZb/Rx32T/HGHhlXF4tCzkePjNPx+b4Kx32RzyLFOGf7qtntMgLRrEzHuWsP
         twjm0DxA+8PFUjB0sxTDOghxY+KUPaWg8938J7L3H/oyJQNMSgH1I+uUQeGM6bZ1eh96
         IG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oiuTbhGCmIgyfVGtsZZidjkuJNucUhUo7kS+WxGGdRs=;
        b=WFnJSdY3qgnvlrjs8VKcdfechJWYl8bfGN5D39k/YRIbwKpiG6cI4yuHrLIp3Dn3LS
         4dpPBQ47Ia/hHQ68NHiU1a+6S/EAOvkvFmbR0nTmo3rYNCC9BEZdY2DaRK+0140qOjKs
         DFuHajqY5kDa6gZKtGEkaIoPMesTbIf8ad48v8hPiM5rphli9tsBcO6Zr0FvaNe7jwou
         9ni9B9TXcS/hI+5AwLo7guWUTm2q0Gk61WMQn3rdMaUw7x6FhWWN1FpiDTf04Non41qY
         w++mToOgIY3OUYPuHlIuwOmZpTuSycL6msROgTbQJ7dytUAZ3Jh/krbLrEQzRMk3Vtu2
         UE/g==
X-Gm-Message-State: APjAAAUBwyrQjzQR+ZOEFs8fffPm7YNHKODZ8w/fDI4jtbvDm4Z1jfTm
        WDViS4sfM/VmzWKYoO4fv08=
X-Google-Smtp-Source: APXvYqxxWbOJQ36b4WTsmkiAuCPjYappOh4KYtHtYCMo61CMRUg/aukAA6XLWK2PG/4cenvb/0RZOg==
X-Received: by 2002:a17:90a:7781:: with SMTP id v1mr8293754pjk.56.1572056442532;
        Fri, 25 Oct 2019 19:20:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id q6sm5837505pgn.44.2019.10.25.19.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 19:20:41 -0700 (PDT)
Date:   Fri, 25 Oct 2019 19:20:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Luke Dashjr <luke@dashjr.org>
Cc:     git@vger.kernel.org
Subject: Re: GIT_COMMITTER_* and reflog
Message-ID: <20191026022039.GE39574@google.com>
References: <201910252149.23787.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910252149.23787.luke@dashjr.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

Luke Dashjr wrote:

> It appears the reflog currently allows its log data (name and date) to be
> overridden by the GIT_COMMITTER_* environment variables. At least for my
> workflow, this kinda breaks the reflog (as I regularly set GIT_COMMITTER_DATE
> to produce deterministic commit objects).

Can you say more about this?  What is the workflow this is part of?  Can
you describe a sequence of steps and how you are affected during those
steps?

> Is there a need to support this override for the reflog?

Yes.

> Is there any reason it can't be changed to use GIT_REFLOG_* instead?

Would a new GIT_REFLOG_* set of envvars that overrides GIT_COMMITTER_*
work for you?  If I understand correctly, you could set
GIT_REFLOG_NAME and GIT_REFLOG_EMAIL to an appropriate identity, but
you wouldn't have a good value to put in GIT_REFLOG_DATE.

If GIT_COMMITTER_{NAME,EMAIL} were used when writing reflogs but
GIT_COMMITTER_DATE weren't, would that help with your workflow?

Thanks and hope that helps,
Jonathan
