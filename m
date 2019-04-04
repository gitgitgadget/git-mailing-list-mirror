Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B111E20248
	for <e@80x24.org>; Thu,  4 Apr 2019 18:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfDDSG6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 14:06:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47015 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDDSG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 14:06:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so4874785wrw.13
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to
         :accept-language:user-agent;
        bh=RdfNiC7gPjQKchqIFYoNIVJH+b5D0Nxc0sEuiDFBnKQ=;
        b=I+DSclWENhEzBoedGvEj4k5no3rblZ2kRduVSCgTHtF/Tqo+mJ3zX5YWENhv2S4g2F
         gXookbAZgbC5I7SMlqdF88CP/73WgUmcW9F1Z9byLzwqk7Ozq3n/YDc20Pb3fVoimTxQ
         ty9fyJjJvJdDizXwkCVj8WeFMhR8JVX6vQZ8FAJLXn0NTnrkiYBFLDQQXhkf9XoQn+Tq
         9PTp5MwQCwkYn0CE48r0gbSxD1k/t/N7c5igGx3xS8EuarzjdjduYzYbaaIV4GXPU8qP
         yYbHL/wTorFcF3ewbaug4GPMTKCZeeuFhC8cyx1WT335XItJqZnLHkSO/uvOu4aJM5vN
         i6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:accept-language:user-agent;
        bh=RdfNiC7gPjQKchqIFYoNIVJH+b5D0Nxc0sEuiDFBnKQ=;
        b=DEhMQ/I8UxCMykhyXooIcWcOTJhKAA3+stJnsQXsGfKPXpG2XQdfWo+yOWAHyqsmXf
         KU5RuwoDPakB5jSEbd2OzlEkWLXGXBIU8+u6PrUgW0L39Eg/1b0TYtl/qKwoxCPOM4+S
         4Gon1HX0DBZxqteh8Ylkx8In7i4AIN9lA7gN40zL04Cp9M8UVpwTRLf6ZB4vNdbllo2o
         8avUEg7rcL0B3zeaxwljmJSl66i+OzN9PhYACxb7hn+c61i9YugXHGkHWO69v2rZd8V2
         1Tu9KiSx0BIrC2KCXcNZBAa4asl2GW6fv5JvYcMNit9rnVBRI8WC8pOXdw60C5taANVT
         VESA==
X-Gm-Message-State: APjAAAVdu6js2nEvA+4H71XeOyfislBAwkn0tfEYPNwvXyY1RvAI+p7Q
        7k3ofpRFwRigvWw9Oxz/0jk=
X-Google-Smtp-Source: APXvYqxRzy4DD5PSC9/e8oUbLc2iZKIcWxV0XcuMfVacgECI4t6GJGaT0HboQeFwocz9pnMSta242g==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr5004187wro.293.1554401216473;
        Thu, 04 Apr 2019 11:06:56 -0700 (PDT)
Received: from jak-t480s ([2a02:908:2813:42c0:fdb4:7ddd:ea6b:efd2])
        by smtp.gmail.com with ESMTPSA id d3sm31539432wmf.46.2019.04.04.11.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 11:06:55 -0700 (PDT)
Date:   Thu, 4 Apr 2019 20:06:53 +0200
From:   Julian Andres Klode <jak@jak-linux.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "Problems" with git format-patch --thread email header ordering
Message-ID: <20190404180653.curtoo7yot6tpqfk@jak-t480s>
Mail-Followup-To: Julian Andres Klode <jak@jak-linux.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
References: <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>
 <xmqqk1h09224.fsf@gitster-ct.c.googlers.com>
 <CAHk-=whe+R7fkTi0eBnhrBY=_k_du3e5dkNsVe=HgKXLoXekdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whe+R7fkTi0eBnhrBY=_k_du3e5dkNsVe=HgKXLoXekdg@mail.gmail.com>
Accept-Language: de-DE, de, en-GB, en-US, en
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 09:59:25AM -0700, Linus Torvalds wrote:
> On Thu, Mar 14, 2019 at 9:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> > > While it's true that header ordering isn't specified, there's a common
> > > "canonical" order that the headers are listed in. To quote rfc822:
> > > ...
> > >             body must occur AFTER  the  headers.   It  is  recommended
> > >             that,  if  present,  headers be sent in the order "Return-
> > >             Path", "Received", "Date",  "From",  "Subject",  "Sender",
> > >             "To", "cc", etc.
> >
> > I obviously won't do the last one myself, but if the issue is only
> > to swap from and date, then this may be sufficient, perhaps?
> 
> I'm not actually sure _what_ the order requirements for gmail are,
> since gmail itself doesn't seem to honor them. Does the order of the
> Message-ID header line matter, for example?
> 
> I don't think it's the order of the From/Date lines, actually, because
> google itself doesn't do that.
> 
> What Thomas Found out was that the exact same email with
> 
>     Message-Id/From/Date/Subject/To
> 
> (in that order) does not work, but
> 
>     Date/From/Subject/To/Message-Id
> 
> does work. Weird and "wonderful". But there might be a lot of other
> orderings that work or don't.
> 
> Having looked through some other emails, I know that
> 
>     From/To/Subject/Date/Message-Id
>     Subject/To/References/From/Message-ID/Date
> 
> also works.  Which makes me suspect that it's the Message-ID line that matters.

I also know that gmail rewrites the Message-ID / creates one if it is
missing or "odd" (such as ends in a .). It those probably makes sense
in that twisted world view to require that to be fairly late...

-- 
debian developer - deb.li/jak | jak-linux.org - free software dev
ubuntu core developer                              i speak de, en
