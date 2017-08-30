Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595DF20285
	for <e@80x24.org>; Wed, 30 Aug 2017 21:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbdH3VMt (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 17:12:49 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35231 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdH3VMs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 17:12:48 -0400
Received: by mail-pf0-f169.google.com with SMTP id g13so22616659pfm.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/cjtIlSNHBlvIztvKIOgsFEiFJexSG93V9XeNGKmQQ0=;
        b=SkRYgO6t5hEe73cncoN+611pZcH7j4ZuHLgMWvBnJbDlhsXjMpFernt+6Kni9HGESs
         V9HCMWpCPH5Ge9jL7r4OXW7mZiMJc5TVKlvFy6asPfrRyH+CC8M3FOYQkvjOoeBRLsAk
         9mVnUejD8OPiFzK1FGbOmGYvvYxGoqJZG2Z5E94ykJcOfrlIJpVD2KON2I98Eld7aCq3
         EoTJv1YkH9Fg4Ow6p2/LYYlAJY4p6+7xHjKGaW91Rs1Tb9dn2uq3B3+eQvg7c+deUOTK
         ftUAy7h514TD+niYbuy0Cv5M6jI647VYdNC4YtSL6CVdKqCAQPLYBqqGy3zB3R3gIrPR
         IxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/cjtIlSNHBlvIztvKIOgsFEiFJexSG93V9XeNGKmQQ0=;
        b=WMMj26Ua5408wmU7vij0NuRoWOWAtC0nK6qYd3PXkFSj5ympMsNuA6yuSeZukUuC1c
         cAosNHk4u+lCNbwi07QhElyWNwTXUKNNIZT+bsVuGfsBLMKksOUesJUou7Pbfa12cSWA
         jx+fnGxJrrQBh44BMMGZDGKt3/eJWFcJgI1LNKmsh3RrkB2ae1F3QfRXJY+70akXAd0u
         jo7LRTJGvydt6OYepyIhiZhGfcMRkOQEW9lERsEeQZGmVD1yzWT1LfN1QrUlZ0RK9bPw
         u+Xddf3qsibugLCRySRFXL8ry2iz8LEfAW7Dq9QL7Ck5qrgTpta11cxpyl7I1Q9u2gUV
         ZVpQ==
X-Gm-Message-State: AHYfb5h9oFmx4gGGxUWFpn5i4j/9hltOLzLvClOrhHqPYFBIEuccRvyu
        QhoLmVANBQNFvryt
X-Google-Smtp-Source: ADKCNb7gYbsksPb/GwoTIKkxjdVyVURQciBKYuYcxKHhqUB+MEJEoWy65IqVssFemcRg5czGziR6tQ==
X-Received: by 10.99.51.78 with SMTP id z75mr2813006pgz.31.1504127567653;
        Wed, 30 Aug 2017 14:12:47 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:81c4:afb0:c46d:bc75])
        by smtp.gmail.com with ESMTPSA id y63sm10782706pff.100.2017.08.30.14.12.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 14:12:46 -0700 (PDT)
Date:   Wed, 30 Aug 2017 14:12:45 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>, jonathantanmy@google.com
Subject: Re: [RFC 0/7] transitioning to protocol v2
Message-ID: <20170830211245.GD50018@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
 <CAGyf7-HTuM2kBRYDP8i9B8pUgqFw02pqBdYCVnp9s7v4bDAM0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-HTuM2kBRYDP8i9B8pUgqFw02pqBdYCVnp9s7v4bDAM0w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30, Bryan Turner wrote:
> On Fri, Aug 25, 2017 at 10:29 AM, Jeff King <peff@peff.net> wrote:
> > On Thu, Aug 24, 2017 at 03:53:21PM -0700, Brandon Williams wrote:
> >
> >> The biggest question I'm trying to answer is if these are reasonable ways with
> >> which to communicate a request to a server to use a newer protocol, without
> >> breaking current servers/clients.  As far as I've tested, with patches 1-5
> >> applied I can still communicate with current servers without causing any
> >> problems.
> >
> > Current git.git servers, I assume?. How much do we want to care about
> > alternate implementations? I would not be surprised if other git://
> > implementations are more picky about cruft after the virtual-host field
> > (though I double-checked GitHub's implementation at least, and it is
> > fine).
> >
> > I don't think libgit2 implements the server side. That leaves probably
> > JGit, Microsoft's VSTS (which I think is custom), and whatever Atlassian
> > and GitLab use.
> 
> Before I manually apply the patches to test how they work with
> Bitbucket Server, are they applied on a branch somewhere where I can
> just fetch them? If not, I'll apply them manually and verify.

I just pushed this set of patches up to: https://github.com/bmwill/git/tree/protocol-v2
so you should be able to fetch them from there (saves you from having to
manually applying the patches).

> Just based on the description, though, I expect no issues. We don't
> currently support the git:// protocol. Our HTTP handling passes
> headers through to the receive-pack and upload-pack processes as
> environment variables (with a little massaging), but doesn't consider
> them itself; it only considers the URL and "service" query parameter
> to decide what command to run and to detect "dumb" requests. Our SSH
> handling ignores any environment variables provided and does not
> forward them to the git process, similar to VSTS.
> 
> I'll confirm explicitly, to be certain, but just based on reading the
> overview and knowing our code I think the described approaches should
> work fine.

Perfect!  Thanks for taking the time to verify that this will work.

-- 
Brandon Williams
