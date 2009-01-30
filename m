From: Frank Li <lznuaa@gmail.com>
Subject: Git log can not show history before rename
Date: Fri, 30 Jan 2009 19:23:20 +0800
Message-ID: <1976ea660901300323n384d3650s3bb5a575accb65d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 12:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSrUM-0002u4-Qb
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbZA3LXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbZA3LXW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:23:22 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:50215 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbZA3LXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:23:21 -0500
Received: by yx-out-2324.google.com with SMTP id 8so153267yxm.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 03:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=pNn5PJ5RscCBlkuLPiTcLjw6H9rxCQAgj+7HQ56HvOQ=;
        b=jEJHfIQw3odcHXet6HdDvnV721bZ8ww2cXPX/vcr1unesOTlp7mTq9dDGJ1yB/gZgA
         //RbMXlIWr+M/8wecb9Jsw5DjdXjKQgYKIMc3pbUx8f5Ej7IcwSS50ss06oF+JhSjoeo
         HRz3+NXZJbrGX6320EyEsgts5vJ7DuY6OUqpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=mYZ4WOpsd8DII0VWYv3AgBuraLm/wfbWDxPRpFbUr7UKqFHRbxMtBjWR3XOGv72IBV
         xMyOiBbUC+Ws5bSH/HMMQ4uGVeOIcE1OsgmQ7+g0VnQ/XRj1RNDL/L+X9xyifzHEj/rV
         vaFmmgmPctZq49Sf6sucavy/3NBNqX8Poz160=
Received: by 10.150.146.14 with SMTP id t14mr372474ybd.98.1233314600142; Fri, 
	30 Jan 2009 03:23:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107798>

mkdir tt3
cd tt3
git init-db
touch a.c
git add a.c
git commit -a -m "test1"

git mv a.c b.c
git commit -a -m "rename"

modify b.c
git commit -a -m "test2"

git log -C -M -- b.c
========================================
commit 8d55ed63d2048d41bde8c34dafc52c6a965d61ed
Author: Frank Li <lznuaa@gmail.com>
Date:   Fri Jan 30 19:20:10 2009 +0800
    test2
commit af0214f7d32cf97fda2743e7d906305e6de2e9a2
Author: Frank Li <lznuaa@gmail.com>
Date:   Fri Jan 30 19:19:15 2009 +0800
    rename
=========================================

I can't get history before rename.
