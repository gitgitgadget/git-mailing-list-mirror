From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git branching & pulling
Date: Fri, 18 May 2007 23:05:09 -0700
Message-ID: <7vzm41xsa2.fsf@assigned-by-dhcp.cox.net>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>
	<7v8xblz71o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Wink Saville" <wink@saville.com>
X-From: git-owner@vger.kernel.org Sat May 19 08:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpI4B-0002HK-36
	for gcvg-git@gmane.org; Sat, 19 May 2007 08:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbXESGFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 02:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525AbXESGFR
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 02:05:17 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:38252 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbXESGFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 02:05:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519060515.MFOR6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 02:05:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0u5A1X0071kojtg0000000; Sat, 19 May 2007 02:05:14 -0400
In-Reply-To: <7v8xblz71o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 18 May 2007 23:00:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47722>

Junio C Hamano <junkio@cox.net> writes:

> "Wink Saville" <wink@saville.com> writes:
>
>> Could someone give me some insight or point me at a url or doc
>> that could shed some light on what is happening and why git-pull
>> doesn't work on kvm.git.
>
> DEFAULT BEHAVIOUR section of
>
>     http://www.kernel.org/pub/software/scm/git/docs/git-pull.html 
>
> would be the place to start.  Recent git-clone (post 1.5.0, I think)
> prepares the following configuration variables for you by default:
>
>         remote.origin.url
>         remote.origin.fetch
> 	branch.master.remote
>         branch.master.merge
>
> but repositories created by older git-clone didn't.

	/me says "oops I did not finish the sentence".

but repositories created by older git-clone didn't get these
configuration variables set.  If you set them appropriately,
taking example of your other repository (and probably you would
also want to remove .git/remotes/origin while you are at it),
you can omit saying which branch to pull from where.

I personally never understood why people would just want to say
"git pull" without saying anything else, but what described in
the DEFAULT BEHAVIOUR section is how it works.
