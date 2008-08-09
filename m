From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH] tg-create.sh: Support for multiple {to,cc,bcc}
	options
Date: Sat, 9 Aug 2008 10:27:01 +0200
Message-ID: <20080809082701.GE32184@machine.or.cz>
References: <1218141086-16063-1-git-send-email-bert.wesarg@googlemail.com> <20080809003357.GQ10151@machine.or.cz> <7vbq039dfa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 10:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRjo0-0001Ua-AU
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 10:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbYHII1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 04:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbYHII1F
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 04:27:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51337 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbYHII1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 04:27:04 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 865252C4C036; Sat,  9 Aug 2008 10:27:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vbq039dfa.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91754>

On Fri, Aug 08, 2008 at 06:37:13PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> >> +	prefix="$(echo "$2" | sed -e 's/\//\\\\\//g')"
> >
> > Maybe use s### ? ;-)
> 
> Personally I like '|' instead.  It's much less visually distracting than #.

I'm just used to '#' more, but either is fine for me.

> >> +
> >> +	git config --get-all topgit.$1 2>/dev/null |
> >> +		sed -e "s/^/$prefix /g"
> >> +}
> >
> > Won't this return an error code and terminate the script in case no
> > option is defined?
> 
> Exit code from upstream of a pipe does not affect the exit code from the
> pipeline, and sed does not exit non-zero just because there was no
> substitution.

Oh, you're right - somehow I didn't quite absorb that pipe is used late
at the night. ;-) I still don't understand the stderr redirect, though.

				Petr "Pasky" Baudis
