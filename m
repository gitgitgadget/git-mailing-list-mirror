From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: bug: git merge --no-commit loses track of file modes in the index
Date: Fri, 13 Jun 2014 07:52:19 +0200
Message-ID: <1ln65kj.xi5xs1rn4dkiM%lists@haller-berlin.de>
References: <20140613013858.GA28485@kitenet.net>
To: joey@kitenet.net (Joey Hess), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 08:01:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvKY3-0007eV-J6
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 08:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbaFMGBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 02:01:07 -0400
Received: from server90.greatnet.de ([83.133.96.186]:37148 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbaFMGBG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 02:01:06 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jun 2014 02:01:05 EDT
Received: from [10.1.15.231] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id DAD7A3B12BD;
	Fri, 13 Jun 2014 07:52:19 +0200 (CEST)
In-Reply-To: <20140613013858.GA28485@kitenet.net>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.9.3 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251515>

Joey Hess <joey@kitenet.net> wrote:

> If git merge --no-commit is used to merge a commit adding a 
> file with an unusual mode -- specifically a symlink which has "mode" 120000,
> it fails to stage the right mode into the index.
> 
> This only happens when core.symlinks=false. I noticed it on FAT, but
> have managed to reproduce it on ext4.

This sounds familiar; I wonder if it is related to the problem that git
can lose the executable bit when core.filemode is false.

   <http://thread.gmane.org/gmane.comp.version-control.git/159716>

I had planned to look into fixing this for years now, as we still run
into it once in a while, and it's pretty annoying; but I still didn't
get around to it yet.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
