Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036C41FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 19:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbdBITbw (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 14:31:52 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34004 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753524AbdBITbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 14:31:50 -0500
Received: by mail-pg0-f66.google.com with SMTP id v184so1054627pgv.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 11:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WYZprg+62njNI3e8B/9CxIxZho8COxFKVpNjLFLtOcE=;
        b=LJYR5QpAHHt8IE/guI3AmeOk3j9zkduz3WL293LO8eyPPjvW+fW3djEYoKjBsjImOl
         X3a+/8pi1KR7PJLeZWS+I/mYPe/M4l9WBldZQR+CjxKuQESvcbMnSBKpIFeyzJiI6IXX
         sSAyZi6G2Ogu/hX3ff3Z79FuuVVq3fVMQhlvxFKLIj/NHpy+rViz6t1bLSQNjVXKwGPm
         lUV9lsBQWLbMhaLm5IwvGMBBMgsfrLDOo82lsbuRoQKVmGFNvY1+XXdpAtLU6LFlM+Gy
         3WqcviULFznnrt5+uIt8AgiMjgh/9DdL323/TEQJ6CBXKOHMCvOIbkE/3ICPPm53nxCt
         /JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WYZprg+62njNI3e8B/9CxIxZho8COxFKVpNjLFLtOcE=;
        b=jIZROkIkxgsixSK1W4KprtWscabIfDaObsiUA5NNf5O0oaeLm2YRPaM46g9v0r0mfQ
         T0ibQdcL8noAk3wL0pfhFBxhUsg33eT1lGATSV5Lz1UpluLT+YRdonugHXkg3nOZus2h
         lDy8uds95WCqbaVyhQevQY6l5hCgqyWdLrBSh+Gz66W6BybrRYvYb+xAXR5Jz7I5JM5P
         HMQSGLmfFc5yfxHw2ZHAWkodqnITRkT9EPLvoDM+zkYuz6CspB/ln2aDv6r+L1zgdEkm
         hw85eNueLwr/SP/6EINh2iwo2GHGyjLB7HxYS1VxOHaFJ/bAp8pR3xuqODBsDMjAseGg
         lbdg==
X-Gm-Message-State: AMke39neWPVTjz7BNTiCQdAly18UITBV035iNjHuXvt8lkUSw/cKlIWB6veMJaxvhlj6Bw==
X-Received: by 10.98.71.7 with SMTP id u7mr5570981pfa.76.1486668707810;
        Thu, 09 Feb 2017 11:31:47 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id z77sm30960486pfk.47.2017.02.09.11.31.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 11:31:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v3 00/27] Revamp the attribute system; another round
References: <20170123203525.185058-1-bmwill@google.com>
        <20170128020207.179015-1-bmwill@google.com>
        <xmqqwpd8s8vd.fsf@gitster.mtv.corp.google.com>
        <20170209171804.GA61274@google.com>
Date:   Thu, 09 Feb 2017 11:31:46 -0800
In-Reply-To: <20170209171804.GA61274@google.com> (Brandon Williams's message
        of "Thu, 9 Feb 2017 09:18:04 -0800")
Message-ID: <xmqqtw83p3dp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> At least v3 gets the attribute system to a state where further
> improvements should be relatively easy to make.  And now as long as each
> thread has a unique attr_check structure, multiple callers can exist
> inside the attribute system at the same time.  There is still more work
> to be done on it though.  Still my biggest complaint is the "direction"
> aspect of the system.  I would love to also eliminate that as global
> state at some point though I'm not sure how at this point.

We are in agreement 100% ;-) The "direction" was the last thorn I
was fighting with (without successfully coming up with a usable
solution) when I stopped working on my original series before Stefan
took it over.
