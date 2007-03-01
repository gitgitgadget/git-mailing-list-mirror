From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 19:31:30 +0000
Message-ID: <200703011931.32170.andyparkins@gmail.com>
References: <20070228151516.GC57456@codelabs.ru> <200703011831.29321.andyparkins@gmail.com> <Pine.LNX.4.63.0703011941020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 20:34:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMr2l-000139-JB
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 20:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965528AbXCATeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 14:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965531AbXCATeW
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 14:34:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:36841 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965528AbXCATeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 14:34:21 -0500
Received: by ug-out-1314.google.com with SMTP id 44so455475uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 11:34:20 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=otDB5Icnn3AS48jw7j3JpT/RAZk2yX8Mfxz14Zd8G41WRqG3OlT6Mst5/he+MFAzqlnmTBF4Ytvx98S8dvMYa3nlfVAwGecNtD1euNAqYo5S46XYkc/Prg8iEQHbFnZJeeXEr08caL34a3A4Tw+hLLwCn0f4j6vFzeBulZy2VNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kyDAmrEDxwh+KXULjnP/R2+d1JgBSSDZf/bKP+liqeKPivMucfRWzMMbuhixAhbxMg1p7YkOp7k6NlKUJRsR/XYhxRvxWsujec1qK7Uq+NwXeV714TPLVBtgc9RItYe5Jq1qmm+u6Gau6izy2LsZWoIlIW0yMT9p8HNAJLpaHLI=
Received: by 10.67.26.7 with SMTP id d7mr2622756ugj.1172777660634;
        Thu, 01 Mar 2007 11:34:20 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id j1sm2188670ugf.2007.03.01.11.34.17;
        Thu, 01 Mar 2007 11:34:17 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.63.0703011941020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41118>

On Thursday 2007, March 01, Johannes Schindelin wrote:

> Got it.
>
> So, in a very real sense, we have file ids. Even tree ids. And commit
> ids.

Absolutely.  Moreso than CVS/SVN.  Putting $Id$ $Rev$ in a git managed 
file would have far more meaning that it does in a CVS managed file.

Actually, $Id$ covers the file hash; $Rev$ covers the commit hash.  I 
wonder if the tree id would be useful to finish the set?

The reason it's so hard to do is because putting the file id in the file 
would change the file, and hence its Id.  Ouch.  However, I reckon the 
upcoming gitattributes stuff is going to have no trouble keeping the 
file contents stable from git's point of view and yet let you 
mangle/unmangle the contents with this keyword stuff.

Actually once gitattributes exists we almost have to have a $Id$, the 
hash of the working directory file isn't stable because it might have 
had it's line endings mangled.  On the other hand we could argue that 
git-hash-object should have unmangling options anyway.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
