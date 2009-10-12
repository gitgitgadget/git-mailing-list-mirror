From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Questions about the new
Date: Mon, 12 Oct 2009 23:03:47 +0400
Message-ID: <20091012190347.GA26977@dpotapov.dyndns.org>
References: <loom.20091012T115746-719@post.gmane.org> <4AD31EBF.6090307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:09:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxQHN-0001BQ-NB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 21:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394AbZJLTEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 15:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757367AbZJLTEe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 15:04:34 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:48414 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934AbZJLTEd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 15:04:33 -0400
Received: by fxm27 with SMTP id 27so9527129fxm.17
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dZFnxnkkpWxSqsVRystkp+z1rYQJc2jhnAsj2hWg1eA=;
        b=rD3pXCEGNQnz+tYyGpnWL4UwV+VyNbkLItFy7mjqCipPpWUH2UlwE3kPUFRetnWQXe
         9X2yJX2r+TzTelr7TXE6Zhc+xDTGNf0IjRg1wa17kMRGQk7uoyKEOveHeLUFZcYE1tJt
         B2v2Etor2JRO5y7MWpeQwppv+mOgZmjj0Xz3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DZj8YDB38ioHFLdnFoTt6gdWptVA2RlslmMU+MePKjQImwPZr1PtmXdGt6+ywkAyX+
         OU0P5kSZNmXn8XCrrL10knJdvRhZedfJSG40JlEuL6taeJ3B5YBS8uxNVyA98hFZoKLo
         hXRpmS4kr2ig0t2OELHoL8UhpTrDoWyPyfF6M=
Received: by 10.86.169.3 with SMTP id r3mr5507345fge.15.1255374236895;
        Mon, 12 Oct 2009 12:03:56 -0700 (PDT)
Received: from localhost ([91.78.50.208])
        by mx.google.com with ESMTPS id 4sm219483fge.7.2009.10.12.12.03.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 12:03:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AD31EBF.6090307@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130052>

On Mon, Oct 12, 2009 at 02:19:11PM +0200, Johannes Sixt wrote:
> 
> With grafts you can only change parenthood; with replace entries you can
> change parenthood *and* all other aspects of a commit (message, author,
> committer, dates).

Actually, you can. I have written a script that did exactly this. It
required to modify parents to point to the new commit. The tricky part
was that modification could be on top of other modifications, but I was
able to handle this case too. Yet, my script was so hackish that I have
never dared to share it with someone (and I used it only couple times
during CVS to Git conversion).

> 
> Hence, replace entries are more general than grafts.

I think both mechanism are theoretically equivalent, but with grafts,
it was rather difficult to replace objects (but not impossible!).

> The problem with grafts was that, for example, git-pack-objects obeyed the
> graft, and could create a broken repository by removing grafted-away
> objects. And since git-fsck also obeyed the graft, it did not notice the
> breakage.

Moreover, grafted-away objects could be removed by the garbage collector...


Dmitry
