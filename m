From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: pull/push inconsistencies
Date: Wed, 16 May 2007 13:51:47 +1200
Message-ID: <46a038f90705151851i9027e01x993300b1b50d0285@mail.gmail.com>
References: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
	 <7vtzudhayr.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90705151811o2159aa5ai84a13e77e790e376@mail.gmail.com>
	 <7v646th8a2.fsf@assigned-by-dhcp.cox.net>
	 <20070516014002.GA8062@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed May 16 03:52:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho8gJ-0005s9-VT
	for gcvg-git@gmane.org; Wed, 16 May 2007 03:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760946AbXEPBvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 21:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760895AbXEPBvt
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 21:51:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:24674 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748AbXEPBvr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 21:51:47 -0400
Received: by wr-out-0506.google.com with SMTP id 76so24829wra
        for <git@vger.kernel.org>; Tue, 15 May 2007 18:51:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BI/CrHdxiTUS3Uycs6vzrMelVa0pM5H9z/oXCRJuFEFyCZ7paDlByhjgWzzkxzpXgz6UMvwTUVmm+Iaezvr1Y3ucjTJZn/5MKytg+ei6EsSZIuTWkxxpbrqRR3PAKLXanmduf0qJwUtclBOYcujbQQN/xc2XNbGGsok60vzjPRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VqyslFYWU4D/3j/OwXneuhYEuCKbbK+XD4Vv1Ou9O16CHhl+0fce37fGrnkHU+wrb67DNqzrztbRTLvFQ6u4+kyXYW/PPE1AZ6qZt3kJkohUodp+8D+ZU2VFF3M7fbu3/HkmVkNho8sORB2VKfEjGWZDpBQSCOifuU14wWZ/500=
Received: by 10.90.98.3 with SMTP id v3mr7258092agb.1179280307079;
        Tue, 15 May 2007 18:51:47 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Tue, 15 May 2007 18:51:47 -0700 (PDT)
In-Reply-To: <20070516014002.GA8062@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47405>

On 5/16/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Tue, May 15, 2007 at 06:22:29PM -0700, Junio C Hamano wrote:
> > "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> >
> > > There are 2 things that I see as wrong...
> > > - local .git/refs/remote/origin/foo and refs/heads/foo match - why is
> > > git-push talking about updating them?
> >
> > Ooo...
> >
> > Do you mean if you have refs/remotes/origin/foo locally, and
> > push into a repository that has refs/heads/foo (but not
> > refs/remotes/origin/foo), the push results in refs/heads/foo
> > getting updated?  If that is what is happening (without any
> > refspecs to instruct git-push to do so) that sounds quite buggy.
> > I need to look into the code for this one.
>
> I understand him to be saying that it *doesn't* do that, and that he
> *wants* it to.

I'm probably in a bad-communication day :-/

I have locally .git/refs/remotes/origin/foo, and the remote repo has
refs/heads/foo. I don't have .git/refs/heads/foo in this case. When I
do git-push, it doesn't really change the remote repo, but it _tells_
me it has.

So - behaviour-wise, it's fine. It's not changing the remote repo. But
it tells me it does. It's just plain weird and misleading...

> People think of refs/remotes/origin as a cache of the origin
> repository's branch heads, and they expect it to be updated on write
> (push) as well as read (fetch).

Yes ;-)

cheers,


martin
