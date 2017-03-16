Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DD6202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 05:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750892AbdCPFQL (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 01:16:11 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35971 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdCPFQK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 01:16:10 -0400
Received: by mail-pf0-f176.google.com with SMTP id o126so18837867pfb.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 22:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=60IyT68kQ2fbBckECT6+2SRUAq8kOkLiIwnm9FVL5E0=;
        b=styAKjZbRc0tDIZofG3Er2v7zWzGaMczSHV+Ecg15xtUCaodUj0UdRGQFXmPYD31eV
         O872KjxZzwz2G7+PhkNZ0X8wlpIpp9FFmT/gmn4HnIB/ObR8dBDLrXz3Glwka7hWpbqT
         GzUV/ffSn2XCAfbhoHBngBEu483C679wlrICV9YtMpuC5mcx1IpVVjYF2wgYw3IPnpu5
         7Vldv8CuWf9gwhj5qgabRzSSJDj8fhpnmUymajF9TtJh7UVSgKXBUY2GxIu8ql/4Qe8b
         qaki/njq+h+H13opZuz9F9PGUbyuYKgYBNptBjl9t88KCCUmHc+QaaFkCCo3seXscrIM
         sLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=60IyT68kQ2fbBckECT6+2SRUAq8kOkLiIwnm9FVL5E0=;
        b=FhblcU35MYBGUILBb08DZpHBXlIdXizSSm9/VXH3cJIMZ7te6924o9f8Ldw6FAOtf1
         6vcLO0946Dz97aa6Y9hrurjxbiHkXWSXcE4oX2fkwwEjQ/etc02+ffySucabNSq6w+AZ
         Hg4243nFe4NDKysfKT0a8TXmC6/yKCJmtNHAwSgdf0pz9sA94dcPDRV8gTn52ri9XqAd
         TOHW7/g+agugQmFGAXZxd9LOBT1m4EeZRxZ2be+SbLRRSJqLs8u/OC5YxyBDwLplFA/F
         u8xxjOFOepPSFIsgQE/TWj1ucQqRbcUVkUnUaOQt1T6bX1QejM2c4oLKDLBp3VjPiBCv
         WWEA==
X-Gm-Message-State: AFeK/H3/cHOnZUYYGIJed7MZdKQf9UF6RjXt2+r1zVid+bIap0JzW5rDE68BTUTyCw3hHipT966rdyN9a20oB+TZ
X-Received: by 10.84.195.129 with SMTP id j1mr9487700pld.88.1489641368706;
 Wed, 15 Mar 2017 22:16:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 15 Mar 2017 22:16:08 -0700 (PDT)
In-Reply-To: <xmqqvarac8hc.fsf@gitster.mtv.corp.google.com>
References: <20170316003332.30918-1-sbeller@google.com> <xmqqvarac8hc.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Mar 2017 22:16:08 -0700
Message-ID: <CAGZ79kZ7rWw=q6a2AomTw20DsU1h+7ou4i8A14a2bcg+asRwLA@mail.gmail.com>
Subject: Re: [RFC PATCH] short status: improve reporting for submodule changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 6:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> While we already have a porcelain2 layer for git-status, that is accurate
>> for submodules, users still like the way they are are used to of
>> 'status -s'.
>>
>> As a submodule has more state than a file potentially, we'll look at all
>> cases:
>>
>>    ------ new submodule commits
>>  /  ----- modified files
>>  | /   -- untracked files
>>  | |  /
>>  | | |   current / proposed reporting
>>  0 0 0     "  "     "  "
>>  0 0 1     " M"     " ?"
>>  0 1 0     " M"     " m"
>>  0 1 1     " M"     " m"
>>  1 0 0     " M"     " M"
>>  1 0 1     " M"     " M"
>>  1 1 0     " M"     " M"
>>  1 1 1     " M"     " M"
>
> You are essentialy saying that there are three levels, 1. with
> commit level difference, 2. the same commit with local mods, 3. no
> mods but with crufts, and instead of wasting 8 letters to express
> all combinations, the highest level is reported, right?  That sounds
> OK to me.  I am not sure if "?" is a good letter to use (doesn't it
> usually mean it is an untracked cruft?), though.

ok. it helped me, though, to picture all possibilities to come up with
what I consider best for each case. Yes in the end it can be described
as 'report highest bit'.

>
> Does the commit level difference really mean "has new commits"?  It
> probably is not new problem but an old mistake inherited from the
> current code, but I suspect that you're just comparing the commit
> bound in the index of the superproject and the HEAD commit in the
> submodule, in which case "newness" does not matter a bit---"is it
> the same or different?" is the question you are asking, I would
> think.

yes, I agree. That is the actual question asked.


>
>
