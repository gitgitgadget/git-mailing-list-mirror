From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: git apply vs. renamed files index mismatch (was: Re: [PATCH 1/4]
	POWERPC: Rename dma_64.c to dma.c)
Date: Tue, 9 Sep 2008 01:27:17 +0400
Message-ID: <20080908212717.GA21338@oksana.dev.rtsoft.ru>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com> <1220900995-11928-2-git-send-email-becky.bruce@freescale.com> <48C57A92.6060608@freescale.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Becky Bruce <becky.bruce@freescale.com>, linuxppc-dev@ozlabs.org,
	git@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 23:28:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcoHd-0005gd-VV
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 23:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbYIHV1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 17:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbYIHV1W
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 17:27:22 -0400
Received: from rtsoft3.corbina.net ([85.21.88.6]:60352 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753473AbYIHV1V (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2008 17:27:21 -0400
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 85993881F; Tue,  9 Sep 2008 02:27:17 +0500 (SAMST)
Content-Disposition: inline
In-Reply-To: <48C57A92.6060608@freescale.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95305>

On Mon, Sep 08, 2008 at 02:18:42PM -0500, Scott Wood wrote:
> Becky Bruce wrote:
>> This is in preparation for the merge of the 32 and 64-bit
>> dma code in arch/powerpc.
>>
>> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
>> ---
>>  arch/powerpc/kernel/Makefile |    2 +-
>>  arch/powerpc/kernel/dma.c    |  200 ++++++++++++++++++++++++++++++++++++++++++
>>  arch/powerpc/kernel/dma_64.c |  200 ------------------------------------------
>>  3 files changed, 201 insertions(+), 201 deletions(-)
>>  create mode 100644 arch/powerpc/kernel/dma.c
>>  delete mode 100644 arch/powerpc/kernel/dma_64.c
>
> Passing -M to git format-patch makes it much easier

I always thought that posting "-M" patches to the public lists is
discouraged since it is quite difficult to apply them via patch(1).
Also think of non-git users...

> to see whether  
> anything changed between the old file and the new file.

This is still possible by comparing the hashes:

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
new file mode 100644
index 0000000..ae5708e
[...]
diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
deleted file mode 100644
index ae5708e..0000000

That is, if hashes match then it was pure rename.

Though, too bad git {apply,am} does not produce any warnings if there
are any hidden changes...

Cc'ing git mailing list.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
