From: "=?UTF-8?Q?Eddy_Petri=C8=99or?=" <eddy.petrisor@gmail.com>
Subject: [PATCH 0/3] git-svn-externals PoC (in a sh script)
Date: Fri, 29 Aug 2008 03:02:12 +0300
Message-ID: <60381eeb0808281702q3dc7543enff2b35ebbcc80d08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 02:03:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrSQ-0003OO-Rq
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYH2ACO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbYH2ACO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:02:14 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:41779 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbYH2ACN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:02:13 -0400
Received: by yx-out-2324.google.com with SMTP id 8so348600yxm.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=elt6pRJFdajpaBxHZfJKDTO0qw64Edl+7YrfqzXfiWQ=;
        b=N9k+9o87XpK6IzT3M34yEXyj4Ks772kkwdbzl0DyQezRaBKRdTNiQh9laRKGjp8Vu2
         nFXBKTTKyoGlc6QJUQSaIe7eWRxpWwBQDxpOv1rXjjtnxWts8OH1zsXih8ribKGv34cn
         GkBJkmpjYMJmyUZa1kALMzZP/QOaNoDX9FxEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=kaDVCXfdvw2L2Oo39xM6O5ITxh9Sx0bCpGgCXlMowPmGI1mHu623SK6SjXBoXuID85
         sGCVJsMoKg9bdTTPuMNoaNI8FifQcGUAj/36uzpSxzDCa+BHYUSMRxVmiRHfS9Bjzkay
         BkEvJrOlNXl/r0hNPfggxCkVmAyOHSIHSxmv8=
Received: by 10.150.156.9 with SMTP id d9mr1110579ybe.224.1219968132536;
        Thu, 28 Aug 2008 17:02:12 -0700 (PDT)
Received: by 10.151.26.18 with HTTP; Thu, 28 Aug 2008 17:02:12 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94221>

Hello,

I have started a while back working on support for svn:externals
support for git-svn, but since I'm not that satisfied with the current
status of the patch, I haven't modified git-svn itself and just left
the sh script I made as a PoC as it was.

There's still work to be done to it, but I the current version is
functional enough to be probably found useful by more people than
myself.


Current status follows:

    Current functionality:
     - fetches all the externals of an already svn-fetched repo
     - support for svn:externals refresh
     - if the location of the external has changed, the current working
       copy will be placed aside and a new directory will be created
       instead
     - if the remote URI is the same (maybe a verison bump, there will
       be a 'git svn rebase'
     - remove support (useful for testing purposes or clean restarts)
     - avoid zombie externals at all costs - in some repos empty
       svn:externals might exist; svn ignores such externals, so git should
       do the same

    TODO:
     - take into account the revision of an external, if it exists
     - do not do deep svn cloning, to avoid legthy operations, just pull HEAD
       (this actually needs changes in git-svn itself)
     - use/create shallow copies to git svn repos (one revision should be enough
       for most externals)
     - use submodules for externals




Any comments are welcome.


-- 
Regards,
EddyP
=============================================
"Imagination is more important than knowledge" A.Einstein
