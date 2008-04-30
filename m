From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Wed, 30 Apr 2008 17:06:53 +0400
Message-ID: <20080430130653.GD6160@dpotapov.dyndns.org>
References: <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> <7vk5ig745b.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness> <7viqy05mhp.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness> <7v63u05khw.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness> <7v1w4o3zle.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 30 15:08:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrC2K-0002wM-Nq
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 15:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757673AbYD3NHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 09:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756983AbYD3NHE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 09:07:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:46099 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898AbYD3NHB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 09:07:01 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1426156ugc.16
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=n0CwhgBtviVxq5K38PNznV4Xl/9hNfwbcGqVWjeYkcA=;
        b=MWXMzXKMlT1tzK7PG/WppYsGx5XUmqwyNEaaJ5HKkxIFMVoay+AS9SQUVaLFsTn1MYQLEAxpWLzar4aEO/MUSYNJoz1mwRXIYrstUMR+dErlzmwOqLvHb8OFuV1roPU+nrrqJB1SVHZHvW5WYaHX/5vAeRLfFx5IKot0vGniNJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=dixnsyRgUeAD3Of0mA5mVuL0nuTI2bMl5solcPHYTJanDuvGVurWMI8mvEfaxFc2NrODZuermskgc6vxk/oIQoWgy6tmmrlJmNG+7meKlWDAG7yuhU4JhSzNbYYY+6aZ0EpJsiZFzOBiPdemQb+aEwxlzUyoNeyVxVrEWXMAyMg=
Received: by 10.67.115.4 with SMTP id s4mr7935230ugm.1.1209560819037;
        Wed, 30 Apr 2008 06:06:59 -0700 (PDT)
Received: from localhost ( [85.141.190.2])
        by mx.google.com with ESMTPS id u14sm924194gvf.6.2008.04.30.06.06.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 06:06:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80835>

On Wed, Apr 30, 2008 at 09:47:02AM +0100, Johannes Schindelin wrote:
> 
> I cannot bring myself to feel that this is messy.  The more I think about 
> it, the clearer it becomes for me that the pick call should use the 
> original commit, whereas the merge call should use the rewritten commit 
> (and should therefore only be called when all ancestors of that merge 
> which need rebasing were rebased already).
>

Maybe, it would be better if re-written commits were marked a bit
differently, so there will be no confusion about whether an original
or re-written commit is referred. For instance, re-written commits can
be marked by adding apostrophe at the end, so if the original commit
was "abcdef" then the re-written should be called as "abcdef'". At
least, it will make plain clear for anyone where in merge rewritten
commits are mentioned. Otherwise, it looks too magical to me.

Dmitry
