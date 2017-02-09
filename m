Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36F01FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932164AbdBIWCn (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:02:43 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36252 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbdBIWCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:02:41 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so995680pfo.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 14:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NU4LoIu89Dk30dOKuEB8lbSHQ0eSTA71Be53VexZMwA=;
        b=fvJc6pY8NNztPpNEIYipUTfs8Nc7jRLizfB1HqXTm/5BhjUc9PICCNLg8EoBbSn4aL
         wP1QrEnbs7kW+EkTSjB9+IjYMrDDe29ObSulco01sFTeM8bdS0RGuEwGrdwmXWbPan6d
         ZyUCU5BBKIF/CWxqTpXp/NOQo6VQZLSoKIPoNpSVjpMpK9Zb2aAaKrUJuiI/sUpyRKlA
         vNV+/B6asfWlf2VJrHa9v4KT2FvCf4D1pbQbizOVMCoEwKwg+4sYo3g+jLOfF7koUDBK
         EQgpDSiD/+wHOlHaFJcEClN4Y1ufvWgau2ohelLYXClFl4C3AausVARCk8stLHmwTKBm
         RiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NU4LoIu89Dk30dOKuEB8lbSHQ0eSTA71Be53VexZMwA=;
        b=rrzm6LWSVFCxD1yp5il0tWS5Va3Es58PZJ3JnrUv0t9ThL3c6k1pSsjbSRW2Ng0pdH
         kzrdkJDs7B8TlFDRuQ8c//eKqwPhNqAUjE0RLxKXNJbi9s6ZaUJsNGUBSNJb2fGYVaaa
         BtxFsoFC+XuScHZao3oMkacHp86T/Z3Bm1diWq1Bi0sOOYMaaoBu8SmHKl2VonOsVsH5
         /JA1rdVc5YKzDoUFrqv3zRu/Wt5F/WnscMfyiSyzT9NP9SlkCUTGKjmccs4/QshiceJ7
         7sdj0CxYR7q/KAfQEe9sAMPiSNUF4QDl5u1r/o3jVZb22CEKl+vdfWPPqqWp7R88hb3W
         gU+g==
X-Gm-Message-State: AMke39mwVH6k1ppj1qZ0s9r/KWdQ0wiHZL4bk+m+qpWoaGiViKzJZIcc8kHSxm9F1MiYDA==
X-Received: by 10.99.102.70 with SMTP id a67mr6630809pgc.222.1486677755654;
        Thu, 09 Feb 2017 14:02:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id k76sm31308653pfg.42.2017.02.09.14.02.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 14:02:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702091319350.3496@virtualbox>
        <xmqqfujns2li.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702092135050.3496@virtualbox>
Date:   Thu, 09 Feb 2017 14:02:34 -0800
In-Reply-To: <alpine.DEB.2.20.1702092135050.3496@virtualbox> (Johannes
        Schindelin's message of "Thu, 9 Feb 2017 21:37:04 +0100 (CET)")
Message-ID: <xmqqk28znhtx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > (And that would have to be handled at a different point, as I had
>> > pointed out, so that suggested preparation would most likely not help
>> > at all.)
>> 
>> I did not think "that would have to be handled at a different point"
>> is correct at all, if by "a point" you meant "a location in the
>> code" [*1*].
>
> Yes, I mean the location in the code.
>
> But since you keep insisting that you are right and I am wrong,...

There is no "insisting".  Didn't we just see how wrong you were
about "different point"?  An extended syntax of override would be
handled in the new helper to handle override, the same point in the
code as other overrides are handled.

> ... and even
> go so far as calling your patch reverting my refactoring a hot-fix, why
> don't you just go ahead and merge the result over my objections?

At this point, you are simply being silly.

Isn't "Putty is not a command but is also handled as if it is a
valid implementation of SSH" a bug?  Isn't making the code not to be
confused like so a fix?

A different approach to fix the issue would be to declare that the
command names and overrides are not in separate namespaces.

If you prefer to go that route, the documentation can use an update
to make it not mention "putty" as a valid override (the users have
to spell "plink"), mention "plink.exe" is also accepted, etc. and
make it clear that the override environment and configuration
variables are the way to tell Git: "The ssh implementation I have
behaves the same way as this well-known implementation, so treat it
as such without actually looking at the path to the command in the
ssh.command string".

That may limit the freedom for future enhancement of overrides, but
is an acceptable short-cut.  After all, the overrides are merely an
escape hatch and we expect them to be used only rarely.
