From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 0/4] gitweb: ViewVC-like "tree_blame" view
Date: Thu, 31 Aug 2006 00:43:12 +0200
Message-ID: <200608310043.12606.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 31 00:43:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIYmA-0004O0-Js
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 00:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWH3Wmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 18:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWH3Wmx
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 18:42:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:43253 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750715AbWH3Wmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 18:42:52 -0400
Received: by nf-out-0910.google.com with SMTP id x30so272424nfb
        for <git@vger.kernel.org>; Wed, 30 Aug 2006 15:42:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:user-agent:mime-version:date:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iHIICeMnaprSW24TZmSIBfLvyAEsxNFPzb/5aSRPPu3rRjHnSSoDBeR9IlC9fh24hTeuNkqAJcyO/J0KjE3hdGYJOS6IbPD+N8KDh2LCbE9daIkGIY4TKJfJMRY+yGxSfK3JO+WlSZE5glaSejqWP42BSh/eLAj3laOOtUBv6J0=
Received: by 10.49.8.10 with SMTP id l10mr305373nfi;
        Wed, 30 Aug 2006 15:42:50 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id n23sm387339nfc.2006.08.30.15.42.49;
        Wed, 30 Aug 2006 15:42:50 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26237>

In response to Thomas Glanzmann (or rather a friend of his) request, 
here is series of patches which adds to tree view information about 
when last time and by whom was given file or directory touched.  As git 
records "snapshot history" and commits are whole tree, and not have per 
file history, it means that one wants to know last commit counting from 
the top which has the same version of file or the same tree.  This is 
something similar to blame (aka. annotate) for file, hence naming such 
view "tree_blame".

Current implementation is done inefficiently directly in gitweb, and 
serves rather as a proof of concept than as a serious implementation to 
use.

This series of patches is based on 'next' (v1.4.2-g39ee2f6) equivalent, 
but with the commit 25691fbe6d02135d55dfc3a5180e29890dce1521
   gitweb: Use --git-dir parameter instead of setting $ENV{'GIT_DIR'}
reverted, as it needs git version post v1.4.2-rc2, while I use git 
version 1.4.1.1, as there are no i386 RPMS for 1.4.2 yet.

ViewCVS/ViewVC prints the last touch of a a file in a directory and you 
can tell it to sort after the date criteria:
http://faumachine.informatik.uni-erlangen.de/cgi-bin/viewcvs.cgi/mutt/?sortby=date#dirlist

-- 
Jakub Narebski
ShadeHawk on #git
Poland
