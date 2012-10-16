From: Mark Hills <mark@pogo.org.uk>
Subject: Re: sharedRepository derived from file permissions
Date: Wed, 17 Oct 2012 00:20:56 +0100 (BST)
Message-ID: <1210170009180.2113@vega>
References: <1210080955590.12283@wes.ijneb.com> <7vhaq4nc7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:36:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOOAi-0004L8-NV
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 09:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab2JQHf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 03:35:57 -0400
Received: from mx.ij.cx ([212.13.201.15]:55639 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751382Ab2JQHf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 03:35:57 -0400
Received: from cpc5-hari13-2-0-cust67.20-2.cable.virginmedia.com ([82.45.173.68] helo=vega.localdomain)
	by wes.ijneb.com with esmtpa (Exim 4.77)
	(envelope-from <mark@pogo.org.uk>)
	id 1TOOAU-0001z6-By; Wed, 17 Oct 2012 08:35:54 +0100
Received: from mark (helo=localhost)
	by vega with local-esmtp (Exim 4.80)
	(envelope-from <mark@pogo.org.uk>)
	id 1TOGRU-0000aW-5r; Wed, 17 Oct 2012 00:20:56 +0100
In-Reply-To: <7vhaq4nc7g.fsf@alter.siamese.dyndns.org>
X-SA-Exim-Connect-IP: 82.45.173.68
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207902>

On Mon, 8 Oct 2012, Junio C Hamano wrote:

> Mark Hills <mark@pogo.org.uk> writes:
> 
> > We make extensive use of unix permissions and core.sharedRepository -- 
> > multiple developers push to the same repo.
> >
> > I have often wondered why core.sharedRepository is needed at all as a 
> > separate configuration?
> >
> > It looks like it might be easier (and less confusing to users) to derive 
> > this attribute from the top-level .git directory?
> 
> Hrm, clever ;-)
> 
> > Is there a reason why Git doesn't just follow (and echo) the top-level 
> > permissions?
> 
> Other than "we did not trust that all the end users are capable of
> doing the right 'chmod 2775 .git && chgrp project .git", with a
> little bit of "we didn't think of that when we wrote the system", I
> do not recall any.

Thanks. If I understand, you mean it might be worth a try to implement 
this. For us it would certainly simplify, and reduce mistakes/confusion.

I've yet to look into the code, but I will try and do this. If you have 
any hints or recommendations where to begin then that'd be good.

I think I did peek some years ago to find out that it was non-trivial, and 
then came up with the script!

I wonder if there are any users who are granting permission to specific 
branchs or tags or tag directories. I'm not sure if this is really a valid 
use case, but there might need to be a way to ignore the top-level 
attributes too for some special cases?

Thanks

-- 
Mark
