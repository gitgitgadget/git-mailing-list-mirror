From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [BUG?] git gui handles type change from file to symlink poorly
Date: Fri, 15 Aug 2008 00:23:09 +0200
Message-ID: <48A4B04D.4070302@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Aug 15 00:24:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlEv-0002Rq-D4
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbYHNWXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbYHNWXO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:23:14 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:54501 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbYHNWXN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:23:13 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id B617F25A69;
	Fri, 15 Aug 2008 00:23:11 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 06853-09; Fri,  4 Jul 2008 02:08:54 +0200 (MEST)
Received: from [192.168.13.34] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 121B225A67;
	Fri, 15 Aug 2008 00:23:11 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92421>

Hi!
Playing around with git gui I noticed that git gui handles the case when 
files are transformed to symlinks poorly.  The following exposes the 
problem:

mkdir foo
cd foo
git init
echo FILE > foo
git add foo && git commit -mFile
rm foo
ln -s bar foo

Now start the git gui and try to stage the change in foo.
Gives:   error: no desc for state={_T} foo

Then try add the change to foo to the index at the command line and try 
to commit in the gui...

I don't speak tk/tcl so unfortunately I can't be of much help chasing 
this down.

/Gustaf
