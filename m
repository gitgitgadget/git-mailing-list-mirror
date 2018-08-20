Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3DE61F954
	for <e@80x24.org>; Mon, 20 Aug 2018 21:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeHUAty (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 20:49:54 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46925 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHUAty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 20:49:54 -0400
Received: by mail-wr1-f44.google.com with SMTP id a108-v6so11469320wrc.13
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZTOAomx5fAcgLImnYilH+ZqoRfRXESlVsOBxiBFtdFI=;
        b=Ge5+pBP1WTeCl9a0NlBwLPA5J2B4/qKlafYH6+mYw0v2svs5KbJYXXPJCfnh7OUx1+
         Ylnh1KHwFSvd+St5IM5bLLbOLGhulBIQW83Wz1z4e9IG8HUATiJ4J22oiGG3ETVL+/Xh
         4JPSVD1+O5FRIo4U6N5+3TXWF94gKayZ48sWLs7UVqhIzqbQAXFhtcTQRA2q7dvBnDcJ
         aiu92l6A4Cr3Vpa6+byLYPiyagmqFuHufbh6hXhO22rVfkBP7+zm/MFubrFKpKLx0xWY
         CyAQzJsBVA8mV0aE+pGUvWRZaBSRDoPXiWPzt4jgkS+AZSRvjPmGyD78ocDmNd5XDf/E
         1TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZTOAomx5fAcgLImnYilH+ZqoRfRXESlVsOBxiBFtdFI=;
        b=pW6FKuyR1yToQc+ANqVksUgrIWzXToNFPI6eAb+NQIU6MP6KVdEvR2mD4gG/647GAK
         7NqiolIHj/wzrjg+jJBl2ZhlPg3q/JzTE6lutNlBF6HTpindkRvDyh0kVPsZgFpm9ldp
         aMQ6vLKbmt5EQEh4XGrwC4d/iRkns72mtVrCcrMoWHJ3n2cozXwKL3sS17ND9AwCgsH2
         l1AfrWNmIatVu/uRJtGmMZ6ekrZMWiegKBrzKa+pWVrrQoDHAW6E4jBF3aiiE/spPTdJ
         KAArsjWRpaB829CYnwlnOIJqAenfxmxAoA9WPC1xEGsJIdQXYTwzu4mdiD5H3GYvF9iV
         VvZw==
X-Gm-Message-State: APzg51BRzEUlpd2ASuj9gYe/lfO0FQW1hXbh5ywRyk0+vaXmD9gfxZ8T
        Iwml3X+vZOejDd3Q+aNHABQ=
X-Google-Smtp-Source: ANB0VdahHcj0cO02TF0ysmdBZrqcMfcxWndwBLYS72+DAvk4hGhSqnoPp31Ctepv534zy7VTXZdWHQ==
X-Received: by 2002:a5d:4c45:: with SMTP id n5-v6mr4970731wrt.71.1534800756551;
        Mon, 20 Aug 2018 14:32:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e10-v6sm582411wmh.19.2018.08.20.14.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 14:32:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Antonio Ospite <ao2@ao2.it>,
        git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbQ5L39kdsfouPXJjJOm_Ni9TY5Qan7nHZE9VbcaEMyGA@mail.gmail.com>
Date:   Mon, 20 Aug 2018 14:32:34 -0700
In-Reply-To: <CAGZ79kbQ5L39kdsfouPXJjJOm_Ni9TY5Qan7nHZE9VbcaEMyGA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 20 Aug 2018 11:11:25 -0700")
Message-ID: <xmqq6004bu6l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  I find the design a bit iffy in that our usual "missing in the
>>  working tree?  let's use the latest blob" fallback is to take it
>>  from the index, not from the HEAD.
>
> I am not sure; why does it feel iffy?

Why doesn't it?  There is no justification why it has to be
different from others and read from HEAD bypassing index.


