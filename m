From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: exit with proper message if not a git dir
Date: Sun, 2 Mar 2008 18:16:49 -0500
Message-ID: <20080302231649.GD8410@spearce.org>
References: <47C735E2.2010500@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jean-Luc Herren <jlh@gmx.ch>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 00:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVxQy-0007LB-6i
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 00:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbYCBXQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 18:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755743AbYCBXQy
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 18:16:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41176 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbYCBXQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 18:16:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVxQ9-0002li-5L; Sun, 02 Mar 2008 18:16:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8E4C620FBAE; Sun,  2 Mar 2008 18:16:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47C735E2.2010500@gmx.ch>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75854>

Jean-Luc Herren <jlh@gmx.ch> wrote:
> git fast-import expects to be run from an existing (possibly
> empty) repository.  It was dying with a suboptimal message if that
> wasn't the case.
> 
> Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
> ---
> fast-import.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/fast-import.c b/fast-import.c
> index 0d3449f..7f197d5 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2377,6 +2377,7 @@ int main(int argc, const char **argv)
> {
> 	unsigned int i, show_stats = 1;
> 
> +	setup_git_directory();
> 	git_config(git_pack_config);
> 	if (!pack_compression_seen && core_compression_seen)
> 		pack_compression_level = core_compression_level;

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
