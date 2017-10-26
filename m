Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2950A202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 21:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdJZVaI (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 17:30:08 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:52390 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdJZVaG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 17:30:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id e64so3410090pfk.9
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ySoAxhTZ73uLGEi0pEAD5LDa4VbvHXjJtsrX+B5KifA=;
        b=fWZX8pKvclKQsIZTNQ7Xscp+R0KqmdapccIVM23S50Y3R99wnC7vBlfFq9/CO6tgMl
         zJazo/haGV7mKE6vHPvaE84lm5erO+ApCQf66ar+qvwOg0xlA1fUa6He7qkXAodsDK3m
         ovV8S8qhLHUhC8r1NB//DU3iKypo/slI8kN+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ySoAxhTZ73uLGEi0pEAD5LDa4VbvHXjJtsrX+B5KifA=;
        b=pqdwX2UH/6bGXj6xdRL/GvCfLN+mK4F0fBzB3tyXSNimZ13kgXDMPioMEmU4t0AzwV
         2NB6ne4M7TyFEASySRULTIYyE16ss3HsLpLGninyPNEOAflCLGpym5NeU5iTFdOfLOWZ
         0eM2xBuyyDYQICL7mNDyuBA2MyVTT3rhG5ehXShe1tMg2PN/pZsqU+ww0FjvQVhxD+J8
         h4gTyiNCTeAOAcSPLYukMz261cZAJizancgF9FJYamsGUFHPOIMnFGtkbJ93oY9jp3Fk
         CXDbdLNNnsWbHqa8R7p+LNwFGak2OW8K+8j1vn4NFg1T25nT3xDUtG8SEU31V6amNumG
         aCsw==
X-Gm-Message-State: AMCzsaUDlV+25+jRMDOTjwnoi5bIbVIONIHKdHgJgVdZWG1ZOrZVx2y0
        Gi5C3FxK2uMpL5v19FZWSq3+Xw==
X-Google-Smtp-Source: ABhQp+SfRUx5gP9MjvekFvjEaAbDlTPq6aUe7ReWjX3ot56oxtG97iPtIgV7Ca6j2vz2joIefg9kXw==
X-Received: by 10.101.90.73 with SMTP id z9mr6051949pgs.76.1509053405789;
        Thu, 26 Oct 2017 14:30:05 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id u77sm11296381pfd.168.2017.10.26.14.30.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Oct 2017 14:30:05 -0700 (PDT)
Date:   Thu, 26 Oct 2017 14:29:57 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Ben Peart <peartben@gmail.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/4] fsmonitor: Don't bother pretty-printing JSON from
 watchman
In-Reply-To: <9bd24b15-6232-1afd-abbe-02870c51c7ad@gmail.com>
Message-ID: <alpine.DEB.2.10.1710261427300.9817@alexmv-linux>
References: <20171026013117.30034-1-alexmv@dropbox.com> <42fd8bccb78992a2894e711e057230a673891628.1508981451.git.alexmv@dropbox.com> <9bd24b15-6232-1afd-abbe-02870c51c7ad@gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 26 Oct 2017, Ben Peart wrote:
> On 10/25/2017 9:31 PM, Alex Vandiver wrote:
> > diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
> > index a3e30bf54..79f24325c 100755
> > --- a/t/t7519/fsmonitor-watchman
> > +++ b/t/t7519/fsmonitor-watchman
> > @@ -50,7 +50,7 @@ launch_watchman();
> >     sub launch_watchman {
> >   -	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
> > +	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
> 
> Since this is a test script performance isn't critical.  This version of the
> integration script logs the response to a file in .git/watchman-response.json
> and is much more human readable without the "--no-pretty."  As such, I'd leave
> this one pretty.

This would be the first delta between the test file and the template
file.  It seems quite important to me to attempt to ensure that we're
testing the _same_ contents that we're suggesting users set up.  In
fact, it makes more sense to me to just turn this into a symlink to the
sample template.
 - Alex
