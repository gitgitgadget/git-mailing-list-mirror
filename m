From: Andy Parkins <andyparkins@gmail.com>
Subject: git-fetch and unannotated tags
Date: Wed, 25 Apr 2007 20:04:42 +0100
Message-ID: <200704252004.45112.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 21:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgmnf-0006wg-AA
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992932AbXDYTFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992949AbXDYTFG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:05:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:17102 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992932AbXDYTFE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:05:04 -0400
Received: by ug-out-1314.google.com with SMTP id 44so477900uga
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 12:05:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DbaBJ/Euh+4TIySA6vPBhtpYBs9MDQED9H0/3vkmbpLCar1tvikjPoWRyui7+9iEOJNRc9e7Kb6jmERPHs5ntpB9Nkp7MRWuWxm3oo4AOTfH4c7r/BDfD1HkIu/79Mc+VsntqKhdwGW8e98MheV+5vcsueGdH0IfuBaXbg6IAXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Bd8+4GTFIM/TmSw7oMhhCpdlYiWMdtRWFUTMtFzrRj8CxlnElbwhUzwBhV2oawg1FK3ERweA7/T0PLm9YAvpVoUoKuq4hxB+XfwvVpZLoFMPxYjzpkL7EjFXGCUGYBBWQQcxD6M0dmcYrsXEjvSWucwgdz0CYincQ9b8jf2/mdI=
Received: by 10.66.248.13 with SMTP id v13mr1588812ugh.1177527899162;
        Wed, 25 Apr 2007 12:04:59 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id b35sm3757699ugd.2007.04.25.12.04.58;
        Wed, 25 Apr 2007 12:04:58 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45545>

Hello,

I often use unannotated tags to mark particular revisions in a 
repository.  I use unannotated tags just as I would a bookmark.  
Annotated tags I reserve for information about a particular revision 
that I want to share with the world.  In essence I treat unannotated 
tags as private and annotated tags as public.

Unfortunately, git doesn't help me with this.  When I fetch from a 
repository that has unannotated tags, those tags are transferred.

Is there any way to stop this?  I'm fine with git doing automatic 
transfer of annotated tags, but not the unannotated.  The only way I 
can get around this is to use branches instead, that way whether they 
are transferred or not is completely under my control.

That makes me think that perhaps we should remove the special treatment 
of tags and treat them just like any other ref...

[remote "origin"]
  url = whatever
  fetch = refs/tags/*:refs/tags/*

However that still doesn't distinguish between annotated and 
unannotated.  Maybe two different glob tokens?

[remote "origin"]
  url = whatever
  fetch = refs/tags/?:refs/tags/?

Would mean annotated tags only...




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
