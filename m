Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5652023D
	for <e@80x24.org>; Fri, 19 May 2017 22:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756707AbdESW1m (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 18:27:42 -0400
Received: from mail-out10.booking.com ([5.57.21.191]:45365 "EHLO
        mail-out10.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756068AbdESW1l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 18:27:41 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 May 2017 18:27:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=booking.com
        ; s=bk; h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:
        In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pL4Ocl4kF538A/vRagxhX4sCk0LSQqNkk1FU6AlbjRs=; b=It00ajOPRJ54At4/Bc5ez+WChT
        LCUNxJ9zbQF1eKq4scNHfrzcobDiYn/jJeTH2EX7Ex1OSndJ8Si0Zu8lKgOUvL6XgUBr2mJnL63tL
        E8C+RQ1I3oua0WiYElB6ntvdjZIcXcw0eIMvFeR62LEzbnqLalPPjkQMEkRSzfP2KfiU=;
Received: from mqueue-102.ams4.prod.booking.com ([10.192.5.5]:49960)
        by mtx-107.ams4.prod.booking.com with esmtp (Exim 4.89)
        (envelope-from <dennis.kaarsemaker@booking.com>)
        id 1dBps2-0001HD-81
        for git@vger.kernel.org; Fri, 19 May 2017 23:55:38 +0200
Received: from exscan-101.ams4.prod.booking.com (exscan-101.ams4.prod.booking.com [10.192.5.20])
        by mqueue-102.ams4.prod.booking.com (Postfix) with ESMTP id 3AAE44E
        for <git@vger.kernel.org>; Fri, 19 May 2017 23:55:38 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by exscan-101.ams4.prod.booking.com (Postfix) with SMTP id 3wV2162WHwz1JcDj
        for <git@vger.kernel.org>; Fri, 19 May 2017 23:55:38 +0200 (CEST)
Received: from mx10.booking.com (mrx-111.ams4.prod.booking.com [10.192.6.5])
        by exscan-101.ams4.prod.booking.com (Postfix) with ESMTPS id 3wV2140xY6z1Jby5
        for <git@vger.kernel.org>; Fri, 19 May 2017 23:55:36 +0200 (CEST)
Received: from mail-wr0-f200.google.com ([209.85.128.200]:44267)
        by mrx-111.ams4.prod.booking.com with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <dennis.kaarsemaker@booking.com>)
        id 1dBprz-0006gg-PB
        for git@vger.kernel.org; Fri, 19 May 2017 23:55:35 +0200
Received: by mail-wr0-f200.google.com with SMTP id y43so6787146wrc.11
        for <git@vger.kernel.org>; Fri, 19 May 2017 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=booking-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pL4Ocl4kF538A/vRagxhX4sCk0LSQqNkk1FU6AlbjRs=;
        b=MkdrP2jFls79U7dJIYSOvUOLos1EzJMWK4kqanMlQqnx1jQb1tE2sL23Th7bMo+qz2
         y01Wng3TJhL0mf3pAPigInBXmNbj5cz8FuE8mkwo1bShkxBjeUfLBotvntjIWnTMGCUz
         zbzpkipeZ/GU6tVKNaYv27QNcOvFalEPYbaPioCl/cV88FiUlIm/0xprpFYSkhTMaIH5
         +yGRECiry9VDS+5VaKhZPMtC2XykdDreYN0xHRUsGoH9G9YsYfEKUHmjD1Hv4BAxUjZT
         WYF3emB0F8H2LKWmOiLRm+4R0blMm+XQbLaww2p3EKK/18AJ3sPnNMl2OSZtZeEfqU7n
         4X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pL4Ocl4kF538A/vRagxhX4sCk0LSQqNkk1FU6AlbjRs=;
        b=ptMN+3nk+m974VTs3s4ktJCBEytM5afno8ZiYm+lWvdBRdrzPGd0Wn7qos+3jCCDao
         adB/y3Z5HntMb06dWC00VUrAenEQQmClMJ6lMYSj3MXZALWz8l0VFUNUT3IgwoQhqUsK
         W6tZEy2t3DY2RkslUuh0fZSrLT+RkKBmbbyHcOseGIPpjwLEXObmzRURjpx3PG20G18o
         zVIJSZUlUDdWG3NOS7/B390rzS/E0RQ8wDKxBUos8ZEdrUGbcpuW4SqOriPwi14xTZqM
         ZNST+jkTNPPa62NJhjtxqVAWz3e2azI9k+gEmtq6B17LHx8A3KPFGcB+n/pYo3/mGkG7
         /LGw==
X-Gm-Message-State: AODbwcDKydCpK0fLKZKumjZZ0qIpRG5toakkt0cSj72hMX1llGdQh5NS
        hnXGLpfH7cVycK1MCa1EwhMd44IY1sC1g7hPyLW0bUCtzVBHjTE6xdvi3asMHaAFyqSPzv5PSNQ
        91A==
X-Received: by 10.80.147.94 with SMTP id n30mr8502222eda.146.1495230935573;
        Fri, 19 May 2017 14:55:35 -0700 (PDT)
X-Received: by 10.80.147.94 with SMTP id n30mr8502215eda.146.1495230935385;
        Fri, 19 May 2017 14:55:35 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id c47sm3751807ede.32.2017.05.19.14.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 May 2017 14:55:34 -0700 (PDT)
Message-ID: <1495230934.19473.10.camel@booking.com>
Subject: Re: persistent-https, url insteadof, and `git submodule`
X-FireEye: Clean
From:   Dennis Kaarsemaker <dennis.kaarsemaker@booking.com>
To:     Elliott Cable <me@ell.io>, Git Mailing List <git@vger.kernel.org>,
        bmwill@google.com, peff@peff.net
Date:   Fri, 19 May 2017 23:55:34 +0200
In-Reply-To: <1495230186.19473.7.camel@kaarsemaker.net>
References: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
         <1495230186.19473.7.camel@kaarsemaker.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AH-From: dennis.kaarsemaker@booking.com
X-AH-Rcpt: git@vger.kernel.org
X-Verified-External: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-05-19 at 23:43 +0200, Dennis Kaarsemaker wrote:
> On Fri, 2017-05-19 at 14:57 -0500, Elliott Cable wrote:
> > Set up `persistent-https` as described in the [README][]; including the
> > ‘rewrite https urls’ feature in `.gitconfig`:
> > 
> >     [url "persistent-https"]
> >         insteadof = https
> >     [url "persistent-http"]
> >         insteadof = http
> > 
> > Unfortunately, this breaks `git submodule add`:
> > 
> >     > git submodule add https://github.com/nodenv/nodenv.git \
> >         ./Vendor/nodenv
> >     Cloning into '/Users/ec/Library/System Repo/Vendor/nodenv'...
> >     fatal: transport 'persistent-https' not allowed
> >     fatal: clone of 'https://github.com/nodenv/nodenv.git' into
> > submodule path '/Users/ec/Library/System Repo/Vendor/nodenv' failed
> > 
> > Presumably this isn't intended behaviour?
> 
> It actually is. git-submodule sets GIT_PROTOCOL_FROM_USER to 0, which
> makes git not trust any urls except http(s), git, ssh and file urls
> unless you explicitely configure git to allow it. See the
> GIT_ALLOW_PROTOCOL section in man git and the git-config section it
> links to.

33cfccbbf3 (submodule: allow only certain protocols for submodule
fetches, 2015-09-16) says:

    submodule: allow only certain protocols for submodule fetches
    
    Some protocols (like git-remote-ext) can execute arbitrary
    code found in the URL. The URLs that submodules use may come
    from arbitrary sources (e.g., .gitmodules files in a remote
    repository). Let's restrict submodules to fetching from a
    known-good subset of protocols.
    
    Note that we apply this restriction to all submodule
    commands, whether the URL comes from .gitmodules or not.
    This is more restrictive than we need to be; for example, in
    the tests we run:
    
      git submodule add ext::...
    
    which should be trusted, as the URL comes directly from the
    command line provided by the user. But doing it this way is
    simpler, and makes it much less likely that we would miss a
    case. And since such protocols should be an exception
    (especially because nobody who clones from them will be able
    to update the submodules!), it's not likely to inconvenience
    anyone in practice.


D.

