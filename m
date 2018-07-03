Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438D01F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeGIWit (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:38:49 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:38908 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbeGIWin (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:38:43 -0400
Received: by mail-pf0-f169.google.com with SMTP id x13-v6so4714676pfh.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 15:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-original-authentication-results:x-gm-message-state:resent-from
         :resent-date:resent-message-id:resent-to:date:from:to:cc:subject
         :message-id:references:mime-version:content-disposition:in-reply-to;
        bh=F1C5GADG6A+/2459HZI74cO1SC6+VnxhFjKgtzGAb6w=;
        b=amCEaIWl8E8qjdzC+oCqwX72bHrRaY3ncByVTv9x+jIehcllzDbheq9dciHueeOw+V
         37RW3BCi7qZ53aNTVaiISDXjnDg8NErTmjWTn8XQYnu6+v+GKVmpOokubFXBstDHrFL9
         TDteqvgrYYDqWjJRVk++/lJWAiPyjB5h+Eu6ulzWuMMiBUgFYpGKb3vVKWktwIh6PtZn
         cQ9i5d0R1LxZRoS7RSbBZ/RsGkCkjFKysXmR/MU5ycwcWiOE+QwIKaHwuusu/U1lcqhG
         tv5e6CB/uiDqpQ/23L3DxaDJcj7XNU+qjdt1ydLMhUAN78bqdjZaboHTUszwLWZjizde
         EhwA==
X-Original-Authentication-Results: peff.net; auth=none
X-Gm-Message-State: APt69E1XyDLCYy10UbG29piq0J5Wzu0HKXSZgUztRYZohWbacTAZxKnA
        LGFkvbWDy/60e/HTXcYgXHleJEN9
X-Google-Smtp-Source: AAOMgpf8nd8xfjbxulxDUYjKTDmNS7BKGuZiS4q9v+/jeV/p+zdhYJ2FbCYIHSygJ+aHReJ/mgbQXQ==
X-Received: by 2002:a63:fd06:: with SMTP id d6-v6mr17252644pgh.348.1531175922178;
        Mon, 09 Jul 2018 15:38:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s87-v6sm25382014pfg.172.2018.07.09.15.38.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:38:42 -0700 (PDT)
Authentication-Results: peff.net; auth=none
Authentication-Results: cloud.peff.net; auth=none
Received: by 2002:a6b:c8cc:0:0:0:0:0 with SMTP id y195-v6csp1397375iof;
        Tue, 3 Jul 2018 09:01:13 -0700 (PDT)
X-Received: by 2002:ac8:35b8:: with SMTP id k53-v6mr1833014qtb.39.1530633673792;
        Tue, 03 Jul 2018 09:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1530633673; cv=none;
        d=google.com; s=arc-20160816;
        b=QQMbtiTkhsCC7Us5/1cJpbEqPJWVmBO7eQs91MubSyCfVwaRD425CBnpU5Gl35x984
         sUzILxjn+DyQ1Ppt/TS6s14QvEtL6TqVFlAeRYEogDLLqP8anhQAUShGcRU2Vp353Q7t
         Eqg+THHQmamwsV5pnYRXM1sas72IOz+6FO4d20vh8lXcWjBtxLKDg+PboD9yntUCgF9a
         BOGj/lwgD16JnX4MGku8dOe/g/edjXaoEimBcsEVU0FRZQf1hQLKJCl42oC/yeq+yWqn
         /XGVRimerDCtbz1wkzRAi9nBm15SMVqJCLXH55u4066VzXQP5PIgk66i/CjzRjS6YziJ
         wGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=F1C5GADG6A+/2459HZI74cO1SC6+VnxhFjKgtzGAb6w=;
        b=kZwa1iBZUDURRJ2OnnXlIKtX5kmFttmtEY48wQVrNz7S8qmfxsTkzG7VSLOJatY6IX
         7kOOhL0uCYAP1wa06PTD+P3kLczZnTGJSh6jrvHeSZUWsiLnyZ849Cd77E+ZE/rlUcEn
         xHK4eaISp3eiC5DJM+Gv3fRZKqlGDQmMPsxcebdIy+UoH5LDFAa2wNejt3nkycq+DavK
         cgCXuJXMCk4T72k+LPvzmWMQSBQc5FOXZj/CtzUfkGVEazSZh1RYf3FCCi+WKW0kDsMd
         gqutQNCvqbjF0ElFizYVlwAWMG/OgBU7zIHG6RVx1CkA4K/KLIgqNc55llsXsNESIV4Q
         IJIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of peff@peff.net designates 104.130.231.41 as permitted sender) smtp.mailfrom=peff@peff.net
Received: from cloud.peff.net (cloud.peff.net. [104.130.231.41])
        by mx.google.com with SMTP id p50-v6si1496184qta.67.2018.07.03.09.01.13
        for <jrnieder@gmail.com>;
        Tue, 03 Jul 2018 09:01:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 104.130.231.41 as permitted sender) client-ip=104.130.231.41;
Received: (qmail 24177 invoked by uid 109); 3 Jul 2018 16:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Jul 2018 16:01:12 +0000
Received: (qmail 2875 invoked by uid 111); 3 Jul 2018 16:01:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Jul 2018 12:01:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2018 12:01:10 -0400
Date:   Tue, 3 Jul 2018 12:01:10 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Akilsrin <Akilsrin@apple.com>,
        Christian Couder <christian@gitlab.com>,
        Tim Triemstra <timt@apple.com>,
        Eliran Mesika <eliran@gitlab.com>
Subject: Re: Subscribing Apple people to git-security@googlegroups.com
Message-ID: <20180703160110.GA26771@sigill.intra.peff.net>
References: <CAGba+=U4nbxL2uuSxyqyZqiiavJpo_E=GhUkipz6DczLdmnkgQ@mail.gmail.com>
 <20180702195016.GA17102@sigill.intra.peff.net>
 <91A9F3A0-5F3F-4137-9A40-CB42EDE4F243@apple.com>
 <20180703133645.GA20316@sigill.intra.peff.net>
 <20180703154814.GA51821@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703154814.GA51821@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 03, 2018 at 08:48:14AM -0700, Jonathan Nieder wrote:

> Administrivia: do you mind if I bounce these messages to some archived
> list, either git@vger.kernel.org or git-security?  Or if we'd prefer
> to avoid the noise from that, do you mind if I work with Eric Wong to
> get them injected in the https://public-inbox.org/ archive?

I don't mind at all. I'm actually going to work later today on preparing
other messages from the security list to go to the public-inbox.org
archive, so that might pave the way.

-Peff
