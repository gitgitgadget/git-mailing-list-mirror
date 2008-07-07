From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Test breakage [Re: [ANNOUNCE] GIT 1.5.6.2]
Date: Mon, 07 Jul 2008 14:44:49 +0200
Message-ID: <g4t342$9m8$1@ger.gmane.org>
References: <7vy74fo9t4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 07 14:46:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFq6Y-00010q-CI
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 14:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbYGGMpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 08:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbYGGMpJ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 08:45:09 -0400
Received: from main.gmane.org ([80.91.229.2]:50321 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480AbYGGMpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 08:45:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KFq5V-000749-2N
	for git@vger.kernel.org; Mon, 07 Jul 2008 12:45:01 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 12:45:01 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 12:45:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7vy74fo9t4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87603>

Junio C Hamano venit, vidit, dixit 06.07.2008 07:34:
> The latest maintenance release GIT 1.5.6.2 are available at the usual
> places:
...

On Kubuntu 7.10 (not my choice, this is at work...), "make test" gives:

*** t9600-cvsimport.sh ***
*   ok 1: setup cvsroot
*   ok 2: setup a cvs module
*   ok 3: import a trivial module
*   ok 4: pack refs
*   ok 5: update cvs module
* FAIL 6: update git module


                 cd module-git &&
                 git cvsimport -a -z 0 module &&
                 git merge origin &&
                 cd .. &&
                 test_cmp module-cvs/o_fortuna module-git/o_fortuna


*   ok 7: update cvs module
*   ok 8: cvsimport.module config works
*   ok 9: import from a CVS working tree
* failed 1 among 9 test(s)

On the second (and subsequent) run, "make test" succeeds. I tried again 
with a fresh copy from the tarball, same effect: failure on 1, success 
on 2 and following.

This is with LANG=de_DE.UTF-8, whereas with LANG=C the tests succeed the 
first time already. Are tests supposed to be done in C locale only? Do 
they reuse data from a previous test run? I didn't notice this with 1.5.6.1.

Michael
