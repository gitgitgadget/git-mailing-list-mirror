Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 791B820437
	for <e@80x24.org>; Mon, 16 Oct 2017 18:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756597AbdJPSSw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 14:18:52 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:52337 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756552AbdJPSSu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 14:18:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id k62so3837362wrc.9
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MMRHHv9nOfv2uhGmswbWX/Hgm2iHFEXb3rQxjBxs5iA=;
        b=WiUVZu0EZe/2z8NWtevwUbjOShFgo09Gmdh2j+QfrahdzDKfBy9nwd+syYSzuVA4XU
         ZH3XwRg4rK/4DlLqGEWH8vlv3xnJd4uHupMby7ZOfyxVeSVQakw/vB7WH/PdTH/86lCt
         DUtomB88a7xeBo32sLFw/duwXTcBlHDyD/bs99yanPyO5RHi4EyQ8bS9ngu1ObOgOccq
         wV3W5sdPsZefypHJPxDwh3Bnhuzy1ZWtytYZgBDLd4aUeFqXxXW9aNrg8xduSXX9GCuh
         RGLdsTrsKqLIrXtGC/ZJNmQY0tnhh98vlV9rrPDEsDRhgM3R1tMz5NnKWDBjcYi6uRcS
         hWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MMRHHv9nOfv2uhGmswbWX/Hgm2iHFEXb3rQxjBxs5iA=;
        b=ip61vL37GKN/SZYXUm9RxzvI6xqGQfKFZrm5eEvod+9z09aNf4XiOJL6yoj0Lt61F4
         Q7mO48HtmYDv/YFB1l1VvQW+uMra5LxBOinKIcQ2KRr7Gw+BTGTtim+R1SPZnzZxcQ3h
         7oO6OnUhmbtv+9T556dIWG5agHF/bCOsaO03dJMihyAnMRFOAEqVDHhbuL+VCrtDJ3eD
         kJaNLIGcSPCjNPLb3x4DICBBBcx/VDgU1zMAhc3v1d1gDWoYLB8Kzm8bdKyLGT3obSJW
         5qi2/o5pF9QOexi+RbmAqbcThFE8ybb2qnmoI2/hXyfjR7nz79I3OpJrnEKd2tvNuKN4
         2QjA==
X-Gm-Message-State: AMCzsaVc7gFh1w4mJFVrqsFRXpOJZ5dD0anWf+j3M8LUI04QVZAwOuqL
        7CZBySA3+K4YyJKorcbdwnb0j9fw
X-Google-Smtp-Source: ABhQp+TyhysVYC8POZ9ntGWP5ga0t4V5y2sJzY8fG6nOhulb1bAJb22sRi/INBP/NqBM3KN9RztOXA==
X-Received: by 10.223.198.130 with SMTP id j2mr1477296wrg.52.1508177928979;
        Mon, 16 Oct 2017 11:18:48 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y144sm7104123wmd.18.2017.10.16.11.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Oct 2017 11:18:47 -0700 (PDT)
Date:   Mon, 16 Oct 2017 19:19:47 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC] deprecate git stash save?
Message-ID: <20171016181947.GE15399@hank>
References: <20171005200049.GF30301@hank>
 <xmqqmv4x2ngs.fsf@gitster.mtv.corp.google.com>
 <xmqqy3ogy5wf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3ogy5wf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thomas Gummerer <t.gummerer@gmail.com> writes:
> >
> >> git stash push is the newer interface for creating a stash.  While we
> >> are still keeping git stash save around for the time being, it's better
> >> to point new users of git stash to the more modern (and more feature
> >> rich) interface, instead of teaching them the older version that we
> >> might want to phase out in the future.
> >
> > With devil's advocate hat on, because the primary point of "stash"
> > being "clear the desk quickly", I do not necessarily agree that
> > "more feature rich" is a plus and something we should nudge newbies
> > towards.
> 
> I do not particulary view "feature richness" is the primary benefit
> of 'push' that makes it shine.  'save' has a quirk in the command
> line option syntax, but 'push' corrects it, and that is why we want
> to move users towards the latter.

I agree it's not the primary benefit (hence why it's in braces :)),
but I at least some users will eventually want the features 'git stash
push' has to offer, and it's better if they don't have to re-train
their fingers at that point.

But yeah, fixing the quirky command line interface is definitely the
stronger reason for deprecating it.

> IOW, I do not object to the agenda; it is just I found the
> justification used to push the agenda forward was flawed.

I'm happy as long as we agree on the agenda here.  Any opinions about
the patches themselves?  Would you prefer me to resend with an updated
description?

> Thanks.
