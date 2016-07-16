Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3F82018F
	for <e@80x24.org>; Sat, 16 Jul 2016 21:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbcGPVOt (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 17:14:49 -0400
Received: from agora.rdrop.com ([199.26.172.34]:1574 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbcGPVOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 17:14:48 -0400
X-Greylist: delayed 1413 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jul 2016 17:14:48 EDT
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id u6GKp89s063874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Jul 2016 13:51:08 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id u6GKp8Mu063873;
	Sat, 16 Jul 2016 13:51:08 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA10573; Sat, 16 Jul 16 13:47:31 PDT
Date:	Sat, 16 Jul 2016 13:47:23 -0700
From:	perryh@pluto.rain.com (Perry Hutchison)
To:	norm@dad.org
Cc:	git@vger.kernel.org
Subject: Re: Question: Getting 'git diff' to generate /usr/bin/diff output
Message-Id: <578a9d5b.xL1egXSTCv+mjhAT%perryh@pluto.rain.com>
References: <201607161912.u6GJCM79069898@shell1.rawbw.com>
In-Reply-To: <201607161912.u6GJCM79069898@shell1.rawbw.com>
User-Agent: nail 11.25 7/29/05
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

norm@dad.org wrote:

> I am trying to learn how to use git, and am having difficulty
> using 'git diff'.
>
> I can't deal with its output very well. What I would really like
> to do is apply /usr/lib/diff.
                      ^^^

For starters, when using the full pathname, you'll need to spell it
correctly :)

> Would some kind soul be willing to tell me if there is a way to
> do that, short of making a backup copy of the relevant file, and
> then doing 'git checkout'. Maybe the '--ext-diff' argument to
> 'git diff' will do that, but I can't figure out how to use it.
> ...
>     git version: 2.5.1.454.g1616360

'git cat' would be simpler than making a backup and using 'git checkout',
but for this use case there's a better way even than that.

Google is your friend when you can't figure something out from (or
find the right part of) a program's own documentation.  A search for

    git "external diff program"

(including the quotes) found several references.

One possible complication:  It's likely that the command parameters
which git passes to an external diff program are not exactly what
/usr/bin/diff requires.  The solution to that sort of problem is to
write a very short executable script that rearranges the parameters
as needed, and specify that script (instead of /usr/bin/diff itself)
as the external diff program.
