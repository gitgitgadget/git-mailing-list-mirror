From: skillzero@gmail.com
Subject: Why do git submodules require manual checkouts and commits?
Date: Thu, 15 May 2008 21:16:23 -0700
Message-ID: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 06:17:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwrO0-0002Uf-5D
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 06:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbYEPEQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 00:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbYEPEQZ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 00:16:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:9573 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbYEPEQY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 00:16:24 -0400
Received: by wa-out-1112.google.com with SMTP id j37so969854waf.23
        for <git@vger.kernel.org>; Thu, 15 May 2008 21:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=BVr3eQDo9QTTuHMNFf6tYaKHcFhLROUdCv04Jqte39Y=;
        b=u5RdoSP7ocLOOz0JlUnko95gcdpCatvSfBheR7nPFVzYIa7pLVnlAxNSfOIJm8dupijqr3e1V6IQ2kwvV1O7DWZZSEJ8d4ofm6gNTTAezS/spy8cHMijfOv2PuN+FwibiUotwjI0ZBnx7szBRixoPh/WiJATvZfQ2usWozqfSOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bq/1ECIMcj+GXu05zPu6YNw4gl9b+wxLEh4ATrt7SwuE3u7yltDE7WlvzfsacY8kA05907CUR2B51exyLAJnvmWZD3xrKQBsyGiwS1NjUyFFqHvATTgKeVXNlBgVv/mAa8LEqDmtMmLJidVTAVmC6ME3M8wnqkEyYsM4ci+nHSM=
Received: by 10.114.241.15 with SMTP id o15mr3290645wah.164.1210911383752;
        Thu, 15 May 2008 21:16:23 -0700 (PDT)
Received: by 10.114.193.9 with HTTP; Thu, 15 May 2008 21:16:23 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82255>

Why do git submodules require manually committing the submodule itself
to each super repository after something in the submodule repository
changes? Is there some reason the super repository can't just "link"
to the submodules by branch name? It seems that if the .gitsubmodules
also specified the branch to use:

[submodule "libfoo"]
	path = libs/foo
	url = git://foo.com/git/libfoo.git
	branch = master

[submodule "libbar"]
	path = libs/bar
	url = git://bar.com/git/libbar.git
	branch = stable

Then a git pull (or git clone) of the super repository could also pull
in all submodules. A commit to a file in a submodule would then be
automatically reflected in the super repository (since the super
repository would always pull HEAD of that branch).

Is this difficult (or somehow undesirable)?
