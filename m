Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE5520C39
	for <e@80x24.org>; Fri,  8 Dec 2017 18:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbdLHSDj (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:03:39 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:41077 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbdLHSDi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:03:38 -0500
Received: by mail-it0-f44.google.com with SMTP id x28so6643265ita.0
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 10:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5EQIAqVlZo68D8+rXSHcsosSUfm8H/zOzWOl7F9F9ng=;
        b=WrHP+Tgmqfy9+ZNxIQ1SiZQYrOVY7hl3AjMthZ7d3mylRestCQ80WYy9QWX+/80pUe
         QPyVXqeLgOHcoiGxliuyC36K4WRHs2PdGJCqOHLsPLF0V4DVhKbRNIv1YyxBuZ4ylKmc
         j4u3QxlqHfjdgO/fpCcyYTA6yniv0bKOugzHvG8Vby1XZovwhHDU0UI3qdrTeXHtVfXp
         mjULUuLW8gCff4W8UEBiYBidcDdaAe95ldNIuuPnD5HNSzkcLsKRaBr1MpLyh26Id7bz
         ylD4hdOA+0Sbpr9u19sOgNq0Nk1C+bZVJm7gls10zr9iJT48zL/Muxk/wKrzffbJLGXH
         SDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EQIAqVlZo68D8+rXSHcsosSUfm8H/zOzWOl7F9F9ng=;
        b=OPKqxOXDKyCEQguVb4iWb3ALTbhiH0DMPuv1TiUurZAS33n59SHfzil3tIdByKb9BW
         XHuwvwiT0Z2oJWeFDzZCjVHFhykbA0z0wJBwD0Gr4b7V4zFsTM7R+5h9SKca6LINNcbL
         r3NLfd646rutAsio1DCcbinL8KRd1JQ8ldLEkL9HDCISRlse3YfGVTHwrcCQFH4ZWpVn
         /7AB+n1Sgo5tr81Gl/cSOM4abzj5Tjssfws6vQnr5XrjGud9J6Tg0cGsxJU2hpHdSHdI
         KTkroxHjw3zLsWoVRMDaGo/BT5kcDBDGruOw+YpRLqiguWbzlsjGMCxZC3eEl5bq479g
         8Rrg==
X-Gm-Message-State: AKGB3mJG7ScIbbbJWdUQ/kDej77CFILY5c8u31at87I+fYgrITv6F4Sf
        JY50pSsoDusoZ+5IOu7S//oBuqD8UYs=
X-Google-Smtp-Source: ACJfBoslpXAeEWLOUF5MZl1hhP/W+pMFnGTqTio47CfZu4KotiIsohhJNZgSymN720ox8abphPSDqg==
X-Received: by 10.107.186.193 with SMTP id k184mr5109154iof.242.1512756217200;
        Fri, 08 Dec 2017 10:03:37 -0800 (PST)
Received: from google.com ([2620:0:100e:422:949a:89bd:af08:7a9c])
        by smtp.gmail.com with ESMTPSA id l66sm3642838ioa.29.2017.12.08.10.03.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Dec 2017 10:03:36 -0800 (PST)
Date:   Fri, 8 Dec 2017 10:03:34 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [WIP 01/15] pkt-line: introduce packet_read_with_status
Message-ID: <20171208180334.GF152943@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-2-bmwill@google.com>
 <CAGZ79kbV07BsKde1P_3EHjnSj7APTMQk+bbGx79X0nvpU2LD+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbV07BsKde1P_3EHjnSj7APTMQk+bbGx79X0nvpU2LD+Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Stefan Beller wrote:
> On Mon, Dec 4, 2017 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > diff --git a/pkt-line.h b/pkt-line.h
> > index 3dad583e2..f1545929b 100644
> > --- a/pkt-line.h
> > +++ b/pkt-line.h
> > @@ -60,8 +60,16 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
> >   * If options contains PACKET_READ_CHOMP_NEWLINE, a trailing newline (if
> >   * present) is removed from the buffer before returning.
> >   */
> > +enum packet_read_status {
> > +       PACKET_READ_ERROR = -1,
> > +       PACKET_READ_NORMAL,
> > +       PACKET_READ_FLUSH,
> > +};
> >  #define PACKET_READ_GENTLE_ON_EOF (1u<<0)
> >  #define PACKET_READ_CHOMP_NEWLINE (1u<<1)
> > +enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
> > +                                               char *buffer, unsigned size, int *pktlen,
> > +                                               int options);
> >  int packet_read(int fd, char **src_buffer, size_t *src_len, char
> >                 *buffer, unsigned size, int options);
> 
> The documentation that is preceding these lines is very specific to
> packet_read, e.g.
> 
>     If options does contain PACKET_READ_GENTLE_ON_EOF,
>     we will not die on condition 4 (truncated input), but instead return -1
> 
> which doesn't hold true for the _status version. Can you adapt the comment
> to explain both read functions?

Good point, I'll makes changes and document the _status version
separately.

-- 
Brandon Williams
