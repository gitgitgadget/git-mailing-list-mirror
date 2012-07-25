From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 13
Date: Wed, 25 Jul 2012 08:44:10 +0200
Message-ID: <87mx2omjb9.fsf@thomas.inf.ethz.ch>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox>
	<7vwr23zb65.fsf@alter.siamese.dyndns.org>
	<20120717082452.GC1849@tgummerer.surfnet.iacbox>
	<500C1AA9.4000306@dewire.com>
	<7vfw8jsk5o.fsf@alter.siamese.dyndns.org>
	<87629fvaxz.fsf@thomas.inf.ethz.ch>
	<7vr4s3pkqr.fsf@alter.siamese.dyndns.org>
	<500DD05D.8030708@dewire.com> <87d33lqsrp.fsf@thomas.inf.ethz.ch>
	<7vy5m9f65b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <pclouds@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 08:44:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StvKU-0008OC-OQ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 08:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab2GYGoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 02:44:13 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:7719 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591Ab2GYGoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 02:44:12 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 25 Jul
 2012 08:44:11 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 25 Jul
 2012 08:44:10 +0200
In-Reply-To: <7vy5m9f65b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 24 Jul 2012 09:58:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202132>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Junio's index-v4 was a speed boost mainly because it cuts down on the
>> size of the index.  Do we want to throw that out?
>
> That's pretty much orthogonal, isn't it?
>
> The index-v4 is merely to show how a stupid prefix compression of
> pathnames without nothing else would reduce the file size and I/O
> cost, in order to set the bar for anything more clever than that.
>
> I thought that this discussion is about keeping, squishing, or
> discarding part of the cached stat info, and nobody is suggesting
> what to do with the prefix compression of pathnames.

True, sorry for being so confusing.  'Throw "that" out' was meant to
refer to the observation that smaller indexes are generally faster.

Whether this matters in the long run is another question.  Perhaps
partial loading combined with something like inotify can avoid full
reads in most operations.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
