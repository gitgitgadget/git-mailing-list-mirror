Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EEE420248
	for <e@80x24.org>; Thu, 18 Apr 2019 00:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfDRAMb (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 20:12:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55797 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDRAMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 20:12:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so619751wmf.5
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 17:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=A0jQEp8O419pTWr+75vS0P3TKZEv/GrFG3pmzDq3X74=;
        b=WquNg6fnEFBa2i3Oy5/0VwUl5Ij601KN/XWCtkjb0z4RBG6EUsVUKTiOBKbuX4P5AR
         ixl0zZxMPzA6JMxs52dOLPMG4UzBKqVMpnSwYn3Rt8vmusCgMD4dtbiDUkRti3j/BZeE
         j+fan174a61tabl8ZHx+U4QzEUnd67BSlCuVvUgR+oQcPzIEx/GSgSzhLg5Xua5bIx7Z
         IO9NHqk1SPmQMjG4Ph0aHkLHGDlHPMMd6GPkAjd9cWgCJdx3X4fjSt5nyjJZ2YsU7f+M
         Gve0Icfu+LWXzlmxRsXKyNM/GQjhlW1tTMnzFDNufJ8KfPQI+9IlDgmXyjxSgDKDIhKY
         0wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=A0jQEp8O419pTWr+75vS0P3TKZEv/GrFG3pmzDq3X74=;
        b=UcYOqxu/Py0Qpp06DwwkXfzyakXtxtcmooBDuw+K3p3MtJLFbFGGFLY5Y1JBjaEDpH
         rGOuii93ew0Kui1LziPDbRkGTlQNFPo2HfcbWk2Z5jVm1VPv+LSRElUm+MlOEGptvUs7
         DLSQa8skRsah1VM81uOdTYYaEwZAgJXnIKNN9lPn6QkrKnEeLPiPoccKpwKtzV3CQhx6
         jODLkbU6ZxT1fa+Uef7oZeeJ0itwAnOKNxkdPzGyjdPJl+v1usIb2qb7kcMj/in5Z2h4
         LoaxTSHD2h3jtN4X4ZEZjRnOmb3TzdFIaoThWctS+ZLMgYOtJK5vy1NvG4oOeIeQwQra
         Vbng==
X-Gm-Message-State: APjAAAXHz4duF6ZT6r+f4ngowBYwBCO392psSz/dt/QZx+S4MVGDjclt
        xcPq5PwgM0By5Nz5xyQfj34=
X-Google-Smtp-Source: APXvYqw9oRb/kgqVtmR7Ac+2/EgGdjqKBCbuppNpBwB8bG6MZk/Ta1UNBaitoOfFMQgl206og6/H4A==
X-Received: by 2002:a1c:7dc7:: with SMTP id y190mr785580wmc.149.1555546348828;
        Wed, 17 Apr 2019 17:12:28 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w14sm433215wrr.16.2019.04.17.17.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 17:12:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <dstolee@microsoft.com>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
        <87d0lmatr1.fsf@evledraar.gmail.com>
        <xmqqa7gqots5.fsf@gitster-ct.c.googlers.com>
        <87bm15aymo.fsf@evledraar.gmail.com>
Date:   Thu, 18 Apr 2019 09:12:27 +0900
In-Reply-To: <87bm15aymo.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 17 Apr 2019 09:18:07 +0200")
Message-ID: <xmqqimvcjhn8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> LGTM, but AFAICT this patch of yours never got sent to the list,
>>> oversight?
>>
>> I am reasonably sure that
>> <xmqqlg0bvppc.fsf_-_@gitster-ct.c.googlers.com> was sent with you on
>> CC: line.
>
> My bad, missed it.

While juggling several dozens of topics in flight, I'm bound to
screw up when it comes to work on and/or send out my own patch,
which only happens occasionally with the current workload.

Erring on the side of caution and helping me by pointing out a
potential mistake like you did was exactly what I would want to
see and appreciate.

Thanks.
