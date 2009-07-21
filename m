From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFE] allow git bisect to figure out in which revision a bug was fixed
Date: Tue, 21 Jul 2009 16:34:58 -0400
Message-ID: <x49k521ojv1.fsf@segfault.boston.devel.redhat.com>
References: <x49ocrdokp9.fsf@segfault.boston.devel.redhat.com>
	<7vfxcpdbsh.fsf@alter.siamese.dyndns.org>
	<20090721202848.GA3453@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Josef Bacik <josef@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTM3V-0007Ux-48
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbZGUUfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755350AbZGUUfL
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:35:11 -0400
Received: from mx2.redhat.com ([66.187.237.31]:33311 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943AbZGUUfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:35:09 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6LKZ8t9001179;
	Tue, 21 Jul 2009 16:35:08 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6LKZ7Tb014707;
	Tue, 21 Jul 2009 16:35:08 -0400
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.16.60.26])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6LKZ2XS027045;
	Tue, 21 Jul 2009 16:35:07 -0400
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
In-Reply-To: <20090721202848.GA3453@localhost.localdomain> (Josef Bacik's
	message of "Tue, 21 Jul 2009 16:28:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123711>

Josef Bacik <josef@redhat.com> writes:

> On Tue, Jul 21, 2009 at 01:24:46PM -0700, Junio C Hamano wrote:
>> Jeff Moyer <jmoyer@redhat.com> writes:
>> 
>> > As a distro kernel grunt, I sometimes find myself in the situation of
>> > having to track down the commit that fixed a given problem so that I can
>> > backport it to an older kernel.  Sometimes I'm smart enough to figure it
>> > out myself, other times I'm not.  ;-)  It would be helpful if git bisect
>> > could help figure out in what commit a bug was fixed as opposed to
>> > introduced.  Is there any interest in implementing such a feature?
>> 
>> Doesn't that already exist?
>> 
>> You are hunting for an existence of the bug, so any commit that is buggy
>> (with respect to the bug you are interested in) is *GOOD*.  The tip of the
>> upstream is *BAD* in that it does not have your favourite bug anymore.
>> 
>> You bisect that history down, and will find the first *BAD* commit.
>> 
>> Now, why is that commit the procedure finds is *BAD*, again?  Yup, because
>> it does not have your favourite bug anymore.  And why is that so?
>> 
>> Because the commit fixed that bug.
>
> Sure, but as one who has used this procedure several times before, it is very
> error prone, on my side because I'm a big goober.  I have a tendancy to get my
> wires crossed and get dumped out at a commit that doesnt make sense (my latest
> attempt put me out at a merge commit).  Sure its my fault for not being able to
> keep it straight, theres no arguing that, it still would be nice for there to be
> a way to remove as much human error from the process as possible.  Thanks,

And now that I've done the research I should have done before posting, I
see that this feature has been requested at least 2 other times.  I can
get by the way things stand, for sure, but it sounds like there's
interest in making things a bit more user friendly.

Thanks for your time.

-Jeff
