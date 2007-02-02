From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: Question: next, master and pu branches
Date: Fri, 2 Feb 2007 12:52:13 +0600
Message-ID: <200702021252.14076.litvinov2004@gmail.com>
References: <200702021142.08975.litvinov2004@gmail.com> <7v8xfhksg0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 07:52:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCsHc-0007mC-1l
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423156AbXBBGwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423158AbXBBGwY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:52:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:22224 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423156AbXBBGwY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:52:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so685041uga
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 22:52:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f81ZvsXO2TYeurBQxni0XoTE44Tma7GbmyTkC9hXU+yyqQ94ysk7IZ158ZwCMgmvvDxW3p5WqcGOm65dw9hn2Vp5TxT9XcDC31tCmYp3YrWC9SL5zQzzYx+QY+kKFpk2FT1WYP2/DZ5uGs0DYBbL70DnpvoaS4rK4gHkuEIOdh8=
Received: by 10.67.117.2 with SMTP id u2mr3917395ugm.1170399140726;
        Thu, 01 Feb 2007 22:52:20 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id k1sm4733826ugf.2007.02.01.22.52.19;
        Thu, 01 Feb 2007 22:52:20 -0800 (PST)
User-Agent: KMail/1.8
In-Reply-To: <7v8xfhksg0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38464>

> I think what you are looking for is how my 'maint' and 'master'
> branches are maintained; 'maint' corresponds to your "stable
> release" while 'master' corresponds to your "develment branch".
>
> When a stable release is cut, 'maint' is forked from there.
>
> Truly obvious corrections will be applied on top of the tip of
> 'maint' directly, while if there are any doubt about a proposed
> change I might fork a topic off of the tip of 'maint' and cook
> the fix for a while until I finally merge it to 'maint'.  This
> way, 'maint' will be "bugfix only since the last release".
>
> The tip of 'maint' will be merged into 'master', from time to
> time, to make sure that all fixes will be in 'master'.
>
> When it is time for a new release to be cut, I'd make sure that
> the tip of 'maint' is merged into 'master' (it usually is) and
> then the tip of the 'master' is tagged to be released.  After a
> release is made, I could have two maintenance branches (one that
> continues on top of the old codebase, another that fixes the new
> release).  A fix that can apply to both codebases will be
> applied to the maintenance branch for the old release and then
> its tip can be pulled into the maintenance branch for the new
> release and then its tip can further be merged into the
> development branch.
>
> At some point, the codebases for the older release and the
> current release become diverged enough that merging could become
> inpractical (the same bug may need different fix if the
> infrastracture has become different); you would need to bite the
> bullet and fix it twice (i.e. differently).

Thanks for detailed description. As a cunclusion I would like to say: all bug 
fixes are made in the stable branch and then stable branch will be merged to 
development branch. That is easy !
