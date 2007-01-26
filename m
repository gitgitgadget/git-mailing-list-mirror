From: Andy Parkins <andyparkins@gmail.com>
Subject: Does git-cvsserver expect all changes to be via CVS?
Date: Fri, 26 Jan 2007 10:37:11 +0000
Message-ID: <200701261037.13948.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 11:37:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAOSk-0006mE-R0
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 11:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXAZKhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 05:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbXAZKhS
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 05:37:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:12394 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbXAZKhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 05:37:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so681023uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 02:37:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mJ96fVCIU1R/TjZYXNucYV3lwPlZ8GN6bNdeQE48R9rdSnYBOInXERGErpwhQqco8VCOEOQzzbQZTpXRuDRSSVtUgcCRy35D8Pn4nXzhZyRtwyM0YilZpw5VAVxlLK5Ephs9G0ycMuf8Y966sfj0WEWrhByWCtR0pKemAkjDGno=
Received: by 10.67.119.9 with SMTP id w9mr4119990ugm.1169807835645;
        Fri, 26 Jan 2007 02:37:15 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id 29sm3522921uga.2007.01.26.02.37.14;
        Fri, 26 Jan 2007 02:37:15 -0800 (PST)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37835>

Hello,

Still messing around with git-cvsserver.  It's behaving very strangely, and it 
occurred to me that I have not appreciated that there might be a limitation 
in it.

Here's what I did.

* CVS user checks out a branch from the repository
* CVS user adds new directory and files
* CVS user checks them in
* git user updates a tracking branch and then working branch to
  match latest
* git user makes changes to same files
* git user checks in and pushes the branch
* CVS user runs cvs update

CVS user can't see the changes; forced updates simply checkout the same files 
he's just checked in.

I deleted the sqlite table from the git repository and ran the CVS update 
again and this time the changed files arrived (but only after a forced 
update).

My question then is: does git-cvsserver require that all changes go via 
itself?  Does it expect you not to use normal git on that repository any 
more?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
