Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA21C20705
	for <e@80x24.org>; Thu,  7 Jul 2016 21:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbcGGVu5 (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 17:50:57 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35792 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbcGGVu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 17:50:57 -0400
Received: by mail-it0-f51.google.com with SMTP id j185so110417189ith.0
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 14:50:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tyISiVBz68Om/FQ8UX8lknYO7PqwfmjkZHFAJ4V6b9c=;
        b=PVj26FH/kX3My/Eu0EUg2Da7Ae00sp8TM1LT30LodOhuq3fwCkoho6bYEWr60u6kvD
         wDjXa9kD0WJK3jYKPTMHkTFxNu0re3pCz/UTJcxC6HRMuzr4gmhTP4HKips6NvtVhFsS
         uOJSiXMTGDfWQcLr0V9iVDoSyoA11oGsXEar7BKqKfkEXyj+/MOnBdA5p3JpXU+cU55t
         rZg4WqzzbpNcqj0DLiCnL79HxlnT3jzKbA3/4fVOzNB7C97nhBULAh7pi/abnrjvhp3H
         4p6HHyioyA9Ghrb0+mRBy5yWZx7OAKmZEAkpPz6v0ohjTs33UJtfLwHnn2D54Z4YxsQC
         PMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tyISiVBz68Om/FQ8UX8lknYO7PqwfmjkZHFAJ4V6b9c=;
        b=csoN5HhjzTTw5Xy7xomYI4r96dXiAeTD1Lv/NPaaXJUMWdJyAEcApTrR5JO49+q9/A
         fcKIkJ9mdK+dNoQu7py/YiXvl67RvrhrDd+NkEpB4LLQgtuU8woGmz7Q8HKPChxIy77M
         nLSa7Dsrp9kG0QbBD3amh/0IsYCth4uS4PRwD8ckNm6dMjNReHxQpPGwOACDPN+svi87
         SfX6g0WbML8fa2ydpbqdnWDMKQOHzJpi5jVBGImQ6qtYQOiJ3i4Z4kDRY7yfB9iVE1Rv
         cJHctLrFvYFstkre4tKTa9VsISyavrzmpQc8LJg/7DJRUR/jnJE2U3LGQkqMaf4yXcn+
         /SAg==
X-Gm-Message-State: ALyK8tLLlI4T33+Wzo20Ar02EHkWLCkBPq3tOcKtmDLXWP2m8Ew5HBXjPfQd/8FDjOQFqKoHY+hoCX5bHQYsZFHL
X-Received: by 10.36.91.80 with SMTP id g77mr82299itb.46.1467928256341; Thu,
 07 Jul 2016 14:50:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Thu, 7 Jul 2016 14:50:55 -0700 (PDT)
In-Reply-To: <xmqqeg75p5cn.fsf@gitster.mtv.corp.google.com>
References: <20160707011218.3690-1-sbeller@google.com> <20160707011218.3690-2-sbeller@google.com>
 <xmqqeg75p5cn.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 7 Jul 2016 14:50:55 -0700
Message-ID: <CAGZ79kb_oHZUv1=8Q0FSV8yVP5PrwStchXAyhZF=mHhv91APHQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 7, 2016 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> What is suboptimal about the structure of the series is that we
> won't bisect down to any of the potential bugs in the above code
> even if we ever see any bug in the future.
> It also does not hint
> where push_options is expected to be read in the code in the
> subsequent patches in the series.  If I were doing this series, I
> would probably have done 2/4 first without plumbing it through
> (i.e. it is sent and accumulated in a string list at the receiver,
> and then cleared and freed without being used), and then added the
> processing (i.e. this step) as the second patch.

But your first patch (2/4) would not yet advertise the capability?
Or advertise and then just ignoring it?

That shadows other bugs that would not properly bisect, I'd imagine?

It is better for documentation purposes in this patch though. It makes
the other patch harder as "it allows transmitting push options, but
in that patch nothing of value is done with them."

So I'll see if I can reorder easily.

Thanks,
Stefan
