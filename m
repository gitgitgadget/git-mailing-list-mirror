From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 17/28] Support automatic command line parsing for
	TextBuiltin subclasses
Date: Fri, 18 Jul 2008 15:38:34 -0500
Message-ID: <20080718203834.GA27528@spearce.org>
References: <4880E880.1010403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Florian KKKberle <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 22:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJwjv-0007Oi-QS
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 22:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306AbYGRUig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 16:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756159AbYGRUig
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 16:38:36 -0400
Received: from george.spearce.org ([209.20.77.23]:36990 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbYGRUig (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 16:38:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CA99B382A4; Fri, 18 Jul 2008 20:38:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4880E880.1010403@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89077>

Florian KKKberle <FloriansKarten@web.de> wrote:
> I had a short look at the files and noticed that the inner "if (help) {"
> is unnecessary:
>
> +		if (help) {
> +			System.err.print("jgit ");
> +			System.err.print(commandName);
> +			clp.printSingleLineUsage(System.err);
> +			System.err.println();
> +
> +			if (help) {

Gaaah.  Good catch, thanks.  I copied and pasted that block from the
global option parser to the per-command parser, and then refactored
it a little and missed removing this unnecessary inner if test.
I'll fix with a rebase.

-- 
Shawn.
