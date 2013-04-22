From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH] bisect: Store first bad commit as comment in log file
Date: Tue, 23 Apr 2013 00:20:58 +0200
Message-ID: <20130422222058.GF5650@pvv.ntnu.no>
References: <20130413152257.GB16040@pvv.ntnu.no>
 <20130415.063809.1055555229072260139.chriscool@tuxfamily.org>
 <20130415095339.GA28480@pvv.ntnu.no>
 <20130422210229.GE5650@pvv.ntnu.no>
 <7vr4i2nuar.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUP6n-0002jq-LL
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab3DVWVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:21:08 -0400
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:54789 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab3DVWVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:21:07 -0400
Received: from torstehe by microbel.pvv.ntnu.no with local (Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1UUP6Y-0004DK-Cb; Tue, 23 Apr 2013 00:20:58 +0200
Content-Disposition: inline
In-Reply-To: <7vr4i2nuar.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222116>

On Mon, Apr 22, 2013 at 14:13:00 -0700, Junio C Hamano wrote:
> Torstein Hegge <hegge@resisty.net> writes:
> 
> > I took another look at this. I wasn't able to come up with anything
> > useful for the "The merge base $rev is bad" case, but for the "only
> > skipped commits left to test" case one could do something like this.
> 
> We skipped them because we can gain _no_ information from testing
> these commits. They are not even "possibly bad", but are "unknown".
> 
> So it feels to me that by definition listing them would not be
> useful. What am I missing?

The information lies in that those commits are the only commits with an
unknown state. So if the bisecter hands off the bisect log to someone
else when they can't test further, the current status is recorded.

I think part of the reason I started looking at this is that there are
no good way to see what git said after the previous 'git bisect
good/bad' if the terminal output is lost. And lost terminal output is
fairly likely if you are bisecting something that requires reboots for
each test.

But I don't feel very strongly about this. It was based on Christian's
idea, so unless he comes up with some compelling arguments I'll drop it.
