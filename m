From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git rev-list -S ?
Date: Wed, 21 Mar 2012 12:14:50 +0100
Message-ID: <874ntixl1x.fsf@thomas.inf.ethz.ch>
References: <4F68CDA4.6060109@ira.uka.de>
	<7vaa3b570l.fsf@alter.siamese.dyndns.org>
	<20120320220032.GA29233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 12:15:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAJVP-0003UV-84
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 12:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030715Ab2CULOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 07:14:55 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:25071 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab2CULOy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 07:14:54 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 12:14:49 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 12:14:51 +0100
In-Reply-To: <20120320220032.GA29233@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 20 Mar 2012 18:00:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193568>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 20, 2012 at 01:53:14PM -0700, Junio C Hamano wrote:
>
>> |    $ git log -S'it drives an external
>> |   an external' master Documentation/RelNotes
>> 
>> is a way to find commits that introduced and then removed the block of
>> text to files in the named directory, starting at the tip of 'master'.
>> 
>> Most of the "ultimate tracking tool" dream has already been realized in
>> "git blame" except one major part.  Once you find where the blame lies,
>> the tool _could_ help the user to find where these blamed lines came from
>> more than it currently does.
> 
> Related to this is the line-level history browser project. The idea was
> basically to get a log-like view (i.e., reverse chronological commits)
> of a chunk of code, tracing the ancestry of a particular chunk of lines.
>
> This was done by Bo Yang as a GSoC project in 2010, but the code still
> hasn't been merged. As I recall, it mostly works, but there are perhaps
> some corner cases or ugly parts of the code still to be re-worked.
> Thomas Rast was cleaning it up some, and could say more on the current

This is all correct.  It mostly works, which is the main impediment to
further work :-)  You can try it by merging

  git://github.com/trast/git.git line-log-cleanup

It segfaults if you attempt to track more than one range, however.

I have started some rewriting, which tries to phrase it more in terms of
simple operations on sets of lines, and pushed that as

  git://github.com/trast/git.git line-log-WIP

This was successful in that the newly written code is easier to read and
completely broken.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
