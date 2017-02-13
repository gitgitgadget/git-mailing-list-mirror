Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174051FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbdBMUDl (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:03:41 -0500
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34248 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdBMUDl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:03:41 -0500
Received: by mail-yb0-f196.google.com with SMTP id w194so4495662ybe.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 12:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ubIGfEX5spXo4ZyzXIonGBVpRp3FgvLcdYdsPgXJuv4=;
        b=nWND9q7YjzGrNqB3bjW7Nw9pc5LQL4KPCDz/rbgdFXIPJuinOU7JSl4sOsp3lA9dvV
         BjBM3S4BKh9WvgEhZNc26LXqi9A/gg0iYhAWk2GVOuTN6Jx9rGb1XwovVbwfVEIon2P0
         k+JgBeQZ0jvYdkjBUqECefLGFNyHHk6wHiXvB6+mWnQV5ZB71raY41mq4tgmikhlyTS3
         qiDpZUoek2JJ+orAxA1u5GRPzPOIeWEoPuxOBFhXXpxdqZyvG7kfkBEklDldl0rsHviO
         8krHtkUPcaJyn8f9GKF6gEhete6OitzwckvVqxR5fStEP1QHQx2+ePmix783MUznwHTU
         p+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ubIGfEX5spXo4ZyzXIonGBVpRp3FgvLcdYdsPgXJuv4=;
        b=SqSOo/bxXqVtK1S7VdpR0x9ibNPdonsehBedhWL6/cgZTQEeBBcKQOcmQpP5J0q6mS
         bdEBuB/JT4BysXKTnKUbwEqXEztIPpF7X/RdjDUjOzkHZSkicNPs67L6Uk5HKdkqJLlI
         ax0yDo5CNYueOz0G77So9MDlxshgDXvhWeI5hWNG1nGJrA9xx1W6AFwX+NrqFvZSNEtg
         MYQ+E0ANw20/vc6Irr7OyNOzyQ5eMBROn3IgSy10ZlzeS0j4/oEvnOajEkcd1UD4dwtg
         k/NGcLrk4w06zYOvRnjluYc2qnIIcq+o3KgbzH1x9DqO7v4NqWcNFbhKfU3HXXTyGhh+
         sGIg==
X-Gm-Message-State: AMke39khju24G0FtT1BT98TgsEQ5HewpdZpDNgFDnAw0zB3o7u4Jo3BqQduk2e9tuc/7qg==
X-Received: by 10.98.34.130 with SMTP id p2mr27479735pfj.11.1487016220025;
        Mon, 13 Feb 2017 12:03:40 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id 75sm16202310pfw.103.2017.02.13.12.03.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 12:03:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     git@vger.kernel.org, pranit.bauva@gmail.com, peff@peff.net,
        pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 2/2 v3] sha1_name: teach get_sha1_1 "-" shorthand for "@{-1}"
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
        <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
        <1486752926-12020-3-git-send-email-kannan.siddharth12@gmail.com>
        <vpqbmu768on.fsf@anie.imag.fr>
        <xmqq1sv1euob.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 13 Feb 2017 12:03:38 -0800
In-Reply-To: <xmqq1sv1euob.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 13 Feb 2017 11:51:16 -0800")
Message-ID: <xmqqwpctdfj9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
>>
>>> +	if (!strcmp(name, "-")) {
>>> +		name = "@{-1}";
>>> +		len = 5;
>>> +	}
>>
>> One drawback of this approach is that further error messages will be
>> given from the "@{-1}" string that the user never typed.
>
> Right.
>
>> There are at least:
>>
>> $ git grep -n -A1 'strcmp.*"-"' | grep -B 1 '@\{1\}'
>> builtin/checkout.c:975: if (!strcmp(arg, "-"))
>> builtin/checkout.c-976-         arg = "@{-1}";
>
> I didn't check the surrounding context to be sure, but I think this
> "- to @{-1}" conversion cannot be delegated down to revision parsing
> that eventually wants to return a 40-hex as the result.  
>
> We do want a branch _name_ sometimes when we say "@{-1}"; "checkout
> master" (i.e. checkout by name) and "checkout master^0" (i.e. the
> same commit object, but not by name) do different things.

FYI, the "@{-<number>} to branch name" translation happens in
interpret_branch_name().  I do not offhand recall if any callers
protect their calls to the function with conditionals that assume
the thing must begin with "@{" or cannot begin with "-" (the latter
of which is similar to the topic of patch 1/2 of this series), but I
suspect that teaching the function that "-" means the same as
"@{-1}" would bring us closer to where we want to go.

