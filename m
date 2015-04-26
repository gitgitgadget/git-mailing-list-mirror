From: Olivier ROLAND <cyrus-dev@edla.org>
Subject: Bug report : bad filter-branch (OSX only)
Date: Sun, 26 Apr 2015 11:25:52 +0200
Message-ID: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 11:26:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmIp5-0005g2-Fg
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 11:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbbDZJZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 05:25:54 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35781 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbbDZJZx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 05:25:53 -0400
Received: by iejt8 with SMTP id t8so108977575iej.2
        for <git@vger.kernel.org>; Sun, 26 Apr 2015 02:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Eja48VVTLnUHYnQ1x6s1iCYam+jf8YzDP8/Ysz99K+o=;
        b=BfQy3dW7yvpWPJV+e4uH25vu17acvEkeAWx/a9e0WIZEcH/834ggKsiT7ZwuFJ9dnJ
         qP8UOh/3Uim7/epAMytZ2Qo5v0vgpT0Rv7DEG4uLiRw1DG7dBj2eli58wOFOw256LAdI
         PcXSREMfYLbVcK8npzo7CRXH3QZQdx/sftl+J6Fx+B1vtFaYduYqsyQRz3mhQFhSLIPN
         sBvKJ/0CsCjmE5+3O9GucAIq3j2SDh7AMP5JLtrdqV8a6ADBeBZYrHYYxwNghz7WrBgm
         blPXuYE+8En6dOsj+9WAPvp4aUHoWyrc7gcR4QlxLscGgxxWV3PUC/NEpbQZng4ltPb5
         gtJQ==
X-Gm-Message-State: ALoCoQngV3vHhdvQsl1brTmjAj6RqPXt1b/UR3rotdSvjQPxbq7HYfhpNVexLkJ0pdxfJvu6d54Y
X-Received: by 10.42.128.84 with SMTP id l20mr7303712ics.21.1430040352338;
 Sun, 26 Apr 2015 02:25:52 -0700 (PDT)
Received: by 10.36.6.8 with HTTP; Sun, 26 Apr 2015 02:25:52 -0700 (PDT)
X-Originating-IP: [90.58.122.223]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267828>

Hello,

Seem to be a bug.

OSX 10.10.3 git 2.3.6 HFS+ case-sensitive

How to reproduce :
Step 1 : git clone https://github.com/begeric/FastParsers.git
Step 2 : cd FastParsers/
Step 3 : git filter-branch --env-filter 'if [ 0 = 1 ]; then echo 0; fi' -- --all

Result on OSX :
Rewrite 65df7c5ac1ed956252b07b8c911ad7eba0a15c2b (206/206)
Ref 'refs/heads/experiment' was rewritten
Ref 'refs/remotes/origin/experiment' was rewritten
WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
Ref 'refs/remotes/origin/master' was rewritten

Result on Debian :
Rewrite 65df7c5ac1ed956252b07b8c911ad7eba0a15c2b (206/206)
WARNING: Ref 'refs/heads/experiment' is unchanged
WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
WARNING: Ref 'refs/remotes/origin/master' is unchanged

Do you have any thoughts on this ?

Thanks.
