From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT 2/5] FileMode: Store bit masks in int constants
Date: Wed, 12 Aug 2009 08:22:52 -0700
Message-ID: <20090812152252.GE1033@spearce.org>
References: <2c6b72b30908120733h4ecb3fccm3a1e80c111c1185c@mail.gmail.com> <1250089776-22895-1-git-send-email-fonseca@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbFfK-0002ep-2f
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 17:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZHLPWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 11:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbZHLPWw
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 11:22:52 -0400
Received: from george.spearce.org ([209.20.77.23]:58926 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbZHLPWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 11:22:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B5E69381FD; Wed, 12 Aug 2009 15:22:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1250089776-22895-1-git-send-email-fonseca@diku.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125709>

Jonas Fonseca <fonseca@diku.dk> wrote:
> +	public static final int TYPE_MASK = 0170000;
> +	public static final int TREE_MASK = 0040000;
> +	public static final int SYMLINK_MASK = 0120000;
> +	public static final int FILE_MASK = 0100000;
> +	public static final int GITLINK_MASK = 0160000;
> +	public static final int MISSING_MASK = 0000000;

These last 5 entries aren't masks, they are type codes.  I'd rather
they be called FOO_TYPE than FOO_MASK.  In particular what is really
troubling is MISSING_MASK, being all 0 it always destroys the input
and then matches everything.  :-)

I'm going to amend this name change in here, s/_MASK/_TYPE/ on the
last 5 fields.

-- 
Shawn.
