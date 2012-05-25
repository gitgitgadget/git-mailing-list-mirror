From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of ~/.gitconfig
Date: Fri, 25 May 2012 19:29:44 +0200
Message-ID: <vpqvcjkrwxj.fsf@bauges.imag.fr>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
	<20120525170159.GA4086@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Cc: nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 19:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyKu-0003XQ-9S
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807Ab2EYR3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 13:29:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38608 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948Ab2EYR3u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 13:29:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4PHLg1a012081
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 19:21:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SXyKf-0004Q3-Q4; Fri, 25 May 2012 19:29:45 +0200
In-Reply-To: <20120525170159.GA4086@burratino> (Jonathan Nieder's message of
	"Fri, 25 May 2012 12:01:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 May 2012 19:21:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4PHLg1a012081
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338571304.67638@VEN29RAwQ84+03IJVOOg3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198487>

Jonathan Nieder <jrnieder@gmail.com> writes:

> What other hidden files at the root of the user's directory are you
> talking about?

A typical user configuration (or at least mine ;-) ) can include:

[core]
	excludesfile = ~/.gitignore
	attributesfile = ~/.gitattributes

Not having a default value for these two variables is a bit painful. For
example, when I teach newbies not to version their *~ backup files, I'd
like to grab their keyboard and type for them

  echo '*~' >> ~/.gitignore

but right now, it takes a bit more time than that (which multiplied by
35 students in a room is not negligible ;-) ).

Actually, I now remember trying to find a default value some time ago:

  http://thread.gmane.org/gmane.comp.version-control.git/133343

The conclusion essentially boiled down to "let's drop the patch until
there's a clear consensus on what the default value should be", and
"don't default to ~/.gitsomething, because it will be painful to migrate
to a user config directory later".

Once it's official that the configuration is in stg like ~/.config/git/,
we can start thinking about a default value for core.excludesfile and
core.attributesfile, in the same directory (note: we're just talking
about default values here, so users having set the variable explicitely
won't be affected by the change).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
