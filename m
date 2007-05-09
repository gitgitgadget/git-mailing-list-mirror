From: Junio C Hamano <junkio@cox.net>
Subject: Re: minimize_url in git-svn?
Date: Tue, 08 May 2007 21:56:52 -0700
Message-ID: <7vhcqmzjaj.fsf@assigned-by-dhcp.cox.net>
References: <C05C5EF4-EC68-490B-946E-630117393F4E@drhanson.net>
	<463F6A95.30207@midwinter.com>
	<9fb1551c0705072048u3ff85ea7n5166596855b8f322@mail.gmail.com>
	<464023D4.5060101@midwinter.com>
	<7v4pmn4oxj.fsf_-_@assigned-by-dhcp.cox.net>
	<20070508193455.GA14602@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Seth Falcon <sethfalcon@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 09 06:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HleEU-0002jt-Jl
	for gcvg-git@gmane.org; Wed, 09 May 2007 06:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966217AbXEIE4y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 00:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934673AbXEIE4y
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 00:56:54 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51277 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934666AbXEIE4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 00:56:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509045652.PPET26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 00:56:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wsws1W00q1kojtg0000000; Wed, 09 May 2007 00:56:53 -0400
In-Reply-To: <20070508193455.GA14602@muzzle> (Eric Wong's message of "Tue, 8
	May 2007 12:34:55 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46659>

Eric Wong <normalperson@yhbt.net> writes:

> .rev_db is offset-based database.  Revision numbers to git commits can
> be looked up using (SVN revision * 41).

Ah, that explains why the file looks so sparse.  Their trunk/
seems to be somewhat inactive and activities elsewhere in the
branch/ namespace we cannot view may advance SVN revisions.

>>  * Assuming there aren't any damage, or maybe some damage that
>>    would cause minor decreased functionality/interoperability,
>>    would it perhaps make sense to optionally allow skipping the
>>    minimizing to avoid this problem?  Would it make sense, or is
>>    the setting at socialtext site too esoteric and it isn't
>>    worth to worry about?
>
> It *should* be automatically detecting the highest level up it can
> access and stop there.  In your case, there's obviously something
> broken in my code :(

Perhaps, but if the user has the proper user identity to access
the full site, I suspect you would be better off getting the
credential and connect to the higher level.  In other words, the
definition of "the highest level up it can access" depends on
the user and what the user is trying to do (i.e. a user who does
have an account with that project may not be interested in
getting tags/ nor branches/, in which case the user may want to
be able to say "I am not interested in uplevel" upfront, so that
the program does not even have to ask for the password.  On the
other hand the user may want to access tags/ and branches/ in
which case the user would appreciate the current behaviour,
asking for the password and go up after authenticated).

> I've definitely tested this as working against Seth Falcon's hedgehog
> repo (URL is somewhere in the archives).  I also setup a test repository
> somewhere that I can double-check against.
>
>> [Footnote]
>> 
>> *1* http://www.socialtext.net/stoss/index.cgi?developing_with_a_dev_env
>
> I'll try to take a look at that in the next few days.  I also have
> segfaults to fix that I haven't gotten to :(

Thanks.  If I type <Return> instead of ^C in the transcript at
the beginning of my message, I get a segfault.  It may or may
not be the same one you have been chasing.
