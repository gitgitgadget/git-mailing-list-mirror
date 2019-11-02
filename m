Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5961F454
	for <e@80x24.org>; Sat,  2 Nov 2019 00:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfKBAnq (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 20:43:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39339 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfKBAnq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 20:43:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id p12so7462682pgn.6
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 17:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SABbEbyCdikstQW7rDwUDF/wnWqLZT16LH5MQOuvg/w=;
        b=W3lS75xp4wQcaZOMYneN7DdLCkj/I65iIwEPsx4bY8KFODOlSokdOiMksStZfuo7p7
         aYWxSyYcbHIBrS+Ma8o/BPR7RVLZEE8VKqNzrhckxdYXP21P+s+4nMTLR6ddcGotZ3ug
         BBe1ar6lmZKw7u5J8ClJb4iHHWWxM3KYqFUpDPDE6EmfksK0VlHGTQBhn88+jMnWx/SQ
         LQOGlJt53WaygCQ1ziBWzsqamd33o90+mNbE60re7aoQeLDocEL0vpXZe+1lB7b1ccQX
         QBViIIrcklJDoPt6NPL7XWJVOIH4krszxl93h0JfK/noLlBsd1G6+nXQq8djPtX+VAV/
         r71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SABbEbyCdikstQW7rDwUDF/wnWqLZT16LH5MQOuvg/w=;
        b=ZstAUPvFDOFmuzjlSHQQ8C4Ehh/ZHJxIIYe0euDNYNL2biWaU7Hw9HgeMP7yBjsdO/
         +4vpbhPFHo00RtJg70zIJcc9e1Gnq0RqlkTSiD+NeJsyIJLiHV+TCiLJtv24fdRU2tCC
         VCg1ItcBCKprGWKvFc6WJhJkiDh2eKcIoYdwMsLl37AFIf3hcJqIZ8z7/gi0d2m67g0d
         hRNT7QVb0M9t6B6XFSGMa7OEVHZFxAUC6JFWhwhfbRxkqLHnbKOMYem51wZMlSudD5sD
         as0CmjX5l3QnX1nxtLOEgq3YWADBqHTERzTCtUu8RCLec+CjUHEhldSAPrM5K3xCqu6K
         5lOw==
X-Gm-Message-State: APjAAAUY0m6h859roM9lzsYgmJ3N112abTWVKOXrAtSdDKejPzjFMdbf
        QbzdiwlEAyBMA3PVjyvGWfWvfTcj
X-Google-Smtp-Source: APXvYqzjpslYz53n0HMbOYBOASUmniCCZy+lbCUz5x1AmQLm0AjyMUOOrTReeVBrBQtEeBWYhfLcww==
X-Received: by 2002:a17:90a:6346:: with SMTP id v6mr18813841pjs.4.1572655425416;
        Fri, 01 Nov 2019 17:43:45 -0700 (PDT)
Received: from localhost ([2402:800:6374:e1c2:8c5a:c959:6fca:fa1a])
        by smtp.gmail.com with ESMTPSA id a11sm7203131pgw.64.2019.11.01.17.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 17:43:44 -0700 (PDT)
Date:   Sat, 2 Nov 2019 07:43:42 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] configure.ac: define ICONV_OMITS_BOM if necessary
Message-ID: <20191102004342.GA17624@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1572596278.git.congdanhqx@gmail.com>
 <7c2c6f060393abf3ac831837e4bf8ed366c2fa69.1572596278.git.congdanhqx@gmail.com>
 <20191101165657.GC26219@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101165657.GC26219@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-01 12:56:57 -0400, Jeff King wrote:
> On Fri, Nov 01, 2019 at 03:25:10PM +0700, Doan Tran Cong Danh wrote:
> > +	v = (unsigned char)(out[0]) + (unsigned char)(out[1]);
> > +	return v != 0xfe + 0xff;
> 
> I wondered at first why not just:
> 
>   return v[0] != 0xfe || v[1] != 0xff;
> 
> but the answer is that you are catching BOMs of either endianness. We
> might at some point need to distinguish the two,

Yes, it's about catching BOM of either endianess. To distinguish
between LE and BE, it'll be better to use AC_C_BIGENDIAN instead (it's
friendlier for cross-compiling).

Anyway, we couldn't compare out[0] and out[1] with 0xf{e,f} directly
because char could be either signed (-2 and -1) or unsigned (0xfe, 0xff).
We must cast it to unsigned char (required to be 8 bits by POSIX),
then let the integer promotion promote it to int (at least 16 bits).

-- 
Danh
