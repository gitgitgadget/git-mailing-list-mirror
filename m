Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A524FC05027
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 00:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjBOA0t convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 14 Feb 2023 19:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBOA0r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 19:26:47 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B34B2F7A2
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 16:26:46 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so2430194pjd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 16:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QebsE+a8rxMI5pogGn2o6WfPj/kbKwXNCitl6XDOOiQ=;
        b=ndEEp/aKM84Wx8wwMPpwiOa5YSmkzWxRH3BXNwxmk2Y3eTvOCqXy2xPUX3nNg5CNjt
         sEi0eQxt1tkL+Q12IGWj7Rasbn2ZTb5EFeC6O4h6JsTNt95LPbnlUIwXr4H9rSdBNvRY
         jark9p/vGWWIQKPLttBtD+QyZjV7oqnzSYZCd9/wyZe9MjTR0ecERQVwKC9WPsau3MpX
         iChh3j75S+0ofO5yBVPhM7aP1wNFOWykzzEBCGxLRrk9av5tBQrnFZXDNTfFMDorBhgn
         3zbQC03t3hZCSfp+uRWuiA1OchJy303eKtPPm7XWQ+d0F7KOTTTcpArd0yPmGKzkK8vG
         EUbg==
X-Gm-Message-State: AO0yUKU6Lffi6pEYdDAZPZXTbSuogaIfaQuSRed8b0EGY2mKapbzjOe7
        dfWNo6x4e7EmRbNb3lIxkGN9zPHyqWyy8/L0teW200IG
X-Google-Smtp-Source: AK7set8ROUG+fmlTH95Qczh85QwKJBabtAzN31yPZ+pmw1R3cABR3X+rSnRzhTpwzZYcuj5YMxnCsG4HWuaiMssoNj8=
X-Received: by 2002:a17:90a:4107:b0:234:190f:87e6 with SMTP id
 u7-20020a17090a410700b00234190f87e6mr301319pjf.8.1676420805774; Tue, 14 Feb
 2023 16:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20230205145245.11078-1-cheskaqiqi@gmail.com> <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-4-cheskaqiqi@gmail.com> <xmqqlela2z3p.fsf@gitster.g>
 <CAMO4yUGmQ371hLCSTODQct+CzY2mqywfLzZO6fsgqN2=1cWGrw@mail.gmail.com> <230207.86h6vx51x3.gmgdl@evledraar.gmail.com>
In-Reply-To: <230207.86h6vx51x3.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 19:26:34 -0500
Message-ID: <CAPig+cTCd4kTM5xVpZv7joiXS+QZfLKVprY_1cpjg9T1_N6Pmw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 7, 2023 at 3:19 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Mon, Feb 06 2023, Shuqi Liang wrote:
> > On Mon, Feb 6, 2023 at 5:44 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> This creates a "test-patch" file with lines 'a' and 'b' that are
> >> common context lines without any whitespace before them, no?  The
> >> original left the necessary single space in front of them (see the
> >> line removed above).
> >
> > I try to change the code to(left the necessary single space in front
> > of 'a' and 'b':
> >
> > @@ -1,2 +1,3 @@
> > - a
> > - b
> > + a
> > + b
> > +c
> > EOF
> >
> > t4113-apply-ending.sh (Wstat: 256 Tests: 0 Failed: 0)
> > Result: FAIL.
> >
> > I'm stumped as to why it's still failing. I've tried searching for
> > answers on StackOverflow, but I still can't figure it out.
>
> But this is almost certainly that you're trying to insert leading
> whitespace into a line that's in a <<-EOF here-doc, the "-" part of that
> means that your leading whitespace is being stripped.

Almost. The `<<-` operator actually only strips leading TABs; other
whitespace following the TABs is left intact.
