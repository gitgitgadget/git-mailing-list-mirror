Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5029F20294
	for <e@80x24.org>; Tue, 31 Oct 2017 18:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932952AbdJaSm2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:42:28 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:50838 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932423AbdJaSmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:42:25 -0400
Received: by mail-io0-f169.google.com with SMTP id 97so928896iok.7
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S8dxEgRpYgrFYYZYxk+7CER4RYx9/+fJhGn+wsuBlxs=;
        b=dW5SJf+WNrMRvdQ5cZ+FAhv1xNlibR4LznpwFEEQA9DzL7dUWQrLMoz/YX6L6JLzh9
         J7/KogYjK3Odzmt0hO7xCs/Bum4ad1PuGDeW8PRFrD15r3Dsq2+DXjciTkyWlkYpJmCU
         s8NyLQ3h7ndQPGIFuh/NwoWwrHs/W4bZUm8mu+1AOWq1e8n4g/5Pr8vRJoTCos0f9YI0
         +FKjfT1rHwf6eFRJZ0gVU+GGwW4SuPFMkCwjQraeJpWiHZCIcyAnUDkcGWHdUIDF5skU
         6zWDU0BEInjjveGyRxC+5bev4vGSa+VRDPtdCEulONOfsWfNvFb/R0JVoFRlby2T81Ne
         EWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S8dxEgRpYgrFYYZYxk+7CER4RYx9/+fJhGn+wsuBlxs=;
        b=rGyjzh1YXN7oKHEKCydkSmuocHJPmo54A/yK1Ns3GLIJHMk9xFen+f6YbSEbFsHvIS
         yQZpSP20cXK2BJwsHYfc827hADDEV8wDHHb2LBE4Wj9sOgAzCgVVOSjkjRKn8J/YwoQd
         R1u0B9cVw+CmErlpNzhdCXx5QSQdxyZRHJhCHO5Lwppr2O/gSYOsP5//szs8WM1MgCbk
         LAkGTuT1kjaayCqilm3iV6s0mADwz5HOvEBDzqVJNWmI0jhXiZ+Vpej5XIlsv/rAznD5
         bjIXyxcIWT3JIzOpbasQnV0RZ+7x8CFXEfoRQ3SdSwI855mwXZBvpBIVukHNh/fLfO8N
         5vOQ==
X-Gm-Message-State: AMCzsaXTWf8HoR/HeR5IzMvIVNdAgnd4cfZlfy+QeFz2yHv+AzsunOy2
        o5pRiSoD41iHf3i/FASCowQap1T3wEc=
X-Google-Smtp-Source: ABhQp+Qzg9mUfP8SexsxLRWZTeismgVNt3pQVOKEN2W6Jaa+osOk8Cev/OACRIHrKPvacV2BhmsnuQ==
X-Received: by 10.36.184.5 with SMTP id m5mr4566982ite.69.1509475344978;
        Tue, 31 Oct 2017 11:42:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:65da:c046:b1c4:7dde])
        by smtp.gmail.com with ESMTPSA id r15sm903253iod.12.2017.10.31.11.42.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 11:42:24 -0700 (PDT)
Date:   Tue, 31 Oct 2017 11:42:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org, spearce@spearce.org, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [RFC] protocol version 2
Message-ID: <20171031184222.GD94048@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <223949CCB658443C972AB1AC1820F0CC@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223949CCB658443C972AB1AC1820F0CC@PhilipOakley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/28, Philip Oakley wrote:
> From: "Brandon Williams" <bmwill@google.com>
> Sent: Friday, October 20, 2017 6:18 PM
> >Objective
> >===========
> >
> >Replace Git's current wire protocol with a simpler, less wasteful
> >protocol that can evolve over time.
> >
> 
> <snip>
> 
> >Capability Advertisement
> >--------------------------
> >
> >A server which decides to communicate (based on a request from a client)
> >using protocol version 2, notifies the client by sending a version
> >string in its initial response followed by an advertisement of its
> >capabilities.  Each capability is a key with an optional value.  Clients
> >must ignore all unknown keys.
> 
> >   Semantics of unknown values are left to
> >the definition of each key.
> 
> This sounds odd. If the keys are known then their semantics are
> known. Or the keys are unknown and they and their values are
> ignored.
> 
> Maybe: Capability keys shall define their response to unknown key values.

