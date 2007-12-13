From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: git config --get-regexp exit status
Date: Thu, 13 Dec 2007 14:42:31 +0100
Message-ID: <871w9qsoc8.fsf@lysator.liu.se>
References: <20071213133653.13925.89254.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 14:49:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oQy-0001cT-1e
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 14:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbXLMNsX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 08:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbXLMNsX
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 08:48:23 -0500
Received: from main.gmane.org ([80.91.229.2]:54744 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbXLMNsW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 08:48:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J2oOF-00047Z-82
	for git@vger.kernel.org; Thu, 13 Dec 2007 13:46:15 +0000
Received: from c83-253-242-75.bredband.comhem.se ([83.253.242.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 13:46:15 +0000
Received: from davidk by c83-253-242-75.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 13:46:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-242-75.bredband.comhem.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:N6CfIaxWSu8GD7kl+CalTKKdjyo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68152>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> I made a patch that uses "git config --get-regexp" to get the
> description and stgit.stackformatversion options for all branches at
> once, and ignore the "protected" flag that I don't use. With this
> change, I'm almost down to half a second, which almost makes it
> usable.

One thing that annoyed me what that "git config --get-regexp" will
return zero, one, or more matches, which are all valid reponses. But
it treats the zero-match special and return an exit status of 1.

Is that a conscious choice, or just an effect of how "git config
--get" works?

Since zero matches isn't really an error, I would like the exit status
to be 0. At least for this use case :-)

--=20
David K=C3=A5gedal
