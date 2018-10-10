Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC1E1F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 19:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJKCcK (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 22:32:10 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37381 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeJKCcK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 22:32:10 -0400
Received: by mail-ed1-f50.google.com with SMTP id c22-v6so5960054edc.4
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkjAZBoGAENjpzHOgxp7YeQLiR35GyKPD9W6PR8xrTY=;
        b=BuvuAMBUOI9SIL/r+WuLTGkmUUex930R6TH0ClKiqvtaIw/gBiIHSV/YkC0bCZjOgn
         JhmU3fN+e7MJ16HMULixQO2GmUByh71zjDFFFL+EyBkOpf/22eFDwIqZDAVy9tCYcjHW
         W0H3NpUF1tn8MMOx6j10byYmDcTY0bzQ3SEz+1QsbJI34DzlmEGbr/wq7IF/DnUgeXKd
         Xt+8R/3FAZz8Vq9zlLnzEbQuyxdec/BOKJrK8DOzxV5sV+g4KvYWLPLeWuA5SjksPqDT
         Rhb/cO2BJp9ZmJvLmJof/xanszq+W04ynxuN3Kv352S6XLnDFCTv/HtsIQz6GNa2Ofs3
         vfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkjAZBoGAENjpzHOgxp7YeQLiR35GyKPD9W6PR8xrTY=;
        b=nq+nL/z/idZ2IXyiQ55cfMJLONRoXfqJv1tV2oAMbpXh+JtE0Cd0rcpexTp52S9/XP
         LZcnf4iVGB35HPClwYeQJQrzqUazyYRXzzFMQ5LqZgqe64zcwuZI+5iFdxi9dQIh3eOp
         b28I9n3AYTQwXMUGJxxT6ZiYbob88mKwfVOIdZ9oq6TEDB3xN/cCmMIIFI3AcL6BjA55
         PiHVWv5jd4HA+LnOn+/fDxK5CxqjVjbwQTnAaIT2IO2RkExb27JJVxXqAD46w96fRClG
         NB5FZ1a9jOFl6mFPiFVfYBq5SAdmP5qxFhKMDLezzUGbUGMRRo66dmvAnyO9pgy+74H1
         xVog==
X-Gm-Message-State: ABuFfohBXflUFn8bziDysa6Hoq9BAffFPTke/UVBkPrJcV/xeKfZ0maq
        k95DjBoQ7J0TwhsNIwtLaykof4TxryGryn0iZSjdBW1tWeA=
X-Google-Smtp-Source: ACcGV62KKgtNWyOv65GKD849ablmgZ+opFrFahdkNMoQ4+8IbHiehvQ3povvmGC3bgR9FVKRmVQmfCBrbxXfmA09X78=
X-Received: by 2002:a50:ad16:: with SMTP id y22-v6mr45119200edc.191.1539198518365;
 Wed, 10 Oct 2018 12:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <87k1mta9x5.fsf@evledraar.gmail.com>
 <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com> <xmqqlg79tta8.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZq3xtsbscrRFD8CSn++yrvdM6Ux+nkQ3AamgabXtPL+w@mail.gmail.com>
 <xmqq4ldwszh8.fsf@gitster-ct.c.googlers.com> <CAGZ79ka5kKrSqPCWFMDetRLYxDqcguJUzJXDex9q-VMwT-ABAw@mail.gmail.com>
 <xmqqmurmobd3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmurmobd3.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 Oct 2018 12:08:26 -0700
Message-ID: <CAGZ79kbz6MmmCYGbNaK7hr9U6Kaq9ANiw69M2_WPdMvX_w3o6w@mail.gmail.com>
Subject: Re: What's so special about objects/17/ ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        nico@cam.org, Nick Alcock <nix@esperi.org.uk>,
        koreth@midwinter.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 9, 2018 at 6:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
> >> Oh, I think I misled you by saying "more important".
> >> ...
> > I do challenge the decision to take a hardcoded value, though, ...
>
> I do not find any reason why you need to say "though" here.

I caught myself using lots of filler-words lately.

  Though, however, I think, I would guess, IMHO....
  fills a lot of space without saying much.

I'll reduce that.

>  If you
> understood the message you are responding to that use of hardcoded
> value was chosen not to help the end-user experience, it should have
> been clear that we are in agreement.

We are, but for different reasons.

> I also sometimes find certain people here are unnecessarily
> combative in their discussion.  It this just some language issue?

certain people? ;-)
I have issues with ambiguity in communication directed towards me,
which is why I sometimes try to be very direct and blunt.
Other times I strive on ambiguity as well (mostly in my reviews).
