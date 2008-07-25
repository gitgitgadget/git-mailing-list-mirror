From: Alex Riesen <fork0@users.sourceforge.net>
Subject: how about removing --exec-path?
Date: Fri, 25 Jul 2008 11:40:15 +0200
Message-ID: <20080725094015.GA22077@blimp.local>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 21:20:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMSq7-00045k-AI
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbYGYTTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754394AbYGYTTd
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:19:33 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:59685 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbYGYTTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:19:32 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44h+5V
Received: from tigra.home (Fa915.f.strato-dslnet.de [195.4.169.21])
	by post.webmailer.de (mrclete mo47) (RZmta 16.47)
	with ESMTP id K0045ak6PJ9Z6Z for <git@vger.kernel.org>;
	Fri, 25 Jul 2008 21:19:30 +0200 (MEST)
	(envelope-from: <fork0@users.sourceforge.net>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 7B71A277C4
	for <git@vger.kernel.org>; Fri, 25 Jul 2008 21:19:30 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 3174536D15; Fri, 25 Jul 2008 11:40:16 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90091>

The thing has at least this problem: is not passed to upload-pack when
running fetch. So upload-pack, everything past it gets called either
from GIT_EXEC_PATH (which usually is not set) or from builtin exec
path (and that's annoying when debugging for instance index-pack).

The feature has a stable alternative ($GIT_EXEC_PATH) anyway.

Or maybe just replace the whole argv_exec_path handling with a plain
setenv("GIT_EXEC_PATH", exec_path, 1)?
