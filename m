From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Manual hunk edit mode + emacs + ^G == garbage
Date: Thu, 14 Oct 2010 00:40:34 +0200
Message-ID: <m27hhld8d9.fsf@igel.home>
References: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org>
	<1287006523.13553.4.camel@drew-northup.unet.maine.edu>
	<24AC771D-07A7-49D7-8824-28E6156C90B4@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:40:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6A06-0001Id-01
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab0JMWkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:40:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55421 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab0JMWkg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 18:40:36 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 590141C15CB1;
	Thu, 14 Oct 2010 00:40:34 +0200 (CEST)
Received: from igel.home (ppp-93-104-137-48.dynamic.mnet-online.de [93.104.137.48])
	by mail.mnet-online.de (Postfix) with ESMTP id A5BF61C000F3;
	Thu, 14 Oct 2010 00:40:34 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 75328CA2A0; Thu, 14 Oct 2010 00:40:34 +0200 (CEST)
X-Yow: ..  are the STEWED PRUNES still in the HAIR DRYER?
In-Reply-To: <24AC771D-07A7-49D7-8824-28E6156C90B4@sb.org> (Kevin Ballard's
	message of "Wed, 13 Oct 2010 14:53:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158995>

Kevin Ballard <kevin@sb.org> writes:

> I've been investigating this on the emacs side as well. At the moment, my suspicion is that ^G causes emacs to trigger (keyboard-quit), but at the same time the surrounding environment (e.g. git) is sending a SIGINT to emacs, which normally acts like ^G but in this case may be triggering the emergency exit mode of emacs. Is there some reason that the interactive add would be sending SIGINT to emacs when I type ^G?

If you are using text mode (-nw) then Emacs redefines the INTR character
of the terminal to ^G.  On the other hand it should also put itself into
its own process group, so the parent should not receive the terminal
signals.  And this is what happens here when I try it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
