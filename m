Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67409209B3
	for <e@80x24.org>; Sat, 10 Dec 2016 00:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbcLJA31 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 19:29:27 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32945 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbcLJA30 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 19:29:26 -0500
Received: by mail-pg0-f54.google.com with SMTP id 3so12949047pgd.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 16:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4QvXCIiXk+KaDFsmWhtrahafgoJgTjmwTOSzuxoM7zM=;
        b=esbVpp8IcYzpVoEZPDuImowLIzKFtQm9ko37hJmhI/0QRrMdVojhDECR6qluAYXRAr
         LDrD0/u0GRi0+dafDyVfUh+UtfoaRi7MJ1RQtFMB76KNvz5lms813C5wv72IOvDPmWXT
         75ofIkFED0KQ1lKRsffpVlJUFauonBO0T/uALzkSjK306Vr7sXOtP4QB4mKQnVdngU+L
         gacSQMTDXlgDnRo5BO80345mjgjq0YT4Zb7/qANLCUSV7ME/cqIqrjaSVxXcuMKCTJwL
         nyaBtLNkkI9BEGMh3z7MJkqYOsaS6bY2kq3yZZJBxn48LAwW8qrzZ4CDKM77xJIgnuN/
         PjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4QvXCIiXk+KaDFsmWhtrahafgoJgTjmwTOSzuxoM7zM=;
        b=I+ev2d0eGSb6igQUPCvKRtgaW0ICUoW1S8B0Z72jARTZsXhwzpJXpIwAxpelz9EUEk
         0RS5l+15M5MoalV62adE1z1BWIVjzchnb2vAPN2lDnwiIs5lbHTaJfgBuBkUDr6LQlt1
         G3jKoKhyWw3odZaMhD/Q1Tn8GCUSSGTq18a4AqT/gGqwxwz83KPqcxm10cL8Kqv1EwU4
         crSmtOAc/3mCi5y2nueFc8hB+gbn6wOZEYufmP+1O8lto8I7bI11y70OBMWFhJMMJ94i
         ASC+VrevIYArynuXWmeWQvV57lDQrGZPVMSd5EIIJgLOc0BJDag26f8lWMv5rKlf+PTB
         GOug==
X-Gm-Message-State: AKaTC01AsafY1j8GxPeBAUOCE3H8xtSaoGpFRQdB/c5eg9Yq6XNBaZvH7ZEibonmK+efGlpx
X-Received: by 10.84.216.10 with SMTP id m10mr162712725pli.131.1481329765852;
        Fri, 09 Dec 2016 16:29:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b541:bdf2:ef3a:110f])
        by smtp.gmail.com with ESMTPSA id y66sm60369017pgb.21.2016.12.09.16.29.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 16:29:24 -0800 (PST)
Date:   Fri, 9 Dec 2016 16:29:23 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 12/16] pathspec: create parse_long_magic function
Message-ID: <20161210002923.GG88637@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481223550-65277-13-git-send-email-bmwill@google.com>
 <xmqqwpf8pt0g.fsf@gitster.mtv.corp.google.com>
 <CAGZ79ka0P0rKF8QH3V0jC-O19eT0oaE+fJLGifbfmm3jC_SijA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka0P0rKF8QH3V0jC-O19eT0oaE+fJLGifbfmm3jC_SijA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09, Stefan Beller wrote:
> On Fri, Dec 9, 2016 at 3:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Brandon Williams <bmwill@google.com> writes:
> >
> >> Factor out the logic responsible for parsing long magic into its own
> >> function.  As well as hoist the prefix check logic outside of the inner
> >> loop as there isn't anything that needs to be done after matching
> >> "prefix:".
> >>
> >> Signed-off-by: Brandon Williams <bmwill@google.com>
> >
> > These refactoring changes look like they are all going in the good
> > direction.  Stefan's :(attr:<attribute spec>)path" changes however
> > have severe conflicts (e.g. the topic already does something similar
> > to this step and calls the factored-out function eat_long_magic()).
> >
> > My gut feeling is that we probably should ask Stefan's series to be
> > rebased on top of this series that cleans up pathspec implementation,
> > once it stabilizes.
> 
> Very much so.
> 
> Jonathan Nieder mentioned off list that he prefers to see that
> series rerolled without mutexes if possible. That is possible by
> creating the questions "struct attr_check" before preloading the
> index and then using the read only questions in the threaded code,
> to obtain answers fast; also no need for a mutex.
> 
> I did not look into that yet, though. So I think you could discard that
> series (again) until I find time to either redo the series or
> resend it with a proper explanation on why the approach above
> is not feasible.
> 
> >  We could probably go the other way around, but
> > logically it makes more sense to build "pathspec can also match
> > using attributes information" on top of a refactored codebase.
> >
> > Thoughts?
> 
> Please let the refactoring in in favor of the attr series.

Sounds good.  I only looked at your series briefly, but I'm hoping that
these refactoring changes I'm proposing make it relatively easy for you
to build on top of in the future.

-- 
Brandon Williams
