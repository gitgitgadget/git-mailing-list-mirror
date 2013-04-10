From: Tom <mail@tgries.de>
Subject: Re: [BUG] shallow clones over http
Date: Wed, 10 Apr 2013 12:48:51 +0000 (UTC)
Message-ID: <loom.20130410T144700-304@post.gmane.org>
References: <20130403040352.GA8284@sigill.intra.peff.net> <loom.20130410T135840-387@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 14:49:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPuSc-0000lE-R5
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 14:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab3DJMtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 08:49:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:38679 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab3DJMtE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 08:49:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UPuSU-0000UT-Fs
	for git@vger.kernel.org; Wed, 10 Apr 2013 14:49:02 +0200
Received: from dslb-178-008-230-161.pools.arcor-ip.net ([178.8.230.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:49:02 +0200
Received: from mail by dslb-178-008-230-161.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:49:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 178.8.230.161 (Mozilla/5.0 (Windows NT 5.1; rv:20.0) Gecko/20100101 Firefox/20.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220684>

The problem occurs to me also when I want to "deepen" a shallow clone of
MediaWiki via https://

 git clone --depth 1 https://gerrit.wikimedia.org/r/p/mediawiki/core.git
 git pull --depth=99999

fatal: git fetch-pack: expected shallow list.

Perhaps it helps someone to find the reason.

UPDATE:

This however works

 git clone --depth=2 https://gerrit.wikimedia.org/r/p/mediawiki/core.git
 git fetch --depth=5
