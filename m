Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61FC31F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 17:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfAPRnY (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 12:43:24 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:36284 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfAPRnX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 12:43:23 -0500
Received: by mail-io1-f73.google.com with SMTP id t13so5389851ioi.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 09:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ooGHQ/1Xphcm9ndMAl+MlW3TXIQJ/iJq8rrjaAIguvo=;
        b=cmuT6wq8dAg90dqk4mav2OUaytf+MCiT5Hc+YdroQ5uqIPVTv8Mtzag7YdsGvwnBW7
         qQsGAabpWfoWVX1LWKXeGMYiNmEJJrgezPMhMCrKdOk/sOmeknY2bqgsCPPysENud033
         AQO1xqrd6fSb/sV+/f2PIuw8XxnZEQg+U/lak7w4G/K3qy9BL1kduxHi3EnzIS8Uy4Yf
         eDiWZDU9zmyYb1ZhS1oym7hKQB+Jxj4ETgshpPgNW/aOW/hTIShLZVMqiQ+71FBwn8a0
         mhLOwmmJrQboWsvKtPqpZ8RVxJKWmqG/QndJ48joVuEFABpZCOsNXvz8+4a7r+hVOD8p
         vBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ooGHQ/1Xphcm9ndMAl+MlW3TXIQJ/iJq8rrjaAIguvo=;
        b=KBNHwnZkCoKth6vJHR6bEYoVFEHZNUUVpD7V0CznC+cZZ2uSMwGuyS4ALETCLq6eRE
         bgDXKKsU46oyOqAnz+PqtSwGmT3PvodBB/UrWZrVRWIPM66ZwMSez3hlAINP+C02/CXX
         6KGtNK08uc27jvme2FUSTP1LWQ7z6zWBokOmQ9if3Pza3lAaO4rrQpfNRSYrJzIg1llM
         0N1SNt3qwQ+eD993EAkJ3/wmbGomc9V+ilwpTguXEkOYQ2qsQrqcW6iRJaOVnmu03HLt
         b40gVb45+xgormZu+ZB00bfzdRfnoMcakIzZdwrqR6WRJDdTNSB2BDUeINHzZMQl8pqr
         +7MA==
X-Gm-Message-State: AJcUukdetdWP0txlLDRYGobebqCPBweVY4hsma3lQ/taa7yARgir3rNr
        q7+UF8VYCSwwP+D0SJF4ShgZDR0zcKLfcZf1qNLs
X-Google-Smtp-Source: ALg8bN5e91lQhOMCSEqnKTJE97nbXwf9eATe1BHZqR8b57Gk3yJXKnvlXWtiVZh7pTmhKPB+Rxrf/7LHQADIU7mHtGKb
X-Received: by 2002:a24:7381:: with SMTP id y123mr5814276itb.32.1547660603073;
 Wed, 16 Jan 2019 09:43:23 -0800 (PST)
Date:   Wed, 16 Jan 2019 09:43:19 -0800
In-Reply-To: <20190116103438.GG840@szeder.dev>
Message-Id: <20190116174319.251432-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190116103438.GG840@szeder.dev>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 2/4] sideband: reverse its dependency on pkt-line
From:   Jonathan Tan <jonathantanmy@google.com>
To:     szeder.dev@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Jan 15, 2019 at 11:40:28AM -0800, Jonathan Tan wrote:
> > A subsequent patch will teach struct packet_reader a new field that, if
> > set, instructs it to interpret read data as multiplexed. This will
> > create a dependency from pkt-line to sideband.
> > 
> > To avoid a circular dependency, split recv_sideband() into 2 parts: the
> > reading loop (left in recv_sideband()) and the processing of the
> > contents (in demultiplex_sideband()), and move the former into pkt-line.
> > This reverses the direction of dependency: sideband no longer depends on
> > pkt-line, and pkt-line now depends on sideband.
> 
> In the last couple of days I noticed occasional but frequent failures
> in the test 'leading space' in 't5409-colorize-remote-messas.sh' on
> 'pu' and on this topic.  Bisect suggests that this patch is the
> culprit, but of course bisecting an occasional test failure can't be
> completely trusted.
> 
> The trace output of the failing test looks like this:

Thanks for checking. Junio noticed a similar thing and I have replied to
it here:

https://public-inbox.org/git/20190116003828.64889-1-jonathantanmy@google.com/

I'll try to ensure that this issue is fixed in the subsequent version.
