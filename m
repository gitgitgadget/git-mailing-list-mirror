From: Pete Forman <petef4+usenet@gmail.com>
Subject: How to pre-empt git pull merge error?
Date: Wed, 27 Nov 2013 15:17:27 +0000
Message-ID: <86d2llc1rs.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 16:35:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlh8z-0006NW-6D
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 16:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab3K0PfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 10:35:06 -0500
Received: from plane.gmane.org ([80.91.229.3]:38696 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428Ab3K0PfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 10:35:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Vlh8p-0006GP-NF
	for git@vger.kernel.org; Wed, 27 Nov 2013 16:35:03 +0100
Received: from petef.plus.com ([212.159.107.241])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 16:35:03 +0100
Received: from petef4+usenet by petef.plus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 16:35:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: petef.plus.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
Cancel-Lock: sha1:HKI5EPP4P8A0vVC5Y7i2+nHwc0o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238443>

I am looking for a way of detecting up front whether a git pull or git
merge would fail. The sort of script I want to perform is to update a
server.

    git fetch
    git okay
    stop server
    backup data
    git merge
    start server

Here git okay is a place holder for the command I am asking for.

If a file has been changed outside of a commit then git pull fails with
the following error.

error: Your local changes to '...' would be overwritten by merge.
Aborting. Please, commit your changes or stash them before you can
merge.

I would like git okay to perform the pre-merge checks described in git
merge and return non-zero status so that the script aborts before the
server is stopped.

Possibilities I have looked for and not found include git merge
--dry-run. My best line of thought is git status --porcelain |
pre-merge-okay. That seems like a lot of work to make a pre-merge-okay
that deals with things like benign untracked files.

I have also asked this question on Stack Overflow but received no
answers.

http://stackoverflow.com/questions/20221383/

-- 
Pete Forman
