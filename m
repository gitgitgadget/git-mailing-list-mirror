From: Steinar Bang <sb@dod.no>
Subject: Is there a "--follow" equvalent argument to git-rev-list?
Date: Mon, 28 Nov 2011 11:37:02 +0100
Organization: Probably a good idea
Message-ID: <87vcq4zg6p.fsf@dod.no>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 11:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUyhn-0002Ts-18
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 11:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab1K1Koy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 05:44:54 -0500
Received: from lo.gmane.org ([80.91.229.12]:60803 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab1K1Kox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 05:44:53 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RUyhf-0002QW-7H
	for git@vger.kernel.org; Mon, 28 Nov 2011 11:44:51 +0100
Received: from cm-84.208.231.161.getinternet.no ([84.208.231.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 11:44:51 +0100
Received: from sb by cm-84.208.231.161.getinternet.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 11:44:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: cm-84.208.231.161.getinternet.no
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.1 (gnu/linux)
Mail-Copies-To: never
Cancel-Lock: sha1:D4t/gtsnCD8h7Vz9TMBPGLdoYNE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186009>

I'm trying to make emacs vc log (`C-x v l') show the full history of git
versioned files.

In my first attempt, I tried adding a "--follow" argument to "git log"
in the vc-git-print-log message.  This made `C-x v l' show the full log.

But the problem with this solution was that commands done from the log,
such as diffing (a very convenient way to do diffs, when the "version
numbers" are sha1 hashes...), showing a particular revision, or
annotating from that revision and back, didn't work.  See the comment at
the end of this bug:
 http://debbugs.gnu.org/cgi/bugreport.cgi?bug=8756

Today I decided to take another peek at this, but vc-git.el in the emacs
23.1 version of the file, now uses "git rev-list" instead of "git log"
to get the revision list.

And "git rev-list" doesn't seem to have anything similar to
"--follow"...?  At least I haven't found it.

The man page doesn't contain the text "renam".

Guessing at what the man page has meant, I've tried adding the "--all"
and "--full-history" arguments, but `C-x v l' still only shows history
back to the last move.

Is there an argument to "git rev-list" that will make it track across
renames?  Or is this only possible with "git log --follow"?

Thanks!


- Steinar
