From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Translations [of Documentation] in Git release?
Date: Tue, 27 Jan 2009 15:45:56 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0901271541250.26770@ds9.cixit.se>
References: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com>
 <bd6139dc0901261130ic64f767gddc960ebe3dfecf2@mail.gmail.com>
 <Pine.LNX.4.64.0901270800100.26770@ds9.cixit.se> <200901271216.59687.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Dill <sarpulhu@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 15:49:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRpEH-00084P-Sx
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 15:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbZA0Oq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 09:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbZA0Oq2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 09:46:28 -0500
Received: from ds9.cixit.se ([193.15.169.228]:53651 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbZA0Oq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 09:46:27 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n0REjvac022314
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Jan 2009 15:45:58 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n0REjuw1022307;
	Tue, 27 Jan 2009 15:45:56 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <200901271216.59687.jnareb@gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 27 Jan 2009 15:45:58 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107348>

Jakub Narebski:

> Fundamental, that program output is considered API (at least for
> plumbing commands) and used when scripting (this might be ameliorated
> with "I am script" switch or environmental variable).

That's a bug. Protocol data (which one could consider the plumbing
output to be) should never be forwarded to the end-user, except for
debugging purposes. It is the porcelain's task here to translate the
messages for the user.

Plumbing commands could still output semi-readable English, but it is
still to be considered protocol, and be hidden from the user. Having
low-level protocol data filter through to the end-user is a common
mistake in software, unfortunately, and makes internationalization and
localization a lot harder.

Of course, if the user insists on calling the plumbing commands
directly, he will not get translated output. That's expected behaviour.

> Technical, because Git is mixture of programs in C, shell scripts,
> and Perl scripts, and you have to come with technical means of
> translating messages in all three of them.

Gettext has succesfully been used to translate messages in all of these
environments, so that should not be a big problem.

> Not in all cases. Sometimes it shows "long usage". Perhaps that
> should be made more consistent?

Consistency is good.

-- 
\\// Peter - http://www.softwolves.pp.se/
