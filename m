From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Sun, 24 Feb 2008 22:04:04 -0500
Message-ID: <20080225030404.GL8410@spearce.org>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 25 04:04:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTTe4-0002hh-BV
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 04:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbYBYDEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 22:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbYBYDEM
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 22:04:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60302 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbYBYDEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 22:04:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTTdE-0005xs-1J; Sun, 24 Feb 2008 22:03:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 85F0420FBAE; Sun, 24 Feb 2008 22:04:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74984>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> +static int fsck_walk_commit(struct commit *commit, fsck_walk_func walk, void *data)
> +{
> +	struct commit_list *parents = commit->parents;
> +	int result;
> +
> +	if(parse_commit(commit))
> +		return -1;

Hmm.  Don't you need to get commit->parenst *after* it is parsed,
and not before?

> @@ -0,0 +1,10 @@
> +#ifndef GIT_FSCK_H
> +#define GIT_FSCK_H
> +
> +#define OBJ_ANY OBJ_BAD

Its unclear why this macro is necessary.

-- 
Shawn.
