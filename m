X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 11:57:15 +0200
Message-ID: <vpqd58g3eh0.fsf@ecrins.imag.fr>
References: <45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	<453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org>
	<453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org>
	<45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org>
	<20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 09:58:27 +0000 (UTC)
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <453F2FF8.2080903@op5.se> (Andreas Ericsson's message of "Wed\, 25 Oct 2006 11\:35\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Wed, 25 Oct 2006 11:57:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30045>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcfWd-0003Wv-8t for gcvg-git@gmane.org; Wed, 25 Oct
 2006 11:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423178AbWJYJ6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 05:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423169AbWJYJ6Q
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 05:58:16 -0400
Received: from imag.imag.fr ([129.88.30.1]:46503 "EHLO imag.imag.fr") by
 vger.kernel.org with ESMTP id S1423178AbWJYJ6P (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 05:58:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52]) by
 imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9P9vHNO002727
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO); Wed, 25 Oct 2006
 11:57:17 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124]) by mail-veri.imag.fr with
 esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GcfVb-00077J-M4; Wed,
 25 Oct 2006 11:57:15 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50) id
 1GcfVb-0000Fy-IO; Wed, 25 Oct 2006 11:57:15 +0200
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

> This is new to me. At work, we merge our toy repositories back and
> forth between devs only. There is no central repo at all. Does this
> mean that each merge would add one extra commit per time the one I'm
> merging with has merged with me?

Two things differ in bzr and git, here:

* bzr doesn't do "autocommit" after a merge. So, new revisions are
  created only if you use"commit".

* bzr has two commands, "pull" and "merge". "pull" just does what the
  git people call "fast-forward", and only this (it refuses to do
  anything if the branches diverged). In particular, you never have to
  commit after a pull (well, except if you had some local, uncommited
  changes). "merge" changes your working directory, and you have to
  commit after. "merge" will never do fast-forward, it will never
  change the revision to which your working tree revfers to, and it's
  your option to commit or not after (if you see that it introduces no
  changes, you might not want to commit).

The final rule in bzr would be "you create an extra commit each time
you commit" ;-).

As a side-note, it could be interesting to have a git-like merge
command (chosing automatically between merge and pull), probably not
in the core, but as a plugin.

-- 
