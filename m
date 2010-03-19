From: Eli Barzilay <eli@barzilay.org>
Subject: Problem with contrib/hooks/post-receive-email
Date: Fri, 19 Mar 2010 02:39:02 -0400
Message-ID: <m3vdcsq0hl.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 07:39:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsVru-0007VO-BV
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 07:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab0CSGjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 02:39:32 -0400
Received: from lo.gmane.org ([80.91.229.12]:51890 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab0CSGjb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 02:39:31 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NsVrl-0007SL-O7
	for git@vger.kernel.org; Fri, 19 Mar 2010 07:39:29 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:39:29 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:39:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:gyLUzBVzmNkeu5FPDWSeeU8WRFI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142563>

The post-receive-email script goes out of its way to avoid sending
commits twice by filtering out commits that are included in existing
refs, but if more than one branch changes then some commits can end up
not being reported.  For example, I made two commits A and B, made one
branch point at A and another at B, and pushed both -- neither of the
resulting two emails had A.
-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
