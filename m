Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB26201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 09:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbdB0J6L (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 04:58:11 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34929 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbdB0J6H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 04:58:07 -0500
Received: by mail-wm0-f68.google.com with SMTP id u63so12525312wmu.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 01:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U6RFo6bCNbUzsvtkCBFSYaUfHQeIB3hnc3VMLOIKRb8=;
        b=VcuMheWUUySjgJio9PTDcYiggc68c/jhOk2cicswkxhCLxlWJBS9DmgaU+ph0aqJNw
         z6T9jijrEhRWMKXMOIxW0z/dBZ9vxOptC+gThkQeZFWen4MqQEzhdpaHR/cZo5AaA87o
         qY26TjUWFO+y9XC5u5JC3lSFj6WHKEd7vHl8nhmxZQvswTm3JLrq75bkEaRabvzS1rPZ
         z71nVUIy2FpApwBwJkbAWAYfHa/OueFaNcl+3dTcJTcCmUreaWm/GSzCDPSzRsSzjEHg
         4wNQY0XouBxGdQvLeMnbc9Y+mw+tqPH+yrhSCBynAyJkUb7MSbtO//p+mcD+BRXGQgj1
         ZVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U6RFo6bCNbUzsvtkCBFSYaUfHQeIB3hnc3VMLOIKRb8=;
        b=SU36jCRHafn5kPZjT4g7uuE8ZnIFlxkwgfwrGe+4zO+nYkZq1tqhDnXLSePTXfFLpB
         smrCzvSxmbnnqIoEKnV5puTW6Sp+6ATASumZJa0BrdWpR/aiQ8EqPz26Hn9J3ewMOeqR
         GszfTJn2LEeSD3q/5XrntYqiVjxYG8ulRjEkRrY3AsVeLoKb/+0S0B1rvZHEBW+lbMyx
         sKvamp+dO+EVWV1vHHnuUcJmnQZke71hvvGoL7Zi/BPjrKKGThrRgdfuXBYOsRRoIK5T
         7+bX746j5rLGer3z9cOJCWTNElTmfGaxupAwmpqv1Gm7GStpP1Wbwa/1L7w2Lr9t1OlW
         PmPA==
X-Gm-Message-State: AMke39kr5g46jRgwnGLEKiNV0neDU9PZt87+PfZQ1mha3wb2iSbkiUN4Md/KNGwApeicIg==
X-Received: by 10.28.30.79 with SMTP id e76mr12340228wme.96.1488188860895;
        Mon, 27 Feb 2017 01:47:40 -0800 (PST)
Received: from macbook.local ([2a02:a03f:85e:d600:dc96:b6f1:625c:99f0])
        by smtp.gmail.com with ESMTPSA id v130sm3851507wmv.2.2017.02.27.01.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2017 01:47:40 -0800 (PST)
Date:   Mon, 27 Feb 2017 10:47:39 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
Message-ID: <20170227094738.mhv72nh4pp66vzny@macbook.local>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
 <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
 <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
 <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 04:02:33AM -0500, Jeff King wrote:
> Ugh. Actually, there are a few complications I found:
> 
>   1. Checking "HEAD" afterwards means you can't actually have a branch
>      named "HEAD". Doing so is probably insane, but we probably really
>      _do_ want to just disallow the @-conversion here.
> 
>   2. This isn't limited to just HEAD and @-conversion. For instance:

It's a bit what I was afraid of.

Luc
