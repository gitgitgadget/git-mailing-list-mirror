From: =?utf-8?Q?=C3=93scar_Fuentes?= <ofv@wanadoo.es>
Subject: BUG? git log -Sfoo --max-count=N
Date: Sun, 06 Mar 2011 22:37:37 +0100
Message-ID: <87hbbgvske.fsf@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 22:38:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwLeX-0003MN-Er
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 22:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277Ab1CFVh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 16:37:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:52668 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807Ab1CFVh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 16:37:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PwLeF-0003Eh-Q2
	for git@vger.kernel.org; Sun, 06 Mar 2011 22:37:55 +0100
Received: from 103.red-79-150-239.dynamicip.rima-tde.net ([79.150.239.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 22:37:55 +0100
Received: from ofv by 103.red-79-150-239.dynamicip.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 22:37:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 103.red-79-150-239.dynamicip.rima-tde.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:3Jg4ON54kl4hZt8lc0vZHRtb2mo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168532>

The documentation says

--max-count=<number> 
  Limit the number of commits output

but when used with -S as in

git log -Sfoo --max-count=N

it acts as "inspect only the N first commits", i.e. if `foo' is not
present on any of the first N commits no output is shown.

Using other filtering options (such as `--grep=' or `-- somepath')
together with --max-count=N will output at most N commits regardless of
the position on the history of those commits, as expected.

Tested with git 1.7.1 and 1.7.4.
