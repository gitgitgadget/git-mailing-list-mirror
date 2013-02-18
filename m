From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 20:48:34 +0100
Message-ID: <87wqu5wgh9.fsf@pctrast.inf.ethz.ch>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
	<87k3q5zfaa.fsf@pctrast.inf.ethz.ch>
	<87fw0ta4ai.fsf@an-dro.info.enstb.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Jens Lehmann" <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ronan Keryell <Ronan.Keryell@silkan.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:49:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Whx-0003rY-NP
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188Ab3BRTsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:48:37 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:25707 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757023Ab3BRTsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:48:37 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 20:48:32 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 20:48:35 +0100
In-Reply-To: <87fw0ta4ai.fsf@an-dro.info.enstb.org> (Ronan Keryell's message
	of "Mon, 18 Feb 2013 10:02:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216505>

Ronan Keryell <Ronan.Keryell@silkan.com> writes:

>>>>>> On Mon, 18 Feb 2013 18:46:05 +0100, Thomas Rast <trast@student.ethz.ch> said:
>
>     Thomas>    The actual programming must be done in C using pthreads
>     Thomas> for obvious reasons.
>
> Are there obvious reasons OpenMP would not be enough to do the job?
>
> It looks like a trade-off between the code readability & portability
> versus the real expressiveness of what parallelism control details are
> needed.

Except for the added dependency you mean?

I'm not sure exactly what the capabilities of OpenMP are that would help
here, but most likely it would work.  It wouldn't really change the
amount of work needed, though, since the main work is in shuffling
around the existing code paths to be amenable to parallel access in the
first place.  A "dumb" parallelization (i.e., just locking around all
shared structures) POC yielded very little speedup because of lock
contention.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
