From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-filter-branch: Add an example on how to remove
	empty commits
Date: Wed, 29 Oct 2008 17:39:19 -0700
Message-ID: <1225327159.21951.15.camel@maia.lan>
References: <1225326833-15210-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Oct 30 01:51:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvLlL-00081N-QH
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 01:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbYJ3Auf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 20:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbYJ3Aue
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 20:50:34 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48972 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbYJ3Aue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 20:50:34 -0400
X-Greylist: delayed 659 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Oct 2008 20:50:34 EDT
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 0E5D021D238; Thu, 30 Oct 2008 13:39:33 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 2190721D157;
	Thu, 30 Oct 2008 13:39:26 +1300 (NZDT)
In-Reply-To: <1225326833-15210-1-git-send-email-pasky@suse.cz>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99443>

On Wed, 2008-10-29 at 17:33 -0700, Petr Baudis wrote:
> +To remove commits that are empty (do not introduce any change):
> +
> +------------------------------------------------------------------------------
> +git rev-list HEAD | while read c; do [ -n "$(git diff-tree --root $c)" ] || echo $c; done > revs
> +
> +git filter-branch --commit-filter '
> +  if grep -q "$GIT_COMMIT" '"$(pwd)/"revs';
> +  then

Why not put the git diff-tree in the commit filter?

Is this tested?  It doesn't look like it does what the comment says...
surely you have to compare with the previous commit, not the null
commit?

Sam.
