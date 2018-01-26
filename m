Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3F01F404
	for <e@80x24.org>; Fri, 26 Jan 2018 00:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeAZAvI (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 19:51:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:58272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751375AbeAZAvH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 19:51:07 -0500
Received: (qmail 1047 invoked by uid 109); 26 Jan 2018 00:51:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 00:51:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10883 invoked by uid 111); 26 Jan 2018 00:51:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Jan 2018 19:51:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jan 2018 19:51:05 -0500
Date:   Thu, 25 Jan 2018 19:51:05 -0500
From:   Jeff King <peff@peff.net>
To:     rleach@princeton.edu
Cc:     git@vger.kernel.org
Subject: Re: git credential-osxkeychain bug/feature?
Message-ID: <20180126005105.GD14017@sigill.intra.peff.net>
References: <7445BC5F-F041-4E7D-8CB5-9513EEFF2C8C@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7445BC5F-F041-4E7D-8CB5-9513EEFF2C8C@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 12:16:33PM -0500, Robert Leach wrote:

> But perhaps access to KA from a remote ssh session is restricted for
> security reasons?  I'm just curious I suppose.  Should/can this work?

It's definitely not a restriction from the osxkeychain credential
helper. I believe that MacOS only unlocks the keychain for console
logins by default.

Googling around I turned up this[1]:

  security unlock-keychain -p <YourPassword> ~/Library/Keychains/login.keychain

but I don't even have a mac these days to see if that still works. And
according to [2] you may have to fiddle with auto-confirmation. Good
luck. :)

-Peff

[1] https://superuser.com/questions/270095/when-i-ssh-into-os-x-i-dont-have-my-keychain-when-i-use-terminal-i-do

[2] https://apple.stackexchange.com/questions/178139/how-can-i-access-the-keychain-remotely-from-the-command-line
