From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC PATCH v2] fetch-pack: log(n)-transmission find_common()
Date: Tue, 28 Oct 2008 10:46:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810281034500.13034@xanadu.home>
References: <1224790716-20551-1-git-send-email-trast@student.ethz.ch>
 <20081027192923.6117@nanako3.lavabit.com>
 <7vljw9h061.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 16:15:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuqHT-0006ed-2U
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 16:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbYJ1PN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 11:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbYJ1PN2
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 11:13:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44676 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbYJ1PNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 11:13:25 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9G00EM6ECQJUA4@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 28 Oct 2008 10:46:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vljw9h061.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99296>

On Mon, 27 Oct 2008, Junio C Hamano wrote:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
> 
> > Quoting Thomas Rast <trast@student.ethz.ch>:
> >
> >> Replaces the existing simple history search with a more sophisticated
> >> algorithm:
> >> 
> >> 1) Walk history with exponentially increasing stride lengths; i.e.,
> >>    send the 1st commit, then the 2nd after that, then the 4th after
> >>    that, and so on.
> >> 
> >> 2) Bisect the resulting intervals.
> >
> > Junio, may I ask what the status of this patch is? I see Nicolas responded and said "I gave this a quick try". Wasn't it a good enough review?
> 
> I took the "quick try" more about "first feel in performance" and not
> "code review concentrating on correctness and trying to catch mistakes".

Exact.

FWIW, I had to back this patch out from my version as things seemed to 
fall into an infinite loop of ref negotiation while fetching the Linux 
kernel repository at some point.  Doing a "git fetch -v -v" turned up an 
endless stream of "got" and "have" lines.  I was in a hurry for $work so 
didn't think of preserving my local refs for reproduction of the 
problem.

Sorry for not being more helpful.  This is some part of git that I know 
f-all about.


Nicolas
