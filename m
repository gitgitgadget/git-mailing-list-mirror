From: Junio C Hamano <junkio@cox.net>
Subject: Re: New release?
Date: Tue, 06 Jun 2006 03:27:06 -0700
Message-ID: <7virnevath.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	<7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606061019440.11478@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 12:27:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnYmS-00018k-ON
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 12:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWFFK1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 06:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWFFK1I
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 06:27:08 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39593 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750800AbWFFK1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 06:27:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606102707.ZYOD27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 06:27:07 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606061019440.11478@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Jun 2006 10:30:27 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21371>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 5 Jun 2006, Junio C Hamano wrote:
>
>>          - letting fetch-pack ask for an arbitrary commit object the
>>            user obtained out of band (Eric W Biederman) -- waiting for
>>            updated patch.  We would need a corresponding one-liner patch
>>            to upload-pack when we do this.
>> 
>> This can wait.
>
> I think that this could be an important step towards a sensible "shallow 
> clone"...

I did not say we are not interested in doing this ever.  The
"arbitrary commit" thing is easy but I do not think it is all
that important to hold all the good stuff back that happened
since 1.3.0 and delay 1.4.0.

Also, what you talk about the "lazy clone" is a lot more
involved than what Eric wanted to have.  It is _never_ shallow
clones that normal users would want -- making it shallow to
explicitly say certain operations break is a cop-out for
implementors.  What the users really want is to be in total
control -- ranging from completely on-demand ala CVS and SVN to
"down to this commit in the history I would want to be cached on
the local machine so that I can go offline and still do useful
things with the history", with new failure modes for history
traversing commands to exit gracefully when offline.  That _is_
the ideal but I know it won't be within reach anytime soon.

>>          - using ~/.gitrc to give a fall-back default when
>>            $GIT_DIR/config does not have values.
>> 
>> I suspect this would be more involved than Pasky's initial
>> patch; but it can wait.
>
> I think that this is quite important for the aliases to be useful. 

I am not saying this is unimportant.  Again, however, it is not
that important to hold other good stuff.
