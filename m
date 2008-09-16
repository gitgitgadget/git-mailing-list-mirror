From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 2/2] Add support for ~/.ssh/config BatchMode
Date: Wed, 17 Sep 2008 00:46:31 +0200
Message-ID: <200809170046.31859.robin.rosenberg@dewire.com>
References: <1221579869-27835-1-git-send-email-spearce@spearce.org> <1221579869-27835-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:48:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfjLS-0004v5-K9
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 00:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbYIPWrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 18:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbYIPWrW
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 18:47:22 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29588 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbYIPWrW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 18:47:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A2CAE800257;
	Wed, 17 Sep 2008 00:47:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1eKvRjqZGqjh; Wed, 17 Sep 2008 00:47:08 +0200 (CEST)
Received: from [10.9.0.9] (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 1B97E800250;
	Wed, 17 Sep 2008 00:47:07 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1221579869-27835-2-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96039>

tisdagen den 16 september 2008 17.44.29 skrev Shawn O. Pearce:
> Connections created through batch processes (e.g. those started by
> cron) don't have a terminal to interact with a user through.  A
> common way to disable password prompting with OpenSSH is to setup
> a Host block in ~/.ssh/config with "BatchMode yes" enabled, thus
> telling the client not to prompt for passphases or passwords.

That did not work when any of the identities in  ~/.ssh matched. Though
I specifically told jgit to use an identity that should not work, it found another
that did. During setup all identities are loaded and made available to JSch.

That bug is not related to this code (so I pushed it) other than it made it tricky
to test. OpenSSH only tries the identity I tell it to, or default  if not told.

-- robin
