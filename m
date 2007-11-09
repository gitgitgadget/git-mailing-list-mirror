From: Andreas Ericsson <ae@op5.se>
Subject: Re: corrupt object on git-gc
Date: Fri, 09 Nov 2007 13:56:45 +0100
Message-ID: <4734590D.6000104@op5.se>
References: <6C2C79E72C305246B504CBA17B5500C902535D9C@mtlexch01.mtl.com> <458BC6B0F287034F92FE78908BD01CE814472B3D@mtlexch01.mtl.com> <6C2C79E72C305246B504CBA17B5500C9029A36A1@mtlexch01.mtl.com> <20071109081035.GA2794@steel.home> <6C2C79E72C305246B504CBA17B5500C9029A36F2@mtlexch01.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Yossi Leybovich <sleybo@mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Nov 09 13:57:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqTQ2-0008Qe-UZ
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 13:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbXKIM4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 07:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbXKIM4t
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 07:56:49 -0500
Received: from mail.op5.se ([193.201.96.20]:41656 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbXKIM4s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 07:56:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6366D1F08723;
	Fri,  9 Nov 2007 13:56:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PmNTGAsUEOlg; Fri,  9 Nov 2007 13:56:46 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 7AC2E1F0871F;
	Fri,  9 Nov 2007 13:56:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <6C2C79E72C305246B504CBA17B5500C9029A36F2@mtlexch01.mtl.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64173>

Yossi Leybovich wrote:
> Hi
> 
>  I know its loose but still I think there are references in the
> repository to this object.
> How I can remove it from the repository ?
> 
> 
> sleybo@SLEYBO-LT /w/work/EMC/ib.071030.001/ib
> $ mv .git/objects/4b ..
> 

That was not a very good idea. You just moved ALL objects whose hash
begin with 4b out of the object database.

Try only moving the offending file out of the 4b directory.

> sleybo@SLEYBO-LT /w/work/EMC/ib.071030.001/ib
> $ git-fsck --full
>               to    blob 4b920d658a05a66a9d18dd34b51d6e3a9f229ce1
>               to  commit 4b1aabfe3ecc12007535369a2ba17bcee776df64
>               to    blob 4b920d658a05a66a9d18dd34b51d6e3a9f229ce1
>               to    tree 4b89da873ce6e1b36a818d70d4665b3074f2354c
>               to    blob 4b920d658a05a66a9d18dd34b51d6e3a9f229ce1>

Notice how all of these start with 4b? Move the directory back and
get rid of just the object that causes errors.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
