From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Few Questions
Date: Tue, 20 Jan 2009 08:04:10 -0800
Message-ID: <20090120160410.GI14053@spearce.org>
References: <726600.29783.qm@web35708.mail.mud.yahoo.com> <m3r62yx9qi.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: m.arya@yahoo.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 17:06:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPJ6z-0002vY-SR
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 17:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbZATQEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 11:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbZATQEM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 11:04:12 -0500
Received: from george.spearce.org ([209.20.77.23]:43880 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbZATQEL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 11:04:11 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4457B38210; Tue, 20 Jan 2009 16:04:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3r62yx9qi.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106485>

Jakub Narebski <jnareb@gmail.com> wrote:
> "Arya, Manish Kumar" <m.arya@yahoo.com> writes:
> > 
> > I want to have following with Git
> > 
> > - LDAP and ssh authentication.
> > 
> 
> Instead of inventing (and failing) its own protocol and its own
> authentication git uses established solutions for authentication: SSH
> for "smart" server, and WebDAV for push via (currently only "dumb")
> HTTPS protocol.
> 
> There exist solutions that help with setting up SSH for git:
> git-shell, ssh_acl, and I think most commonly used Gitosis (see
> seminal reference about Gitosis on http://git.or.cz/gitwiki/BlogPosts).
 
Yup.  Gitosis is very popular for this.

At my last job I rolled my own Gitosis-lite, but in Perl, because
they are a Perl based shop.  It also uses the update-paranoid hook
for access controls, as its more flexible (and easier to confuse
the heck out of yourself) than Gitosis.  But if you can get along
with Gitosis, its a good choice.  Unfortunately its authentication
is limited to public keys registered in the authorized keys file
of the "git" user.

<plug type="not-quite-ready-but-will-be-soon">

Gerrit2 is also likely to enter this "market" soon.  I'm trying to
get it production ready and live for one major project before the
end of this month.  It embeds its own SSH daemon on a non-standard
port, completely disconnected from the OS authentication.  This may
make it slightly more palatable in some enviroments then Gitosis,
as you don't need a huge authorized_keys file, and you don't have
to worry quite so much about attack vectors.

Unlike with Gitosis, public key management is placed on end-users
by using web authentication to identify the user, and letting the
user manage their own "authorized key list".  It also has a full
blown web based code review system built in.  Which right now a
project must use if it is hosted by Gerrit2.  :-)

</plug>

-- 
Shawn.
