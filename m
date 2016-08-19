Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275841F859
	for <e@80x24.org>; Fri, 19 Aug 2016 22:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755791AbcHSWAz (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 18:00:55 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:34513 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755729AbcHSWAx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 18:00:53 -0400
Received: by mail-yb0-f181.google.com with SMTP id d10so20072072ybi.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T+E/oQy/9n7/qgy3EvMao4bS8+bInpRbvd+ByvSuoLs=;
        b=mpQiJru5cOhLlBFikr8yL71azMutcDiI/cIr3Kxz4kO/bgydvRXZF7nHwOnRVh82t8
         LsndahveDRRA9PHn/obyQp76GUzx9/ott4JSwwV1mrcWElsapBDiTcDfxqUAIbxyV/yI
         pcjmMu0M/FRo9RM2Rn4dyqkFaXULXCQMRqLhKBm6TZePg+H2ysX54k5LnkfxUAlr6HRB
         6YAuy+/0rScwWaB/S0/deZL7iaGtTXrpEBCrLp3Aym2H4UHgQrIrIkceRXDslgi91MdH
         3ScliNjO5Bf0zrDkhY1C5IE59LDZY0qjvC2nzTBDvdx6/9wVroJyd7ikH8DTEzZsVbx3
         WlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T+E/oQy/9n7/qgy3EvMao4bS8+bInpRbvd+ByvSuoLs=;
        b=C46ZE5zBkOfoOqH8OxoWWsGZNnIsLGNzDGti1wlnnofD/Ni9lT2++gD4tz97Fb0rNC
         UQNtt90VxGTdVN+EItP7s4+YuHLvAVJLz3LQK5MGbAgDA7LxuqZ6MPI4NA5t22TzHbGv
         EUD5sklBlyW/ou9Eih1ZjqXDqdMVOnQpsg5SNMyJXj2Klxi/GOVOwFXNUHgzMDrm052r
         A0AW+7PzApJV3feUNsVNRA+0tt2/eg431yGeNqqZ0fb+0bmush+EkvtLBsHh+lk6nV8l
         OQVCGfeFnJ0uCU22lgdpC7K5NcIwB1fDkG4jX4XGJ2sLBwtbggg3H3Q9Lix3ecyqdXxR
         tJ5w==
X-Gm-Message-State: AEkoouueT4um2GJXw7QSrpqwxLI1UuKR0B+99jYp5omL6fVlRc04czNcJ/xMuLCc+B+wbip2xwE2IE5NPzWMQw==
X-Received: by 10.37.119.134 with SMTP id s128mr8023468ybc.58.1471644052650;
 Fri, 19 Aug 2016 15:00:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Fri, 19 Aug 2016 15:00:30 -0700 (PDT)
In-Reply-To: <xmqqy43szcom.fsf@gitster.mtv.corp.google.com>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
 <20160819000031.24854-5-jacob.e.keller@intel.com> <xmqqvayw1q1z.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xrFkCbLyvXKt1PKYsdFH2rCmjdMEyB27sDEScvGhxs7XA@mail.gmail.com> <xmqqy43szcom.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Aug 2016 15:00:30 -0700
Message-ID: <CA+P7+xoy+dNY_LVZC4auavHZtPg-tKs_iwaBJF6kgYv_u+ubEA@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] submodule: allow add_submodule_odb to work even if
 path is not checked out
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> submodule. I think we already have the complete path. Or is the name
>> *not* equivalent to the path?
>
> A submodule that is bound to top-level at "path" originally gets
> "path" as its name.  If you move it elsewhere, you do not want it to
> lose its identity (and its place in .git/modules/* of the
> top-level).  so a submodule whose name is "path" can reside in the
> new place after such a move.
>

Is there a way to do this lookup? I couldn't find it.

>> There was no empty line in the place I copied from.
>
> Is that "because I copied from a source that is mistaken, I refuse
> to make it right"?  Or just an explanation why there is a mistake?
> Or something else (like "we should update the original one while we
> are at it as a pure clean-up")?

That was an explanation for "I didn't understand that was a mistake"
and a "if we fix this we might want to fix them also to avoid this
same problem in the future".

>
>> If we put them in test_expect_success setup they aren't.
>
> Yes, that is why I said they are unnecessary.  Let's minimize the
> amount of random code that sits outside the control of the test
> framework (i.e. test_expect_{success,failure}).
>

Yes I agree.

Thanks,
Jake

> Thanks.
