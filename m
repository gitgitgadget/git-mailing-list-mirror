From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Thu, 15 Mar 2007 14:56:16 +0100
Message-ID: <81b0412b0703150656v6fb91c9bge73f64d4dc05a115@mail.gmail.com>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0703140216480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0703131831390.9690@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0703140237270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0703140137i6d0df44aua9205e81249570ea@mail.gmail.com>
	 <Pine.LNX.4.63.0703141301210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0703140526p454ee85fk74dcd76fb684217c@mail.gmail.com>
	 <45F940E0.60302@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Mar 15 14:56:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRqRM-0001vb-Nq
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 14:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161342AbXCON4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 09:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbXCON4W
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 09:56:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:64816 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161342AbXCON4V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 09:56:21 -0400
Received: by ug-out-1314.google.com with SMTP id 44so333022uga
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 06:56:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jQuuqpDd/hH7WoH50v2NoSAZ+305ulbJK67o+Fo/jWkPykYtjXdcXVaequdYVAOMIwT42//YqMpBj/DQIZcUlpa7HQGu/K8cSyTsFsIJj+QP1eDYtPAmksihHcQsRQmWlhG8zZiXmNzrLcVRhM/Qr+M0nqzZ1DYv+PQ/64i22d0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S+Y5LMILVJUiTuWrkHmayN43kJ0QsEAuMtXz40JfbxExIGNRHPr3jGv3qhP3lamo3IXnW98CGZiffOKhC4nYQYwwhvpiMrvQWqXT5cRurDhwbp4MsaDJpFporAJzoesDNat6KsxQooUToZpYdguMPnrR6BTLKi7VRkgRuFzvZds=
Received: by 10.78.106.3 with SMTP id e3mr364430huc.1173966976701;
        Thu, 15 Mar 2007 06:56:16 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Thu, 15 Mar 2007 06:56:16 -0700 (PDT)
In-Reply-To: <45F940E0.60302@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42280>

On 3/15/07, Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> Alex Riesen wrote:
> > We have "PAGER=cat" in test-lib.sh which just disables pager,
> > so gits tests do not have the problem (maybe it was disabled just
> > because of this?). And if someone has own tests _with_ pager active
> > the one better be aware of what the one doing.
>
> Does PAGER=cat really disable the pager?  seems to me that it simply
> passes the data through cat.

Yes:
pager.c:

	else if (!*pager || !strcmp(pager, "cat"))
		return;
