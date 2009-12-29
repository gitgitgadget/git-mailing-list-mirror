From: Fyn Fynn <fynfynn@gmail.com>
Subject: Possible bug in 1.6.6 with reset --hard and $GIT_WORK_TREE
Date: Mon, 28 Dec 2009 22:47:24 -0800
Message-ID: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 07:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPVre-0006nk-Jr
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 07:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbZL2Gr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 01:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbZL2Gr0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 01:47:26 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:49291 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbZL2GrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 01:47:25 -0500
Received: by yxe17 with SMTP id 17so9882000yxe.33
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 22:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=yCek2Zq9jpIMmOfBeYbYi3gXC5FOLsy1qpzkcexYHVA=;
        b=MnzT0LgXrsW04ijx990krcD05d2371oorHn7YTvOfEqe4IxAsCRVZKTnyktnoUm+FY
         bPQx9Fnmz6edaCzBm11+zo0GDxwRzGuynM6LQPZTwLLuPy52rs9ZxmDfQFxhDjbC7cZK
         ZQFcvjS96uiGUfDNCtuwFuSdDHhl3vECQForU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=SH2fq3Cag0tjvIbVzBdtYCyNqUXBzNNg9OO2YTaIqQhe01ZAkvrDdoNfk31Bh2rFPG
         M8KAZgPBodZ965KEfK4ajionDsoByFosjN9FAVFv7M81eBD104Vo1ZPe7CsnfN3YV6zu
         Y8ME/1Elqicgh9mb8pYFYtaU0Yp5yEZpjbGwM=
Received: by 10.100.243.16 with SMTP id q16mr19096531anh.113.1262069244667; 
	Mon, 28 Dec 2009 22:47:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135779>

The exact same git reset command that works in 1.6.4, fails to work
under 1.6.6:

$ GIT_WORK_TREE=$HOME/rawdata/ GIT_DIR=$HOME/rawdata/.git
/usr/local/git-1.6.6/bin/git reset --hard
fatal: hard reset requires a work tree
$ GIT_WORK_TREE=$HOME/rawdata/ GIT_DIR=$HOME/rawdata/.git
/usr/local/git-1.6.4/bin/git reset --hard
HEAD is now at 77ec73f...

What gives?
