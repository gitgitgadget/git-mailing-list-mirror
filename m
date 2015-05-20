From: Laszlo Papp <lpapp@kde.org>
Subject: Re: git log --follow for directories
Date: Wed, 20 May 2015 09:20:58 +0000 (UTC)
Message-ID: <loom.20150520T111434-930@post.gmane.org>
References: <CAOMwXhP-BRd356xpfdLgZ0zKYTMVryt8jtmi3T2jhVh91hY04Q@mail.gmail.com> <xmqqsias8rvy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 11:25:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv0FU-0001kz-0G
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 11:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbbETJZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 05:25:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:37789 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbbETJZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 05:25:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Yv0FL-0001hR-G0
	for git@vger.kernel.org; Wed, 20 May 2015 11:25:03 +0200
Received: from mail.polatis.com ([212.44.19.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 May 2015 11:25:03 +0200
Received: from lpapp by mail.polatis.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 May 2015 11:25:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.44.19.228 (Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269458>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Laszlo Papp <lpapp <at> kde.org> writes:
> 
> > Is there any benefit about having it like it is today or is it just
> > the usual "no one has implemented it yet"?
> 
> It actually is even more sketchy than that.  A single file following
> was done merely as a checkbox item that works majority of the time,
> and any mergy history that renames the file on one side of the side
> branch but not on the other may not truly follow it.
> 

Well, in worst case, why not have something like --follow-dirs, then?

The case at hand is that we unfortunately named a directory based on the
codename of some software for the time.

Now, we have improved that software and the codename is different
accordingly. Now, instead of "pastcodename", I would change the directory
name to "src" to be future proof, but here, I face these difficulties:

1) The directory name is stuck with some ancient codename and it therefore
will be confusing for the rest of the life cycle for this project.

2) We get unfollowable directories. At best, we could use some scripts to
work this around, but why not address this directly in git?

I think renaming a directory without losing the history would be really cool
to have, one way or another. If that requires a separate option, I am happy
with that, but what I would really like to avoid is not being able to rename
directories without losing the history.

Note that I am speaking from user point of view. I do not know the
nitty-gritty technical details, but that is just implementation details as
far as I am concerned, anyway.
