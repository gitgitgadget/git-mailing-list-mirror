Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 862C11F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 21:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdH2VKL (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 17:10:11 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35991 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbdH2VKK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 17:10:10 -0400
Received: by mail-pf0-f170.google.com with SMTP id z87so13530184pfi.3
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DtCeQbrMFCsl6HR6bwf9A3wYgv1DjlAPDgk9jDFXit4=;
        b=Y3AdQlcoiVJYLRgbxE7TJQebXvsfAmZRVD56wNJTSMVBKLRjeVpgcxRoGnAf01DWQo
         3MkiEttCUd6TnICHbkAdTeQQwLjWg5740Tj4XPupUhrNQbWFuTvQITcXTizweFAHID/a
         RVo7Oel4KhZvC/IHY/iMOc3ISyxAmPLOV/Fl25iq4hfjSEratho/+P6XX3e1AMNkecZK
         AWrXg2HXOsFofTTFl2noQOttA4lRm+I66AwHEG+nDH5EW7MBA6uhNU3V9aYDI5Xw/zoY
         y7uSFayLr22CovECZO47KZn5vIQTNCsSOK/p0W+187HQNL7t+CKsS1bqFXZUE5AjwiCw
         XeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DtCeQbrMFCsl6HR6bwf9A3wYgv1DjlAPDgk9jDFXit4=;
        b=aunFvwnyC7lHhDx3tv8umYm/SA8omoJirnJo/qYUC2rCfoGS2YE/Ss1kxb1epXy7FZ
         CwNvOqaP2T/IbPDEtg4Sql0d/mKKA+kL8YdMRDruOCTqGYHCRff9M9GY2j5THEQCD6iC
         FMc+TNZea7MTSz/DtERToGbJcF174rAFlyAoZD19ninHmB3pJRMtbGhZrRovoFUCJ7Z2
         TCqD62gCgC19GGEJcMREatOc6zb1bgeJ2GaZPhug9j7K6soBfdNvStW5p9lIfsuY9GY0
         0qLDRkF4ziD+FLZFQvbFsilDKhUaI9vPmQNXjXckeye6Pb1Hl9QTYjGETcB9Bctjad0H
         n6nw==
X-Gm-Message-State: AHYfb5jeQUY3lD+vInpg9YHW7EaCfQY4Pr3cMYqhBcbPi/UmDxUycZCU
        nIZFQibNTzqbBb7k
X-Google-Smtp-Source: ADKCNb6RMnu5z3meqj+cqQ3+oulQX5o4cmHP6nNU35waH11dRdC+wOQ/qNRNUvX7xkTKZ0Z5FBmmRw==
X-Received: by 10.98.50.130 with SMTP id y124mr1674780pfy.277.1504041009505;
        Tue, 29 Aug 2017 14:10:09 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c55:9408:3387:8e7e])
        by smtp.gmail.com with ESMTPSA id 73sm7259527pfu.3.2017.08.29.14.10.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 14:10:08 -0700 (PDT)
Date:   Tue, 29 Aug 2017 14:10:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [RFC 0/7] transitioning to protocol v2
Message-ID: <20170829211007.GF131745@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
 <20170825173550.GJ13924@aiede.mtv.corp.google.com>
 <2ff0ead4-e13a-220e-f858-36ab206c1485@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ff0ead4-e13a-220e-f858-36ab206c1485@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/29, Jeff Hostetler wrote:
> 
> 
> On 8/25/2017 1:35 PM, Jonathan Nieder wrote:
> >Hi,
> >
> >Jeff King wrote:
> >>On Thu, Aug 24, 2017 at 03:53:21PM -0700, Brandon Williams wrote:
> >
> >>>Another version of Git's wire protocol is a topic that has been discussed and
> >>>attempted by many in the community over the years.  The biggest challenge, as
> >>>far as I understand, has been coming up with a transition plan to using the new
> >>>server without breaking existing clients and servers.  As such this RFC is
> >>>really only concerned with solidifying a transition plan.  Once it has been
> >>>decided how we can transition to a new protocol we can get into decided what
> >>>this new protocol would look like (though it would obviously eliminate the ref
> >>>advertisement ;).
> >>
> >
> >>I don't think libgit2 implements the server side. That leaves probably
> >>JGit, Microsoft's VSTS (which I think is custom), and whatever Atlassian
> >>and GitLab use.
> >
> >I'd be happy if someone tests the patches against those. :)
> 
> I just wanted to jump in here and say I've done some initial
> testing of this against VSTS and so far it seems fine.  And yes,
> we have a custom git server.
> 
> VSTS doesn't support the "git://" protocol, so the double-null trick
> isn't an issue for us.  But "https://" worked just fine.  I'm still
> asking around internally whether we support passing SSH environment
> variables.
> 
> Jeff
> 

Thanks for checking on this, I really appreciate it.  Please let me know
if anything I haven't thought of becomes an issue.

I'm currently working on getting these patches into a more polished
state to be used (as discussed elsewhere on this thread) as a precursor
to an actual v2.

-- 
Brandon Williams
