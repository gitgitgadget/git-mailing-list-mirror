Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736ED20756
	for <e@80x24.org>; Tue, 17 Jan 2017 18:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbdAQSv1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 13:51:27 -0500
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:49208
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750918AbdAQSv0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Jan 2017 13:51:26 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jan 2017 13:51:26 EST
Received: from jessie.local ([82.181.81.240])
        by :SMTPAUTH: with SMTP
        id TYiAcO2kQ9jIhTYiEcMRgS; Tue, 17 Jan 2017 11:42:32 -0700
Date:   Tue, 17 Jan 2017 20:42:24 +0200
From:   Max Kirillov <max@max630.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Max Kirillov <max@max630.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG/RFC] Git Gui: GIT_DIR leaks to spawned Git Bash
Message-ID: <20170117184224.GA23841@jessie.local>
References: <20170116224022.GA8539@jessie.local>
 <alpine.DEB.2.20.1701171145050.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701171145050.3469@virtualbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfItV/Tg11KyF5Q2lSKew6tfDwZqDELqg70rbn/pZ7mMWOS+VthmrN0lp/AlUqhxOeQYaZPsH7oBE+Vde+DnCC2y3Rr6VZ4FrkO4gzMe+YKrHoT+3Tadk
 vhRoqJV76WJuy8iPBGaEY5NY0xc5ynpv/2CZ6SfDD/knqG8zg2wv3kdsBdCmdPRg+3mWWoOjVGlrABxhjoiBBe17lvRp/XYjF1jrCpC8TddB2N6TBDzKgYez
 Vfgz3XJU69b26qDDNUrdMRcdXTDw74AjGYFizVJy650m9m9xDRF0o1Jjd8fzgkKx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 11:52:29AM +0100, Johannes Schindelin wrote:
> Hi Max,
> 
> On Tue, 17 Jan 2017, Max Kirillov wrote:
> 
>> Apparently various GIT_* environment variables (most
>> interesting is GIT_DIR but AFAIR there were more) leak to
>> shell session launched from Git Gui's "Git Bash" menu item.

...

> After all, you won't even notice unless you use the very
> same Git Bash to navigate to a *different* worktree.

That's right, I haven't been noticing it myself for quite a
time. But once I decided to tweak my habits to having only
one terminal window opened, and immediately noticed.

> And having said *that*, I have to admit that I was unable to reproduce

I have found exact way to reproduce it and actually the
reason. Turns out to be obvious mistake in code. PR is in
github: https://github.com/git-for-windows/git/pull/1032

-- 
Max
