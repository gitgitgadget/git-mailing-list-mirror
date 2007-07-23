From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: index-pack died on pread
Date: Mon, 23 Jul 2007 17:32:59 +0200
Message-ID: <81b0412b0707230832w438613d0rdaa8dc97013962a6@mail.gmail.com>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: "Michal Rokos" <michal.rokos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 17:33:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICzuF-0008FC-VW
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 17:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbXGWPdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 11:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbXGWPdE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 11:33:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:55911 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbXGWPdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 11:33:01 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1213768ugf
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 08:32:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TpBcqzHDx8n75Ey8dh5th1oGuIX+VycI+Vqbg/e+LRFixQGUgbmjUld8/JuonmExpSdwGoVrjxs7osLxSk7PypQSOeGZ0pHAy2mSuIimcgR3ZWy8XHMMu4IQREqlTXW3RLB0VFEvTaKFqYeqtnLq3ZwJxQF567kI7Ri3i2myalQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UL+KKjw1CL9WTHcKYOAzvwrTYmhqEceG7t8P7qAwk2BsLHwCpQqGC58xgYMS6iLHedda+XXbWzmwZpNSwjHuW7VztBYbAkGu2ttcEWDVCHAFUWo3KHrs1FBa/D9Trthfp15wKkQAF9uRDAvvDcstRaSJcnZSVmCphQIHz8+o6cE=
Received: by 10.78.170.6 with SMTP id s6mr796894hue.1185204779159;
        Mon, 23 Jul 2007 08:32:59 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Mon, 23 Jul 2007 08:32:59 -0700 (PDT)
In-Reply-To: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53442>

On 7/23/07, Michal Rokos <michal.rokos@gmail.com> wrote:
> fatal: cannot pread pack file: No such file or directory (n=0,
> errno=2, fd=3, ptr=40452958, len=428, rdy=0, off=123601)
> fatal: index-pack died with error code 128

strange. pread(2) should not return ENOENT. Not in HP-UX
not anywhere.

Could you recompile with NO_PREAD=1 and try again?
Maybe HP-UX pread(2) implementation is just broken.
