From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local changes without pushing
Date: Wed, 12 Jun 2013 08:55:12 +0200
Message-ID: <vpqli6f24z3.fsf@anie.imag.fr>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
	<20130609060807.GA8906@sigill.intra.peff.net>
	<CAETqRCiJmnz_1yjwvyWx+=kPkt3M+vKk--CnS=rnQcDA4wMSmg@mail.gmail.com>
	<20130611213722.GA21203@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?iso-8859-1?Q?Beno=EEt?= Person <benoit.person@ensimag.fr>,
	git@vger.kernel.org,
	=?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 12 08:55:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umext-0008Bo-ES
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 08:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab3FLGzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 02:55:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54739 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab3FLGzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 02:55:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5C6tC3A017126
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 08:55:12 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Umexd-0000L2-6G; Wed, 12 Jun 2013 08:55:13 +0200
In-Reply-To: <20130611213722.GA21203@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 11 Jun 2013 17:37:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jun 2013 08:55:16 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227587>

Jeff King <peff@peff.net> writes:

> I was thinking that you would be self-contained inside the
> contrib/mw-to-git directory, and therefore you would have to teach your
> code how to install the Git module, and you could not longer just "cp
> git-remote-mediawiki" into the right place to install it.
>
> But I think we have already crossed that bridge somewhat with Git.pm.
> And if you add your module as perl/Git/MediaWiki.pm and use the existing
> perl build system, then it is not any extra effort from the build
> system.

I'm not sure having perl/Git/MediaWiki.pm would be a good idea: this
MediaWiki.pm would be really a mediawiki thing more than a Git thing, so
the Git main tree probably want to stay away from it and keep it in
contrib.

But you should be able to use contrib/mw-to-git/perl/GitMediawiki.pm or
something like that and chain to ../../perl/Makefile in
contrib/mw-to-git/Makefile.

Also, for now, git-remote-mediawiki works only after you run "make
install" in Git's toplevel. I think that's ok, but it would be weird to
be able to use/test git-remote-mediawiki only after doing a "make
install" to deploy the new mediawiki Perl module.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
