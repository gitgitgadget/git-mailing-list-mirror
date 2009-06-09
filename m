From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Expand the rename(2) workaround in mingw to cover case
 	change in filename
Date: Tue, 09 Jun 2009 07:54:53 +0200
Message-ID: <4A2DF92D.1080605@viscovery.net>
References: <20090608203248.GA22972@blimp.localdomain>	 <alpine.DEB.1.00.0906082355350.26154@pacific.mpi-cbg.de> <81b0412b0906081508v5435c59cm3faf3ac92a56578c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 07:55:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDuJG-0005mq-Lz
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 07:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbZFIFy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 01:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbZFIFy4
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 01:54:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:31708 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZFIFyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 01:54:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MDuIQ-0007D1-9M; Tue, 09 Jun 2009 07:54:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 047006B7; Tue,  9 Jun 2009 07:54:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <81b0412b0906081508v5435c59cm3faf3ac92a56578c@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121139>

Alex Riesen schrieb:
> 2009/6/8 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> On Mon, 8 Jun 2009, Alex Riesen wrote:
>>> NOT TESTED. Can't. My Windows broke again. Not even compile-tested.
>> Yes, that is pretty easy to see as you first used pold/pnew and then
>> src/dst.
> 
> Yep.
> 
>> I minimally fixed up your patch (it now uses strbuf), and added a
>> test-case.
>>
>> This test-case is actually crucial: it shows that your patch is not
>> enough: the culprit is this code in builtin-mv.c:167--168:
>>
>>                else if (lstat(dst, &st) == 0) {
>>                        bad = "destination exists";
> 
> Ah, thanks. Missed that completely.

That's the reason why I think any work-around for this problem is not
worth it.

If you want to be cross-platfrom, make up your mind about file names in
advance.

-- Hannes
