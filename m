Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D271C352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 11:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A1322314
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 11:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgBGLC0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 7 Feb 2020 06:02:26 -0500
Received: from claranet-outbound-smtp08.uk.clara.net ([195.8.89.41]:48518 "EHLO
        claranet-outbound-smtp08.uk.clara.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgBGLCZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Feb 2020 06:02:25 -0500
X-Greylist: delayed 1167 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Feb 2020 06:02:25 EST
Received: from 79-76-60-118.dynamic.dsl.as9105.com ([79.76.60.118]:36085 helo=PDSDELL)
        by relay08.mail.eu.clara.net (relay.clara.net [81.171.239.38]:10465)
        with esmtpa (authdaemon_login:gershenson-smith) id 1j0168-0006Nd-SO  for git@vger.kernel.org
        (return-path <paul@pauldsmith.org.uk>); Fri, 07 Feb 2020 10:42:57 +0000
From:   <paul@pauldsmith.org.uk>
To:     <git@vger.kernel.org>
References: <VI1P192MB025548BB0508125DF9B5852DC81C0@VI1P192MB0255.EURP192.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P192MB025548BB0508125DF9B5852DC81C0@VI1P192MB0255.EURP192.PROD.OUTLOOK.COM>
Subject: Support 'help' for custom/alias commands
Date:   Fri, 7 Feb 2020 10:42:56 -0000
Message-ID: <005001d5dda3$5bc12510$13436f30$@pauldsmith.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
thread-index: AQJYcFYYt0Fq+QhLlA5BsdLSkzFOOqcKZa7g
Content-Language: en-gb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding a custom comment (let’s call is ‘foolish’) is easy but then you
someone types ‘git help foolish’, they get some strange message about help
not being found.

There are two problems with this:

1. It’s hard for users to create good documentation in the same format as
the core git product 2. The git ‘help’ processing currently looks in one,
and one place only and that location is often ‘locked down’ meaning that
mere users cannot add their custom help to this directory.

I propose that #1 be solved by creating a command/tool and documentation
that explains how to mimic the input to the standard Git help files and have
them processed to create the HTML/HTML5/MAN help normally produced.  Ideally
it would do exactly the same processing as the core tools (perhaps even
having their docs built using this tool now) and use exactly the same
template files that core git uses.

I propose that #2 be solved by allowing a new set of ‘git config’ fields.
The layout should be sensible and should users to be able to set a git
variable which then means that the core git help finds their help text.
Possible we want to force

<where I installed my tool>/docs/man, or html, or html5

And the git config variable be something like
“help.custom.foolish=<where-foolish-is-installed>/docs”

Paul DS.

P.S. I have a perfectly respectable e-mail address at
paul_d_smith@hotmail.com which I have used for years - why won't you accept
e-mails from it?



