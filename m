Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B15620986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbcJDSIf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:08:35 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34624 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbcJDSIe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:08:34 -0400
Received: by mail-qk0-f178.google.com with SMTP id j129so190804519qkd.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RtQc3osqH/aiw86jLLhrBD9qziQ7qqShDhPvJ/IAc7A=;
        b=aFz6kIUEdppvkpCdcIAa3uRghJ8kc3j4VCs+47CMVBnWgo7/rpKdV0BI21iLqczpcv
         pzXU0RGGQayxS2ohYG4DuilBpPWM7WG7N0qS20Qek9iySUy+tnCy2fcvq4Ieg70fs+Tj
         86s0B5ROuPivrvO8y5omW9bHHhRGADusdjUWpVt8+NGJez8S9Fkl8wmRviFzhu9XdzzR
         4uhRaUtLjlImE6/MKzFSlQnCeR+i01E03bJeSlow5VUryZFRdv6yDEJ8icmhTIp+pNSc
         F764QwxoxglVuwebfWtbHqlswBL/GU6WmCEQf05OqJ4AjiN1ZKXhxDASzD3S+L3UD+Oa
         7+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RtQc3osqH/aiw86jLLhrBD9qziQ7qqShDhPvJ/IAc7A=;
        b=JWKOeg3q24ASqJCxB+Zb2y34tUY+wSytdSaXWc7aV2xJU4/u8Rslps/oatakfYHraw
         3ofvUdbSbTpGKEjbffpkRprrpu+4UlJpca18cUW+NdESMRAsIIIAhIQNt+1WQ99HEs9V
         4VVmKMjcIFDD4y8HXA+CGhg/4IlZuln6llFAokem+2zqbD9a0CofWFU+UfDnJLFvdTlA
         WefvaqG3DRAeo+Dp3GZrQxZbuQXu/mGlGlfiI4O4tibKXvV7U2teyR6gXoEXjki0FiVI
         r2SoZjultrzuPRgoO5Oe+guR0RuBndl/ay/YgugPvtsn4jPYz+DU9aQzv5VzF5EsyjB9
         Y1lA==
X-Gm-Message-State: AA6/9Rk8YLizzJjNcaG4KqiN1he2cKdteGjMiKULTbgvZ+10zVlmS5X2jheiU4a+t5eiOyBtNXRHB29HzIfSzc43
X-Received: by 10.233.216.194 with SMTP id u185mr5245678qkf.173.1475604513609;
 Tue, 04 Oct 2016 11:08:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 4 Oct 2016 11:08:33 -0700 (PDT)
In-Reply-To: <xmqq7f9ouh1t.fsf@gitster.mtv.corp.google.com>
References: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
 <20161004164036.6584-1-sbeller@google.com> <20161004173430.eax4ptohyonc5bw2@sigill.intra.peff.net>
 <CAGZ79kaKOjqLBsNVSmudzLUCkOJf_CsFGE8OZZHsTmuXCfiVeg@mail.gmail.com>
 <20161004175449.gn5cw6wcbvloqkzj@sigill.intra.peff.net> <xmqq7f9ouh1t.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 11:08:33 -0700
Message-ID: <CAGZ79kYQsXxzXihtzC70Oj29RAe=8+nuJeUWNmbF17C75xbEag@mail.gmail.com>
Subject: Re: [PATCH] push: change submodule default to check
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 11:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Actually, I like that a bit better. It would not cover the case where
>> you have not actually checked out any of the submodules (or at least not
>> called "submodule init", I guess?). But arguably that is a sign that the
>> auto-recurse behavior should not be kicking in anyway.
>
> Yeah, the "no init, no recursion" line of thought is very sensible.
> I like it.
>

Bear in mind that "submodule init" only fuzzes around with .git/config.
It doesn't touch .git/modules (i.e. cloning/fetching), that is to be done
with the update command.

So if we also want to cover the case of init'd submodules, but not
cloned/checked out submodules, we'd rather want to consult .git/config
whether there is any submodule.* option set, though that seems more
expensive than just checking for files inside the modules directory.
