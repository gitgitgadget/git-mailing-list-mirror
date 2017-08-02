Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A758320899
	for <e@80x24.org>; Wed,  2 Aug 2017 17:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbdHBRcb (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 13:32:31 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33719 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbdHBRca (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 13:32:30 -0400
Received: by mail-lf0-f41.google.com with SMTP id d17so22976094lfe.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xLC1K64/2kkl+NqKzQ+bUcCZyHLZCBKmC+c2tczuCXI=;
        b=iNOdKasVyZXo3S42fAnE1BjpJENDO1ck3CrY6+khTJSC7qDi9yJp2u0S9/DtQkREgA
         l0tpJ/m9dNJJ8tEAmks4nP84b+2NX191jUI+SUcp1dWFab1oj3KaQNA9+LCWZ1VUUINL
         ZzYt2U3mdXLME8jRXOdR0zz6eRL/dbWQajC58l2x8/DgxDW7cZ3aFLhPhDDpSmDoX119
         WSZD7KHBPKxg6bsUkctewk0TwieJnWjT5Sv1LdPEUgVsNslbdpo7NPNL5WD9jlnZDW/u
         HWX3hvuaevgo/SA2T0VOSG13OixxDkIKMcZqe7zm+V7VWjfIBCGxF9B9YaKgpWAeJ2C+
         4w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xLC1K64/2kkl+NqKzQ+bUcCZyHLZCBKmC+c2tczuCXI=;
        b=hPU/ucNSyXjX8D4aRnSYTpLm9cMR+tZL3LNMJRLfl3uLCeB4TVwvldUAZpKryy3elv
         Xsos0khI8cyy7eKz1OiGTRTJ4S1YMppA1WsKmNkZ3fxZmIeBEmW4GvJoJIrve7D8syPB
         JtaY90t7j8fvwKb/6ZL+u9wOOzM6YnaSuMDMYdGfPrIpWaeSYmJ7i34g7Xeba7qUv+4R
         rqgV5ThRUXdq5McVGtIBHVcwTxu2Uk9fbPjS86n+zK3JgDU0OB4uyutZw4e92vKlVq1J
         ZHBersyVxJX5D7oLQWxnsi2rVPY4+knbvYNKdjI6PnI9GKgwiWU+VM3u9RuQvTeOf7JY
         qsNA==
X-Gm-Message-State: AIVw113MWnztSEKO6C840V2YhCYT/jsi+fSbBb8/uctSS/AZcZgY9nVV
        WcqIT2gOe0SOQIE4S8lOQKBOjhjPb/Wq
X-Received: by 10.46.69.6 with SMTP id s6mr9402864lja.40.1501695148477; Wed,
 02 Aug 2017 10:32:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 2 Aug 2017 10:32:27 -0700 (PDT)
In-Reply-To: <1501676577.1957.4.camel@gmail.com>
References: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
 <20170730161816.2412-1-kaarticsivaraam91196@gmail.com> <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
 <1501603171.1671.8.camel@gmail.com> <CAGZ79kY_NdBe1QjJWrLUkfDOk8Zrnopa945F1xBq=WFDNpRWMg@mail.gmail.com>
 <1501676577.1957.4.camel@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 2 Aug 2017 10:32:27 -0700
Message-ID: <CAGZ79kbCg+xdVE1U0dv8MJ6vUuWvraWQCMSzKOTBsOvtdSvkGg@mail.gmail.com>
Subject: Re: [RFC] The correct and consistent alternative to quote a command ?
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 2, 2017 at 5:22 AM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> On Tue, 2017-08-01 at 10:38 -0700, Stefan Beller wrote:
>> On Tue, Aug 1, 2017 at 8:59 AM, Kaartic Sivaraam wrote:
>> > I assume you mean the consistency in quoting i.e., you're expecting the
>> > patch to use (") instead of (') for quoting. Correct me, if I'm wrong.
>>
>> Actually I did not imply any expectation on the outcome, because I
>> do not know what the consistency end game looks like for this issue.
>>
>> So maybe we'd want to go with the currently most used way?
> On scanning through Documentation/SubmittingPatches, I saw that most of
> the commands were quoted using double quotes and chose to use it for
> this patch. I'm not sure if it's the right one to use.

Thanks for checking. I think it is a reasonable thing to do then.

>
> Changing the subject of this mail; hoping some one who has thoughts
> about this would dive-in.
>
>> (Are there only three? (a) with dash, (b) with single quotes and
>> (c) with double quotes?)
>
> --
> Kaartic
