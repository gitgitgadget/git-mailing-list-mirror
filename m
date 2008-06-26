From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Thu, 26 Jun 2008 11:15:03 -0500
Message-ID: <4863C087.1070304@freescale.com>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <486329C9.8020801@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Boaz Harrosh <bharrosh@panasas.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jun 26 18:17:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBuA1-0003gT-Bb
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 18:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbYFZQQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 12:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbYFZQQ2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 12:16:28 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:34301 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbYFZQQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 12:16:28 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m5QGFCpK003162;
	Thu, 26 Jun 2008 09:15:12 -0700 (MST)
Received: from [10.214.72.255] (mvp-10-214-72-255.am.freescale.net [10.214.72.255])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5QGFAWA001175;
	Thu, 26 Jun 2008 11:15:10 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <486329C9.8020801@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86460>

Andreas Ericsson wrote:

> There is a "--hard" after one of them. It reads like this:
> 
> git reset --hard  ;# move current branch to random point in history
>                   # discarding working tree and index state
> 
> git reset --mixed ;# move current branch to random point in history
>                   # discard the index but keep the working tree
> 
> git reset --soft  ;# move current branch to random point in history,
>                   # leaving index and working tree intact

I always thought that these would be best presented in
a linear ordering so that the effects were clearly
shown in an "increasing" way:

--soft
    - touches one thing

--mixed
    - touches one thing and a second
    - this is the default

--hard
    - touches one thing, a second and a third

Want a patch down that line?

jdl
