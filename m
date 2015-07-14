From: John Keeping <john@keeping.me.uk>
Subject: Re: git log fails to show all changes for a file
Date: Tue, 14 Jul 2015 08:45:08 +0100
Message-ID: <20150714074508.GE1451@serenity.lan>
References: <20150714073035.GA22707@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Tue Jul 14 09:45:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEuu3-0002is-R7
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 09:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbbGNHpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 03:45:18 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:51441 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbGNHpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 03:45:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A3E12CDA52C;
	Tue, 14 Jul 2015 08:45:16 +0100 (BST)
X-Quarantine-ID: <yA5UEC9CaD0y>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.5
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_05=-0.5] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yA5UEC9CaD0y; Tue, 14 Jul 2015 08:45:15 +0100 (BST)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 147E6CDA566;
	Tue, 14 Jul 2015 08:45:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20150714073035.GA22707@aepfle.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273938>

On Tue, Jul 14, 2015 at 09:30:35AM +0200, Olaf Hering wrote:
> 
> I wonder why this command fails to show all commits that modify a given
> function: 
> 
>   linux.git $ git log -p -M --stat -- drivers/hv/channel_mgmt.c
> 
> With commit 1f656ff3fdddc2f59649cc84b633b799908f1f7b init_vp_index() has
> "const uuid_le *type_guid" already. And somewhere between commit
> d3ba720dd58cdf6630fee4b89482c465d5ad0d0f and the one above the "const"
> was added. But git log does not show this commit.
> 
> Why is that so, and whats the command to really show all and every change?

It was added in an evil merge (f9da455b93f6ba076935b4ef4589f61e529ae046),
try:

	git log -p -M --stat --cc -- drivers/hv/channel_mgmt.c