I'll work to make the language a little clearer.

> 
> > Some capabilities will describe commands
> >which can be requested to be executed by the client.
> >
> <snip>
> 
> >Ls-refs
> >---------
> >
> >Ls-refs can be looked at as the equivalent of the current ls-remote as
> >it is a way to query a remote for the references that it has.  Unlike
> >the current ls-remote, the filtering of the output is done on the server
> >side by passing a number of parameters to the server-side command
> >instead of the filtering occurring on the client.
> >
> >Ls-ref takes in the following parameters:
> >
> > --head, --tags: Limit to only refs/heads or refs/tags
> > --refs: Do not show peeled tags or pseudorefs like HEAD
> > --symref: In addition to the object pointed by it, show the underlying
> >           ref pointed by it when showing a symbolic ref
> > <refspec>: When specified, only references matching the given patterns
> >            are displayed.
> 
> Does the --symref also the pseudorefs?
> 
> Isn't there a need somethimes to determine the ref that the remote's
> HEAD points to. This is an issue with the current clone and bundle
> code when there is a choice of refs/branches that could be the
> current HEAD ref and the wrong one is chosen, though this V2 change
> doesn't affect bundles.

Yeah, currently the resolution of HEAD is stuffed into the
capability line in v1.  The intention of this would be to allow for the
resolution of all symrefs (including HEAD).

> 
> >
> >The output of ls-refs is as follows:
> >
> >   output = (no-refs / list-of-refs)
> >     *symref
> >            *shallow
> >            flush-pkt
> >
> >   no-refs = PKT-LINE(zero-id SP no-refs LF)
> >   list-of-refs = *ref
> >   ref = PKT-LINE((tip / peeled) LF)
> >   tip = obj-id SP refname
> >   peeled = obj-id SP refname "^{}"
> >
> >   symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
> >   shallow = PKT-LINE("shallow" SP obj-id LF)
> >
> >Fetch
> >-------
> >
> >Fetch will need to be a modified version of the v1 fetch protocol.  Some
> >potential areas for improvement are: Ref-in-want, CDN offloading,
> >Fetch-options.
> >
> >Since we'll have an 'ls-ref' service we can eliminate the need of fetch
> >to perform a ref-advertisement, instead a client can run the 'ls-refs'
> >service first, in order to find out what refs the server has, and then
> >request those refs directly using the fetch service.
> >
> >//TODO Flush out the design
> >
> >Fetch-object
> >--------------
> >
> >This service could be used by partial clones in order to request missing
> >objects.
> >
> >//TODO Flush out the design
> >
> >Push
> >------
> >
> >Push will need to be a modified version of the v1 push protocol.  Some
> >potential areas for improvement are: Fix push-options, Negotiation for
> >force push.
> >
> >One change that will need to happen is to improve how `push-options` are
> >sent to the server (so that they aren't sent twice!!).  Also the
> >report-status needs to be better than it currently is in v1 so that
> >tools like gerrit can explain what it did with the ref-update the client
> >sent to it. Maybe have a push-rebase capability or command?
> >
> >//TODO Flush out the design
> >
> >Other Considerations
> >======================
> >
> > * Move away from pkt-line framing?
> > * Have responses structured in well known formats (e.g. JSON)
> > * Eliminate initial round-trip using 'GIT_PROTOCOL' side-channel
> > * Additional commands in a partial clone world (e.g. log, grep)
> --
> Philip
> 

-- 
Brandon Williams
