From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Hash tags by commit SHA1 in git-describe.
Date: Sun, 14 Jan 2007 14:01:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701141358440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org>
 <20070113222816.GB18011@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 14:01:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H64zC-0000Lq-LZ
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 14:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbXANNBT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 08:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbXANNBT
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 08:01:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:36484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751271AbXANNBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 08:01:18 -0500
Received: (qmail invoked by alias); 14 Jan 2007 13:01:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 14 Jan 2007 14:01:17 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070113222816.GB18011@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36802>

Hi,

On Sat, 13 Jan 2007, Shawn O. Pearce wrote:

> If a project has a very large number of tags then git-describe
> will spend a good part of its time looping over the tags testing
> them one at a time to determine if it matches a given commit.

Why not just use object_refs? This also obviates the need for your patch 
3/4, since you no longer have buckets to search binarily. Plus, it uses a 
hash map, which already turned out to beat (in terms of performance) the 
hell out of bucketed lists in git history.

Ciao,
Dscho
