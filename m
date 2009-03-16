From: Kevin Williams <kevwil@gmail.com>
Subject: git-svn rebase can change branches during merge?
Date: Mon, 16 Mar 2009 14:49:35 -0600
Message-ID: <683a886f0903161349k172679a6t24cc4e393aea8f2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJm7-00042P-Ox
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758727AbZCPUti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757784AbZCPUti
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:49:38 -0400
Received: from mail-gx0-f165.google.com ([209.85.217.165]:57705 "EHLO
	mail-gx0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757750AbZCPUth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:49:37 -0400
Received: by gxk9 with SMTP id 9so2217535gxk.13
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=3efqRj3wddUKctzNgD7bR6tu4kcSX87q1Xo/lUoRCbg=;
        b=rjVfkJlh4nDBooa+iCbkgj1Xdaq8Tk+mFhQDmD+/qjyK46nCR+Fp96E1kBDdIu+Zgu
         imsbNlJ/pQodjSA0ycU/DSKK3JB5KYxyen/8idPZNmfEcepTLDub5T4NDi20GPYjmP/m
         YHER7CSilq6sux0P91OPDpTyOP3g6EwJkC6Go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=kCXF9+dF/O2sW6sMwqopDgeQax/oN1kpiOAQA9Fr1yQIQetW3eodubeM+ow+Z2nMlM
         TjSkz+w/mynztdDVhPN2yvQDcLG8kN1gdeT7ys5NpdWxs5eRrbMILEm0n9tocFddBus8
         aiTLtYizhaCKCkC15sitPjNNyiYFuiP8zfyvw=
Received: by 10.151.82.13 with SMTP id j13mr9219445ybl.84.1237236575231; Mon, 
	16 Mar 2009 13:49:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113381>

I've outlined steps where I can reproduce this bug here:
http://gist.github.com/80058

When using "git svn rebase" and there is a conflict between a local
(git) change and an upstream (svn) change, the local git repository is
left in a ghost-branch. It shouldn't change branches during a rebase,
should it? I also seem to be unable to recover from the merge
conflict, but that may be just due to the noob at the keyboard (me).

I tried working through this with some folks in the #git channel last
week but they were stumped as well.

I'm using the latest Git build from MacPorts (1.6.2.1 as of today) on
a MacbookPro with OS X 10.5.6 (fully updated with all patches)

-- 
Cheers,

Kevin Williams
