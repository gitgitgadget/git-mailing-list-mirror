From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Thu, 28 Jul 2005 21:25:45 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.28.19.25.39.562903@smurf.noris.de>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <20050722205948.GE11916@pasky.ji.cz> <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <20050728155210.GA17952@pasky.ji.cz> <42E9020F.3080302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Jul 28 21:29:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyE44-0004PR-HU
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 21:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVG1T2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 15:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVG1T0g
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 15:26:36 -0400
Received: from main.gmane.org ([80.91.229.2]:25573 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262080AbVG1T0b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 15:26:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DyE1B-00047J-KB
	for git@vger.kernel.org; Thu, 28 Jul 2005 21:26:09 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 21:26:09 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 21:26:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, A Large Angry SCM wrote:

> So you're arguing for "last match wins" versus "first match wins". I, 
> personally, find the former more natural and easier to debug by hand.

You know, up until five minutes ago, I thought so too.

However ... as a human being, I liik for meaning, not for processing
instructions. Thus, reading the list top-down, this

> 	*.html
> 	!f*.html
> 	fo*.html

makes perfect sense to me. ("Throw away the HTML files. Well, except for
those that start with 'f'. Well, *except* for foobar.html or whatever.")

The other way round, however, the sequence
> 	fo*.html
> 	!f*.html
> 	*.html

is not immediately understandable in one pass, as the second line makes no
sense whatsoever without the third one. ("Throw away foobar.html. Umm,
we're keeping everything anyway, so why ... oh, HTML files are junked, OK,
so ... now ... umm, what did I want to find out in the first place?")

It gets even more confusing when you're lazy and omit the .html suffix in
the second line.

YMMV, and all that.
-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
(It is an old Debian tradition to leave at least twice a year ...)
	-- Sven Rudolph
