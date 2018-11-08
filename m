Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8A11F453
	for <e@80x24.org>; Thu,  8 Nov 2018 21:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeKIH3E (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 02:29:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44733 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeKIH3E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 02:29:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id j17-v6so17715005wrq.11
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 13:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OjTuvc+OmvVFBBGpOf6/mR8ON56dtN4XcJ/eFR7+Adg=;
        b=jVNl/z0CqXzC6jg/t9h089jaJD/eoapyyPuXVzJXJTajlQx7JrWc+7/p9ZOx92s3Hy
         hhw5/d9LtgQWVGsG27HLCrQSnZrkgRyOtsjOoMkH+dPQ5SbqYCLQ7o/SMPQDsa+j/ozI
         eNpY+muHwg+iZY7EDXQBjvkKYW8hsDSzWm4iUSWYFtqdjOJOEXOgHli+DxNveYAYxq8w
         qocdZJusb/jWAZaPme1NTmAKX9ekBOqh2PrxbzM3qVFHPDGrfk49Ub4vMsqSYVGZPLXs
         G4P0o3wZNYk1BLxZg60u/C8uK2qVViECD4hCMkN/VexEENxKW0qAZQyEctrO14nXcwkj
         vWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OjTuvc+OmvVFBBGpOf6/mR8ON56dtN4XcJ/eFR7+Adg=;
        b=hDbjw2hMahw9+Wk4bp+fV9zrV56Zy0HTGVkg8XZBno0dK9RiQAaUzjDp6WiK0IbBgs
         u0+SesCnRNjIpCeDPSIuJMhuNCh+pR1pxV2EX0ZYsRSUR09FUWUaIEuEc++2fu5GBjFs
         gCSmoYhptf7NuQdeg65to9aosy1xz0PRS2TreoFW/Y64U0+mvIxYkszIoUDP+vRD18Ho
         xwA6Mj4xUy+QCN1gGkODuFjAaZ7WmuNVRX8D8pSNSkMWkBplAgJ4DTDmiRm4DOvQ2PTV
         F/8wrv9iUMvbRjBvAzsCLUTBXEb7LhXY+XjgyE/9o7uKa8emNZ2sFmXHCUdSO+8FwiYz
         FvKw==
X-Gm-Message-State: AGRZ1gJkqorpsQK9gJSLLbmGEiPIvGkb5/haeWGFEeeL2Eqf5Mc82TeI
        LSg8RCpgepGR5Vmr3wHb3b8=
X-Google-Smtp-Source: AJdET5fv/lG9j13j+JM8/s4DXryjJOPHNcbIQerWh/+SRFQhV8a51pRgtGUrlHivZKrEb62artOySg==
X-Received: by 2002:adf:f651:: with SMTP id x17-v6mr5393240wrp.229.1541713896711;
        Thu, 08 Nov 2018 13:51:36 -0800 (PST)
Received: from szeder.dev (x4db97fb9.dyn.telefonica.de. [77.185.127.185])
        by smtp.gmail.com with ESMTPSA id 126-v6sm4028827wme.48.2018.11.08.13.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 13:51:35 -0800 (PST)
Date:   Thu, 8 Nov 2018 22:51:33 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: install packages in
 'ci/install-dependencies.sh'
Message-ID: <20181108215133.GC30222@szeder.dev>
References: <20181026013949.GN30222@szeder.dev>
 <20181101114714.14710-1-szeder.dev@gmail.com>
 <xmqqa7msrzaq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa7msrzaq.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 02, 2018 at 11:25:17AM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Ever since we started using Travis CI, we specified the list of
> > packages to install in '.travis.yml' via the APT addon.  While running
> > our builds on Travis CI's container-based infrastructure we didn't
> > have another choice, because that environment didn't support 'sudo',
> > and thus we didn't have permission to install packages ourselves.  With
> > the switch to the VM-based infrastructure in the previous patch we do
> > get a working 'sudo', so we can install packages by running 'sudo
> > apt-get -y install ...' as well.
> 
> OK, so far we learned that this is now _doable_; but not enough to
> decide if this is a good thing to do or not.  Let's read on to find
> out.

Yeah, this paragraph is just a bit of background about how the current
situation came to be and what recent change made the switch possible.

> > Let's make use of this and install necessary packages in
> > 'ci/install-dependencies.sh', so all the dependencies (i.e. both
> > packages and "non-packages" (P4 and Git-LFS)) are handled in the same
> > file.  
> 
> So we used to have two waysto prepare the test environment; non
> packaged software were done via install-dependencies.sh, but
> packaged ones weren't.  Unifying them so that the script installs
> both would be a good change to simplify the procedure.  
> 
> Is that how this sentence argues for this change?

Yes.

> > Install gcc-8 only in the 'linux-gcc' build job; so far it has
> > been unnecessarily installed in the 'linux-clang' build job as well.
> 
> Is this "unneeded gcc-8 was installed" something we can fix only
> because we now stopped doing the installation via apt addon?

Now that you mention it: no.  It would have been possible to install
gcc-8 only in the 'linux-gcc' build job even via the apt addon, namely
by removing the two Linux build jobs from the implicit build matrix
and adding them as two independent build jobs in the 'matrix.include'
section of '.travis.yml'.  The drawback is that all the extra packages
used in both build jobs would have to be duplicated.

> Or we
> could have fixed it while we were on apt addon but we didn't bother,
> and this patch fixes it "while at it"---primarily because the shell
> script is far more flexible to work with than travis.yml matrix and
> this kind of customization is far easier to do?

Basically yes (though I think it's not about not bothering; I don't
know about others, but it just occured to me that it would have been
doable, however, even if it occured to me earlier, because of the
duplicated list of common packages I wouldn't have done it).

Doing it in good old shell is indeed easier and the common packages
are then only listed once.

> > Print the versions of P4 and Git-LFS conditionally, i.e. only when
> > they have been installed; with this change even the static analysis
> > and documentation build jobs start using 'ci/install-dependencies.sh'
> > to install packages, and neither of these two build jobs depend on and
> > thus install those.
> >
> > This change will presumably be beneficial for the upcoming Azure
> > Pipelines integration [1]: preliminary versions of that patch series
> > run a couple of 'apt-get' commands to install the necessary packages
> > before running 'ci/install-dependencies.sh', but with this patch it
> > will be sufficient to run only 'ci/install-dependencies.sh'.
> 
> So the main point of this change is to have less knowledge to
> prepare the target configuration in the .travis.yml file and keep
> them all in ci/install-dependencies.sh, which hopefully is more
> reusable than .travis.yml in a non Travis environment?

Oh, "more reusable" indeed, that's a more eloquent way to put it.

> If that is the case, it makes sense to me.
> 
> > This patch should go on top of 'ss/travis-ci-force-vm-mode'.
> >
> > I'm not sure about the last paragraph, because:
> >
> >   - It talks about presumed benefits for a currently still
> >     work-in-progress patch series of an other contributor, and I'm not
> >     really sure that that's a good thing.  Perhaps I should have
> >     rather put it below the '---'.
> >
> >   - I'm confused about the name of this Azure thing.  The cover letter
> >     mentions "Azure Pipelines", the file is called
> >     'azure-pipelines.yml', but the relevant patch I link to talks
> >     about "Azure DevOps" in the commit message.
> >
> > Anyway, keep that last paragraph or drop it as you see fit.
> 
> I hope we'll hear from Dscho in one or two revolutions of the Earth
> ;-)

... revolutions around what? :)

