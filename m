From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] git-gui: make "Git GUI Here" Explorer extension more robust
Date: Mon, 30 Mar 2009 08:51:42 +0200
Message-ID: <200903300851.43164.markus.heidelberg@web.de>
References: <200903300030.03733.markus.heidelberg@web.de> <alpine.DEB.1.00.0903300243050.6454@intel-tinevez-2-302>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:53:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBMy-0007zC-2g
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606AbZC3Gvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 02:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbZC3Gvp
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:51:45 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:57332 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbZC3Gvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:51:45 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id C048AF9B9AE8;
	Mon, 30 Mar 2009 08:51:42 +0200 (CEST)
Received: from [89.59.73.72] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LoBLS-0004C8-00; Mon, 30 Mar 2009 08:51:42 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903300243050.6454@intel-tinevez-2-302>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18ECcAcP9BpP2LvmWwOL9OBg2XIDLy22Zs96A/Y
	GVEL8LAm60QjIH3WZHyjj1mTLl00YXf+W3PcBrzf8cUj6VIX54
	P9BE3GXDeBkCUlMOvlzQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115090>

Johannes Schindelin, 30.03.2009:
> Hi,
> 
> On Mon, 30 Mar 2009, Markus Heidelberg wrote:
> 
> > Starting git-gui via Windows Explorer shell extension caused problems 
> > when not started from the project directory, but from a directory within 
> > the project: starting the Explorer from the git-gui menu "Explore 
> > Working Copy" didn't work then.
> > 
> > Starting git-gui via Explorer shell extension from the .git directory 
> > didn't work at all.
> > 
> > To make these things possible, "cd .." until we see .git/
> 
> How does this interact with GIT_WORK_TREE?

Not sure. What's the use case for a globally set GIT_WORK_TREE, how is
it used?

> And with bare repositories?

Git-gui doesn't seem to work with bare repositories, I get
"Cannot use funny .git directory: ."
when started on the command line.

But I just noticed, that it will obviously "cd .." forever, if no .git/
was found. Somehow the root directory has to be catched.

Markus
