From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] builtin-gc.c: allow disabling all auto-gc'ing by assigning 0 to gc.auto
Date: Thu, 20 Mar 2008 09:08:13 +0200
Message-ID: <200803200908.14061.tlikonen@iki.fi>
References: <47E18540.4020908@nrlssc.navy.mil> <47E18B50.2080402@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>,
	Jens Axboe <jens.axboe@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 08:09:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcEtY-0003xK-Kv
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 08:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbYCTHIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 03:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbYCTHIT
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 03:08:19 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:58068 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752968AbYCTHIS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 03:08:18 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A00266669; Thu, 20 Mar 2008 08:08:17 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <47E18B50.2080402@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77636>

Brandon Casey kirjoitti:

> The gc.auto configuration variable is somewhat ambiguous now that
> there is also a gc.autopacklimit setting. Some users may assume that
> it controls all auto-gc'ing. Also, now users must set two
> configuration variables to zero when they want to disable
> autopacking. Since it is unlikely that users will want to autopack
> based on some threshold of pack files when they have disabled
> autopacking based on the number of loose objects, be nice and allow a
> setting of zero for gc.auto to disable all autopacking.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>  builtin-gc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

This change should be documented in the git-gc.txt and config.txt. For 
example, the former currently says:

"Housekeeping is required if there are too many loose objects or too 
many packs in the repository. [...] Setting the value of `gc.auto` to 0 
disables automatic packing of loose objects."

So, from the git-gc.txt's (current) point of view, gc.auto=0 does not 
touch the "or too many packs" part.
