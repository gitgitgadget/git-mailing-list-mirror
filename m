Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5071F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 01:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfAPBNQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 20:13:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36996 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfAPBNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 20:13:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so2146356plr.4
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 17:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UEXP7mw8wgDfN/6qrhZdH2MbR8Fwuqs8RPcOfS+wnkU=;
        b=sDoqsGQ9t/bEPwbhGDKxJ9AHTt2rzlUG0mVARb22vvmSMrL+g1QJWJkXZcSXZsfXIy
         ZgdipaBmxAv75iwh7xKp98sf2AG838WyhZXyeCEGtfNRFL4GQfoCB4tPnZoK2KefZlJ9
         6O3ybP1rGJIVjm4R9PBqsk5nQzyRX2kNw6TJuaS50+NuuEY2Te4TZSFkop9RAfS4Jatd
         juj4CpgKm5LPoHwm4hwD8cfIMW/UmF+HwHvNp+nFPAdBS/9VgAKIzXhp6MqJhFOyLtiB
         W2NXolj6Nw1dUYhBVel98kb7y2U+FCwDD3USH7SGsLAiZLN6FHIzxcN+R4iQIu/8lxif
         wdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UEXP7mw8wgDfN/6qrhZdH2MbR8Fwuqs8RPcOfS+wnkU=;
        b=g4AkeKR7nhNNN/OZdv33F8E9Zwf7MGrH3thIxcXYiCYT1AXxRZxp/1BbBcvupDm5bQ
         PWzNIbskhHIrcSq+9Th63giK4Cn68FHyCH7ljpPmTVD3+N0RSiGx/OsKPGNRdFoZ3GVw
         E8tJMX09k29wBLUxJ7SvmIL+d5bOWkuYfZTYorf+P3NGOrlc3Xhc1GN23VV8zImFzk6Y
         sLDVURrbVp/cMCmXMhG/MLz3/aR1j4qY82lzH9Sq0H8uPQYOIRhyc3AiFS+9Cxv1bNHu
         zpxFIBmRi/+4mlGjCKpJA9DFVuOPl78N7KaHgL3ZUrylNMwG+ezAnQfU87ACV6D3inE6
         I0nA==
X-Gm-Message-State: AJcUukcenCy2kOuf9a3p9y9x/bArEIzf8c4XRuaukEPXb87TdtdD8KfE
        KUclaUqsdYFSGkHwJrBrKfQ=
X-Google-Smtp-Source: ALg8bN7rzyCFP4GKIoWgki6tVdyXPcp689lShk4bLNDnyPKshPY+kn8zHcqepDihbWEJUix4p5SR/g==
X-Received: by 2002:a17:902:a40f:: with SMTP id p15mr7188882plq.286.1547601194620;
        Tue, 15 Jan 2019 17:13:14 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id g28sm6214008pfd.100.2019.01.15.17.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 17:13:13 -0800 (PST)
Date:   Tue, 15 Jan 2019 17:13:11 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] compat/obstack: fix -Wcast-function-type warnings
Message-ID: <20190116011311.GA8864@google.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20181220162452.17732-2-szeder.dev@gmail.com>
 <87zhszeqsr.fsf@evledraar.gmail.com>
 <xmqqef9k1a4n.fsf@gitster-ct.c.googlers.com>
 <20190111003743.GA840@szeder.dev>
 <xmqq4lafysve.fsf@gitster-ct.c.googlers.com>
 <20190111185118.GD840@szeder.dev>
 <20190115235546.GF840@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115235546.GF840@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

SZEDER Gábor wrote:
> On Fri, Jan 11, 2019 at 07:51:18PM +0100, SZEDER Gábor wrote:

>> As to re-importing obstack.{c,h} from upstream, we've made some
>> portability fixes to these files, and neither of the commit messages
>> of those fixes mention that they are backports from upstream.  OTOH,
>> one of those commits mentions platforms like
>> "i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1, SunOS 5.10", which makes
>> me suspect that the re-import will be susceptible to those portability
>> issues again.  Therefore, I think re-importing these files from
>> upstream is beyond the scope of this patch series (and might not be
>> the right thing at all).
>
> gnulib's obstack.{c,h} doesn't fix the issues that we've fixed in
> 3254310863 (obstack.c: Fix some sparse warnings, 2011-09-11) and
> d190a0875f (obstack: Fix portability issues, 2011-08-28).  So if we
> were to re-import from gnulib, then these two patches would have to be
> applied on top yet again.

Thanks for looking into it.  The former looks applicable to upstream,
while the latter appears to do some Git-specific things (e.g. relying
on git-compat-util.h).

Mind if I send the former upstream?  I believe gnulib upstream relies
on copyright assignment, so it would help if you have a copyright
assignment for the project on file, but if not, they may consider it a
small enough change to take without.

Thanks,
Jonathan
