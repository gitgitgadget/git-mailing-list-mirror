From: Alex Riesen <raa.lkml@gmail.com>
Subject: git-send-pack: broken handling of ref specs with wildcards
Date: Fri, 8 Jun 2007 00:53:02 +0200
Message-ID: <20070607225302.GA10633@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 00:53:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQqs-0000th-58
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965736AbXFGWxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965893AbXFGWxH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:53:07 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:33312 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965736AbXFGWxG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:53:06 -0400
Received: from tigra.home (Fc805.f.strato-dslnet.de [195.4.200.5])
	by post.webmailer.de (klopstock mo59) (RZmta 7.2)
	with ESMTP id K02d6aj57KtP85 for <git@vger.kernel.org>;
	Fri, 8 Jun 2007 00:53:03 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 7903C277BD
	for <git@vger.kernel.org>; Fri,  8 Jun 2007 00:53:03 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id F167ABEA7; Fri,  8 Jun 2007 00:53:02 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWosH
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49402>

Try something like this:

    git-send-pack --remote=origin --thin /some/other/repo \
    'refs/heads/*:refs/remotes/child/*'

The result looks broken: the sent reference are created not in
refs/remotes/child/ but just in refs/heads/ of /some/other/repo.
