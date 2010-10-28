From: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>
Subject: Re: svn repository URL and git
Date: Thu, 28 Oct 2010 21:02:27 +0200
Message-ID: <20101028190227.GC46314@acme.spoerlein.net>
References: <loom.20101027T170254-268@post.gmane.org>
 <4CC845EE.5040602@debugon.org>
 <loom.20101027T180316-38@post.gmane.org>
 <loom.20101028T184823-831@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: H Krishnan <hetchkay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 21:10:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBXrn-0004lL-67
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 21:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759024Ab0J1TKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 15:10:22 -0400
Received: from acme.spoerlein.net ([188.72.220.29]:34553 "EHLO
	acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758884Ab0J1TKU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 15:10:20 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Oct 2010 15:10:20 EDT
Received: from acme.spoerlein.net (localhost.spoerlein.net [IPv6:::1])
	by acme.spoerlein.net (8.14.4/8.14.4) with ESMTP id o9SJ2Rse063135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Oct 2010 21:02:27 +0200 (CEST)
	(envelope-from uqs@spoerlein.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoerlein.net;
	s=dkim200908; t=1288292547;
	bh=PDYLCWd4so5IYEaOmLhz7y5WlObpDcFKk+qFa716gRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=NwHsDFxDNB2uzMj96qIJcw7xkfVUQSUg9Kt7E/vQlnRVnpJKPgbz2rpaWGjLXJ4a1
	 +n6BBi53A/Zl1Vyn8dUpR4m6/qynOfL1tPD6klTrgb3VesZn3qBf92Ef4Gy1iJwonp
	 UlwVzH0LIwEJiHCSUPw0wZ7n8roXi8kMGZlGYdRw=
Received: (from uqs@localhost)
	by acme.spoerlein.net (8.14.4/8.14.4/Submit) id o9SJ2RH4063134;
	Thu, 28 Oct 2010 21:02:27 +0200 (CEST)
	(envelope-from uqs@spoerlein.net)
Content-Disposition: inline
In-Reply-To: <loom.20101028T184823-831@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.4 points;
 * -2.6 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
 *      [score: 0.0000]
 *  4.0 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
 *      [188.72.220.29 listed in zen.spamhaus.org]
 *  4.0 URIBL_SBL Contains an URL listed in the SBL blocklist
 *      [URIs: spoerlein.net]
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160211>

On Thu, 28.10.2010 at 16:58:28 +0000, H Krishnan wrote:
> 
> Hi,
> I think I resolved this problem by using --rewrite-root as suggested. I used a 
> dummy root during the git-svn clone:
> 
> git-svn clone --rewrite-root http://git.is.great <myrepo>
> 
> All my commit messages now have http://git.is.great but I am able to change the 
> repository URL and continue.
> 
> Could this approach be used as an insurance against svn url changes? When 
> initializing the repository, we could use --rewrite-root. Subsequently, if the 
> svn repository relocates, we need to edit only .git/config. 

Yes, that's exactly what the rewrite-url was introduced for, you can
even clone from a local svnsync mirror (iff the UUID matches, you have
to setup the mirror in a special way ...).

So, every developer must use:

$ git svn clone --rewrite-root CANONICAL-URL-NEVER-TO-CHANGE <whatever-url-is-convenient>

Oh, and all devs must use the same authormap (or no authormap at all).

hth,
Uli
