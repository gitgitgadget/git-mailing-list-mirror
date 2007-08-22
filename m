From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: confused about preserved permissions
Date: Wed, 22 Aug 2007 14:52:36 +0200
Organization: eudaptics software gmbh
Message-ID: <46CC3194.764A29D4@eudaptics.com>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 14:52:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INphg-0003FC-Jl
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 14:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759479AbXHVMww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 08:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759098AbXHVMww
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 08:52:52 -0400
Received: from main.gmane.org ([80.91.229.2]:39624 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756843AbXHVMwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 08:52:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INphZ-0000v7-EM
	for git@vger.kernel.org; Wed, 22 Aug 2007 14:52:49 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 14:52:49 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 14:52:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56376>

Benoit SIGOURE wrote:
> this thread drifted away and although the discussion is interesting,
> the original question hasn't been answered so far and I am in a
> situation where I'd like to know the answer (because my working tree
> needs to be group-readable for a given project and my umask 066 keeps
> annoying me although I don't want to change it).
> 
> Someone on IRC pointed me to http://git.or.cz/gitwiki/
> ContentLimitations which says:
> 
> "By design, git cannot track other aspects of the filesystem, including:
>    * File modes (except for the "executable" bit, and being symbolic
> link)"
> 
> That's weird since the file mode is saved in the tree, isn't there a
> way to ask Git to restore this file mode?

At this time, there is not. git tracks only the executable bit. Even
though it stores (and reports) the complete mode, it only ever stores
one of these mode values: 100644, 100755, 120000. Yes, that's an
enormous waste of bits, but that's how it is.

-- Hannes
