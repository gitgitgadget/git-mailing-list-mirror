From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-grep documentation
Date: Sat, 21 Jan 2006 11:06:27 -0800
Message-ID: <7vzmlpo0y4.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP07F7EA1F3B544C07AA01F8AE1F0@CEZ.ICE>
	<7vvewet330.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP031BAB23C3237DA15F88D3AE1E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:06:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0O4G-0007j4-5T
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 20:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWAUTGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 14:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWAUTGa
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 14:06:30 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:1748 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751193AbWAUTG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 14:06:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121190531.SJBF15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 14:05:31 -0500
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP031BAB23C3237DA15F88D3AE1E0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sat, 21 Jan 2006 09:13:18 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15003>

sean <seanlkml@sympatico.ca> writes:

> So your new patch should also fix that comment to remove the 
> "(or flags)" portion.

Probably.

> Since you comment on the -- marker here I think it should
> also appear in the command line above:
>
> 'git-grep' [<option>...] [-e] <pattern> [--] [<path>...]

I've thought about this but it is not any more correct than what
we have now (both are technically incorrect).  If you do not use
an `-e` and let a non-option terminate the option processing,
double dashes are not removed, so you do not want it there.

> Instead it is more useful for them to be told _specificly_ which 
> git-ls-files options  are available and that all others will be 
> passed to grep.   Somthing like:

I like it.

> ...    Your patch fixes the problem case and 
> there is no reason now to warn the user away from supplying the --
> marker in addition to the "-e"; it'll work properly in either case.

Does it?  I think if you give -- without -e it will look for a
path that matches -- because we pass our own -- to ls-files.

> That's it and the rest looked good.  In case you agree with anything
> i've said here, find an amended version of your patch below.

Thanks.

When people make an improvement proposal, I'd often prefer to
see a patch that is on top of the patch being discussed, not a
replacement.
