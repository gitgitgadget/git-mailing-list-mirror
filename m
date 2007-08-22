From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: empty directories
Date: Wed, 22 Aug 2007 13:31:39 +0900
Message-ID: <fage86$hui$1@sea.gmane.org>
References: <1187716461.5986.71.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 06:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INhtm-00067L-Fc
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 06:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXHVEcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 00:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXHVEcZ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 00:32:25 -0400
Received: from main.gmane.org ([80.91.229.2]:49019 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbXHVEcY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 00:32:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INhtD-0005UR-BH
	for git@vger.kernel.org; Wed, 22 Aug 2007 06:32:19 +0200
Received: from cerberus.is.titech.ac.jp ([131.112.51.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 06:32:19 +0200
Received: from salikh by cerberus.is.titech.ac.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 06:32:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cerberus.is.titech.ac.jp
User-Agent: Thunderbird 2.0.0.6 (X11/20070819)
In-Reply-To: <1187716461.5986.71.camel@beauty>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56348>

Josh England wrote:
> Git doesn't seem to allow me to add an empty directory to the index, or
> even nested empty directories.  Is there any way to do this?  What is
> the reasoning?  I've got a use case where having empty directories in my
> git repository would be *very* valuable.  Any information and help is
> greatly appreciated.

While the the other replies provided a historical background of how exactly
git handles directories and why it wasn't storing empty directories,
there is no fundamental reason for empty directories not being stored,
it's just nobody got to implement it.

Linus Torvalds posted an untested patch in a recent discussion and requested
that anyone interested in this functionality continued development and testing.

Design discussion: http://lists-archives.org/git/624494-empty-directories.html
Patch: http://marc.info/?l=git&m=118480075313827&w=2

Johannes Schindelin also posted an alternative implementation, which emulates
empty dirs by adding empty .gitignore placeholder to the index.
http://marc.info/?l=git&m=118484785410247&w=2

You could also read the long discussion of the subtle semantic issues that storing empty
directories introduces in the mail thread accessible from above links.
