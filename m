Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB9B1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbcLITDv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:03:51 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34440 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLITDv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:03:51 -0500
Received: by mail-pg0-f53.google.com with SMTP id x23so10568160pgx.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 11:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m4VvQT1vc+I11bdlB1DW/t9DAiQkp3yz6wUjuGtNIP0=;
        b=FXYoiL+7XCR1XbkwiJI/cfuh2rU6e4tyXqfHcPtZ47YJOKe4C9JW93ZcaPYjd/XBdN
         mjLEGb3GZ/H9DQmJHRZB/8vx+8TGZ8HA5wulJxiuzND1zNRxmrmBXaC2Jy4wHGbhyHiu
         PR8e5ZN6p8HOPf+DP9rXsoJEjZ+DK4Xihu2i1OFrzKK4n4pPKtto6/fkz0jnBtiEKrRp
         FKFq41HHt6570Y2zDeuCfUpMPJr4OIsm8/AM2qxvj05REKc502r0ES4uPBewyDyU8QZn
         7WT+Mr13MuHx1obsDfZJA598+Qwuzg+uN/465LGxBTf4x4P45VuRheDXzpvZW/IV5Tx0
         LLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4VvQT1vc+I11bdlB1DW/t9DAiQkp3yz6wUjuGtNIP0=;
        b=cowAY7GNkMveY4FbxCv2e1lrhP3aAE203Hh4vG89iI8DycIfQSpMxxQFaTbwQiN3o9
         CWf8OPlQvap1Olqdz+bxRilxBLQnRIZGrGx7NnXkMxw4AME7cue/3BJiDmq/mJQC8j/n
         VjZFWQPGmmQjsVLYB5kWOY6koehLglvNEzGJhl8rKPW6Qd97q78/cqwt6TDPUbJjPZKx
         PwdrtsUClkAkq+9jS/DFtNld3jITqbTUr1+KNk/wF2fixjsrqAU7FUGTrmbck8GtKoWh
         GGOOLIuN4VisDvINdpv7l2DHo3R8gqlqDEUD3+060mOdzESUmuyM+6E5vFkMBuRXwC7n
         GBcQ==
X-Gm-Message-State: AKaTC03AYxvnOhNGuNa7Vllc/+LQCjeu70/o5tmTTprxJaITfUAbtz05mrhxmqa2K+t2blup
X-Received: by 10.99.232.21 with SMTP id s21mr147178240pgh.19.1481310229981;
        Fri, 09 Dec 2016 11:03:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b541:bdf2:ef3a:110f])
        by smtp.gmail.com with ESMTPSA id c22sm59678362pgn.12.2016.12.09.11.03.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 11:03:49 -0800 (PST)
Date:   Fri, 9 Dec 2016 11:03:47 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 00/16] pathspec cleanup
Message-ID: <20161209190347.GA88637@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
 <xmqqk2barls5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk2barls5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08, Junio C Hamano wrote:
> Will queue, but with fixes on issues spotted by my pre-acceptance
> mechanical filter squashed in, to fix style issues in the
> destination of code movements.

Is this pre-acceptance filter you use something that I could run
locally?

-- 
Brandon Williams
