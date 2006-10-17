From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 18:53:34 -0400
Message-ID: <45355EEE.3060105@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <Pine.LNX.4.64.0610171448150.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 00:53:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZxoi-00009k-Dp
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 00:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWJQWxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 18:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWJQWxn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 18:53:43 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:54980 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1750908AbWJQWxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 18:53:42 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZxoW-00057h-00; Tue, 17 Oct 2006 18:53:36 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610171448150.3962@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29128>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Tue, 17 Oct 2006, Aaron Bentley wrote:
>>>> Interesting.  We don't do 'fast-forward' in that case.
>>> Fast-forward is a really good idea. Perhaps you could implement it,
>>> if it is not hidden under different name?
>> We support it as 'pull', but merge doesn't do it automatically, because
>> we'd rather have merge behave the same all the time, and because 'pull'
>> throws away your local commit ordering.
> 
> Excuse me? What does that "throws away your local commit ordering" mean?

Say this is the ordering in branch A:

a
|
b
|
c

Say this is the ordering in branch B:

a
|
b
|\
d c
|/
e

When A pulls B, it gets the same ordering as B has.  If B did not have e
and c, the pull would fail.

> So generating an extra "merge" commit would be actively wrong, and adds 
> "history" that is not history at all.

It's not a tree change, but it records the fact that one branch merged
the other.

> It also means that if people merge back and forth from each other, you get 
> into an endless loop of useless merge commits.

You can pull if you don't want that.  We haven't found that people are
very fussed about it.

> There's no reason _ever_ to not just fast-forward if one repository is a 
> strict superset of the other.

Maybe not in Git.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNV7u0F+nu1YWqI0RAhGtAJwOlWpl088pbl63EHyF04qQCYlXBgCfW0Tm
cfXuE0vqeWelfFbpzffiCNI=
=McQ2
-----END PGP SIGNATURE-----
