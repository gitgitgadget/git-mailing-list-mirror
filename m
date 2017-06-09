Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB821F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 16:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbdFIQjr (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 12:39:47 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36317 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdFIQjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 12:39:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id y7so9063342pfd.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BPSXvPg0+0Y8/hulidmpWgtJr5H+3kQjFMc1QYHMZQ8=;
        b=Kt6aiOuCzSEHjASxXvKyZYcJjBUxGzUUb7PVTyto5HfVngpdydh/kIGPCBArDFKeqG
         608eslZkYyybyqZAklau6oJXhTfRROSRqUz0MFRbbixFiI+3hf+4V6DVJ5fRlx9XzE88
         u0aUb4yByUmTtSGULbW/Y36YUmVYKDbWrb/K569tQ5EHTSGNOgh8Y0a95C/rlgj8k8V4
         P919XDeaoeWcHNMPcY5DVpSBhssfevFg/2XyRvP7dAkJbZAWo7rkxrqgoNYY6q4+NN6+
         xSQ5RDwnAk1dnkaC3GjrRbd9fs3mZ2g6aDp9x/shdboiH8EB6syXfE7V2ZbRSVy6qvUF
         Bdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BPSXvPg0+0Y8/hulidmpWgtJr5H+3kQjFMc1QYHMZQ8=;
        b=p2MqWvx8MZSr4aEBzKPUZQIAliNZ+GrckohgbQqVfPRaw7zia4j6Y9JxvLk0+zrzdU
         w9Uksvii6otpKleDhZ4ncMIuQeVclN3brVM5o1cBASL4h78FYgfNmfQDxzjkIYZBhQP4
         EFAB5YoJlx4BrcdY02Oo8LFCjz+40o+bK/CDuc4HY3UtRynWyEoSA3tIaYtuEbu8o4AY
         bkd3YM0asDIyLuI7CeaTO9xadgr1UbU9vJoKzuFvPTN5ZXk8kxpKT1E4SFRFNJ0efQqm
         hr/BonYIPFYH8KsF3Ov1OLjzHhmV6B0Vo9dGkpbDKvYrxCx6wYN152CUhnWuPw0Yk3ES
         yZOA==
X-Gm-Message-State: AODbwcBSW7+hm1tsI3Nu369MJb+8tOxNUi2elRK3ub4O1gwZXVzSzSZ1
        nJO2j1EmQWP6Eg==
X-Received: by 10.99.127.73 with SMTP id p9mr45112795pgn.169.1497026385262;
        Fri, 09 Jun 2017 09:39:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id z4sm3596671pgc.22.2017.06.09.09.39.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 09:39:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] rebase: Add tests for console output
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170531104213.16944-3-phillip.wood@talktalk.net>
        <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
        <5309bbe7-edd8-0c34-82ff-c3162d7d9e66@talktalk.net>
Date:   Sat, 10 Jun 2017 01:39:43 +0900
In-Reply-To: <5309bbe7-edd8-0c34-82ff-c3162d7d9e66@talktalk.net> (Phillip
        Wood's message of "Wed, 7 Jun 2017 11:47:02 +0100")
Message-ID: <xmqqr2yt5d4g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> I'm confused by this as my script does not use the escape sequence "\r"
> out of portability concerns. It has a literal carriage return as you get
> from typing Ctrl-Q Ctrl-M in emacs or Ctrl-V Ctrl-M in bash ...

I think the worry is that some implementations of sed may be unhappy
to see these raw control characters in the sed script.
