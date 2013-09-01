From: Andres Freund <andres@anarazel.de>
Subject: [RFC] Running a hook on reset
Date: Sun, 1 Sep 2013 14:17:11 +0200
Message-ID: <20130901121711.GC5695@awork2.anarazel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 14:27:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG6kV-00081W-9M
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 14:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab3IAM1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 08:27:06 -0400
Received: from mail.anarazel.de ([217.115.131.40]:45750 "EHLO mail.anarazel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768Ab3IAM1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 08:27:05 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Sep 2013 08:27:04 EDT
Received: by mail.anarazel.de (Postfix, from userid 108)
	id A19274E8003; Sun,  1 Sep 2013 14:17:15 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,NO_RELAYS
	autolearn=ham version=3.2.5
Received: from andres.at.anarazel.de.authenticated.anarazel.de
	by mail.anarazel.de (Postfix) with ESMTPSA id 508A04E8002
	for <git@vger.kernel.org>; Sun,  1 Sep 2013 14:17:12 +0200 (CEST)
Received: by anarazel.de (Postfix, from userid 1000)
	id 8D1C1100353; Sun,  1 Sep 2013 14:17:11 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233587>

Hi,

I propose adding a hook that is run after git reset.

My personal use case for that is that I am indexing my checkouts using
global (a tool similar to ctags, cscope, ...)  and I really like that
index to be up2date all the time. I can catch most cases where the work
tree changes from git via the post-checkout, post-merge, post-rewrite
hooks. The only frequent case I don't know how to trigger a reindex is
git reset --hard.
Another related usecases I can imagine is people wanting to check that
there is nothing important/irrecoverable in the current checkout before
resetting it, but that would obviously be a pre-reset hook.

Any opinions about the feature before I start writing a patch?

Greetings,

Andres Freund
