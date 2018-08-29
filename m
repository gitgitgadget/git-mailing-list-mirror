Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300DB1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 17:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeH2V5z (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 17:57:55 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:38976 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeH2V5z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 17:57:55 -0400
Received: by mail-pg1-f182.google.com with SMTP id g20-v6so2660121pgv.6
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vf3uIUmON2bB5CdfOt1ZbKlz0AwkCH+zCqdQDM7m8Ug=;
        b=qBSkDTzClYltTbJdqIL97eXtjlu9Eava+IyOAqGRdFgOArdAkAmX3jO7n4OCuMi8mp
         IrcN4gyvxGbQIp9z2zwuYp52JxEOEjX2+7bkSjgGTyJ5UdOrMwxyS35VV5GPbbsKkqqv
         04yofW0KPEMx7qny3ATGjDZ+abw5P8dx7y7qzsihk3HC2tjYpkOuhP7rrGMeUTk1y+2z
         9tB+KrNUmGm2bonFvojrEegooEtBfFIoP+daTP2W2fWW4VB21lshP+R+OvPrHoDID2gU
         hJEBQdX8QvtyZMs1CNIXGIDfpEp+k+EC64iYBjM/L1+U8s6pg/5nNlnw2vGdDhW55kVm
         YubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vf3uIUmON2bB5CdfOt1ZbKlz0AwkCH+zCqdQDM7m8Ug=;
        b=iJobpY3wQTXvv6R9gBhHaOGFi8M5JU+Qb8b8pX4OKnQYSnt1c3iA1p3SA6jJdG4KxC
         7D1DkiMWJFhcICbIL3f56NvCc+TbyTkSFYR9CaQS3Y8NxQNPsoxATr2u39F0kwSQ5/EP
         sKMK1Ait4cHcfVMwmPhiD1FBJbJ8vwpJZuh0tUIjScjZgGYTLG5oq4fkj93KB9V4Ysta
         xCJTUDw5QRB6ltFHmCTWrsgedK9/91rKOB3c0cBvijWw3uLovN4WlVRLdJCzrYpzbb9k
         T1u4ba3ko5IdX3Qaac1SPXFVGqQSqMBwxV5Q95xHbKGSwr3wsjJ06g+tDOBXYsinuUBI
         VpxQ==
X-Gm-Message-State: APzg51AaQidKp8w2j2YWi+8ShDTcYFjHByyGIQEPy+zEjZzhGCotMIhG
        btPKXd580HlwNLyGHKpy358=
X-Google-Smtp-Source: ANB0VdYJ4lXQAtJnWjEWd/xORHNkSHcxTeCYR6lEbdqMD0A27vtyRMcMAvwL0bLUG9S3yuHF39f0TQ==
X-Received: by 2002:a63:1760:: with SMTP id 32-v6mr4854699pgx.31.1535565592824;
        Wed, 29 Aug 2018 10:59:52 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r205-v6sm16624735pgr.11.2018.08.29.10.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 10:59:52 -0700 (PDT)
Date:   Wed, 29 Aug 2018 10:59:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: How is the ^{sha256} peel syntax supposed to work?
Message-ID: <20180829175950.GB7547@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014703.GE99542@aiede.svl.corp.google.com>
 <877ek9edsa.fsf@evledraar.gmail.com>
 <CAGZ79kaGb_TL7SiR4CFGFzrfy2Lotioy76o6sUK4=vZK5qwqNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaGb_TL7SiR4CFGFzrfy2Lotioy76o6sUK4=vZK5qwqNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

>                  And with that model, <hexdigits>^{sha256}^{tree}
> could mean to obtain the sha256 value of <hexvalue> and then derive
> the tree from that object,

What does "the sha256 value of <hexvalue>" mean?

For example, in a repository with two objects:

 1. an object with sha1-name abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd
    and sha256-name ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01

 2. an object with sha1-name ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
    and sha256-name abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd...

what objects would you expect the following to refer to?

  abcdabcd^{sha1}
  abcdabcd^{sha256}
  ef01ef01^{sha1}
  ef01ef01^{sha256}

Thanks,
Jonathan
