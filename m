Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B30820437
	for <e@80x24.org>; Fri, 13 Oct 2017 22:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbdJMWqE (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 18:46:04 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:45851 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbdJMWqD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 18:46:03 -0400
Received: by mail-pf0-f177.google.com with SMTP id d28so11463231pfe.2
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HVsZEXzQGmpx49sFCvU5PdFAKyEMBcJBm8wGqxWqAzg=;
        b=PgnXNOYgk453GtjWbU6j8j7pi4zUxahH6lVB2JvXvQcmF3vnB8I0xUlc6nGVdrvvwR
         0/up72ZvmPI8P5n1+e1mTb1J/KEhDIepYXSCFZQRDRNfMtR0lfwlLPW2Vo3MY5O58b3y
         3YSm4j84PFnxEuDq31TVB+D+FlbrT/IDfS0RPoOKVo1xbF99Ns75gL26s+ZjR1Gunkuv
         vTdht3Sxa7qduOTSvdGjSZaP0t62XSKegPOthnY5WM2lXWiHUf0vz80tT6OooeoYufbj
         CUfuj1q2ZWyI1iay8s4vmBjZ3Q6XhCRPBnMWPWPatNcCYysTh+MYF8YktC7sglgjq/gP
         BvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HVsZEXzQGmpx49sFCvU5PdFAKyEMBcJBm8wGqxWqAzg=;
        b=Qf2ocBWy4XwBTxLQbnxsjm8dEEYMZXmlUnXdw5sXpnImJTmknV4wBQl4odcCGjmSJN
         o+IAqMV3aLSSm2COtxoIIlQeGY+bl6SFM27E6UVwQWLWGiBKvAf7Y4RWlFql6ktFoGjz
         vYfv5eXtbSucuGT97/+Kh66lnw2kT7fkWNYVBww85RxLqfprgmnTljbr9iawk0xZv3Ys
         2YPWfr4Tym3AiLvWu5Chq3BJPEJQH1hm5sRG2zEk866FPM8soexUEMUp/VUs2iRRtuUU
         l7s8yvA8w7Z5o5YF0vmBKGzuBzESSRrW2FiasB1wuuLMmByzJToXuwUjKjotOtVcE/ov
         zWIA==
X-Gm-Message-State: AMCzsaWGzCPWzQ2Qm0ifBZfaPyqAWvA9beNWK4CFU9t1bpSM4mD+Ggo9
        r79cwHE3yPP56V6U775O5Fk01Q==
X-Google-Smtp-Source: AOwi7QBtjGI2012EeAixJcs/FTe4FsHrYPOOaWSR9DN8kIn8H9KgeQcpjOSrIQpBudQVgoWDbQKigg==
X-Received: by 10.98.252.17 with SMTP id e17mr2614215pfh.48.1507934762485;
        Fri, 13 Oct 2017 15:46:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b031:5884:4d4f:f3a9])
        by smtp.gmail.com with ESMTPSA id m16sm3750815pgn.76.2017.10.13.15.46.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 Oct 2017 15:46:01 -0700 (PDT)
Date:   Fri, 13 Oct 2017 15:46:00 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>,
        Git Mailing List <git@vger.kernel.org>,
        bturner@atlassian.com, Jeff Hostetler <git@jeffhostetler.com>,
        jonathantanmy@google.com, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention
 mechanisms
Message-ID: <20171013224600.GD101395@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-4-bmwill@google.com>
 <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
 <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com>
 <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
 <20171010210049.GA77383@google.com>
 <20171010211755.GY19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010211755.GY19555@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > Given some of this discussion though, maybe we want to change the
> > semantics of 'protocol.version' so that both servers and clients respect
> > it.  As of right now, these patches have the server always allow
> > protocol v0 and v1?  Though that doesn't do much right now since v1 is
> > the same as v0.
> 
> I strongly prefer not to do that.
> 
> If we want to make the advertised protocol versions on the server side
> configurable, I think it should be independent from the configuration
> for protocol versions to use on the client side.  Rationale:
> 
>  - As a client-side user, I may want to (after reporting the bug, of
>    course!) blacklist certain protocol versions to work around server
>    bugs.  But this should not affect my behavior as a server --- in
>    my role as a server, these server-side bugs have no effect on me.
> 
>  - As a server operator, I may want to (after reporting the bug, of
>    course!) blacklist certain protocol versions to work around client
>    bugs.  But this should not affect my behavior as a client --- in my
>    role as a client, these client-side bugs have no effect on me.
> 
> Making the client-side case configurable seems important since Git is
> widely used in environments where it may not be easy to control the
> deployed version (so having configuration as an escape hatch is
> important).
> 
> Making the server-side case configurable seems less important since
> Git server operators usually have tight control over the deployed Git
> version and can apply a targetted fix or workaround.

This is fine with me.  Realistically, as I mentioned, all of this is
unimportant at the moment as it doesn't prevent us from moving forward
with the transition or with implementing a v2.  If we do get to a point
in the future where we need to explicitly care about blacklisting or
whitelisting protocol versions from the config then we can take care of
that then.  The important thing is that servers won't die if they see
multiple 'version=?' entries or unknown values of '?' in GIT_PROTOCOL.


-- 
Brandon Williams
