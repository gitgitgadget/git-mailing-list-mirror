From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: 1.5.4-rc2 plans
Date: Fri, 21 Dec 2007 04:09:49 -0500
Message-ID: <8bd0f97a0712210109q7805d967sc9b4cd13d4131360@mail.gmail.com>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
	 <476B6ABB.6040009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 10:10:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5dtr-0004Py-CZ
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 10:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbXLUJJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 04:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbXLUJJ4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 04:09:56 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:15926 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbXLUJJx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 04:09:53 -0500
Received: by py-out-1112.google.com with SMTP id u77so550053pyb.16
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nh39CicPcGyrZPPLU+zt5QzaWFhVJID9edKHyESV36g=;
        b=Vvm6lhPiBu3wJgWoUd8LpGy9WiEh7E3HE56ocJUdXBLtdopIQjAGv/1Jr88XaOn4Q94Qj284XB2P8F/uedKrGOXsT3FOt3Grxy75p8wkRpbgS1Yoj/LrLGWt1JDLg6beTUVyVClFzV5p4D7EFJ8bfLvAwt860sIXLZk6hKxnHGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mJhAH8fdJ6IfQBqY61z0rOpXH20Ykzjlum4DM9QlXdtk5DpKK4zvGBgqRqGO2CuGWKOQ/Y/u2+JP3fyK8j0RAsW++c5iLdrTEWhisKwm0+hn6r2IbbARDoF8SyF2jzVBhj9PG9Ku0d8/NWVZD1CUg8Q1eqIN0LtKkHDYVSB5Vq4=
Received: by 10.142.128.6 with SMTP id a6mr488175wfd.135.1198228189921;
        Fri, 21 Dec 2007 01:09:49 -0800 (PST)
Received: by 10.142.165.7 with HTTP; Fri, 21 Dec 2007 01:09:49 -0800 (PST)
In-Reply-To: <476B6ABB.6040009@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69048>

On Dec 21, 2007 2:26 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Junio C Hamano schrieb:
> >  * Should "git stash" stop doing anything useful?  I think the patch
> >    from Nana today may be a reasonable compromise, although I still
> >    think fundamentally different behaviour for the same command
> >    configurable per-user is not very nice (we have precedent in "git
> >    clean" already, though, but "git clean" is inherently dangerous
> >    command, and "git stash" is much more useful and the issue impacts
> >    more people).
>
> IMO we should give in and play the safe game. For those who don't like to
> type "git stash save" can always
>
>     git config --global alias.shelve "stash save"
>     git config --global alias.unshelve "stash apply"
>
> and retrain the fingers.

in the past, i used git merely to checkout code and send diffs to
maintainers ... never for my own work.  ive started to transition from
using svn everywhere to trying out git, and saw reference to this
"stash" command on another list.  i wanted to learn more about it, so
i started off with `git-stash` to get some info, and wondered what
just happened.  then i typoed the --help option and wondered even more
what just happened :).

after flipping through the git mailing list for a while, it's good to
see that `git stash <random crap>` will be fixed in the next release,
and yes the default behavior of saving is confusing.  the argument
that newbies can easily recover their work really only works if the
newbie knows what's going on.  if they knew from the start, then they
wouldnt be newbies eh.

making the default behavior non-destructive (which is to say, not
changing anything) and allowing people to arbitrarily configure the
default behavior sounds sane to me.  taking it up a level, people
could just as easily write functions in their shell environment to do
the same thing.  which is to say that imho, the argument against this
for fear of different behavior depending on user is over the top.
configuration options are there to change the behavior based on the
user's preference.
-mike
