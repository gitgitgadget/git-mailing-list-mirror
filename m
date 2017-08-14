Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547BD20899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbdHNW3X (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:29:23 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35855 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbdHNW2w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:28:52 -0400
Received: by mail-yw0-f170.google.com with SMTP id u207so63196329ywc.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=57d5B2/lRP/RP/MmRvTicits9RactMYdBz8W4C84v4Q=;
        b=eB7IULewNJnT4xqokMgEVVtlSXKR/NYW1fa+fs0BfHP26t0aQbA0cOSHsZf63zp6ne
         dX+OSNMiG6/Hby1nzQom9PqJ5IZLCR4sSp9fOSX3wmEFoRLEOo8wc+2esZ2FG5CrDV6X
         gRRh5lHM6nO3oazNPswck/WpJJR4iwrZOPx8fr3BMiyoi5RH6m02jc1++gDaTcczum+M
         frF2q4BbK/Bhtkoz+zCrc22x1robbMx9pAbpoZfxIlfatugop/W8xDwbSUhS8Dk7keUH
         zgFEzcID4xkXTYEPAuclJDEHWGE9DtGiBF70LCvoIUJuzBBJGhSITYe0hiD+LNtu31HE
         aopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=57d5B2/lRP/RP/MmRvTicits9RactMYdBz8W4C84v4Q=;
        b=FGhSnNYZHE7BanB+gV9PF6rDIsLrJB1hlANfsnjdNt1CNcAOZbigegt1OqSirrQt4K
         AwNU2QhMDoMfz/eWFtZ8OXZtvJ9Nz0WqUYLzZDolouEMsGKlvuQRNbdZTDxnM/z+iYny
         SM0j3prsd53vixOZibU1ZGFvkSx3o4xIQCAwxk9xyYnzScYAo+2hmbj3xOdsSG5PnA/N
         /+9dTZyFnGvv4bxlUcNVcPKRh1PICJ0ccLDKMh53eQxkAAykgS7+wLWn2gGgYWp4hBOI
         FExCFFTRDmi3o60oC17Q+3azreYJZKPXDig56rTlGkeupjIm265VdpMJxkb+IKSz+Den
         0Hzw==
X-Gm-Message-State: AHYfb5h9Buo7xsHM+V7WbVFSXChvyRfV3vmJJEwTWBh7CR2/0Pu2EIRE
        jUJDygn/IJPWK62kKj8QCppKGTmHIlaO
X-Received: by 10.37.55.79 with SMTP id e76mr21376312yba.215.1502749731173;
 Mon, 14 Aug 2017 15:28:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 14 Aug 2017 15:28:50 -0700 (PDT)
In-Reply-To: <xmqqd17xu6qg.fsf@gitster.mtv.corp.google.com>
References: <20170808012554.186051-1-bmwill@google.com> <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-3-bmwill@google.com> <xmqqd17xu6qg.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 15:28:50 -0700
Message-ID: <CAGZ79kbAp0p8-y-UpamU0J65A2P0B9r7KEWM0ZCBv=x4E77sGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: add style build rule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, Ben Peart <peartben@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> Add the 'style' build rule which will run git-clang-format on the diff
>> between HEAD and the current worktree.  The result is a diff of
>> suggested changes.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>  Makefile | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index ba4359ef8..acfd096b7 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2414,6 +2414,10 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>>  .PHONY: sparse $(SP_OBJ)
>>  sparse: $(SP_OBJ)
>>
>> +.PHONY: style
>> +style:
>> +     git clang-format --style file --diff --extensions c,h
>
> Did we get "git clang-format" subcommand, or is "s/git //" implied
> somewhere?

You need to have clang-format installed (debian/Ubuntu package, or
however it is named in your distribution), which provides this command
for us.
