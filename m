Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE04F1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938712AbeBUQ6y (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 11:58:54 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39662 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754878AbeBUQ6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 11:58:51 -0500
Received: by mail-wr0-f196.google.com with SMTP id w77so6424485wrc.6
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 08:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ym6Sk1+dypP0woa7JyQOtN1APJhQobaR78LYpCMzPuQ=;
        b=QvlT8mxdXmk4k/u61RtvLM9Kp4gD3AlTBbr4A7yZloj0etBNX4hxP88SCUCGnsM5kD
         MeZ6SnbBEhjAgyBI2LnLxtyv/OrAEfZw7UtWydsJNdJ2XTK4vECZKafrmsnAEhrTaLsO
         RSl+zzJMWvbVYGMuF6wisuKv4DE44mNpqp+nE+u2MLAa/RtNqbRfXDV+XwW/q+TCApJw
         GVo1UpTb23GkXFnJezxRDhwpPEC1yxDL/yLqOAR45WG3FldhiyGuoCwfhPsVj98rK9ES
         kxiXJEY5RY+tZ5Z22KvW6zGNo8fQ6kMczLeEHifcpK1IfwkO6a6CqyFaHUkD7IvzLdYX
         vjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ym6Sk1+dypP0woa7JyQOtN1APJhQobaR78LYpCMzPuQ=;
        b=e1mujXxJ0b3ymxh6S3GP/qJaBZrH6fVKYyNSt/pMRAnQEwIRGy3ab7vEbjV1rlTaTY
         wF/GxxXOfOEb9Hlu6UKou1tasnYKiIMgmQVTaS9Hfgxke9ou0m0C63LoPYKmsLo91Xo2
         wN7I+Nv6pKI03w3SZSSjbjRjDWLl5Lul+8DWf6bJV6DX7VxCIFkXP5KZ7ccCTsPqj2P2
         qG1ek6O8SCFWkhsLtmrmRU3feyGuLFgfyoGVKt1yO6PQDwgjZK4RoE42zQlQJhwV0ETa
         2UFTiZgqsFFIp48Ai1gnMFBIbG5U8OUG7n9e0F+ZJi9uThx1z5xiJDvIoi9u6GRygMm1
         HLcg==
X-Gm-Message-State: APf1xPDXRraM6m9Lu77uuBVygQ+fbtiMaG5jQy9WE2YojLS1AmRRkteE
        1P3jx7EY41udSDjpUELuhMLYVg/g
X-Google-Smtp-Source: AH8x224NrVD5NTqz6Ai9WfbdXGg0Yq0VieI3oFqDjnL+qfhqne7zvFsMtwI5IGOtDY3jaRlu5rfD5g==
X-Received: by 10.223.176.13 with SMTP id f13mr3818248wra.231.1519232329691;
        Wed, 21 Feb 2018 08:58:49 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u20sm7114384wru.94.2018.02.21.08.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 08:58:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 4/9] t3701: don't hard code sha1 hash values
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180219112910.24471-1-phillip.wood@talktalk.net>
        <20180219112910.24471-5-phillip.wood@talktalk.net>
        <xmqqk1v74l1t.fsf@gitster-ct.c.googlers.com>
        <8f39e6b1-0031-5d97-f636-ae67cfdb3f1c@talktalk.net>
Date:   Wed, 21 Feb 2018 08:58:48 -0800
In-Reply-To: <8f39e6b1-0031-5d97-f636-ae67cfdb3f1c@talktalk.net> (Phillip
        Wood's message of "Wed, 21 Feb 2018 11:42:30 +0000")
Message-ID: <xmqq606q1dpz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> Keeping the permission bits makes sense (I'd not thought of them when
> I created the patch) as we want to check that the file has the correct
> permissions. As for the all-zero object name, is it really worth
> leaving it in - if a file has been created or deleted then we'll still
> have /dev/null as the file name for one side or the other and the diff
> lines will show it as well. As these tests are just to check the state
> of the index then I'm not sure the hash values add anything. How do
> you feel about a filter like
>
> sed "/^	index/s/ [0-9a-f][0-9a-f]*\.\.[0-9a-f][0-9a-f]*/x/"

Something like that, with perhaps the single 'x' replaced with
something more normal looking and the all-zero thing special cased,
was what I had in mind.

Special casing all-zero matters.  I know that the current code uses
all-zero on the missing side.  The thing is, tests are about
protecting the correctness we currently have, and we want to catch
the next idiot that breaks the code to stop showing all-zero when
talking about the missing side.
