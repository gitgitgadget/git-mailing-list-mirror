Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5C0209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 12:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbdFFMn2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 08:43:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32891 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdFFMn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 08:43:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id v104so10222069wrb.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8g0tv1QIH/gHEiHwj+7i0rmDOWxxYnU/8CjCSpLkrx4=;
        b=pajrAdqLc14TVl1ZXpi+3H9db0zjQJkrQGx045Lan4KCU4WYaJMXQZG2uuc8ttr6xx
         MtV1HV8qbygSrw43pdGHsQDQY9mi5lhafQvJ6iLWP+7nGzEAt5vAKdI2HeXkts9+yBE6
         mRLUyQjXJIjoQGx6BNGeEfQxBWorHEhZVpqaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8g0tv1QIH/gHEiHwj+7i0rmDOWxxYnU/8CjCSpLkrx4=;
        b=U90IfGASG4SSP+7M0WpInsfDeFfxbHliVOXrv9MwNhZYgT5TibM9eJD8D4bWFwyjva
         Bi5DvQb8Rj0udX7+lJ45Cas56TukDfQ204a+MH7xWbgtfxjffcVYspEIvsR5ExQogI33
         ErLW/OYe8CNEjxtVAf+dmZjXDoaldACzZrCCxTp3t0f0ONFtH5ORmzUfA6n6Pp1sfQKH
         F/RkwWJ6AZ2jwohOPdDyaZ7UD4IuSZ0Yq8Y68NtQWLLEHsoDB4St6uBHykKrKKOZbIvs
         V0hPbD+4272ZNSIhvCtn6x9/GuNIbLrrbtGUvN8o98vwKJN89qvu1enkPyq8mi98ZwRL
         MQnA==
X-Gm-Message-State: AODbwcATglImsvB5o2ha+Wm5rA0pUPNUDhmXNAZK96nMwHlHKSK/8tN+
        qugYSugbqSB1Zmzy
X-Received: by 10.223.139.211 with SMTP id w19mr7484127wra.119.1496753006167;
        Tue, 06 Jun 2017 05:43:26 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id u141sm14277845wmd.28.2017.06.06.05.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 05:43:25 -0700 (PDT)
Date:   Tue, 6 Jun 2017 13:43:23 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Git v2.13.1 SHA1 very broken
Message-ID: <20170606124323.GD25777@dinwoodie.org>
References: <20170605203409.GB25777@dinwoodie.org>
 <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com>
 <xmqq4lvtap3m.fsf@gitster.mtv.corp.google.com>
 <20170606100355.GC25777@dinwoodie.org>
 <xmqqmv9l8h5z.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv9l8h5z.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2017 at 08:55:04PM +0900, Junio C Hamano wrote:
> Adam Dinwoodie <adam@dinwoodie.org> writes:
> 
> > Digging briefly into the endianness detection, it appears Cygwin has
> > both _LITTLE_ENDIAN and _BIG_ENDIAN defined.  Git's detection works by
> > assuming it's in a little endian environment and switching to big endian
> > if it detects any of the defines that indicate such, and a010391 adds
> > _BIG_ENDIAN to the set of defines that indicate big endianness.
> 
> I suspect that the upstream has already fixed this one to cope with
> FreeBSD.  My preference is that we do another import on top of the
> ab/sha1dc-maint topic, below the commit on ab/sha1dc that adds the
> upstream as a submodule.

Apparently so!  a010391 brings Git up to the upstream's cc46554 ("Skip
temporary variable for SHA1DC_ALLOW_UNSIGNED_ACCESS", 2017-05-18); the
problem has been fixed in upstream's a24eef5 ("rewrote Endianness
selection", 2017-05-29).

In the interim, I'll use the CFLAGS route to try to get a v2.13.1 build
ready to release for Cygwin.
