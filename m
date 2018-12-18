Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990981F405
	for <e@80x24.org>; Tue, 18 Dec 2018 09:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeLRJ2b (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 04:28:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46706 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRJ2b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 04:28:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so13231545edt.13
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 01:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jIuix13JUAf2fKPblkQRtYtsiVGEtBQ5nv+j1oolzn4=;
        b=mrYi8CBNmcmojtQWT34l8IZPIJO+seJbFGrbzR/A0BUS3AP5p0q00zuK88q4SltPIq
         MaMxa9S9SfgFppGuAJqJLUKGTF+lBRUpA8toiuDRavfPxOi0Pe8kCwdMm74YhC3jNiU7
         JqbadL+B4fi3PprCdY/V57BEnyh+qrpdTZogr/H3D0ki6cLthuB6GQy4OAPkMIxcdmxq
         wsUlAacGn5UY/5vHJozXLQrNpBN2qCSZjfDRZ3Voh2U8V+5iI2owuYCc0rDDgTYDAjgQ
         uTCOh74NWHOwWq8lG9fdGK1zhiINM44Gmh0juYho8f2Qg7dV79rFDbOn2or294toP/S3
         Rotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jIuix13JUAf2fKPblkQRtYtsiVGEtBQ5nv+j1oolzn4=;
        b=KKOqZbQR4zBeNVEjpEKzkMxDtSWd/D3ghwVucHrugWYcRlCUs2D/jRHIbP4Omeuark
         v45OHPfMBH6xDV+H9kG77feX+1ywBOqg5J3c2LxwE/DNVqiq0SFcmU0J2PlnhgQNJIg1
         MFs18SKRuc4ZT0EhSZDLmNRBSiSAe92dAbOlbTOgwWa8My4cBd0d4/atEA2uhlRH2xlZ
         U5V8k59lUa7Nc0Vs08ErI6KSJAtgEQGFf8uyPODEm3gI60ZwYiR27jga14iC0JWivlcH
         xJ5W+OFiUOoiTapEVQd23CVC2rrpiwB/UYRqEJ/6py5KGbDNjKw3SjDjCpsLBLw57wJ9
         vB4A==
X-Gm-Message-State: AA+aEWZSq6gNL64Pfx5qf97LVSGxFMSK9S7oi6V0zV86BBktKBzhJvgb
        U1SAIcpUi+E54d2s4STxltU=
X-Google-Smtp-Source: AFSGD/X9EkXjDkJERrScJM6idVZZM9mZCN0RJYZFn7HPT6KugRgO29UNzmouAEFwBwGfSKSjJ281iw==
X-Received: by 2002:a50:9ac4:: with SMTP id p62mr16101609edb.179.1545125309366;
        Tue, 18 Dec 2018 01:28:29 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id y53sm4318768edd.84.2018.12.18.01.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 01:28:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
        <20181213155817.27666-9-avarab@gmail.com>
        <87pnu51kac.fsf@evledraar.gmail.com>
        <20181214101232.GC13465@sigill.intra.peff.net>
        <87o99o1iot.fsf@evledraar.gmail.com>
        <20181217195713.GA10673@sigill.intra.peff.net>
        <20181217231452.GA13835@google.com>
        <874lbb209x.fsf@evledraar.gmail.com>
        <20181218000227.GB13835@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181218000227.GB13835@google.com>
Date:   Tue, 18 Dec 2018 10:28:27 +0100
Message-ID: <8736qv18w4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 18 2018, Jonathan Nieder wrote:

> Ævar Arnfjörð Bjarmason wrote:
>> On Mon, Dec 17 2018, Jonathan Nieder wrote:
>
>>> This would make per-branch ACLs (as implemented both by Gerrit and
>>> gitolite) an essentially useless feature, so please no.
>>
>> Doesn't Gerrit always use JGit?
>>
>> The discussion upthread is about what we should do about git.git's
>> version of this feature since we document it doesn't do its job from a
>> security / ACL standpoint, but that doesn't preclude other server
>> implementations from having a working version of this.
>>
>> But if gitolite is relying on this to hide refs, and if our security
>> docs are to be believed, then it's just providing security through
>> obscurity.
>
> Yes, Gerrit uses JGit.  JGit shares configuration with Git, so if we
> make that configuration in Git warn "This is just a placebo", then
> people will naturally assume that it's just a placebo in JGit, too.

Aside from the merits of this change it sounds like a good idea to
document the server options JGit shares with us somewhere, or have a
test mode similar to what I added in (but didn't follow-up on
integrating) in
https://public-inbox.org/git/20170516203712.15921-1-avarab@gmail.com/

> More importantly, if Git upstream stops caring about this use case,
> then the protocol and other features can evolve in directions that
> make it even harder to support.  I am willing to take on some of the
> burden of keeping it working, even when I do not run any servers that
> use plain Git (I do interact with many).
>
>> Like you I'm curious about a POC. The patch I submitted in
>> <20181217221625.1523-1-avarab@gmail.com> takes the "SECURITY" docs at
>> face value.
>
> One of the difficulties that security engineers have to deal with is
> living without absolutes.  In other words, their experience is
> constant risk/benefit tradeoffs: if you want 0% risk, then don't use a
> computer. ;-)
>
> If someone has thoughts on what would lead people to be comfortable
> with removing the SECURITY notice, then I'm happy to listen.  As
> already mentioned, I am strongly against abandoning this use case.

For me this would be docs backed up by tests (which can start as a ML
reply) showing a case where this actually works to hide data.

I.e. have a repo with "master" and a "root-password" branch, where the
"root-password" branch has content that's irresistible to "git repack"
for delta purposes, do we end up sending the "root-password" content
over on a fetch even when that branch isn't advertised & forbidden?

Or, if that fails are there ways to make it work? E.g. using hidden/* in
combination with delta islands?
