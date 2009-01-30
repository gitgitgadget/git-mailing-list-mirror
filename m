From: Frank Li <lznuaa@gmail.com>
Subject: git log --follow --parents can't rewrite history
Date: Fri, 30 Jan 2009 21:16:11 +0800
Message-ID: <1976ea660901300516x75205c6cifb32ca67c866768a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 14:17:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LStFb-0006i1-Ne
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbZA3NQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbZA3NQO
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:16:14 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:5253 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZA3NQN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:16:13 -0500
Received: by yx-out-2324.google.com with SMTP id 8so165242yxm.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 05:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=b6h6hpJCPTchcXKP0ICKhIGQO7NlJgcWcoSXl2+p00E=;
        b=EGN6yv9ghEwyi/6upD0S9HId6RdOxBvg4yag0vh1YkyuqWYfZwag5Z9O/QZbveOkgD
         /8RPp04sWZgh3BmruoivRhCObYrOvNWwm/kfM1NmFGKFNJ+b58QqAfgZp519/cefFNSh
         3DHrRw9C2sQMjaD3EtuO9GQG0IoEpb9YnrfMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=i5I/XqzgXCalGvxp96sD8aBfBInd4M5aPhBuFMPrIC8cSI51MrdztC0h+UdVSBizXz
         qOKTJRnzRrMY0DXWG9kUq5j2GEIsLIg1jMpYFa4ejl8Tpay1OrO8NwqZjTQrEycMJyrF
         xZsIeEKgXlpuYorByDwDhPVXzXfMJKmzsNYSs=
Received: by 10.150.212.14 with SMTP id k14mr1179023ybg.226.1233321371565; 
	Fri, 30 Jan 2009 05:16:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107810>

use git.git repository.

git log --pretty=format:Commit:%H%nParent:%P%n%n --parents  -- alloc.c

Commit:100c5f3b0b27ec6617de1a785c4ff481e92636c1
Parent:2c1cbec1e2f0bd7b15fe5e921d287babfd91c7d3


Commit:2c1cbec1e2f0bd7b15fe5e921d287babfd91c7d3
Parent:579d1fbfaf25550254014fa472faac95f88eb779


Commit:579d1fbfaf25550254014fa472faac95f88eb779
Parent:855419f764a65e92f1d5dd1b3d50ee987db1d9de


Commit:855419f764a65e92f1d5dd1b3d50ee987db1d9de
Parent:

Parent will be rewritten correctly.

But When I add --follow, it will be
git log --pretty=format:Commit:%H%nParent:%P%n%n --parents --follow -- alloc.c

Commit:100c5f3b0b27ec6617de1a785c4ff481e92636c1
Parent:2c1cbec1e2f0bd7b15fe5e921d287babfd91c7d3


Commit:2c1cbec1e2f0bd7b15fe5e921d287babfd91c7d3
Parent:f948792990f82a35bf0c98510e7511ef8acb9cd3


Commit:579d1fbfaf25550254014fa472faac95f88eb779
Parent:446c6faec69f7ac521b8b9fc2b1874731729032f


Commit:855419f764a65e92f1d5dd1b3d50ee987db1d9de
Parent:64e86c57867593ba0ee77a7b0ff0eb8e9d4d8ed5

parent will be not rewritten.
