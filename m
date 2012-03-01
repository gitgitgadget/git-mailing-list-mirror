From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH-w 101/105] t6300 (for-each-ref): modernize style
Date: Thu, 1 Mar 2012 09:42:51 +0100
Message-ID: <87ty28n244.fsf@thomas.inf.ethz.ch>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
	<1330566326-26075-7-git-send-email-tmgrennan@gmail.com>
	<7v62epqd9a.fsf@alter.siamese.dyndns.org>
	<20120301032053.GD2572@tgrennan-laptop>
	<7vty29ovcd.fsf@alter.siamese.dyndns.org>
	<20120301051010.GE2572@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 09:43:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S31bG-0002qa-V3
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 09:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415Ab2CAIm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 03:42:56 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:55594 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379Ab2CAImy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 03:42:54 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 09:42:51 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 09:42:52 +0100
In-Reply-To: <20120301051010.GE2572@tgrennan-laptop> (Tom Grennan's message of
	"Wed, 29 Feb 2012 21:10:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191906>

I sent out a reply to the same effect as Junio's longer one in this
side-thread.  You can disregard that.  Sorry for not first reading the
whole thread.

Tom Grennan <tmgrennan@gmail.com> writes:

> On Wed, Feb 29, 2012 at 07:26:10PM -0800, Junio C Hamano wrote:
>>Tom Grennan <tmgrennan@gmail.com> writes:
>>
>>> It's trivial to remove these "quiet" and "silent", but to me that's the
>>> only value added by these patches.  More seriously, the remaining
>>> modernization still seems much larger than its value.
>>
>>Don't do that, then ;-).
>>
>>Some older scripts do redirect the output from the commands to /dev/null
>>but that dates back before we made the default reasonably silent, and in
>>"modern" style we tend to keep them sent to their standard output to help
>>debuggability. These quiet/silent takes us to the prehistoric times.
>
> Hey! I am prehistoric:-)
>
> Like I said, I think there is currently a debug distraction with verbose
> mode.  However, rather than hiding expected failures and diverting other
> output as I had, perhaps we should dup stderr to stdout in verbose mode
> so error messages show up near the logged invocation when piped through
> a pager (i.e. mimic "|&").  With this, one can quickly scan past the
> noise to focus on the broken cases.

If you have trouble finding the broken case, you can run with -v -i.

I also think you are making an argument for a different feature (which
does not rob us of having all the debug output): test-lib.sh could
perhaps redirect the test output to a file, and dump the file to stdout
only if the test failed.  Perhaps --verbose-failing or something like
that.

Otherwise, your proposal is restricting us to having only an "easily
scannable" amount of output per test, perhaps 5-15 lines.  Which I
personally think is an insane restriction for something that was
intended for debugging in the first place.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
