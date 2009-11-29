From: Peter Weseloh <Peter.Weseloh@gmail.com>
Subject: What is the best way to backport a feature?
Date: Sun, 29 Nov 2009 16:28:17 +0000 (UTC)
Message-ID: <loom.20091129T164518-669@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 17:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEmdk-00070Z-1X
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 17:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZK2Q2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 11:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbZK2Q2f
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 11:28:35 -0500
Received: from lo.gmane.org ([80.91.229.12]:49315 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbZK2Q2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 11:28:35 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NEmdc-0006wE-9x
	for git@vger.kernel.org; Sun, 29 Nov 2009 17:28:40 +0100
Received: from 192.94.31.2 ([192.94.31.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 17:28:40 +0100
Received: from Peter.Weseloh by 192.94.31.2 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 17:28:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.94.31.2 (Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.20) Gecko/20081217 Firefox/2.0.0.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134020>

Hi,

Suppose I have the following situation:

  o--o--o                    Release_1.0
 /    \  \                  
o-o-o--o--o-o-o-o-o-o---o--o Mainline
     \       \       \ /    
      F1--F2--M1--F3--M2     Feature_A

Now I want to backport "Feature_A" to the "Release_1.0" branch so that it gets
included into the next minor release, i.e. I want to apply the commits F1, F2
and F3 onto the "Release_1.0" branch.
I cannot just merge "Feature_A" into "Release_1.0" because that would also bring
in the merges M1 and M2 so a lot of other stuff from the Mainline.

I played with cherry-pick but that means I have to manually find the commits F1,
F2 and F3 (which in reality could be many more if Feature_A is big) which is not
very nice.

I also tried 'rebase -i' but that means I have to manually delete all the lines
for changesets from the mainline. Also not very nice.

Is there a better way? To me this scenario sounds not unusual but I could not
find a solution.

Thanks,
Peter
