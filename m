Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FEA1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeILB1G (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:27:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37194 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeILB1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:27:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so27320774wrr.4
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YsAJF/wyp992sixeFW76cMEBMIHX1+a78Xl3Hen5KNM=;
        b=WOdQ4lgPWfUxpPTndrceZ8WabY/kD2tf5zRAd/AoURtvzNtsf4HmRvUgED1pQHf42S
         a9LAP7v7OE29coRqHaY8dQCYlycDWzysd2B92Zpe4Rpg+NyGamRtcAT9bhuDvnBsMpRF
         L4IG2VnLf3QBc8qipBpZKDRRE5KgYraDCzfyKWZSa9Gx4NBJMeO/g9RiOvMlQyAL5d5G
         fyiawNkAgPx2i4uLKJl9Z40hhCIaELq87bpUdNEw1rYDqjLjeGAXgRUyZfSF2HBgmlGZ
         dGJEN/sy/xvBDJ2JmOwvpSTHoB5hZ7XYCK3Eg2HR7S2N/zoYBJbFCC5TL/uKs1if+9f+
         6lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YsAJF/wyp992sixeFW76cMEBMIHX1+a78Xl3Hen5KNM=;
        b=CFS3gl0EEZUDAPc3hyhTG+0MraS74QfqOXzRmYFhUKPDXwNVF7DqmqSqNJDtnSRdXp
         UudBRb+98HG/J/28CGet5HcMRUXCjVzZPfJqseP2Ubg4byOByN3ZmZj/+qkNuTuJbsrU
         zdhffwRf5L3tkDM5a5EHoUA5rdWW5K3/rSiIf/D7c38UnAedwQFSMnx0AiYwPL0ZNB+m
         PPCSKDftpsHROu/bAdqB/6aD9L0D2yArJxnjOUVlivRXlIuFC0TFdO2xYT1ph8fEn6OO
         MxngAeER2Yp7UV6FK8w2JIAkHvqtmZn8+DWSieN7AEVH9G2lscNDdk7XfXhkAMMrwAZN
         Pqqw==
X-Gm-Message-State: APzg51C0Gy2O3ultBSYK0kiE/BSHN5wMyYVeVht9IUhM61wW+jrIbX9e
        k8em13ZSv3uCqXdgFGs6ToQ=
X-Google-Smtp-Source: ANB0VdbDMjdDZRO2rIee6FBbQc35Y/sH/e2eKg3Tsv2tz63vP17bS9lJ9T4Wf/kQCBL0Fy56dDjiow==
X-Received: by 2002:a5d:6aca:: with SMTP id u10-v6mr20777426wrw.44.1536697566957;
        Tue, 11 Sep 2018 13:26:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o15-v6sm19453280wru.23.2018.09.11.13.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 13:26:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/2] commit-graph: add progress output
References: <20180904202729.13900-1-avarab@gmail.com>
        <20180907182954.2413-1-avarab@gmail.com>
Date:   Tue, 11 Sep 2018 13:26:05 -0700
In-Reply-To: <20180907182954.2413-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 7 Sep 2018 18:29:52 +0000")
Message-ID: <xmqqo9d3ok6a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Based on feedback on v1, and the "this is yelling at my users through
> gc.log" bug I found.

I notice that between 'master' and 'pu' there already is one new
callsite of the write_commit_graph_reachable() function; because I
suspect that we will discover more places that give us better
trade-off to have a call to the function, I would not be surprised
if this will conflict with more in-flight topics soonish.

Let me try to queue it and see what happens.

Thanks.

