From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Repository from hell (gitk stresstest)
Date: Sun, 4 May 2008 15:36:49 +0200
Message-ID: <20080504133649.GA31370@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 15:38:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsePl-0006eD-H0
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 15:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYEDNgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 09:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280AbYEDNgv
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 09:36:51 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42975 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYEDNgu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 09:36:50 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 2D1855461; Sun,  4 May 2008 15:36:49 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81175>

Just in case someone wants to see how gitk performs on a tree with 8
main branches and littered with backports (single-patch-cross-merges
between branches), have a look at:  git://git.cuci.nl/pike

Start gitk with --all to view it in full glory (of course).

Some notes:
- The branches are interconnected through their first-parents as follows:
   v0 --o--o--o--o--o--o--o-------- 7.7
         \  \  \  \  \  \  \
          \  \  \  \  \  \  o------ 7.6
           \  \  \  \  \  o-------- 7.4
            \  \  \  \  o-------- 7.2
             \  \  \  o-------- 7.0
              \  \     \
               \  \     o------ nt-tools
                \  o-------- 0.6
                 o--------- 0.5
- As one can see, gitk deals with the numerous backports just fine,
  except that it uses a bit (too) much screen realestate perhaps at
  times.
- I find the Branches, Follows and Precedes display of gitk confusing
  on occasion, when inside this entanglement of backports.
  Most notably, IMO:
  + It should only show the main branch you're on (i.e. when determining
    the branch, please use the first-parent information only, and
    disregard any parents that come from merges).
  + The "Follows" and "Precedes" list might look cleaner when
    displaying only the tags which are on the same main branch the
    current commit is part of.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
