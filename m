From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH V3 1/4] git-mw: Introduction of GitMediawiki.pm
Date: Sun, 16 Jun 2013 22:18:34 +0200
Message-ID: <vpqobb5g679.fsf@anie.imag.fr>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
	<1371349893-7789-2-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Sun Jun 16 22:18:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoJPZ-0006jD-VX
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 22:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab3FPUSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 16:18:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58547 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015Ab3FPUSh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 16:18:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5GKIWEj031574
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 22:18:32 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoJPG-0003nQ-Ut; Sun, 16 Jun 2013 22:18:35 +0200
In-Reply-To: <1371349893-7789-2-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Sun, 16 Jun 2013 04:31:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 16 Jun 2013 22:18:32 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228024>

benoit.person@ensimag.fr writes:

> changes from the V2:
>   - Add a way to test, without installation, code that uses GitMediawiki.pm.

This still needs to be documented, even very quickly, somewhere in the
code (e.g a comment in the Makefile).

> -build install clean:
> +copy_pm:
> +	cp $(GIT_MEDIAWIKI_PM) $(GIT_ROOT_DIR)/perl/blib/lib/

I already commented on this:

http://thread.gmane.org/gmane.comp.version-control.git/227711/focus=227721

Also, it seems to be only part of the solution. With your change, from
contrib/mw-to-git/ and after running only "make",

./git-mw takes the installed version of GitMediawiki.pm in priority

../../bin-wrappers/git takes the installed version of git-mw only (i.e.
does not know "git mw" if "make install" hasn't been ran).

>  perlcritic:
> -	perlcritic -2 *.perl
> +	perlcritic -2 *.perl
> \ No newline at end of file

Please, avoid these whitespace-only changes. They create noise during
review, and more potential conflicts.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
