From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-am failed, what's next ?
Date: Thu, 22 Feb 2007 11:30:22 -0800
Message-ID: <7virduf0s1.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
	<7v8xeqh6bj.fsf@assigned-by-dhcp.cox.net>
	<38b2ab8a0702220238l14628f54s3165f050f6af5447@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 20:30:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKJe7-000341-5l
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 20:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbXBVTaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 14:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXBVTaY
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 14:30:24 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42634 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbXBVTaX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 14:30:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222193023.GVWS233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 14:30:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SjWN1W00H1kojtg0000000; Thu, 22 Feb 2007 14:30:23 -0500
In-Reply-To: <38b2ab8a0702220238l14628f54s3165f050f6af5447@mail.gmail.com>
	(Francis Moreau's message of "Thu, 22 Feb 2007 11:38:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40373>

"Francis Moreau" <francis.moro@gmail.com> writes:

>> Applying by hand
>> ----------------
>>
>> If you (as most people) are not comfortable editing the patch
>> text you can update your working tree to pretend that the patch
>> applied cleanly.  You can do number of things:
>>
>>  * Use "git apply --index -C<n> .dotest/patch" to attempt
>>    applying the patch with reduced context.
>>
>>  * Use "git apply --reject .dotest/patch" to get apply only
>>    hunks that apply cleanly, while getting *.rej files.
>>
>>  * Use "GNU patch" with less strict options, perhaps like
>>
>> 	$ patch -p1 --fuzz=<n> --ignore-whitespace
>
> why using 'patch' ? couldn't this be done by using 'git-apply' ?

The default operationg mode of 'patch' is less strict than
git-apply is, and it can be told to be much less strict, so some
people seem to like it.  You do not have to use it unless your
patch text is based on too far away version.  I usually don't.

Also the above is not an exhaustive list.  If you are handy with
other tools to make patches that do not cleanly apply apply
(e.g. wiggle), they can be used instead.

> Maybe these several choices could be proposed to the user when using
> the interactive mode ?

I do not think so.  As far as I remember, interactive mode
helps the "Fixing patch text" strategy but not "Applying by
hand" strategy.  When a patch does not apply, you fix the text
and re-apply, and [v]iew command is to review how you fixed the
patch, for example.
