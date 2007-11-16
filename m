From: "Ollie Wild" <aaw@google.com>
Subject: git-svn fetch failure: index.lock file exists
Date: Thu, 15 Nov 2007 16:07:20 -0800
Message-ID: <65dd6fd50711151607x50639232w6d79322129c3d82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 01:07:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsokK-0007Ks-6w
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 01:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765233AbXKPAH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 19:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765110AbXKPAH1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 19:07:27 -0500
Received: from smtp-out.google.com ([216.239.33.17]:41787 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757460AbXKPAH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 19:07:26 -0500
Received: from zps77.corp.google.com (zps77.corp.google.com [172.25.146.77])
	by smtp-out.google.com with ESMTP id lAG07MvT030994
	for <git@vger.kernel.org>; Fri, 16 Nov 2007 00:07:22 GMT
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:mime-version:
	content-type:content-transfer-encoding:content-disposition;
	b=fN1pKaJ8S9hgupSo0WZBXa2doaFz69cCZZrHsx4mrHLtp6S7g0r1T+uu5etZ4ZBcv
	7GFKkvETqlAK51R01FGhg==
Received: from py-out-1112.google.com (pycj37.prod.google.com [10.34.111.37])
	by zps77.corp.google.com with ESMTP id lAG06oUS020768
	for <git@vger.kernel.org>; Thu, 15 Nov 2007 16:07:21 -0800
Received: by py-out-1112.google.com with SMTP id j37so4044869pyc
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 16:07:21 -0800 (PST)
Received: by 10.35.36.13 with SMTP id o13mr1435932pyj.1195171640170;
        Thu, 15 Nov 2007 16:07:20 -0800 (PST)
Received: by 10.35.46.15 with HTTP; Thu, 15 Nov 2007 16:07:20 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65181>

Hi,

I've been using git-svn for a while now to work on gcc.  Last night, I did a

  git svn fetch

and got the following failure:

  Found possible branch point: svn+ssh://aaw@gcc.gnu.org/svn/gcc/trunk =>
      svn+ssh://aaw@gcc.gnu.org/svn/gcc/tags/libbid-last-merge, 128810
  Found branch parent: (tags/libbid-last-merge)
      789aa951bbc6a49f791bf5109136335fc33222c5
  fatal: unable to create
'.git/svn/tags/libbid-last-merge/index.lock': File exists
  read-tree 789aa951bbc6a49f791bf5109136335fc33222c5:
      command returned error: 128

Naively, it looks to me like I've just got a stale lock file from a
previous run.  However, I have no idea what the correct recovery
strategy is.  Can I just delete the lock file?  Do I need to do some
sort of data validation?

I'm using git version 1.5.2.5 with subversion version 1.4.5 (r25188).

Thanks,
Ollie
