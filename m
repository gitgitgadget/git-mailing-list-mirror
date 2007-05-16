From: Andy Parkins <andyparkins@gmail.com>
Subject: Opinions on bug fix organisation
Date: Wed, 16 May 2007 11:38:28 +0100
Message-ID: <200705161138.30134.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 12:38:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoGu5-0003R6-PM
	for gcvg-git@gmane.org; Wed, 16 May 2007 12:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634AbXEPKih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 06:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756299AbXEPKih
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 06:38:37 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:35215 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184AbXEPKih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 06:38:37 -0400
Received: by nz-out-0506.google.com with SMTP id r28so503710nza
        for <git@vger.kernel.org>; Wed, 16 May 2007 03:38:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tUmlvPSv5WfqCqKsxf0aeLa2Ku4EiyJTAaEm04y38skB8mKcWqgNCETaF6tDKdmqmuI3Kolk0yR8OO/mf2d7BqcJGcnZ1Du8ga4IJ8sM5VKoYUzbVh1+7hVSmiHM8PUApkXyoD+qlGP/DgSKYhs8ZqSROWBmLiamaFq941s6i/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IQWVunpYB9pSHwlAN7fxji5YU7EOrAR9qwweO7uyZv372QArcmNxBKpU6QWMW9xAla+7BYdpy9zkmK8IWsGjDfKAc8vgSB8x931HkQTAu5sDbPo0JwYqVsuPYFUhL32/4SBzRtac3o1/OxYvF9WLy2oPP1y0JzHTtmrkWE7tdb0=
Received: by 10.65.185.3 with SMTP id m3mr2913692qbp.1179311916155;
        Wed, 16 May 2007 03:38:36 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id f16sm1941891qba.2007.05.16.03.38.34;
        Wed, 16 May 2007 03:38:35 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47430>

Hello,

This is not so much a question about git, but more about history organisation.  
I'm undecided on the best way to deal with bug fix history.

Imagine this situation:

 * -- * -- B -- * -- * -- *

"B" is a commit that introduced a feature and a bug, that bug is present 
forever more in history (which I think is good - history is history).  I've 
pushed the repository to the rest of the developers in the meantime, so there 
is no editing "B" and doing some rebase magic.

Now, I want to make a commit that fixes that bug.  These are the options:

 * -- * -- B -- * -- * -- * -- F

 or

 * -- * -- B -- * -- * -- * -- M
            \                 /
             --------------- F

That is - just commit a fix or, commit the fix, "F", directly on "B" then 
merge that fix back to HEAD with "M".

I quite like option 2 because it records intent - i.e. "I wish I could have 
gone back and changed this revision, but I can't", but it makes a more 
complicated history.

What do people think?



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
