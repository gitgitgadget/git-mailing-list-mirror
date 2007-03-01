From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: Implement core.symlinks to support filesystems without symlinks
Date: Thu, 1 Mar 2007 20:24:01 +0100
Message-ID: <200703012024.01707.johannes.sixt@telecom.at>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.63.0703010213420.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200703011256.50659.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 20:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMqss-0005Hc-8n
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 20:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965518AbXCATYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 14:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965520AbXCATYJ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 14:24:09 -0500
Received: from smtp3.noc.eunet-ag.at ([193.154.160.89]:44188 "EHLO
	smtp3.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965518AbXCATYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 14:24:07 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.noc.eunet-ag.at (Postfix) with ESMTP
	id 8AE3B3465C; Thu,  1 Mar 2007 20:24:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id AD2884E895;
	Thu,  1 Mar 2007 20:24:03 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <200703011256.50659.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41117>

On Thursday 01 March 2007 12:56, Robin Rosenberg wrote:
> torsdag 01 mars 2007 02:18 skrev Johannes Schindelin:
> > So, all I would like to do on top of Johannes' patch is to add a _big_
> > _fat_ warning whenever Git realizes it has to substitute a file for a
> > link, but I DON'T WANT THE BLOODY FILE TO BE COPIED.
>
> I do want it to fail early initially (checkout), no default workaround,
> until I SAY I want  copies (or text links, this is apparently a preference.
> By default git should complain loudly that it cannot create links.

Oh, git will fail early: symlink(2) will complain.

> - What do you want to do today?
> 	a) Screw me with copies
> 	b) Screw me with text links
> 	c) Screw me with shortcuts (cygwin does this which is fine as long as I
> stay within cygwin, so it is ok as a default behaviour there, but not
> otherwise)

The patch implements behavior b), and it will need to be turned on in a 
conscious act, or it won't "screw you".

-- Hannes
