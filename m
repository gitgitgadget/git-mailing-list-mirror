From: Marcus Comstedt <marcus@mc.pp.se>
Subject: git log --stat FILE
Date: Sun, 08 Aug 2010 13:29:29 +0200
Message-ID: <yf9wrs1fili.fsf@chiyo.mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 13:39:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi4Du-0004qC-0M
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 13:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab0HHLjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 07:39:20 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:40773 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab0HHLjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 07:39:19 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Aug 2010 07:39:19 EDT
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id DE3CAE907
	for <git@vger.kernel.org>; Sun,  8 Aug 2010 13:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1281266971; bh=GaRQailytD0NLbcyAZwVJ+A+JrbGw8vtJGFVxvNo9iA=;
	h=To:Subject:From:Date:Message-ID:MIME-Version:Content-Type; b=h4jE
	Y3vlj3zmE8RwHRnA6/TaqBdPVt+BnTR6aLD898Y+EXS9jX1XCGK3ZdvQ0dO/9CgFcBX
	GcZknyBA2sp584X7jdrcktQCxGjTGs4g83Jv7VeZhOF1edaeJ5QA51ghIgtta2dslVj
	N3ShiVZCLANJsQ7wj+aVBI9XFNBUTDAkc=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@mc.pp.se>)
	id 1Oi44I-0004iR-Il
	for git@vger.kernel.org; Sun, 08 Aug 2010 13:29:30 +0200
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152899>


Hi guys.

I'm probably just missing something here, but I've run across a rather
annoying behavior of log.

When I do "git log --stat FILE", then only commits which touch FILE
are displayed, as expected.  However, contrary to expectation (well,
my expectation at least), the stat shows that only one file (FILE) is
modified by the commits, even if they actually modified multiple files.
That's not what I wanted; I used FILE to select commits, not to
control how they are presented.  In fact, the information which is
hidden is exactly that which I wanted to see; the whole reason for the
--stat was that I wanted to know what _other_ files were modified
together with FILE.

What's worse, I could not find how to circumvent this behavior, short
of using

 git log --format=format:'%H' FILE | xargs git show --stat

which isn't especially convenient...

So, if this behavior is intentional, how can it be turned off?


  // Marcus
