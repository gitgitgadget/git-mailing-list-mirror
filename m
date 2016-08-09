Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891F21F859
	for <e@80x24.org>; Tue,  9 Aug 2016 22:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbcHIWFc (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 18:05:32 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35375 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbcHIWFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 18:05:31 -0400
Received: by mail-it0-f45.google.com with SMTP id u186so24244821ita.0
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 15:05:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uIDtrenbizshMy4/REmROchWaxeGvSR1wMmofo7m+vA=;
        b=H2IaV/mP4+wjUk39EVApNYNHwp5s+jjqaH8NmECIHrR/THFgHaQVWL5T2ro+uCzQ14
         PDZ2Et+uTAd4ls4QP0MSsi3zPbd0aB/m0hjCmuzskyCK9FGu5E6He5YcSgsVZZ+DyLuj
         TmoShvZ2qPjcoy1xzW0cA2RyhKIJW8NwNnfzAq7Ui7puhR8vzquB4ujr5nGQjmyCDOrq
         Lp+3shxEeMx1VUXkyG6Y/q8Y6viXyp+cSOcIGS7nyehCsRlyX56BFIaG4RztefEDJU2F
         nyS4hybnLLJgdMx4gqZokcpLdO5BS05bSvbLZ77VA98/C9P4NvJIEiKYWiw7H8bzEkbS
         1enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uIDtrenbizshMy4/REmROchWaxeGvSR1wMmofo7m+vA=;
        b=AbtYXLiAC4CwADBg23hWwVmxCOdJ780N9ZPWteU1cvA/8+Tw7rjVXEQBDIz4af2yJT
         6fcKl8jUpQPhFqQBdu8mnPSgvp+yzobbQ++migPlLcXbSoVCfn/ZW0NScEFPE9YynUqB
         r61o5C7xkV5G+DdSzFImPXyNFkLWONz7OcDj2TtSxzVGyZWIGraMEQG4EGd3/rRuacgI
         Cm1RKSRCf3BOcwWz5QOuXPs9rNxB+8U1mOORSRpwCcmRCm/3yH/dYOKwJL0gd/JPWk6J
         SiFmYdFCrVAYaq7w0T3A23EBaWFJgOG7EHFkJFglnjhbDPhtKRXWnmz4/1Pj/x/yV9e8
         U1Vg==
X-Gm-Message-State: AEkoouumUjsm/pA4OnOc195AaDbFx/XwvZVma7MMNFB+tlK/1S1mtTTJawrVBNEm9ABXFZyZoM0P89w7gAULCzYM
X-Received: by 10.36.127.7 with SMTP id r7mr1573042itc.49.1470780308164; Tue,
 09 Aug 2016 15:05:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 15:05:07 -0700 (PDT)
In-Reply-To: <xmqqeg5x8vl4.fsf@gitster.mtv.corp.google.com>
References: <20160809040811.21408-1-sbeller@google.com> <xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZKTV5PCAR41O1t1c_y6N18u6gsoWozOfr=EPHic-7wYw@mail.gmail.com>
 <xmqq8tw5bzs1.fsf@gitster.mtv.corp.google.com> <CAGZ79kY8EiGaugsh4FxKYp1FxqYr10JfGqsrfsnhULB+OBnFXw@mail.gmail.com>
 <xmqq8tw5aijv.fsf@gitster.mtv.corp.google.com> <CAGZ79kbPvj6dU1DMaCh7ieJbs0qWimdHSD8xFfUyV98md2pywQ@mail.gmail.com>
 <xmqqeg5x8vl4.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 15:05:07 -0700
Message-ID: <CAGZ79kYkn6eVUBd_hXd4FSxr+y-iNTSsOfqdcKWBWp-aaVpAkQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> becomes easily doable (i.e. subsequent "submodule update" can realize
> that the submodule does not have alternates but it could borrow from
> the submodule in the other-super-project-location).

I would suggest to postpone this to a later time once the need arises.

I rather imagine that once you clone from "other-super-project-location"
and get the warning about no alternates borrowing, you can decide if you want
to set it up and link the submodule manually to that alternate, or if you just
don't care about this one repository being duplicated.

For now I plan to introduce 2 options, as these are 2 different things, that
can be extended independently of each other:

submodule.alternateLocation::
    Specifies how the submodules obtain alternates when submodules are
    cloned. Possible values are `no`, `superproject`.
    By default `no` is assumed, which doesn't add references. When the
    value is set to `superproject` the submodule to be cloned computes
    its alternates location relative to the superprojects alternate.

submodule.alternateErrorStrategy::
    Specifies how to treat errors with the alternates for a submodule
    as computed via `submodule.alternateLocation`. Possible values are
    `ignore`, `info`, `die`.

> *1* Rather, I meant: clone has a very intimate knowledge on what and
>     what cannot be borrowed from and it is not just "is there a
>     directory?", so "git submodule update --init" is not in a good
>     position to decide if it wants to add --reference to the
>     invocation of "git clone" it makes internally, and introducing
>     an "if-able" variant to "clone" is one way to relieve it from
>     having to make that decision.

That is how I first understood the design as well.

>
>     I could have suggested an alternative: because the submodule
>     machinery is gettting moved to C the "update --init" code that
>     drives the internal invocation of "git clone" could share the
>     the logic in "git clone --reference" that determines if a local
>     repository can be used as an alternate by small refactoring of
>     builtin/clone.c::add_one_reference().

I see. I might actually need to do this anyway as the helper is a place
to act on the submodule.alternateErrorStrategy.
