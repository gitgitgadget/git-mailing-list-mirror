Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB6CC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 01:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C7921E92
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 01:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgLIB3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgLIB3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 20:29:24 -0500
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Dec 2020 17:28:28 PST
Received: from pug.qqx.org (pug.qqx.org [IPv6:2600:3c02:e000:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9196C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 17:28:28 -0800 (PST)
Received: by pug.qqx.org (Postfix, from userid 1000)
        id BBC691DB50; Tue,  8 Dec 2020 20:18:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schrab.com; s=mail;
        t=1607476702; bh=b03uVGBiH94rMfDm90IJvgdHE3hpMUMOGy0GjqEOA24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXsLpdFQeM4ubifppfNDhA9ik+NVyWWqVmLeByaxvti64LzShYz63MFq9mUJuOWDH
         0jRbCWK8HBWJu+VlMagjQDVF4iuTeRWkO8aZGW5Eo0wrdIf4n284WfJUOBImqJxdMN
         T7giJJYIsoLXk2NQ2VVw3P4CyOWKnNkvsk6qV5fdgp2OPKb7ZDfHFA2a27tXVzUHG9
         YnNPnHwSHGULNM3GP4wUt+Pv+9ta83+YfuKCom3SAMScIg9zJP4HOxMO73x7+JE2/V
         GJ/mGFu9lZmDeHG1R7p5Xg4s/vGFOfGOjKODV7zgYfk996XtwtZDvJFcBfbsT93Bzw
         6E2ICFo+FNoLQ==
Date:   Tue, 8 Dec 2020 20:18:22 -0500
From:   Aaron Schrab <aaron@schrab.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
Message-ID: <X9Al3u9/jw3QWN7q@pug.qqx.org>
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>
References: <20201209002619.25468-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201209002619.25468-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 18:26 -0600 08 Dec 2020, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>By default it's ignored, you need the following in your ~/.vimrc
>
>  set exrc

Running `:help 'exrc'` in vim includes the text:

         Setting this option is a potential security leak.  E.g., consider
         unpacking a package or fetching files from github, a .vimrc in there
         might be a trojan horse.  BETTER NOT SET THIS OPTION!
         Instead, define an autocommand in your .vimrc to set options for a
         matching directory.

So I don't think it's a good idea to encourage people to do that by 
using a name that invites it. Also I think that the file would be more 
discoverable for people to incorporate into their own configuration if 
not named as a hidden file.
