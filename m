From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] translate bad characters in refnames during git-svn fetch
Date: Sat, 28 Jul 2007 09:33:51 +0200
Message-ID: <85lkd13rts.fsf@lola.goethe.zz>
References: <20070715130548.GA6144@piper.oerlikon.madduck.net>
	<20070716033050.GA29521@muzzle>
	<20070716111509.GC18293@efreet.light.src>
	<20070715130548.GA6144@piper.oerlikon.madduck.net>
	<20070716033050.GA29521@muzzle>
	<20070716174731.GA4792@lapse.madduck.net>
	<20070717122852.GA21372@mayonaise>
	<loom.20070728T091909-416@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 09:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEgof-0002a3-Qg
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 09:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760653AbXG1HeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 03:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762415AbXG1HeK
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 03:34:10 -0400
Received: from mail-in-15.arcor-online.net ([151.189.21.55]:42008 "EHLO
	mail-in-15.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754083AbXG1HeJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 03:34:09 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id DA9E1A4184;
	Sat, 28 Jul 2007 09:34:07 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id C130B212FA9;
	Sat, 28 Jul 2007 09:34:07 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-039-045.pools.arcor-ip.net [84.61.39.45])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 9FB9010400C;
	Sat, 28 Jul 2007 09:34:07 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id EBAD11CFF95E; Sat, 28 Jul 2007 09:33:51 +0200 (CEST)
In-Reply-To: <loom.20070728T091909-416@post.gmane.org> (Mike Hommey's message of "Sat\, 28 Jul 2007 07\:23\:11 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54004>

Mike Hommey <mh@glandium.org> writes:

> Eric Wong <normalperson <at> yhbt.net> writes:
>> 
>>   Somebody naming directories on the SVN side with the path component
>>   ":refs/remotes" in them could screw things up for us.
>
> Why not "simply" allow some form of escaping in refs, such that special
> characters CAN be used anywhere. Then git-svn would just have to escape these
> characters.
>
> Something like:
> git update-ref "refs/remotes/tags/sometag\~1" $sha1
>
> I'm pretty sure that could help fix a lot of other similar issues.

Well, having had to do my fair level of porting shell-scripts and
installation stuff and so on to Windows/MacOSX whatsoever where spaces
(and other characters) in file names are considered business as usual:
it is a bottomless pit.  You'll always find one more place in your
software that does not get this right.

It may be a more confined problem to make the interoperation utility
responsible for quoting/renaming.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
