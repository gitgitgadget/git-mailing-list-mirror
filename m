Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5E11F731
	for <e@80x24.org>; Fri,  2 Aug 2019 15:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbfHBPRp (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 11:17:45 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:44157 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbfHBPRp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 11:17:45 -0400
Received: by mail-lf1-f47.google.com with SMTP id r15so36201261lfm.11
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NmuoiPbMnXca1oPe54b396PfTYw0TgCdW7rYvQL9/mI=;
        b=NzqUDTtVRO7AaVvRLCHM/Yxn7929/3Ztt8+wDusFIPpHu325QXhbhNCWI4MVYy8uwI
         sOLlYzLdJkKuHuHQwjlz4OYq/CbnrGrKqMZTJ8pKx84GCoIhNgbHKkU2Q667kOXd6Ryh
         ZdVEbrdzHR2bXqDmHE6xwFsa7EZGWEIH//puHhXxdpQ3ay7qu1NfB+1JJWs3mG7FqbXk
         FY1u4NtVE5QNLSI/yY0+H6Uw73AnmFTZmnXU0LoWsgqWrByaLA6OxrofnPfoIuxv13hO
         lBm59k1NC2qgSNxOvpk1jD7OIfdrLNJSMHbYnpsOVQZfI9hkXq9zCpC1rDpD4RoNKrIx
         SSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NmuoiPbMnXca1oPe54b396PfTYw0TgCdW7rYvQL9/mI=;
        b=CB1E6IAEONURALYMVr3A67gucozyircvBETlURJCKRwV6g+k24gqvRLTPds9Ec7xDa
         iwTN6H7NtaFMfi5TQpJl+ciOPrcFyU1qept5ESx5epZeEoKu2QEuBlJb+5WIN5Mq4QfH
         igc4ITQB7dWcVMzJo8rj/PiYkZQBkRNY0DqDLUXtxDWjnnXOSNrXCSNGh6umTu7n6SLF
         nQte4mT62FEQaNkRQD3WPjTov1fL5uwH1JezyuvZMNmG2kKZDLRKJvIZZO8XsI5ADjj+
         BnZLrOGKQZJ/iLuUNCfOBtFPQDldVF3W4RO1NiamNHF31O5hRW0kGl4nWPlSwh4T6eZg
         BWHQ==
X-Gm-Message-State: APjAAAW8dEq+j+BMPiahrbc9YuTr7V+qGsKX2gAEdMauKch23Ib8Hpa8
        Pn85a8NFDx3jcZe41PU3g6Ib+qkRx6Q=
X-Google-Smtp-Source: APXvYqzCjdtlGD3eFpamPwGLjsfaJ040JaP0sjeNnhQgAqVFAuQzhq5JrYG32w5X5uKwxtt35HZR6A==
X-Received: by 2002:ac2:5e82:: with SMTP id b2mr21104992lfq.3.1564759063315;
        Fri, 02 Aug 2019 08:17:43 -0700 (PDT)
Received: from DEV747.cadcorp.net (ftth-nat-108.ip4.greenlan.pl. [185.56.210.108])
        by smtp.gmail.com with ESMTPSA id w1sm17548632ljm.81.2019.08.02.08.17.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 08:17:42 -0700 (PDT)
Date:   Fri, 2 Aug 2019 17:17:42 +0200
From:   Mateusz Loskot <mateusz@loskot.net>
To:     git@vger.kernel.org
Subject: Re: cherry-pick merge commit with log message populated
Message-ID: <20190802151742.bsxugrfxd6kxspfn@DEV747.cadcorp.net>
References: <CABUeae8EBzPSM1KrZTMiGj=6F3iyxeXXbqUNMf2p_LfPkqcfnA@mail.gmail.com>
 <xmqqr264my73.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqr264my73.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20171215
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19-08-01 13:24:00, Junio C Hamano wrote:
>Mateusz Loskot <mateusz@loskot.net> writes:
>
>> Is there any other way, without remembering to `git merge` with `--log`?
>
>"git config merge.log true"?

That's sweet! Thank you

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
Fingerprint=C081 EA1B 4AFB 7C19 38BA  9C88 928D 7C2A BB2A C1F2
