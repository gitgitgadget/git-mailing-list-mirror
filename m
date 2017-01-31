Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E221F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 22:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbdAaWCj (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 17:02:39 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34791 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdAaWCi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 17:02:38 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so29952294pfb.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 14:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fWuaKe3Z41SG0S3gltIZvDzsvnpPvrygS2e0UwOEejw=;
        b=aW4yanJwfjJmiKxYz+atHumAkxHgZtExqrTtBGNcQy2wHun7QJG09uj7NxoIBGC6E9
         6xR/f0RPECWUygg1JumKRTw7pIZWzOY7qpXo8uUQ1ZQkcZ5TGZbju+XtKWk7XnmnVclZ
         XzWCBfTK6pE4+ADJcpSccr5qSPOMpospGcnTrg+8bBJLIwWomasxQ+ftxPPFploBFT5m
         FLdNokrjhOAPeO19gUWYk45BRIy4x5FIXKRuvGug1Sj8a51n89qGH8VP+/LM1k6IFcAr
         V01rBYZybHjfCf1YSvBv5d/h369aKv59Q5udHXSNBH3jw59hwOeW0chdV86P4aYlJGNa
         jT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fWuaKe3Z41SG0S3gltIZvDzsvnpPvrygS2e0UwOEejw=;
        b=ajstqioT7TJ7+Utpz4UfRpQRNuHdSq1SNqBwENXoZE/WmUSOS/CJ9k1sFTIjTO2X3x
         FhlycVvU6kM+tTlT8HBwGxfAaeqOBJBuN45xeArSANaJKkblqEkIzez2oUuhXmlRueL0
         MxuAwJ7865DxOqTSmTJ0haggdZwHnIq+ElKlxQ90WvqvQTJNz+Yb90IKxY5ghKjlOAfS
         +ZpS+zOr2QAQlmH5NhzdY7OM89meVktOyPYe4561ZORBkVww3RJmiD6EzSPz0aNHkYFX
         Asikl+pzqlg8oXHlJlofOEXOoTy5yr3WWSzaqiPjbfqDPOIxhk5S8h8AaW9EspWO0fsW
         1FJA==
X-Gm-Message-State: AIkVDXKcluY0m28VnwcnAFUqWwMhjZ/2eTrqpU22h6kC4SuBYsWzPfs3cfazIB4QXEh7oA==
X-Received: by 10.98.33.66 with SMTP id h63mr31607192pfh.142.1485900157332;
        Tue, 31 Jan 2017 14:02:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id t15sm43912323pgn.18.2017.01.31.14.02.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 14:02:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
        <20170127100948.29408-1-cornelius.weig@tngtech.com>
        <20170127100948.29408-2-cornelius.weig@tngtech.com>
        <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
        <20170130233702.o6naszpz32juf5gt@sigill.intra.peff.net>
        <xmqqbmunrwbf.fsf@gitster.mtv.corp.google.com>
        <ce8f90a6-d719-63c7-95d0-b2538270e263@tngtech.com>
Date:   Tue, 31 Jan 2017 14:02:35 -0800
In-Reply-To: <ce8f90a6-d719-63c7-95d0-b2538270e263@tngtech.com> (Cornelius
        Weig's message of "Tue, 31 Jan 2017 21:28:43 +0100")
Message-ID: <xmqq7f5aripw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cornelius Weig <cornelius.weig@tngtech.com> writes:

> On 01/31/2017 06:08 PM, Junio C Hamano wrote:
>> I think it is probably a good idea to document the behaviour
>> (i.e. "--no-create" single-shot from the command line is ignored).
>> I am not sure we should error out, though, in order to "disallow"
>> it---a documented silent no-op may be sufficient.
>
> Yes, maybe abort on seeing "--no-create-reflog" is a too drastic
> measure. I presume that the best place to have the documentation would
> be to print a warning when seeing the ignored argument?
>
> Or did you just have man pages and code comment in mind?

I meant only in the documentation, but "you gave me a no-op option"
warning would not hurt.  I do not care too deeply either way.

