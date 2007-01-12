From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Fri, 12 Jan 2007 18:38:26 +0100
Message-ID: <81b0412b0701120938o1606dcachf2553a83b47921b1@mail.gmail.com>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	 <7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	 <20070107163112.GA9336@steel.home>
	 <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	 <20070112184839.9431ddff.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 18:38:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5QML-0004Lt-Nq
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 18:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbXALRib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 12:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbXALRib
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 12:38:31 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:12718 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964801AbXALRia (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 12:38:30 -0500
Received: by wr-out-0506.google.com with SMTP id 70so730555wra
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 09:38:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b5/TEUPN5AZtOTkkiQAVTkyP9hyLpqiIcUPWC/MXRV2CMAmNIjLARZWOo3W2g7SQMd5tVbIHflo9JES6bCL3j3Te3M+0WM02LB1U9tDbgii/IjNk+wkJ17KuIqd2o3B/FPUces9o/FPMfaqoOk+yI4NGFXT3+ey7PMkQiGIPvTc=
Received: by 10.78.185.15 with SMTP id i15mr519701huf.1168623506633;
        Fri, 12 Jan 2007 09:38:26 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Fri, 12 Jan 2007 09:38:26 -0800 (PST)
To: "Sergey Vlasov" <vsu@altlinux.ru>
In-Reply-To: <20070112184839.9431ddff.vsu@altlinux.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36683>

On 1/12/07, Sergey Vlasov <vsu@altlinux.ru> wrote:
> > Subject: [PATCH] merge-recursive: do not use on-file index when not needed.
>
> This commit broke t3401-rebase-partial.sh:
>
> ...
> *   ok 3: rebase topic branch against new master and check git-am did not get halted
>

Hmm... Can't reproduce. Do you have your own patches in the tree?
Or could you post your merge-recursive.c?
