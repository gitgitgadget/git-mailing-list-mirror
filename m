Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A1B1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbdLHULM (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:11:12 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:45381 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbdLHULL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:11:11 -0500
Received: by mail-it0-f53.google.com with SMTP id z6so7166040iti.4
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 12:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NuLB5bxZL+taxVXUWHiXTkFzJ6kruiSvOun5Y/8gfj0=;
        b=XDt7E8jEIbQud1DI80jMt854c2qpeem2rWiPDfFR1hboPReix4Pg1v8uC9RKcfWYyF
         wWJtu5ogC+oQE5uoMVVZS+q0gAog4vHytLZjx+iEGjiqjIftMwtmCjA5usoP29sCJHUn
         xc4MLe5eyU0E/oL3JwlNWDJNu9/stCGdd5KQb/dDOHAxQk+37Qg+SGOS6BN+39ehvkTa
         60EWUcY6Mj9ykLqrLIX6yMo93fCsWYE17Fht3yA5w0PwWV0iTFemlPTiQcgNzgRNVqdd
         SfUMsVgSj40ICvDd/EVN7m8Up88ZQB82moT8YcWsQdJ4ipglHsy2xTWRO97UPHufoy7a
         abgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NuLB5bxZL+taxVXUWHiXTkFzJ6kruiSvOun5Y/8gfj0=;
        b=QiiNSRDW0KmVHfrNRAsKLdw+hlYFHmZnX3fh8qgSwnq1p0Gql4iUfbH9L6UCMgq/wy
         4xhxSQ4TXe9SEv9JZzLY7HgCFKr+1BO/Uzk3GVB5cVGKU2yZScq/XqH32MV7XmvyLdmw
         fnkMUeK//G0Ilivo20j1FyBrkbDjG4ducCV7c3oBaQMjgH87SHVsmHX01MxQ5GHV27d8
         GMAVG8Kc0oTYWPGid93wlicfc46u3B0mUOAH7rFC33xWxiMnVHPLjvGnrFj6PZFRj52R
         S+wyuw2C7vp+DYsjeZE9c4YkAkNgPFufImGP56ojT0HtHwJmyu376LefMaxiPl/DGbSg
         FKHg==
X-Gm-Message-State: AKGB3mJoluB3boU0HJNew0p7CTaGRanqKRLcsXwlTDnuh2/pavDwC/od
        sNgdiT3bWuscqbTGrO7jqPxbMQ==
X-Google-Smtp-Source: AGs4zMYdfpAsX/u+865D4T83l6P7kUN3EjOs9PlSwg3zP/vvfY3FCk9mXdTlKkJM7yNK6R4D6A1ZfQ==
X-Received: by 10.36.139.69 with SMTP id g66mr7015053ite.71.1512763870520;
        Fri, 08 Dec 2017 12:11:10 -0800 (PST)
Received: from google.com ([2620:0:100e:422:e4f1:b67a:70f2:4fbe])
        by smtp.gmail.com with ESMTPSA id 76sm1109198itk.23.2017.12.08.12.11.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Dec 2017 12:11:09 -0800 (PST)
Date:   Fri, 8 Dec 2017 12:11:08 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 08/15] connect: discover protocol version outside of
 get_remote_heads
Message-ID: <20171208201108.GB140529@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-9-bmwill@google.com>
 <xmqq7etye5il.fsf@gitster.mtv.corp.google.com>
 <20171207190446.GB152943@google.com>
 <xmqqy3mecp4x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3mecp4x.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > While we could wrap the preamble into a function it sort of defeats the
> > purpose since you want to be able to call different functions based on
> > the protocol version you're speaking.  That way you can have hard
> > separations between the code paths which operate on v0/v1 and v2.
> 
> As I envision that the need for different processing across protocol
> versions in real code would become far greater than it would fit in
> cases within a single switch() statement, I imagined that the reader
> structure would have a field that says which version of the protocol
> it is, so that the caller of the preamble thing can inspect it later
> to switch on it.
> 

Yes, patch 9 changes this so that the protocol version is stored in the
transport structure.  This way the fetch and push code can know what to
do in v2.

-- 
Brandon Williams
