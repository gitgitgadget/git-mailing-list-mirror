Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814D9201C8
	for <e@80x24.org>; Thu,  9 Nov 2017 20:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbdKIUaj (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 15:30:39 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:47828 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbdKIUai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 15:30:38 -0500
Received: by mail-qt0-f171.google.com with SMTP id z50so9298011qtj.4
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 12:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EI0gTyVFPuCDpvO3BFC6fXJHTTegP2juTxUXGSiNvmg=;
        b=Xk0YmKL9ubuxKORTvW4VxNekM7UbxHxgNAGiRVsI14AL97tdd3UdgcBitWCFvYWZ6s
         zmHh8hUvXaSTJxmSF7E5QpLt5tY6lZ6Lnas6nZxdHgcZrjYJ4B9QDMPoS4aLIr0a6waq
         QPaM4rwIGs/do2FNOlbC8OxTBn+siRKopwk1x9BFDVCdVJYtuvoakOPK7zV3Y5Zi8T2C
         21JP5pYqIJZHPPlYb+Pfd114vavey/lPznmcIq/WgJAE/b9gbP9C05Cj2VIJT5Nt6V/K
         WcHaiILkykIaKi4lVVbk7jz+Chok3gWR2ecSxtiWGyZ6mpus9IOMfP0Msn5UaHOPEf+U
         E2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EI0gTyVFPuCDpvO3BFC6fXJHTTegP2juTxUXGSiNvmg=;
        b=SOx77mrDLMJe8Z5ePVS5Zw3+zpMpVLHJkgNyK4/70bWkz5C19dht4YJqxWMln5V1FR
         OvtP5S8YroRaqskqHU/mwzm5cVts9vwo9+xhVuPmMReNgYo/0ouBVE5P7FCidFNF1v1i
         dVmkjKox40vWsDL7ZU8Nzx0+AlHgNNoPa3DLJ3vs2kj/2n+da47MU2be9O0LhcAqQPHr
         LEMp7lgiCJRkA3SmwpgWyDvIvRf5SAomQDmO0xfFJvQ+EElZAxPdUdtZTErQWcRCiUFP
         Truj/MLQwqduQSkitnh9jcm/SJ90GPIESs9rumEY6rinDVuTxbmWNM6/7FZyaQ48bIt2
         OMPg==
X-Gm-Message-State: AJaThX5lzpz782HloSyddEMA8OP9PrAH6fkKGB3Pm0txFWlMCQILrrtE
        C07JAxLEQGzklEQ40ADIcmGtmXsrLlWf5OyrPAY1lQ==
X-Google-Smtp-Source: AGs4zMZOfVvxDeBwJQZgct5k9M28pe3zPk+w3SgIlnOeHhlaWI8P60RsI2fsxGpYZu3y3WlQxSvqUYeKRiDYYQDZNNI=
X-Received: by 10.200.63.79 with SMTP id w15mr2833882qtk.224.1510259437208;
 Thu, 09 Nov 2017 12:30:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 9 Nov 2017 12:30:36 -0800 (PST)
In-Reply-To: <D199FB1260C4462ABFC1F0F77D26EF06@PhilipOakley>
References: <20171028004419.10139-1-sbeller@google.com> <20171031003351.22341-1-sbeller@google.com>
 <20171031003351.22341-7-sbeller@google.com> <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>
 <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com> <CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com>
 <xmqqinetsayr.fsf@gitster.mtv.corp.google.com> <xmqq375xs3zr.fsf@gitster.mtv.corp.google.com>
 <BFE987312194406AAAEA8DAC7EC5BFF5@PhilipOakley> <xmqqlgjlkzmm.fsf@gitster.mtv.corp.google.com>
 <D199FB1260C4462ABFC1F0F77D26EF06@PhilipOakley>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Nov 2017 12:30:36 -0800
Message-ID: <CAGZ79kYRunzS9vDO=Zk1jQk1BvwJomN5+=1gQi0aDau_qbamew@mail.gmail.com>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rereading this discussion, there is currently no urgent thing to address?
Then the state as announced by the last cooking email, to just cook it, seems
about right and we'll wait for further feedback.

Thanks,
Stefan
