Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8F91F597
	for <e@80x24.org>; Wed,  1 Aug 2018 22:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbeHBApX (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 20:45:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38579 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731976AbeHBApX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 20:45:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so128490pgq.5
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mrljaDT5PWNyw7OoYN9EmZTDW6lx7c5h7j8GAw3/g5g=;
        b=bgXq3kQb/4f41o6QI+r7nshErdlzhnnZB7NErf3zQT2w9/ewbC2efhy7OumXj6u6Tm
         0fx9ca1QBsA8JUs/vo/kaitWa9R/nyA/h75K5wggmDgnxcALU0dwNMK8PdmnRlQg9pXF
         g6Q0cq2v9qruPWx9cmeNA89OwLcF+hFSAS56DtNrvSfg0Qbw0L5Sx28zZjLPsl6c5pa+
         DnzRQzMfckLkOe7fxb92YW++zG5VmppNguzFefb5kxDczh39/dnr7L1lV3b22gQ4iUCS
         mDKa9pqzhoTV2wCm0p/pnZp6XWP3vr8XaHCNBXA7lSFFycuNRawVQdcomLlvJXgonbVq
         J10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mrljaDT5PWNyw7OoYN9EmZTDW6lx7c5h7j8GAw3/g5g=;
        b=gRCjQJQkibTqDKbhg6jFg3yTPFKqDKfYiczitdIaJiFG1ESYvhf/LrQisR/zRn4VFQ
         9G7renh384nviiRy/lDvBQC1+7z4TkyH1BygbI162lx1hmWiE+CUM12GVQisTecYYTxX
         9obJJkl2rFS7edjG8qUpCmm0JhnysDQNYBLt28XvkPVjZp46ZUwxtL+g0qashm2SlbFa
         iqBggDHuLBYVpdCKNZWLKQcWI5ghlj0tf2/X0t1A9h8gJybai0riZV7PqHxUBnKtmuMI
         g+0pRGdSCcsAbH2/lUUY/2Xo3lKJrhQ8cROtssrKTbo0ENhObYdz/k3uiInWCDiqrHzo
         0eGw==
X-Gm-Message-State: AOUpUlG4/fNJPQ8PeUIZWgmRVKVviNzt7AkAIHWmrFwT81S79YNWIWh0
        VbJFLuoCPcRnVghGy506De4=
X-Google-Smtp-Source: AAOMgpe+wzGnwlsYkrVwZdI1u+1XmLMVgt7LJVAjp5ySxIXhoCbz4I6bsQ5S6CBF7tuEEQAlRtp1GA==
X-Received: by 2002:a63:774c:: with SMTP id s73-v6mr248200pgc.339.1533164235989;
        Wed, 01 Aug 2018 15:57:15 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g5-v6sm146797pfh.63.2018.08.01.15.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 15:57:15 -0700 (PDT)
Date:   Wed, 1 Aug 2018 15:57:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
Message-ID: <20180801225713.GB189024@aiede.svl.corp.google.com>
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> Add a comment to save future readers from wasting time just like I
> did ;-)

Thanks.  I think we should go further, and start the comment with
TRANSLATORS so it shows up for the audience most affected by this as
well.  See the note on TRANSLATORS in po/README for details.

Sincerely,
Jonathan
