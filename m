From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Tue, 10 Apr 2012 16:39:44 -0400
Message-ID: <20120410203944.GA12139@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
 <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
 <20120410181317.GA17776@hmsreliant.think-freely.org>
 <7vfwcbpem5.fsf@alter.siamese.dyndns.org>
 <20120410200019.GC17776@hmsreliant.think-freely.org>
 <7v8vi3pbtf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 22:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHhr3-0005Be-4Z
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 22:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab2DJUjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 16:39:52 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:52831 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988Ab2DJUjv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 16:39:51 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SHhqs-0006zw-Ko; Tue, 10 Apr 2012 16:39:48 -0400
Content-Disposition: inline
In-Reply-To: <7v8vi3pbtf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195128>

On Tue, Apr 10, 2012 at 01:32:44PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > On Tue, Apr 10, 2012 at 12:32:18PM -0700, Junio C Hamano wrote:
> >> Neil Horman <nhorman@tuxdriver.com> writes:
> >> 
> >> > On Tue, Apr 10, 2012 at 09:45:46AM -0700, Junio C Hamano wrote:
> >> > ...
> >> >>  (2) The message is given by the "git commit" command.  "If the commit was
> >> >>      created empty" looks confusing.  Even though I can understand that
> >> > Its coded within the git commit command code, but is only ever displayed if
> >> > whence is GIT_CHERRY_PICK, so as far as I can see, from a users perspective,
> >> > this will only be seen if they type git cherry-pick on the command line.
> >> 
> >> Here is what I tried, and I think you are wrong.
> >> 
> >> 	$ git cherry-pick $some_commit
> >>         ... conflicts ...
> >>         $ edit so that the working tree matches HEAD
> >>         $ git commit -a
> >>         ... message from status ...
> >>         THE ADVICE IN QUEWSTION COMES HERE!!!
> >> 
> >> 
> > Ok, I admit I didn't really think of that case, but that seems to me to be the
> > trivial case, which is unlikely to be encountered.  If you do a git cherry-pick and
> > have conflicts, you by definition don't have a commit that is resolved to empty...
> 
> Not at all unlikely, especially in a distributed world.
> 
> You may have seen two patches but they make sense as one so that you apply
> to one branch as one change, while the branch you are cherry-picking from
> may have these two changes as individual commits.  Neither of them will
> apply cleanly to your tree, and your resolution will be "keep mine---I
> already have this".
> 

Ok, fine.  What do you say to my proposal regarding the splitting of the device
dependent on how we were executed?  It seems we can't use a single advice string
in this case, as no matter which we choose there is a use case in which it fails
to make sense.
Neil
