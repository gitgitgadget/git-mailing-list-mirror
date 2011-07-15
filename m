From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: encrypted netrc for Git
Date: Fri, 15 Jul 2011 12:08:49 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <8762n379pa.fsf@lifelogs.com>
References: <877h82nlua.dlv@debian.org> <87aacygcfx.fsf@lifelogs.com>
	<87bowxt0sh.fsf_-_@lifelogs.com>
	<20110714150033.GA6797@sigill.intra.peff.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 19:09:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhlt6-0001ge-B0
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 19:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702Ab1GORJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 13:09:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:58443 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225Ab1GORJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 13:09:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qhlsu-0001bV-SU
	for git@vger.kernel.org; Fri, 15 Jul 2011 19:09:04 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 19:09:04 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 19:09:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:pnIgfq9sXNZiFN+zK1WoNAVfPfM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177205>

On Thu, 14 Jul 2011 11:00:33 -0400 Jeff King <peff@peff.net> wrote: 

JK> On Thu, Jul 14, 2011 at 09:05:50AM -0500, Ted Zlatanov wrote:

TZ> This would also be really nice.  ~/.netrc is not a great place to put
TZ> passwords for the HTTP transport.  In GNU Emacs we have ~/.authinfo.gpg
TZ> with the same content as ~/.netrc but encrypted by GPG and thus more
TZ> secure (the user is either prompted for the password, if the file is
TZ> encrypted symmetrically, or the user simply loads their private key into
TZ> the GPG agent).  I believe all this can be done with the GPGME library.
TZ> There's also the Secrets API on newer Gnome and KDE installs, which has
TZ> a pretty nice D-Bus interface.

JK> Check out:

JK>   https://github.com/peff/git/commits/jk/http-auth

JK> which provides an interface for getting credentials from external
JK> helpers.

The API is good, but it's not clear from the docs how to configure
credential helpers from the user side.  From the tests it looks like you
set GIT_ASKPASS to them, is that right?  And you can also set
credential.helper?

Where do those helpers fit with the .netrc file?  Are they called before
or after or instead of the .netrc parse?

Linking these with external libraries like GPGME and the Secrets API
will be pretty easy and improve the user experience.  So I'll be glad to
work on it and provide you with feedback.  Would you be interested in
pushing your patches further after the testing?  They seem pretty
complete.

I'm off-line for the next 10 days or so; I'll start testing when I get
back.

Thanks for your help
Ted
