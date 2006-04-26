From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] git-fetch: resolve remote symrefs for HTTP transport
Date: Wed, 26 Apr 2006 13:09:46 -0400
Message-ID: <20060426170946.GA7843@spearce.org>
References: <20060426161001.GH32744@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 19:10:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYnWZ-0002mN-0G
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 19:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWDZRJ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 13:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWDZRJ4
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 13:09:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58014 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932329AbWDZRJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 13:09:55 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FYnWJ-0007wk-9a; Wed, 26 Apr 2006 13:09:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6862420FBB4; Wed, 26 Apr 2006 13:09:46 -0400 (EDT)
To: Nick Hengeveld <nickh@reactrix.com>
Content-Disposition: inline
In-Reply-To: <20060426161001.GH32744@reactrix.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19212>

Nick Hengeveld <nickh@reactrix.com> wrote:
> 
> Maybe this isn't the right way to handle this - since we're already
> calling perl we could use LWP to do the transfers (using keepalive
> even?)

LWP, no.  My Mac OS X perl installation appears to have LWP installed
by dumb luck but my Gentoo Linux perl doesn't have LWP anywhere
in @INC.  :-) Yet both systems run GIT happily.

The HTTP support in GIT is already linked against libcurl and libcurl
is required to use said HTTP support.  I would think that libcurl
is capable of using Keep-Alive when possible, and libcurl and C
are certainly available anywhere GIT's HTTP support is currently
being used.  Ideally any HTTP feature should either be using the
curl command line tool, or better, be written in C against the
libcurl library.  But not LWP.  Its not always available even though
a valid perl is.

-- 
Shawn.
