From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 02:13:16 +0200
Message-ID: <20080910001316.GF7459@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <20080909195930.GA2785@coredump.intra.peff.net> <7vljy159v7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 02:17:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdDOZ-0005nI-B5
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 02:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbYIJANR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 20:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbYIJANR
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 20:13:17 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:50673 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbYIJANR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 20:13:17 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 1FA5E5465; Wed, 10 Sep 2008 02:13:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vljy159v7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95471>

Junio C Hamano wrote:
>As for "by the way ... was used to make this commit": this is git.  So how
>you arrived at the tree state you record in a commit *does not matter*.

The typical use case for the origin links is in a project with several
long-lived branches which use cherry-picks to backport amongst them.
There is no real other way to solve this case, except for some rather
kludgy stuff in the free-form commit message which doesn't mesh well
with rebase/filter-branch/stgit etc.

As to "does not matter": then why does git store parent links?

>To my ears, it rhymes rather well with a famous quote from $gmane/217:

>    You're freezing your (crappy) algorithm at tree creation time, and
>    basically making it pointless to ever create something better later,
>    because even if hardware and software improves, you've codified that
>    "we have to have crappy information".

I tried to accomodate this approach by overloading the parent link and
then making git more intelligent to figure out if it is a cherry-pick or
not.  That was deemed undesirable, so using the origin links is the next
best thing (IMHO).

>good idea, nor this time around it is that much different from what the
>previous "prior" link discussion tried to do.

It is well-defined this time, and doesn't bleed across fetch/pull.
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
