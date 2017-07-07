Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2A5202B1
	for <e@80x24.org>; Fri,  7 Jul 2017 16:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbdGGQlw (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 12:41:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33902 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdGGQlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 12:41:50 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so5255684pfe.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QvQlUCtw+cAmXMSGoDNuiRDbV++4Hjr5NlZudt5jN5o=;
        b=rKAzACRp2Ny+kiHq83pTmVmGT/vIFDSOw7evbC+z++HnZVMlIFNQ7qf/ijxkdHeFXh
         6iypTZx3L2z+rEGCDAolg1eZsmnLEFQ64aggKKnGY6vnKIU9zF6tJnxkB9EZnTKV0Qq4
         /jO2op1uvYoSWXXKTUWAuwQFjlfSmXG2Zfy5SZKAPkmzGzJFPJSWqPvNCvqebFCtYzSl
         /MVP7eMuoP31b3+xGKu2p7Pho5suXPBGd8ZjKYM4Jos+mAU2B47/C4TiWEXFUY/hfpMO
         fwFUq0cNZ01tBTtf+ejnhIS09LB+VUZb591C1wQeyFlZzIhxVOLXqVdNnTg+0mujdUC/
         xRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QvQlUCtw+cAmXMSGoDNuiRDbV++4Hjr5NlZudt5jN5o=;
        b=szk1+mqwFwBpvDq4rz/TQrYA7Nl42BvZ9xyPPSStbrMVgW9/XrhrbTlG2ifJg14ZoT
         Ko3ps3xxXYcBlLmIfBbW/dSa+4zl4nF7KIR1Ci6nGivNfzvAuhuoly21eBiK9LIQuvG7
         R4xayUvs4AewmqMbO8tCmWOBScikup/aJPxtmI5u1ll3FovRlU6dwSvakTzTSFk+otya
         VAimSuNZnBM+t/NNej0DNILbpquMdAYLGnsPFPj/12p1qDXv4HzKfsZQLQouSBmJFKlj
         im7OvG07KxiZ/J/7NXsKEL9+z9sLXW6GKfUv9l4FqhDM8FT9vFWWQ/ZwAfmtGxBQVBFM
         A7KA==
X-Gm-Message-State: AIVw112PJ4sJMjbgDhdVvbmLyMbe0l9v5DrcgV8WW24r45N32Fv2ALq1
        NPHB5pAXtG5aNjDOboc=
X-Received: by 10.84.198.3 with SMTP id o3mr4019917pld.84.1499445709655;
        Fri, 07 Jul 2017 09:41:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id x5sm6029176pgq.18.2017.07.07.09.41.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 09:41:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: Re: [PATCH] t5534: fix misleading grep invocation
References: <936f43ce2c993e545deaee5e196c018933375214.1499254650.git.johannes.schindelin@gmx.de>
        <xmqq1spukfyw.fsf@gitster.mtv.corp.google.com>
        <22feab0a-ca75-2aea-1ec9-2f71fe40c9d0@grubix.eu>
        <alpine.DEB.2.21.1.1707071259550.84669@virtualbox>
Date:   Fri, 07 Jul 2017 09:41:45 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707071259550.84669@virtualbox> (Johannes
        Schindelin's message of "Fri, 7 Jul 2017 13:13:06 +0200 (CEST)")
Message-ID: <xmqq8tk0ci7q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes, there are grep versions that behave differently... how did you guess?
>
> I am in the middle of an extended investigation trying to assess how
> feasible it would be to use a native Win32 port of BusyBox (started by
> long-time Git contributor Nguyễn Thái Ngọc Duy) in Git for Windows to
> execute the many, many remaining Unix shell scripts that are a core part
> of Git (including crucial functionality such as bisect, rebase, stash and
> submodule, for which we suffer portability and performance problems).

I've long thought that BusyBox was primarily about size and not
about performance, but I can imagine that it would be a big win to
be able to run things like "mkdir" and "rm" without fork/exec, as it
is likely to be extermely more expensive than preparing to call and
actually making system calls mkdir(2), unlink(2), etc.

Interesting.  I learned a new thing today, but apparently that
FEATURE_SH_NOFORK was not a very new development.  I do not think
anybody is crazy enough to attempt making Git a nofork applet,
though ;-)



