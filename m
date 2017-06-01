Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4465220D12
	for <e@80x24.org>; Thu,  1 Jun 2017 01:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbdFAB73 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 21:59:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33694 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdFAB72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 21:59:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so5517891pfe.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 18:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wtPBPAT++sHm3CAwNo8HXX/r1z/5zfdCHIPJw1En+SU=;
        b=TLzDLk1NkZ/w4SbG2/OTA7SOyjhssYSwebsoBRgIuqwOj9jzkPJm1B5bR8d0oUBUFM
         t/FocwR4Q+uVumrpGPAlXMyVYdUoOjc5CMYT22/hzRlWKyQp0UzXcgcwYuFup+zBgddI
         4fezNXEAt1RQALUVE88C3BAxA5+AsKhLYv8W9B4XaJoRJPUidk8wNOzMj4HGbjmK9/gD
         aG/fZySue9w6Lgq3LV6Hwl6Wh6IuLZzAIPQTEE4htd7DlR3dWT8Nlg8f6TSLtMglq+rD
         bqm/dcaRJ6VBxwss4zAb4390Wo9xjE6MSTNx6nq9KyzxBSmA7103dKHPaWNNjBukTrCy
         AuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wtPBPAT++sHm3CAwNo8HXX/r1z/5zfdCHIPJw1En+SU=;
        b=XgAd7+J/MuU3LRSZy37ezEWN+KfRAAJi8vXX9osdtKhmm4qus0kIeuEJEFf6nTltsw
         5U8JKQqECAPKTqoOhVJA8eXtAZ92MMHNvcSL0Lj25R/kbbIjXJtBywyJrSp5UZABFlej
         l8S7xdFp4ercp/qmCLokIVNY+h0FAOaRGDCjuB/mXlQA0hIUDqE6De6Vl9516YeSXr8f
         P/lQ+GO+PbB2nbLNvcSbSsqkXopM5tcWmNR8rJCMOW6SbFHxhjo231YT0jngpOMZbF8Q
         Mc8alhFjZpwwqW7wN2Hvkj1f4ejPYCdQ34hqJLT8FIRf90VJhCcN9UWNvjZ07Himxv1Z
         dmog==
X-Gm-Message-State: AODbwcCIP2IxqC1HWvFYSpLUE+ATCHHpeR9JuTYVb9/utGRLNtrrffLt
        64hk72kNHQjOuQ==
X-Received: by 10.99.123.81 with SMTP id k17mr36214321pgn.125.1496282367738;
        Wed, 31 May 2017 18:59:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id l85sm30864277pfj.130.2017.05.31.18.59.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 18:59:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] rebase: Add tests for console output
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170531104213.16944-3-phillip.wood@talktalk.net>
        <39cd140a-4ba1-f3ee-d945-bf43199d4a82@talktalk.net>
Date:   Thu, 01 Jun 2017 10:59:26 +0900
In-Reply-To: <39cd140a-4ba1-f3ee-d945-bf43199d4a82@talktalk.net> (Phillip
        Wood's message of "Wed, 31 May 2017 20:02:53 +0100")
Message-ID: <xmqq7f0w8o3l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 31/05/17 11:42, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Check the console output when using --autostash and the stash applies
>> cleanly is what we expect. To avoid this test depending on commit and
>> stash hashes it uses sed to replace them with XXX. The sed script also
>> replaces carriage returns in the output with '\r' to avoid embedded
>> '^M's in the expected output files. Unfortunately this means we still
>> end up with an embedded '^M' in the sed script which may not be
>> preserved when sending this.

Or such a sed script may simply be not portable.
