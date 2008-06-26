From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Don't reset HEAD in git-amend-file.
Date: Thu, 26 Jun 2008 10:25:10 +0200
Message-ID: <87tzfg7gd5.fsf@wine.dyndns.org>
References: <m2myle77bb.fsf@nschum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nikolaj Schumacher <n_schumacher@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:49:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBnAf-0002sS-MZ
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 10:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbYFZIsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 04:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752949AbYFZIsi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 04:48:38 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:41333 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbYFZIsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 04:48:37 -0400
X-Greylist: delayed 1391 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jun 2008 04:48:37 EDT
Received: from adsl-84-226-43-62.adslplus.ch ([84.226.43.62] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1KBmn3-00073z-M6; Thu, 26 Jun 2008 03:25:24 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id E8E871E723B; Thu, 26 Jun 2008 10:25:10 +0200 (CEST)
In-Reply-To: <m2myle77bb.fsf@nschum.de> (Nikolaj Schumacher's message of "Sun,
	22 Jun 2008 00:27:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86420>

Nikolaj Schumacher <n_schumacher@web.de> writes:

> The current implementation of git-amend-file is a little dangerous.
> While git --amend is atomic, git-amend-file is not.
>
> If the user calls it, but doesn't go through with the commit (due to
> error or choice), git --reset HEAD^ has been called anyway.

That's a feature, even if it's a little dangerous. You have to reset
HEAD to be able to properly do diffs, refreshes, etc.  Maybe there should
be an easier way to redo the commit if you change your mind, but the
command would be much less useful without the reset.

-- 
Alexandre Julliard
julliard@winehq.org
