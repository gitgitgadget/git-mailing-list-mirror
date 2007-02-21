From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-remote: support remotes with a dot in the name
Date: Wed, 21 Feb 2007 02:29:21 -0500
Message-ID: <20070221072921.GB28152@spearce.org>
References: <20070221050336.26431.46485.stgit@dv.roinet.com> <7vwt2ct79x.fsf@assigned-by-dhcp.cox.net> <20070221004631.q4npyww808k88s0o@webmail.spamcop.net> <7vfy90t4mo.fsf@assigned-by-dhcp.cox.net> <20070221021206.8onspw0840gcs8ck@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 08:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJlut-0008Lx-EF
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 08:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbXBUH32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 02:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbXBUH32
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 02:29:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54985 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030569AbXBUH31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 02:29:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJlul-00068I-1o; Wed, 21 Feb 2007 02:29:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B077020FBAE; Wed, 21 Feb 2007 02:29:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070221021206.8onspw0840gcs8ck@webmail.spamcop.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40286>

Pavel Roskin <proski@gnu.org> wrote:
> I was thinking of something like
> 
> [remote "wireless-2.6"]
> url = http://foo/bar
> url.push = ssh://foo/bar

The key `url.push` is not a valid string in a config file.
 
> > But my Perl is rusty, so please double check it.

FWIW Junio's pattern looks OK to me.

> The "(\S*?)" construct looks weird (you probably meant to use "(\S*)" for the
> remote name), but the rest is probably OK.  I'll send the "double-checked"
> patch tomorrow unless you beat me at that.

The use of (\S+?) here is right.  We want to be non-greedy in our
matching of the remote name, as we don't want to overslurp and grab
through the key name and part of the key value into the remote name
by mistake, especially if the key value contained spaces.

-- 
Shawn.
