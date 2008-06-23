From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Git clone behaviour change in 1.5.6 (vs 1.5.5.1)
Date: Mon, 23 Jun 2008 16:03:47 -0500
Message-ID: <0YbSdnKH0_SP30-YMV0Y1aH4SO46yc6x_2EA1VGwPtV_CltGk-7wdg@cipher.nrlssc.navy.mil>
References: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com> <alpine.LNX.1.00.0806231554380.19665@iabervon.org> <20080623203835.GA8105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, zuh@iki.fi,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtDn-0003Ve-I2
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144AbYFWVEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758034AbYFWVEI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:04:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54882 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758059AbYFWVEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:04:08 -0400
Received: by mail.nrlssc.navy.mil id m5NL3luN018414; Mon, 23 Jun 2008 16:03:47 -0500
In-Reply-To: <20080623203835.GA8105@sigill.intra.peff.net>
X-OriginalArrivalTime: 23 Jun 2008 21:03:47.0667 (UTC) FILETIME=[A1270230:01C8D574]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85922>

Jeff King wrote:
> On Mon, Jun 23, 2008 at 03:56:41PM -0400, Daniel Barkalow wrote:
> 
>>> Switching to the 1.5.6 release from 1.5.5.1, I found out that the
>>> rewritten git-clone command changed its behaviour wrt cloning to a
>>> non-existing destination directory structure. In the shell version the
>>> destination (work tree) is created with 'mkdir -p' but in the C
>>> version with just the mkdir() call which doesn't create the parent
>>> directories.

> Here is a partial fix.

There is a mkdir_p() in builtin-merge-recursive.c which calls
safe_create_leading_directories() in sha1_file.c

Can these functions be reused?


-brandon
