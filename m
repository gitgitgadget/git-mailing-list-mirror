From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: Confusion about diffing branches
Date: Sun, 26 Aug 2007 20:40:56 -0500
Message-ID: <20070827014056.GB7422@mediacenter.austin.rr.com>
References: <20070826233555.GA7422@mediacenter.austin.rr.com> <7v6431omn8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 03:40:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPTaU-0007yb-No
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 03:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbXH0Bjv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 21:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbXH0Bju
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 21:39:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:46993 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbXH0Bju (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 21:39:50 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1479058wxd
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 18:39:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=tYFsjZ9OshTIa3G+DKrG7fdshYnVtf5EsnIM1AsJAQPEuCyTMirqNspiu4EUgJoeB0pO6OXvq3NA5pQYEhbcg89i8dWPCBS25uLkczhsJzYCyd/4HLYXDdoqV+EeDbENeqzfQkHMwTRi963Sp7vWYOkc0otlu9sH0hKxu8kW2Og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=S0DPqYStYnbO3sp+wKtlP23iBfWqSQ1Dp7tbJMy6pThwtdpGQyo8UjJYTl5J5/4e2GbjpYv/04Hol+ouLKLFZLYrDYMcY1S0mr88la1EVeegx8Oeb6yf6wjHdtYHbLaGcajbdCUkXHwX2J+wzaa9LYNTwbfS2ThlyvX+1DfSz5Q=
Received: by 10.70.68.9 with SMTP id q9mr9319005wxa.1188178788402;
        Sun, 26 Aug 2007 18:39:48 -0700 (PDT)
Received: from mediacenter.austin.rr.com ( [70.112.123.114])
        by mx.google.com with ESMTPS id 74sm9071887wra.2007.08.26.18.39.46
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2007 18:39:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v6431omn8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56755>

On Sun, Aug 26, 2007 at 05:18:35PM -0700, Junio C Hamano wrote:
> When you are working on topic it is often desired to see "what
> have I done since I forked?" and "what have they done while I
> was looking the other way?".

Absolutely, and from the user manual I gathered that this was what the
two-dot form was for.  "git diff master..topic" show me the diff of
commits reachable from topic, but not from master.

The three-dot form seemed to address the other use case which is
probably the more usual case for git-diff which is show me the changes
reachable from master or topic but not both.

> "git diff master topic" (which is the same as "git diff
> master..topic" -- the two-dot form is just a syntax sugar to
> avoid mistypes for people who are too used to type two dots as
> reflex because that is how you express a revision range) shows
> a squashed diff that is A+B-E, and often people found "-E" part
> distracting and useless.  Three-dot form was invented
> specifically to address this problem.  You do not have to (and
> you do not _want_ to) use that form if you _want_ to see the -E
> part of the diff.

So if I understand you correctly people in the git world are simply more
used to typing two dots (instead of three) so that is why the two dot
notation shows the more common use case (show me the difference between
the tip of the master branch and the tip of the topic branch).

I must admit that for me, a new git user, it would be much more
intuitive if all git commands used the same syntax for specifying
revisions.  After all every other git command that I have used so far
uses the opposite syntax as git-diff.  This includes git-log,
git-format-patch, gitk, git-rev-list, and git-rev-parse.
