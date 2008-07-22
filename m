From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: Re: [PATCH] mailinfo: better parse email adresses containg
	parentheses
Date: Tue, 22 Jul 2008 12:24:39 +0200
Message-ID: <20080722102439.GB7792@plop>
References: <1216647269-12287-1-git-send-email-book@cpan.org> <7v63qyr4kk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 12:25:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLF3u-0002vD-EL
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 12:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYGVKYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 06:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbYGVKYm
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 06:24:42 -0400
Received: from zlonk.bruhat.net ([91.121.102.217]:38771 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbYGVKYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 06:24:41 -0400
Received: from localhost ([127.0.0.1] helo=plop)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1KLF2J-0004de-LA
	for git@vger.kernel.org; Tue, 22 Jul 2008 12:24:03 +0200
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1KLF2t-0006QN-OI
	for git@vger.kernel.org; Tue, 22 Jul 2008 12:24:39 +0200
Content-Disposition: inline
In-Reply-To: <7v63qyr4kk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89482>

On Mon, Jul 21, 2008 at 08:16:43PM -0700, Junio C Hamano wrote:
> >
> > Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
> 
> Hmm, tests?
> 
> By the way, that second form parses like this:
> 
> 	mailbox =
>         name-addr =
>         display-name angle-addr = "User Name (me) <user@host>"
> 
>         display-name =
>         phrase = "User Name"
>         
>         angle-addr = CFWS "<" addr-spec ">" = "(me) <user@host>"
> 
> So strictly speaking, shouldn't we be stripping the whole (me) as garbage?
> It is not even part of the display-name but is a whitespace equivalent
> comment.

Well, I use this:

    "Philippe Bruhat (BooK)" <book@cpan.org>

as my From: line, and I would like to be able to use it so in git.

As git knows the difference between user name and user email, it should
be able to keep the information separate all the way.

Which makes me think that since it seems that rebase goes through a
patch-file step, the problem with my username may actually lie with
creating the patch file (no quotes around a user name containing parens)
rather than with parsing the patch  From: line.

-- 
 Philippe Bruhat (BooK)

 Everyone's life seems easier from the outside.
                                    (Moral from Groo The Wanderer #45 (Epic))
