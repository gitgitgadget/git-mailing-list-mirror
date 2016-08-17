Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8631FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 18:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbcHQSrZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 14:47:25 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34741 "EHLO
	mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbcHQSrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 14:47:25 -0400
Received: by mail-ua0-f170.google.com with SMTP id k90so185503860uak.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 11:47:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pWqM2nLAIGDV2Rtgo7dBRCdHN+546BUeygZ3ERYAz6Y=;
        b=ELOP5adoTToy9uTKLBa6BwwQW0SHG9vtKw/4yEZwXs9DTwyuhMGaqQpg5Hxj/4SLBv
         QpWTUfzfg5lUKj1RoCMezKoTPHgwYLf465L4HDg+4jDbNdmaDyGYVn2jQtkzpzxyVI1J
         mbuSPhh5cv0zogcJ/vWEpkkaoC4eglPi5etoB5xKXGpnTRh8mKRuxgfPakZ6Ee47DVhV
         678mVdKlwicHJSHrh/i1DfAMyliwTxfMpjIfGFXtCiiSTawus4DuZM8AGbuAPaI4OS8Q
         QGsgk3Z3V81VMuHlS9hrpkDRbTnxNYIcfkP2fca4pjffKlpBGBXuk8w9zZ7Bg95nZyeX
         fC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pWqM2nLAIGDV2Rtgo7dBRCdHN+546BUeygZ3ERYAz6Y=;
        b=PEHldqTZF+7biINjF5c4PfaRz76WWr/5vs7hXKreUU17u0ds8VULyafWUpqd2XmzNT
         G0EO2BMVzD6qnzMXbVcRZgxjG68Z6Dg+lefixGHVdZ9X/tRl/Ty/cyQwTIRCa05DIngE
         DfLbKYrnPBIBy5x2TD55jkKtKz5D9BFjSwOHY2vA/IZCXRaqWPFpq6ucL310dO+UCvtf
         t44ngYz3BT8vrMpKm1Q4tTSGNpShGKkLi6jATam8PCdcZKp2PFJKNMx8s0JuB0T3cn6B
         KVeqhceH2qv7qa6GxfSjXW8HhfHtbKzPnbq9AuGcHRZPL21NS24ibQYoJKjddLXCkvFs
         kU9Q==
X-Gm-Message-State: AEkoouvZCMgJausksMGBNBzvgpuVtM1aq232wVwvMCfwaZyn3+xT6DOGr0UXlyxCPxL1ScYxXhfIX/pwJucIkw==
X-Received: by 10.159.33.184 with SMTP id 53mr16718498uac.32.1471459644259;
 Wed, 17 Aug 2016 11:47:24 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.4.230 with HTTP; Wed, 17 Aug 2016 11:47:23 -0700 (PDT)
In-Reply-To: <xmqq8tvv9rcd.fsf@gitster.mtv.corp.google.com>
References: <CAHd499D50TLMYtAovTF80ev0=2u=9yyMNcq6-he3Ba2kXzqW9g@mail.gmail.com>
 <xmqq8tvv9rcd.fsf@gitster.mtv.corp.google.com>
From:	Robert Dailey <rcdailey.lists@gmail.com>
Date:	Wed, 17 Aug 2016 13:47:23 -0500
X-Google-Sender-Auth: lLfvI4j_-XXKJDg3zGPJDUj46so
Message-ID: <CAHd499AP9VnQ8cVioc5aPQ7qUPdV=i70o58OW1Sh6uYOMf1W7Q@mail.gmail.com>
Subject: Re: diff --diff-filter on modified but locally deleted files
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 17, 2016 at 1:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> My use case is that I do a merge from branch A to branch B. Branch A
>> modified a file which is already deleted on B some time before the
>> merge.
>>
>> When I do a `git status -sb`, these locally deleted but remotely
>> modified files show up as "DU".
>>
>> I want to invoke git status or diff (or something else) to get a list
>> of these specific conflicts (locally deleted, remotely modified).
>
> As far as "git diff [--cached]" (which is "compare HEAD with the
> working tree through index") is concerned, these paths are in the
> "U"nmerged category, so you'd give "U" to diff-filter to view them.
> Of course, that would give you other kinds of unmerged entries.
>
> If you know they show up as DU, why not "grep DU" in that output?

I'm happy to do that and in fact considered it, but since
--diff-filter exists, I figured it might solve the problem. I also
need a better understanding of how diff-filter works since it
technically has 2 sides during a merge conflict. I guess it functions
only on the right (local) side.

Thanks Junio.
