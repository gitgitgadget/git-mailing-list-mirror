From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in archive files)
Date: Mon, 03 Sep 2007 22:19:27 +0200
Message-ID: <85ps0zmrhs.fsf@lola.goethe.zz>
References: <46DC4D45.4030208@lsrfire.ath.cx>
	<Pine.LNX.4.64.0709031935540.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 03 22:19:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISIOW-0006Bp-IQ
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 22:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbXICUTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 16:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbXICUTb
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 16:19:31 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:37534 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753868AbXICUTa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 16:19:30 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 3B0572F28E5;
	Mon,  3 Sep 2007 22:19:29 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 278F1114372;
	Mon,  3 Sep 2007 22:19:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-037-052.pools.arcor-ip.net [84.61.37.52])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id EF2E8212F62;
	Mon,  3 Sep 2007 22:19:28 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D87281C0039C; Mon,  3 Sep 2007 22:19:27 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0709031935540.28586@racer.site> (Johannes Schindelin's message of "Mon\, 3 Sep 2007 19\:40\:04 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4140/Mon Sep  3 19:59:33 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57505>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 3 Sep 2007, Ren? Scharfe wrote:
>
>> Add support for a new attribute, specfile.  Files marked as being
>> specfiles are expanded by git-archive when they are written to an
>> archive.  It has no effect on worktree files.  The same placeholders
>> as those for the option --pretty=format: of git-log et al. can be
>> used.
>
> I almost like this approach.  Would it not be a little more useful if you 
> could mark the placeholders with something like "$Format: xyz %c$"?  
> Because then we could just shut up all those complainers that want to 
> insert some revision specific information into the files, without 
> affecting formats for printf().
>
> Of course, the idea to keep the worktree unaffected is brilliant.

I think a bit more layering would be helpful: when using git-svn, one
would want to have things like $Id$ and $Date$ expanded, so maybe
attribute specs like

somefile: expandmarkers="$Date: %aD$ $Id: ....$"

would be nice having.  In the case of git-svn, I would expect them to
be generated from git-svn from the respective svn properties, so that
the user is not bothered with figuring out the awful $Id$ and whatever
strings.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
