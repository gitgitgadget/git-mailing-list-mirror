From: Junio C Hamano <junkio@cox.net>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 14:26:32 -0800
Message-ID: <7v3bilr2zr.fsf@assigned-by-dhcp.cox.net>
References: <43F20532.5000609@iaglans.de>
	<200602142230.11442.Josef.Weidendorfer@gmx.de>
	<7v7j7xr54u.fsf@assigned-by-dhcp.cox.net>
	<200602142317.29626.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 23:26:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F98d8-0000lM-BG
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 23:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422839AbWBNW0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWBNW0f
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 17:26:35 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:29114 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1422839AbWBNW0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 17:26:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214222351.HFMW26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 17:23:51 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200602142317.29626.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 14 Feb 2006 23:17:29 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16185>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Tuesday 14 February 2006 22:40, you wrote:
>> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
>> 
>> > Why not allow something like
>> >
>> > 	git-checkout master~5
>> >
>> > which implicitly does create a read-only branch "seek-point"?
>> 
>> Now what does "git-checkout branch" mean?  Does it switch to the
>> branch, or does it force tip of seek-point to be the tip of
>> branch and switch to seek-point branch?  More interestingly,
>> what does "git-checkout seek-point" mean? 
>
> You are right; it would get quite confusing.
> But perhaps the current error message
>
>   git checkout: you need to specify a new branch name
>
> should be a little bit more explaining by appending
>
>   "... to switch to for being able to checkout the requested revision"

While we are on the subject of improving the error message to
better guide users in a likely-to-be-what-he-meant direction,
there is another confusing message (I am assuming you are
interested in this enough to come up with a patch to fix that
"... to switch to ..." thing):

	$ git checkout -b test v2.6.10

The user wanted to create a new branch test based on tag
v2.6.10, alas that tag does not exist.  We give quite confusing
error message because we are confused that the user meant to
checkout only "./v2.6.10" file and that operation and switching
branches are incompatible.
