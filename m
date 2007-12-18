From: Alex Riesen <raa.lkml@gmail.com>
Subject: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 18:33:21 +0100
Message-ID: <20071218173321.GB2875@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 18:33:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4gKC-0006rz-Ma
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 18:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562AbXLRRdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 12:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbXLRRdY
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 12:33:24 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45199 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbXLRRdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 12:33:23 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsGSh4=
Received: from tigra.home (Fcb97.f.strato-dslnet.de [195.4.203.151])
	by post.webmailer.de (fruni mo62) (RZmta 14.6)
	with ESMTP id v03756jBIH0NcR for <git@vger.kernel.org>;
	Tue, 18 Dec 2007 18:33:21 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 96F41277AE
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 18:33:21 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 804F656D22; Tue, 18 Dec 2007 18:33:21 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68786>

Noticed by a collegue of mine. Consider:

    $ cd $GIT/t
    $ git show 570f32266:t/test-lib.sh    # works
    $ git show 570f32266:test-lib.sh      # does not work
    $ git show 570f32266:./test-lib.sh    # does not work
    $ git show 570f32266:/t/test-lib.sh   # does not work

Considering that the relative path names work as filters (and many
agreed on that being useful), it would be nice to allow relative
pathnames in blob specifications for git-show and git-cat-file.

(besides the colon is a good delimiter, even tab-completion works with it)
