From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 00/19] gitweb: Remove dependency on external diff and need for temporary files
Date: Fri, 25 Aug 2006 23:15:56 +0200
Message-ID: <200608252315.57181.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 23:16:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGj1v-0000nf-Vo
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 23:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWHYVPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 17:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWHYVPx
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 17:15:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:7398 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750830AbWHYVPw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 17:15:52 -0400
Received: by nf-out-0910.google.com with SMTP id o25so892235nfa
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 14:15:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sWDrBOL2CyZ8KL6H5qThzsSdenNTLfnPwYNPdkDdGIPfiMYekOQSyI8FQJMdLUnrGoTxchJjR5yHbx/ZXNPMN/pXglkXkeN4URhfC5K5PT0pTtrgEiedo8SePEPw5vK8Yqfu187Ai6WMbcxtI2YZcs0rI7MGhwdGUONzfzy4TCU=
Received: by 10.48.48.18 with SMTP id v18mr5923873nfv;
        Fri, 25 Aug 2006 14:15:51 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id l27sm7308990nfa.2006.08.25.14.15.51;
        Fri, 25 Aug 2006 14:15:51 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26015>

This series of patches (now finished) removes dependency on
external diff (/usr/bin/diff) to produce commitdiff and blobdiff
views, and the need for temporary files.

Comments appreciated.

You can view new gitweb in work at
  http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi
---
 gitweb/gitweb.css  |   16 +
 gitweb/gitweb.perl |  734 +++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 515 insertions(+), 235 deletions(-)


Shortlog:

01/19 gitweb: Use git-diff-tree patch output for commitdiff
02/19 gitweb: Replace git_commitdiff_plain by anonymous subroutine
03/19 gitweb: Show information about incomplete lines in commitdiff
      Revert "gitweb: Replace git_commitdiff_plain by anonymous
              subroutine"
04/19 gitweb: Remove invalid comment in format_diff_line
05/19 gitweb: Streamify patch output in git_commitdiff
06/19 gitweb: Add git_get_{following,preceding}_references functions
07/19 gitweb: Return on first ref found when
      git_get_preceding_references is called in scalar context
08/19 gitweb: Add git_get_rev_name_tags function
09/19 gitweb: Use git_get_name_rev_tags for commitdiff_plain 
      X-Git-Tag: header
10/19 gitweb: Add support for hash_parent_base parameter for blobdiffs
11/19 gitweb: Allow for pre-parsed difftree info in git_patchset_body
12/19 gitweb: Parse two-line from-file/to-file diff header
      in git_patchset_body
13/19 gitweb: Add invisible hyperlink to from-file/to-file diff header
14/19 gitweb: Always display link to blobdiff_plain in git_blobdiff
15/19 gitweb: Change here-doc back for consistency in git_blobdiff
16/19 gitweb: Use git-diff-tree or git-diff patch output for blobdiff
17/19 gitweb: git_blobdiff_plain is git_blobdiff('plain')
18/19 gitweb: Remove git_diff_print subroutine
19/19 gitweb: Remove creating directory for temporary files

-- 
Jakub Narebski
ShadeHawk on #git
Poland
