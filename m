From: Kerrick Staley <mail@kerrickstaley.com>
Subject: bash-completion now loads completions dynamically, so __git_ps1 is
 not defined when you open a shell
Date: Wed, 28 Mar 2012 15:27:20 -0500
Message-ID: <CANaWP3wu3260uFNzCLJ=YSG1BWFr=ge_6CmMGrG6zLThvFnjcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 22:27:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzTF-0004ui-It
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354Ab2C1U1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:27:48 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:55354 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758004Ab2C1U1q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:27:46 -0400
Received: by wejx9 with SMTP id x9so891004wej.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 13:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:from:date:message-id:subject:to
         :content-type:x-gm-message-state;
        bh=Gck2DECe3QYsVd/ZvFYTapOJxa2t/pm6e0n+EpDXxHI=;
        b=LLuW6T7uQHXkTrBDdnrZ3gKXfkMYuGlU2LHZNOCEX7D3jRqMkKoDBvITjZkjSFjP8b
         5F3Eag9irvSVvfoFRB31VyZWEfwdObsdDNBlkw3BmqgHRqhC2R72AiSVjQzKzou6HibH
         Jzh7U2W5YwQbuhHp4WhEv9KIGq/pbMxcgE1ePl1LH5gFIAQwujRuOlzGCIHir74RXXhm
         ShlIG4fJWRWy90qdsms1z8atLbZf0KQ9FPg39ah37IEkq5866gqeBOLzCf9WEybcyuL1
         w2OC5gFgtaIjYSFjNIkUNd6fwintaAX96qQfXLNv/SPhLuCy+oKZye7pLG+Bll1RTzwn
         2Rcg==
Received: by 10.216.145.194 with SMTP id p44mr17577057wej.38.1332966464655;
        Wed, 28 Mar 2012 13:27:44 -0700 (PDT)
Received: from mail-lpp01m010-f46.google.com (mail-lpp01m010-f46.google.com [209.85.215.46])
        by mx.google.com with ESMTPS id n8sm17609794wix.10.2012.03.28.13.27.42
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 13:27:42 -0700 (PDT)
Received: by lahj13 with SMTP id j13so1600482lah.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 13:27:41 -0700 (PDT)
Received: by 10.152.110.193 with SMTP id ic1mr24870603lab.4.1332966461318;
 Wed, 28 Mar 2012 13:27:41 -0700 (PDT)
Received: by 10.112.52.166 with HTTP; Wed, 28 Mar 2012 13:27:20 -0700 (PDT)
X-Originating-IP: [129.186.193.127]
X-Gm-Message-State: ALoCoQl7S7RLedfOsa/1cgmqk5G+hdnjcNivS0LmsgY9tB7AnM1YRY44hIPZ4weYRG2E583oFpuO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194188>

The __git_ps1 function is defined in same script that defines Git's
tab completions (contrib/completion/git-completion.bash). Since
bash-completion loads completions on-the-fly in newer versions, the
__git_ps1 function isn't immediately available in a new shell. How
should this be handled? Should users just source git-completion.bash
before they redefine $PS1?

-Kerrick Staley
