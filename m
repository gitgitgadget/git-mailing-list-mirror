From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Convert emailing part of hooks--update to hooks--post-receive
Date: Sun, 25 Mar 2007 02:13:04 -0700
Message-ID: <7v7it54rfj.fsf@assigned-by-dhcp.cox.net>
References: <200703231023.58911.andyparkins@gmail.com>
	<200703241550.05590.andyparkins@gmail.com>
	<7vfy7tajiz.fsf@assigned-by-dhcp.cox.net>
	<200703250951.04503.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 11:13:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVOmj-00066l-Sf
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 11:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271AbXCYJNI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 05:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933276AbXCYJNH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 05:13:07 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56749 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933271AbXCYJNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 05:13:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325091305.PNZW22511.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Mar 2007 05:13:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id exD31W0041kojtg0000000; Sun, 25 Mar 2007 05:13:04 -0400
In-Reply-To: <200703250951.04503.andyparkins@gmail.com> (Andy Parkins's
	message of "Sun, 25 Mar 2007 08:51:02 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43044>

Andy Parkins <andyparkins@gmail.com> writes:

> On Sunday 2007, March 25, Junio C Hamano wrote:
> ...
>> I think you can do something along the following line.
>>
>>  (1) You say "for-each-ref --all" to get the ref information
>>      that is after update.
>
> Would you mind if I delayed that to a separate patch?

Surely.

As we discussed, I would prefer a patch to create this as a new
file in

	contrib/examples/hooks/

directory.  A single-liner 

	# see contrib/example/hooks for examples.

in another new file "templates/hooks--post-receive" would be
also nice.

>> Actually it was not quite "nicely done".  If taggername has an
>> unusual character then dq pair you hard coded there may not
>> quote the string correctly.
>
> Devious.

and funny, isn't it?

>   generate_email $2 $3 $1 | cat
>
> This is to force the deactivation of the pager for all the git commands 
> that generate_email calls.

I think you could probably do the same with:

	PAGER= generate_email "$2" "$3" "$1"
