From: Chris Packham <judge.packham@gmail.com>
Subject: Egit/Jgit support for relocated .git directories
Date: Tue, 26 Jun 2012 20:18:31 +1200
Message-ID: <4FE97057.3040609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>, jgit-dev@eclipse.org,
	egit-dev@eclipse.org
X-From: git-owner@vger.kernel.org Tue Jun 26 10:18:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjQz0-0000tT-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 10:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758497Ab2FZISk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 04:18:40 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45022 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245Ab2FZISR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 04:18:17 -0400
Received: by dady13 with SMTP id y13so6483085dad.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 01:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=IlbPW74epI49Gcd5Aa58Qk4WChTXeWENm0SpXpIA/7c=;
        b=gMoLBRYM6hX5e0hCDox8CgphAYAdNBOfvREcqEmlXupmuARv2Op+h6VgxlCV6WBz+6
         rjp1+pZGuAlzzRXyD+MHfzIXLyuh2839SpdpayJFzk34vmCdrmaAnLRj44kvqdCC7ada
         xOSIoUHo4pMNPogVNOwzKoU04JCzFvyhIIbPmQlzHZxEnMnD3fX5Do40U40An2XxvmdX
         z/5cBK4vvAwVo5vFWNFyWizzq3vYszP0xvUlfmsdqKSuaiUT5rqigxCv2ZVH1pdGk4My
         aH64AkbiK4EV14SKo4y4ce3z+Y0F8KedV56kdYdWzOYJVKonR/mwziLdmke1jk+0B6eu
         bVlg==
Received: by 10.68.134.201 with SMTP id pm9mr50936640pbb.49.1340698697266;
        Tue, 26 Jun 2012 01:18:17 -0700 (PDT)
Received: from [192.168.1.66] (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id os9sm11158300pbb.62.2012.06.26.01.17.53
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jun 2012 01:17:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120421 Thunderbird/12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200636>

Hi,

This is a bit of a secondhand bug report/query so sorry if the details
are a bit sketchy.

Since git 1.7.8:

``When populating a new submodule directory with "git submodule init",
the $GIT_DIR metainformation directory for submodules is created inside
$GIT_DIR/modules/<name>/ directory of the superproject and referenced
via the gitfile mechanism. This is to make it possible to switch
between commits in the superproject that has and does not have the
submodule in the tree without re-cloning.''

I've had several colleagues at work tell me that with the relocated
$GIT_DIR the Egit integration with eclipse doesn't work. I can't really
qualify "doesn't work" but from what I've been told importing the
project works but blaming/annotating doesn't.

I believe the gitfile mechanism isn't new but it possibly hasn't been
used by many Egit/Jgit users. Can anyone confirm if it is supported by
Egit/Jgit (and I'm barking up the wrong tree).

Thanks,
Chris
