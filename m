From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Automatically line wrap long commit messages.
Date: Tue, 30 May 2006 01:38:46 -0700
Message-ID: <7vhd373o15.fsf@assigned-by-dhcp.cox.net>
References: <20060529085738.GB29500@spearce.org>
	<7virnp8a30.fsf@assigned-by-dhcp.cox.net>
	<20060529094605.GB27194@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 10:38:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkzkZ-0003Dk-Si
	for gcvg-git@gmane.org; Tue, 30 May 2006 10:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWE3Iis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 04:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWE3Iis
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 04:38:48 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50149 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932151AbWE3Iis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 04:38:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530083847.TBEE15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 04:38:47 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060529094605.GB27194@spearce.org> (Shawn Pearce's message of
	"Mon, 29 May 2006 05:46:05 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21022>

Shawn Pearce <spearce@spearce.org> writes:

> OK.  Ignore both patches then.  Two negative votes in such a short
> time suggests they are probably not generally accepted.  ;-)
>
>> We probably should allow "commit -F -" to read from the standard
>> input if we already don't, but that is about as far as I am
>> willing to go at this moment.
>
> We do.  So apparently the solution to my usage issue is:
>
> 	$ fmt -w 60 | git commit -F-
> 	This is my message.
>
> 	This is the body.  Etc....
> 	EOF
>
> I'm thinking that's too much work for me.

If we supported multiple -m (presumably each becomes a single line?)
with internal fmt, I do not see how it would become less work.

	$ git commit -w60 -m "This is my message." \
        	-m '' \
        	-m 'This is the body.  Etc....'

looks more typing to me, even without the second line to force
the empty line between the summary and the body.
