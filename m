From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Coping commits from one branch to another
Date: Tue, 22 Jan 2008 17:45:18 +0200
Message-ID: <8e04b5820801220745m3736686exf631f31c9e6d785a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 16:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHLJw-0003ER-Rb
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 16:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbYAVPpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 10:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYAVPpW
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 10:45:22 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:19050 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbYAVPpW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 10:45:22 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1440917nze.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=+zFbEobOIYL9NvkbZyZ04KebLpuwj74Bal3q9TnpKXw=;
        b=WE2Yj3/qiOuSK5gjzGZ/KewVrJ0nTcMSs+lB6Myfru+4ttjM70M+PM0qyKW1rFQ67ZsfLi57YggbvZWdy+THV86CmB7HG2iqr5i/L9r1aQSWScxbazDIhpJ2ZmXnaKWva7Ee+Vjh6r2kqEEU5N9uWwHYJvV/99gsuKv1JdahV+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hmfgeUfNkbpXNmKzWEMNWRGN12YGVfgVxJqHpg/MineTvX36E7YcvVz7sCfcusQRoFtYo7f65/jy7RCdu2XdN/RTAC2t5Rg3TvFdBc6lLtINjoDuZUPzzvxsuSVSH/5AqfsJSOXtXGU+xJpSg9pTSB5nIWBhYeEzCZleahWFFOk=
Received: by 10.110.46.14 with SMTP id t14mr3698509tit.16.1201016718939;
        Tue, 22 Jan 2008 07:45:18 -0800 (PST)
Received: by 10.70.109.19 with HTTP; Tue, 22 Jan 2008 07:45:18 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71456>

    Hello all!

    My question is how can I use git-rebase -- or a similar command --
to actually copy the commits from one branch to another.

    For example I have cloned the linux kernel repository and I have
the following branches:
    -- v2.6.22-stable
    -- v2.6.23-local
    -- v2.6.23-stable
    -- v2.6.23-local

    The difference between v2.6.x-stable and v2.6.x-local are just a
few minor patches (which are not in the default kernel tree) and some
script files added to make the compilation and deployment easier for
my setup. Thus v2.6.x-local is an ancestor of v2.6.x-stable. Now when
v2.6.24 will arrive I would like to "copy" the commits from
v2.6.23-local to v2.6.24-local.

    One solution would be to use:
    git rebase --onto v2.6.24-local v2.6.23-stable v2.6.23-local

    But this will not copy the commits, but actually move them. (And I
do not see anything about this case in the git rebase documentation,
or pointers to other commands similar to rebase.)

    So how should this be done?

    Thanks,
    Ciprian Craciun.

    P.S.: The simplest solution would be to obtain the list of commits
and apply them with cherry-pick... But this is not that straight
forward...
