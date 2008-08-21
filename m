From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] filter-branch: Grok special characters in tag names
Date: Thu, 21 Aug 2008 16:34:52 -0500
Message-ID: <yncKq2pMiBaRiN-VbWFQsKLk4CfOXCHjFSB_xG9FtqweMeZ_6Hwf-w@cipher.nrlssc.navy.mil>
References: <1219329911-31620-1-git-send-email-johannes.sixt@telecom.at> <NWVPkDIELqWBHTU58gfzDqO8HR575ZDJVO2pYdPMtqv9aBLzMLvyZg@cipher.nrlssc.navy.mil> <7v3akyi07f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 23:36:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHpb-0008Sd-GZ
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 23:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbYHUVfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 17:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756392AbYHUVfW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 17:35:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33861 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295AbYHUVfV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 17:35:21 -0400
Received: by mail.nrlssc.navy.mil id m7LLYqj8018555; Thu, 21 Aug 2008 16:34:52 -0500
In-Reply-To: <7v3akyi07f.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 21 Aug 2008 21:34:52.0310 (UTC) FILETIME=[BEF03360:01C903D5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93214>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Junio complained that my initial version of this was fragile which has
>> similarities with the above. Initially, I was blindly changing the first line
>> to contain "object...", second line to "type...", etc.
> 
> Was it more about not limiting the munging to only the header part?

No. I originally had something like

   1c\object $new_sha1
   2c\tag commit
   ...

blindly changing line one to "object ...", line two to "tag ..." etc.
That aspect is what you commented about. So it would have modified the
proper parts of a well-formed tag.

I took your comments to be concerned with future proofing or dealing
with a corrupt/flawed tag (allowing the flaws to propagate so mktag
would error out), but you didn't state that explicitly.

You also educated me about addresses like 1,/regex/ which was used to limit
the munging to only the header part.

> In
> any case, I think what Hannes has in the patch is fine (although I did not
> look the lines that follow outside the context).

That's fine.

-brandon
