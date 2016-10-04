Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67BDB20986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbcJDRs7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:48:59 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33935 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbcJDRs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:48:58 -0400
Received: by mail-qk0-f171.google.com with SMTP id j129so190313291qkd.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vxxey6d0PcxbRRJLMlRJAGcXXZJGB1UlYuwQrX1BPuo=;
        b=Af0LjlQn/vkb8NwtVwc3Aj4GrT7InrXBJv+H4FG0bNIxgudAdIh46hLaNYus1cgYym
         5ITTwsx70m1Q67Wck09h3LiOFkzpNgCntk1ZbEdg8j5MERdeRYRWD2iQqjVZWYx3DlBq
         X1guOVgSG+X6s9PpCg6HLXIeReGCVYHBQufXPCAmPkwdr7QhhSSTgSGnzpfbO14D2kVL
         cAHuDzcXZxjWbf/1jCdrSSSx8rI/NbS07PAY2IQ4YDEDgVRQ6g/V5/ebCQRsc38b3t+S
         B0iswa/kj1dc/SmBUAMnEAHWNk4FdeBRO7ZWTMqzfX3WheIaKWgQfQag9nhnGgNRODTi
         50Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vxxey6d0PcxbRRJLMlRJAGcXXZJGB1UlYuwQrX1BPuo=;
        b=a9A+1q73XS4BOSljuUkd1tvDgk66IxM+JJcfGIo9ZC8iipIbVq+ngStVQa3l9PnNSn
         fTXWQQ7DmeoNYwWVYs0A7afCHmobXDm5wl9J+E5uXuvUSSK9oKBGc63wLd+5HHWB+ib7
         qSFm9/+JHC5N1vYhM202E9eIXy1KBldu839xhf4zyxA3fYcqn3B3TF0hrhwc9mRXIllA
         ZMnpKdG4TcyOEm2ZXWkgD59jLo6Li32WbqxWdeLFKwpGeoiic02VNEMSraNOmVruif7q
         KI1LhVtqS+nA+3VZruQJsjWfxOIhVbX/v/ehSQd3sMD7zLb2F1uBdbrwVz7i9YZPPg3m
         X4LQ==
X-Gm-Message-State: AA6/9Rlkh9/9vuVuX/LC2gXtCtf7awcgapBnneXvIoxef5/jRgD8kpvh0G105wC1CgErYo7Reg4bahKWfuqBHyCj
X-Received: by 10.55.56.11 with SMTP id f11mr4772181qka.255.1475603332296;
 Tue, 04 Oct 2016 10:48:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 4 Oct 2016 10:48:51 -0700 (PDT)
In-Reply-To: <20161004173430.eax4ptohyonc5bw2@sigill.intra.peff.net>
References: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
 <20161004164036.6584-1-sbeller@google.com> <20161004173430.eax4ptohyonc5bw2@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 10:48:51 -0700
Message-ID: <CAGZ79kaKOjqLBsNVSmudzLUCkOJf_CsFGE8OZZHsTmuXCfiVeg@mail.gmail.com>
Subject: Re: [PATCH] push: change submodule default to check
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 10:34 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2016 at 09:40:36AM -0700, Stefan Beller wrote:
>
>> >> Why should we even have a default different from today's?  If most
>> >> repositories don't have submodules enabled at all, we can just let
>> >> those working with submodules enabled to toggle their configuration
>> >> and that is an very easy to understand solution, no?
>> >
>> > You will not see any complaint from me on that. I was taking for granted
>> > that the current default is inconvenient to submodule users, but I don't
>> > have any experience myself.
>> >
>>
>> And there I was trying to help submodule users not shoot in their foot.
>
> Sorry if my reply came off as snarky.

Yeah, sorry about starting being snarky here.

>>
>> +static void preset_submodule_default(void)
>> +{
>> +     if (file_exists(".gitmodules"))
>> +             recurse_submodules = RECURSE_SUBMODULES_CHECK;
>> +     else
>> +             recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>> +}
>
> This does seem like a reasonable heuristic. I wonder if you want to
> confirm that we actually have a worktree (and are in it) before looking
> at file_exists(). It's unlikely that looking at ".gitmodules" in a bare
> repo would trigger in practice, but it does not hurt to be careful.

In a bare repo we'd rather want to check for an entry of .gitmodules in HEAD ?

I considered it a non issue, as I don't think many people push from
bare repositories.
So if we were to check in the HEAD tree instead of the file system, why would we
apply different rules for bare and non bare repositories? We probably
would not want
to do that, so is it reasonable to check for the .gitmodules in the HEAD tree in
general in the non bare case? I dunno, it sounds like an equally cheap heuristic
covering most cases.

Here is another thought:
.gitmodules may not exist (either in working dir or in HEADs git
tree), so maybe the
"correct" heuristic is to check for directories in $GIT_DIR/modules/
That is "more correct", because it is inconceivable to change the submodule
pointers without having the submodules checked out. (Who would do that? Why?)

>
> -Peff
