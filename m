From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] Re: [TRIVIAL] Documentation: merge: one <remote> is
 required
Date: Wed, 12 Aug 2009 12:56:18 +0200
Message-ID: <1250074578.7545.2.camel@localhost.localdomain>
References: <1249995838.1589.3.camel@localhost.localdomain>
	 <20090811144253.GA12956@vidovic>
	 <1250002681.2707.2.camel@localhost.localdomain>
	 <7vy6ppbvdf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 12:56:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbBVj-0001vq-GP
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 12:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbZHLK4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 06:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbZHLK4V
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 06:56:21 -0400
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:52832 "EHLO
	smtp-out3.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552AbZHLK4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 06:56:20 -0400
Received: from [212.123.169.34] (helo=[192.168.1.61])
	by smtp-out3.tiscali.nl with esmtp (Exim)
	(envelope-from <pebolle@tiscali.nl>)
	id 1MbBVE-000816-Pk; Wed, 12 Aug 2009 12:56:20 +0200
In-Reply-To: <7vy6ppbvdf.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.27.5 (2.27.5-3.kb.1.fc12) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125693>

On Tue, 2009-08-11 at 19:48 -0700, Junio C Hamano wrote: 
> Paul Bolle <pebolle@tiscali.nl> writes:
> > No, since "<remote>..." means one or more instances of the "<remote>"
> > option.  
> 
> Does it really?
> 
> After you brought up this "one or more", I re-read the docs your patches
> touched, thinking that the author might have meant 'zero or more of A'
> with these '<A>...'  notation.
> 
> And I realized that they made perfect sense.
> 
> In general, you can write:
> 
> 	<command> ...
> 
> and read this as "The <command> can be followed by nothing or something
> (zero or more) of unspecified kind".  If <command> takes only one type of
> zero or more things, you can _clarify the ellipses_ by prefixing them with
> what kind of "stuff" you are talking about:
> 
> 	<command> <remote>...
> 
> and read this as "The <command> can be followed by nothing or something
> (zero or more) of <remote>s".
> 
> On the other hand, you can also say (note that the ellipses stand on their
> own and are not associated with <remote>):
> 
> 	<command> <remote> ...
> 
> and read this as "It takes one <remote> followed by nothing or something
> (zero or more) of unspecified kind".

It is (now) clear to me that in these two documents the author(s) meant
"zero or more". Still, I find the "one or more" meaning more obvious.
The (GNU) manpages of "cp", "mv", "rm", and "ls" use the "one or more"
meaning. (Note that the explanation quoted above can easily be rewritten
with for "one or more" meaning and still make sense.) 

Anyway, I now see that "zero or more" is used quite a lot in git's
manpages. But, that meaning doesn't fit so well with the
"[<command>...]" syntax that is also used a lot in these manpages. (I
find "optionally one or more of <command>" more obvious as otherwise
"<command>..." and "[<command>...]" are basically identical.)

Confusingly, as far as I can see, the manpages of the following commands
seem to use the "one or more" meaning:
    git merge-base
    git mv
    git name-rev
    git rm
    git send-email
    git tag -d
    git tag -v
    git verify-tag

("git mv" uses both meanings in its synopsis. The two "git tag"
invocations seem to do nothing with zero arguments and do not return an
error.)

If the above commands really use the "one or more" meaning, that would
mean both versions are used in the documentation. I'd say it would be
better to stick to one meaning throughout the manpages.


Paul Bolle
