Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5CA201A7
	for <e@80x24.org>; Sat, 20 May 2017 23:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdETXVj (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 19:21:39 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35242 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdETXVi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 19:21:38 -0400
Received: by mail-pg0-f65.google.com with SMTP id i63so13517566pgd.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2xQLOkEQ9S8wBNqx0utv90MK1/xunYxtLbsQu269uWs=;
        b=erm1G8ezl1dFg5VvZAgf5jgFPbO7Y9oOIaHNATbTOW6AEb8FGLrZjAp5sOPpMshXU7
         mcX+iuiQb/NaCTFHINswXYX+6+WzbuRLLgGCdlRNsloSTRV5Ps4N9BTIzmCsL+YCpYPe
         /LHV3uEorPbGStceNqiX5RlXHjESUegrEoO9JZlNrCvvWClJH/am7NtWN6ZQPikp5+eI
         Zcc9m7FfXNAzx94j5sJV9iZnAfUC25Xpz+VkwX8BTHsCpXjY3CmHQwUpkWilWrXLNFmT
         ibDxr4BSHQf1o4OoO2CTFQu//JdOy6txEDZZV+rOlTavu6E703WQk4EYSivyMWVyHVk/
         1M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2xQLOkEQ9S8wBNqx0utv90MK1/xunYxtLbsQu269uWs=;
        b=IQIrtPtaA2D7j/yi8JT2e/TwFywMn6r8GiIQ6s2ey55mfbvJEvkrR4Xv6twRWJTgP4
         BZCtS385ZkGvJBpcnhqjC0yaDusF9xy4fuNZ+PuPPhBoj2WtAm0bfLEtvi0RtekzWoyY
         iTBYv6lhm4BDCHfFF0lgnE2wqfrRLOvqQymL9/yo//N/coqHdevhA9TWtzOlMnBK+gjW
         Yk5PhWNzAxrJC6FLGdctYSiC+00Ix4rL9prDSsNRwUd/tp3BGYyDYGTGDIWJmaVG3y/q
         AycCFfLq5hBhc2Wi94P8r/rS7lwJMoXMfUDh8WYidJF1Yo+fXsrcVE3+s6Bc07hiF/Zj
         9ULQ==
X-Gm-Message-State: AODbwcDri6jbw7e6RgB794+FON7ihq0CfmPMQ/u0OLkUTCaWVYnXvInp
        iZvrnHkww2iM/Q==
X-Received: by 10.98.224.136 with SMTP id d8mr18108674pfm.140.1495322497519;
        Sat, 20 May 2017 16:21:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4027:806a:d2b9:807c])
        by smtp.gmail.com with ESMTPSA id l7sm34541696pgn.10.2017.05.20.16.21.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 20 May 2017 16:21:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Eric Wong <e@80x24.org>, Michael J Gruber <git@grubix.eu>,
        git@vger.kernel.org
Subject: Re: [PATCH] name-rev: use larger timestamp for is_better_name
References: <20170520203649.GA13079@untitled>
        <fe9ca677-1f38-4b61-a610-9f8ab014daff@ramsayjones.plus.com>
Date:   Sun, 21 May 2017 08:21:35 +0900
In-Reply-To: <fe9ca677-1f38-4b61-a610-9f8ab014daff@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sat, 20 May 2017 22:16:10 +0100")
Message-ID: <xmqqh90fru68.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I test on 32-bit Linux from time to time, and tonight's 'pu'
> branch fails t4202.44, t6007.2,5-6,12-13,16, t6012.2-11,
> t6111.2-65. I bisected the t4202 failure to a merge commit
> (99d31e1378, merge branch 'jc/name-rev-lw-tag') and I spotted
> the 'unsigned long' taggerdate parameter to the is_better_name()
> function.

Thanks.  My earlier "oh, cutoff that was long also is a timestamp"
patch was what I did while making this exact "evil merge" change,
and then when I re-integrated everything, I forgot about it.

I'll teach my rerere database about this.  Thanks.
