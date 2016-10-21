Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA68520229
	for <e@80x24.org>; Fri, 21 Oct 2016 20:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934775AbcJUU4W (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 16:56:22 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36354 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934765AbcJUU4U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 16:56:20 -0400
Received: by mail-qk0-f172.google.com with SMTP id o68so170515003qkf.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4wsb6dfRtSk3EVXLUwKZM9EuyVgYuT7a16l+PWv5Cpw=;
        b=Rd8gY+PsWt8Wvd0VJHXFJiaDtrhS5OXtoWupwUSiiVXFu+ABitUUav+XBEXovX+esL
         1fbkkWo/Cp3cUMulafHHM3p8/BlcZezbdiXp9IeRcJfEZV314itdNfJPcKM5OIt/b9oD
         w2pcshk29ZvQVrPjPL2lu6NTcNivGb+GVN9QDw+q3aP4Bivzc20DSYnkNwS8oANpKOAp
         WSnqd/IwPYAEH3ZBDAlxXhzlm9fIFJTis5ISJmS546hL3z8+GTRdxyGpwIq+gCkQZoj6
         heZe2iWUUdvoRqDpFS30mYOEOh73QLjo08mO7cGrULwpAfC9zdT4WD7N8iJ2U/fIfwHD
         b2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4wsb6dfRtSk3EVXLUwKZM9EuyVgYuT7a16l+PWv5Cpw=;
        b=MIHXZrOLT+mjIwo3XEJrnGr5P1Z1vjurhSTxCMsJtCCyA5vkj3diqf9CxK/VL/ZAPb
         Lijdff9aGFfD3tlahArKmq7yADjKXSDhTv94OE2UlsHtOGJWNN1Yw1VMwn/VioIACg1P
         ClEwFnwyt+IkvfdM+atDwKCEFItetIc01iOqqkN6ucmeEkwpFrJyB1dpWbOYeKk1rvkj
         PJRlPcH5o0DiBRu7clcR34aU7aNRX4ldNOdVJURawG5RRQtz+bw2cwYroZhEOPtp+/yw
         k03ARtWp6bs7LwCiiXexHGFFumINN85jvwAS3jfPcX4Q4DN78TiObt7mna0Tx4FHQmJ5
         CF/Q==
X-Gm-Message-State: ABUngvcuOq9ENJx9Z828OSvm+ygzIZVU4b16houLJTF7gVmlXSZsVw5xZ7enqumSzn1oqbtWRLEF7O/pkgNn32QZ
X-Received: by 10.55.142.130 with SMTP id q124mr3198549qkd.220.1477083379788;
 Fri, 21 Oct 2016 13:56:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 21 Oct 2016 13:56:19 -0700 (PDT)
In-Reply-To: <xmqqwph5m6th.fsf@gitster.mtv.corp.google.com>
References: <20161018210623.32696-1-sbeller@google.com> <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
 <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com> <CAGZ79kZHLVpxbJ_C-dM2LDA64-_TJNyY+52fTWkOvLvvAq2XDg@mail.gmail.com>
 <xmqq60opnolz.fsf@gitster.mtv.corp.google.com> <CAGZ79kYrKGLEOO72aWuX5OOM-AecdFZFXRqBkRzhdAM-VbPFxA@mail.gmail.com>
 <xmqqwph5m6th.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 21 Oct 2016 13:56:19 -0700
Message-ID: <CAGZ79kYXyUr9qets_xkHU4NekSz2J67=Pheu=fTq5ztx0gRu2w@mail.gmail.com>
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 7:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I am not sure.  Certainly we would want to make sure that the normal
>>> case (i.e. no funny trailing junk) to work correctly, but we do want
>>> to protect the fix from future breakage as well, no?
>>
>> Exactly. So not intermediate "root" that we clone from, but adapting the
>> relative URLs. Maybe half the broken tests can switch to 'root' and the others
>> go with the current behavior of cloning . to super.
>>>
>>> Perhaps we can do a preliminary step to update tests to primarily
>>> check the cases that do not involve URL with trailing "/." by either
>>> doing that double clone, or more preferrably, clone from "$(pwd)"
>>> and adjust the incorrect submodule reference that have been relying
>>> on the buggy behaviour.  With that "root" trick, the test would pass
>>> with or without the fix under discussion, right?
>>
>> I assume so, (not tested).
>
> OK.  Thanks for sticking with it.

Ok, the root trick works fine without the fix, however we preferrably
want to fix it
without double cloning, then the fix becomes a bit harder to follow:

instead of

    git clone . super

we do

    git clone "$(pwd)" super &&
    git -C super config --unset remote.origin.url &&

instead, such that the relative urls work the same way.
(The super becomes its own authoritative source of truth with no upstream.
In that case the url is relative to the superproject, e.g.

    git -C super submodule add ../submodule

will then resolve the relative path from super/../submodule to be just
as before, where
we bugily used $(git config remote.origin.url =
...super/.)/../submodule, which due to the
but resolved to the submodule as well (as /. was counted as a directory).
