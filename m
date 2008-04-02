From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: "git add --interactive" does not work with UTF-8 filenames
Date: Tue, 01 Apr 2008 17:41:00 -0700
Message-ID: <7v63v1ccmb.fsf@gitster.siamese.dyndns.org>
References: <200804012232.03559.tlikonen@iki.fi>
 <m3y77xtk32.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 02:42:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgr35-00074M-3J
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 02:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbYDBAlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 20:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbYDBAlM
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 20:41:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbYDBAlL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 20:41:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B12421F8F;
	Tue,  1 Apr 2008 20:41:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D6D831F8C; Tue,  1 Apr 2008 20:41:02 -0400 (EDT)
In-Reply-To: <m3y77xtk32.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue, 01 Apr 2008 13:08:07 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78672>

Jakub Narebski <jnareb@gmail.com> writes:

> git-config(1):
>
>   core.quotepath::
> 	The commands that output paths (e.g. `ls-files`,
> 	`diff`), when not given the `-z` option, will quote
> 	"unusual" characters in the pathname by enclosing the
> 	pathname in a double-quote pair and with backslashes the
> 	same way strings in C source code are quoted.  If this
> 	variable is set to false, the bytes higher than 0x80 are
> 	not quoted but output as verbatim.  Note that double
> 	quote, backslash and control characters are always
> 	quoted without `-z` regardless of the setting of this
> 	variable.
>
> Since 1.5.2.2 (I think), or at least 1.5.3, so you have new enough
> version of git (git is now at 1.5.5-rc2).

Yes, but I do not think "add -i" unwraps the path quoting.  I think it
should, but I do not think I bothered to.  Because it is trivial to do by
any aspiring git hacker wannabes, I left it as an exercise to readers when
I did the "interactive" as a quick-and-dirty hack (aka "demonstration").

Somehow nobody found an itch to improve it until now, but it seems that we
found a volunteer with the itch ;-)
