From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Few Questions
Date: Tue, 20 Jan 2009 07:44:27 -0800 (PST)
Message-ID: <m3r62yx9qi.fsf@localhost.localdomain>
References: <726600.29783.qm@web35708.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: m.arya@yahoo.com
X-From: git-owner@vger.kernel.org Tue Jan 20 16:45:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPInc-0005rT-Lr
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 16:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbZATPob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 10:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756029AbZATPob
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 10:44:31 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:63659 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772AbZATPoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 10:44:30 -0500
Received: by ewy13 with SMTP id 13so986972ewy.13
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ncjkorqYDvl2xKqpSKHFLMip8AlKgn7DvRiIhMZIqJo=;
        b=xm9e0e4SChWGB69UtHg3imqybPSvzaYpeZ1VW0cKGnViBYJUhBnt/eZE41gTzQa+03
         aZbIxV/ruMePOGmGnjd83tkgGsyogord+o6cPgYE104jqO1YnL3BPkW4SY7wQ/m/tq6B
         aIrO1r6kkBLhghVlHMW8f1rHaDjFV7ifmbSTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=k9XJftkauLGsrr31TCEDDOhGIGPn8hl8Y+8Xf++HT6Pk+ponzwT/WmyIL9VUbaypLc
         uqNWwpl6L+Pq27ly4nExEJnJE5sY/dUfe1CHsPAPRE3azJGNRlfiSAxp/eauN+JauxFC
         aVVwTIt1cxwlU8vHSiiCgfggwDYm3XmsfRiKc=
Received: by 10.210.70.14 with SMTP id s14mr799668eba.36.1232466268523;
        Tue, 20 Jan 2009 07:44:28 -0800 (PST)
Received: from localhost.localdomain (abvq106.neoplus.adsl.tpnet.pl [83.8.214.106])
        by mx.google.com with ESMTPS id 28sm11105904eyg.54.2009.01.20.07.44.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jan 2009 07:44:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0KFitDW000581;
	Tue, 20 Jan 2009 16:44:55 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0KFisbF000578;
	Tue, 20 Jan 2009 16:44:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <726600.29783.qm@web35708.mail.mud.yahoo.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106482>

"Arya, Manish Kumar" <m.arya@yahoo.com> writes:

> Hi,
> 
> I am new to Git. Earlier I have configured svn with LDAP auth and
> svnwebclient.
> 
> I want to have following with Git
> 
> - LDAP and ssh authentication.
> 

Instead of inventing (and failing) its own protocol and its own
authentication git uses established solutions for authentication: SSH
for "smart" server, and WebDAV for push via (currently only "dumb")
HTTPS protocol.

There exist solutions that help with setting up SSH for git:
git-shell, ssh_acl, and I think most commonly used Gitosis (see
seminal reference about Gitosis on http://git.or.cz/gitwiki/BlogPosts).

> - checkin and checkout using web interface and ssh
> 

Git is distributed version control system: checkin (named 'commit' in
git) and checkout are _local_ operations.  Fetch (getting new changes
from remote repository) and clone (creating new local repository
following or forking specified remote repository) can be done via
local filesystem, via git:// protocol, via "dumb" HTTP, and via SSH.
Push (sending changes to remote repository) needs autheticated
channel: most common used is SSH, but you can also use WebDAV with
HTTPS.

There are web interfaces for Git, something like SVN::Web or ViewVC,
like gitweb (in Perl, developed in git.git repository) and cgit (in C).
See also "Web interfaces" section on InterfacesFrontendsAndTools page
on git wiki.

> - when ever someone checkin something then a email should be send to
>   a email address (a mailing list)

If by 'checkin' you mean publishing changes to a server (i.e. push in
git terminology), see for example contrib/hooks/post-receive-email
hook.
 
> please let me know how to do this with Git

Please learn that Git is _different_ from Subversion, and not try to
follow your SVN workflow and expectations blindly.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
