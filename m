Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ADBF20437
	for <e@80x24.org>; Tue, 10 Oct 2017 21:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932602AbdJJVSB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 17:18:01 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:56044 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754196AbdJJVR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 17:17:58 -0400
Received: by mail-pf0-f169.google.com with SMTP id 17so10220289pfn.12
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gGW/M82x65s2XngVGt+HsXAkwAOVtolAVJwpi+opVoQ=;
        b=SVQVDxYMONvbnIdPSZPHqsDoANttOnmqFqDgNZ3qayuR5itosOu3fAQZmkn/FPrx0x
         dRdbQReiELygcZPEtX7Hforvr7LbRQSoKnWjE/v1Uhu3cPqKpzADmNnoENeIKftZkOxU
         5bPCmlBmJ21C4DLE5WjbTNCRxF430SGaWtjVWvc8vW6GUaO570aOY9CY/7nUdxnt7X24
         plU7NccRbRSqsfslAsJrFqlCXvi/OKhoIbGaB4l3iWIngX3nh+/JJSeTct2H5ntXd78Y
         4ixo/6443u6GvJ4aijDgPfGpbu7Qd2wer0LVw/IhnaIaKyGqWcJmD1Ys9W5xwNDl19r7
         FtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gGW/M82x65s2XngVGt+HsXAkwAOVtolAVJwpi+opVoQ=;
        b=JnjhxE9zU2V0IszdlbwZYABjrOoEY5XWgfgCtzT75v37TNFpEVydKB9xsHpcOjOZFa
         auHz4s577h89+bCneTNFGK16uQI+LFWGuMOsVmAh0a/UmvSEmrtJpdKXoKY4elRwrtiH
         LcpsdCQiQvZQGxptXozjWsoKjRHMbYyVxXotwtHKEZzLTHjgRAVPiBY0CDFr9uUlknHj
         CHN2rYv2rrFIgEIvz/nwWxiuMRFQrnNS0JO+94+O9LqJLW/JaaGO+i8LNkb1BKjtn1RP
         GC1m+fKdHb5pdv9y+ECQs71qgsKOQ3uCTZn1bGslXq/Hp5qhgoWfbzEsIck5Uw+ydSMM
         XUlA==
X-Gm-Message-State: AMCzsaVaz6aTkzJU/adAOVP7ZFIIVjo3D16bZ1B/P6AF/Pg+UxqWudpo
        fWiHhQxdvCR3Lr+YwwBm5PT/5HVD
X-Google-Smtp-Source: AOwi7QCudDwSAjNGqUHPT16JoegveRCt18B2IIoBwr42JkchW8wiacAX9wFZO2Q+Sab6ig8UdaDTPw==
X-Received: by 10.84.239.15 with SMTP id w15mr13203623plk.29.1507670278149;
        Tue, 10 Oct 2017 14:17:58 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id 2sm21357789pfn.185.2017.10.10.14.17.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Oct 2017 14:17:57 -0700 (PDT)
Date:   Tue, 10 Oct 2017 14:17:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>,
        Git Mailing List <git@vger.kernel.org>,
        bturner@atlassian.com, Jeff Hostetler <git@jeffhostetler.com>,
        jonathantanmy@google.com, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention
 mechanisms
Message-ID: <20171010211755.GY19555@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-4-bmwill@google.com>
 <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
 <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com>
 <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
 <20171010210049.GA77383@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010210049.GA77383@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Given some of this discussion though, maybe we want to change the
> semantics of 'protocol.version' so that both servers and clients respect
> it.  As of right now, these patches have the server always allow
> protocol v0 and v1?  Though that doesn't do much right now since v1 is
> the same as v0.

I strongly prefer not to do that.

If we want to make the advertised protocol versions on the server side
configurable, I think it should be independent from the configuration
for protocol versions to use on the client side.  Rationale:

 - As a client-side user, I may want to (after reporting the bug, of
   course!) blacklist certain protocol versions to work around server
   bugs.  But this should not affect my behavior as a server --- in
   my role as a server, these server-side bugs have no effect on me.

 - As a server operator, I may want to (after reporting the bug, of
   course!) blacklist certain protocol versions to work around client
   bugs.  But this should not affect my behavior as a client --- in my
   role as a client, these client-side bugs have no effect on me.

Making the client-side case configurable seems important since Git is
widely used in environments where it may not be easy to control the
deployed version (so having configuration as an escape hatch is
important).

Making the server-side case configurable seems less important since
Git server operators usually have tight control over the deployed Git
version and can apply a targetted fix or workaround.

> One other considerations that I should probably handle is that a client
> doesn't do any verification right now to ensure that the protocol
> version the server selects was indeed the protocol that the client
> requested.  Is that something you think we need to check for?

Do you mean in tests, or are you referring to something else?

Thanks,
Jonathan
