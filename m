Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0EF520285
	for <e@80x24.org>; Wed, 30 Aug 2017 20:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdH3Uim (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 16:38:42 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:38451 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdH3Uik (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 16:38:40 -0400
Received: by mail-ua0-f182.google.com with SMTP id j46so22287098uag.5
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2K+wqhtdnbga4//IyrEnNRZ/dYjmjZ+b5Szr/SaJHUg=;
        b=lV7l+EJfkdpy2BYVl+GyGwS2BVfn0WpNjeifLUgX2Ad/e2fP+L/lCaimkLyCGHtZEA
         vqjO9vZgX96HI/iZ0BoSPNO4Bhe5TlQwfeAbJNdQB6Ib1oQI66FlSgioVtiQUA+TY0zd
         PGE87q6YSBJpYC3X7RkUsUZJtNDtJIDOT+iwlHBdcahUmbHA9vhxrSovw39IuIYTA7T2
         3X6dF/TMiLAfwT8t6uTR2UhZWMEzay+uv0trnVWwQLwlCqgEU3jGlKQikJrnyrmNwKgg
         oxZoQ7GuBycprXrKWZ++UmP2D/fUUbSNUfLhy9kcBCrY8+8AT1iSGloW4laVSMWjmmx6
         y3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2K+wqhtdnbga4//IyrEnNRZ/dYjmjZ+b5Szr/SaJHUg=;
        b=SHgvXAGSEFi5VGUJ7IxTIRdlQach8T0Pixne1wt41WDNmXfVmICXNPpMQOvzs8B3sM
         UIw1xXS5t/txlH7R3H1MyxhAMTUlIbQbzkcgYR71fMD0oXDA+wrM7wfUY4FGO4mASLZx
         ummdru2F6ZNSFJDc4vCr7Sm6TB9T+RjtEPHNUdbmKNfaJgtYmPNfURxH2m8pPJeX7lYN
         9q1a6CyriI1Y2TVD0Ys2xkayulhb49u4R2uAil8QvaSMksZF/K5Dln3iMrrUlI8H8SBO
         HsHuT97qorZorVuPGf/OMfkY5UaEkINwEM1Or27cRtdGs3K1mn1F8atGmirSQ3D1tCcA
         TfMA==
X-Gm-Message-State: AHYfb5jJPA5RARZV5htqyW34bVhtDWj8cDtN7vZYLPgiR6lAf0iiEvP0
        q6YXoLitXOqn9CXb9pmyVmDn0KD1wBlf
X-Received: by 10.176.92.138 with SMTP id s10mr304000uaf.50.1504125519964;
 Wed, 30 Aug 2017 13:38:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.92.212 with HTTP; Wed, 30 Aug 2017 13:38:39 -0700 (PDT)
In-Reply-To: <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
References: <20170824225328.8174-1-bmwill@google.com> <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 30 Aug 2017 13:38:39 -0700
Message-ID: <CAGyf7-HTuM2kBRYDP8i9B8pUgqFw02pqBdYCVnp9s7v4bDAM0w@mail.gmail.com>
Subject: Re: [RFC 0/7] transitioning to protocol v2
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Users <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 10:29 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Aug 24, 2017 at 03:53:21PM -0700, Brandon Williams wrote:
>
>> The biggest question I'm trying to answer is if these are reasonable ways with
>> which to communicate a request to a server to use a newer protocol, without
>> breaking current servers/clients.  As far as I've tested, with patches 1-5
>> applied I can still communicate with current servers without causing any
>> problems.
>
> Current git.git servers, I assume?. How much do we want to care about
> alternate implementations? I would not be surprised if other git://
> implementations are more picky about cruft after the virtual-host field
> (though I double-checked GitHub's implementation at least, and it is
> fine).
>
> I don't think libgit2 implements the server side. That leaves probably
> JGit, Microsoft's VSTS (which I think is custom), and whatever Atlassian
> and GitLab use.

Before I manually apply the patches to test how they work with
Bitbucket Server, are they applied on a branch somewhere where I can
just fetch them? If not, I'll apply them manually and verify.

Just based on the description, though, I expect no issues. We don't
currently support the git:// protocol. Our HTTP handling passes
headers through to the receive-pack and upload-pack processes as
environment variables (with a little massaging), but doesn't consider
them itself; it only considers the URL and "service" query parameter
to decide what command to run and to detect "dumb" requests. Our SSH
handling ignores any environment variables provided and does not
forward them to the git process, similar to VSTS.

I'll confirm explicitly, to be certain, but just based on reading the
overview and knowing our code I think the described approaches should
work fine.

Best regards,
Bryan Turner
