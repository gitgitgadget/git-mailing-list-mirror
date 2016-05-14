From: Joseph Musser <me@jnm2.com>
Subject: Subtree split unsquashes everything
Date: Sat, 14 May 2016 12:53:00 -0400
Message-ID: <CAKRjdd7Czj2iTKdwVCmz4x9fDNKCPZtLi=UjgHOsSPuYL_yLXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 18:53:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1cor-0006gh-8o
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 18:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbcENQxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2016 12:53:31 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38233 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbcENQxa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2016 12:53:30 -0400
Received: by mail-ig0-f170.google.com with SMTP id m9so24065771ige.1
        for <git@vger.kernel.org>; Sat, 14 May 2016 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=B1W9OivewMc188vIexfNveoxAww1NG1L7lnLlDX1gTU=;
        b=TB1NR6HS9VpcNHiAaHhCv1v+DGT/mzaAy+xQNrO/brk2VNvj6JFd/Eo5GX6Wk+MPdE
         KVr4qATe7PR/a8FwPwaaKB2NfXfVMqU9QBAiM36Vf2iPt7ft1CSW3UXZBo/755LD7Kl6
         m5MkGQaWaqgmHl9+MtYcg0m67BU0mVzQka/oJrqpR++zqME7CRRzgR2CJD0jA1+njja9
         HLMAeStXNFKQX4+OnGQJFt2+ppdl+4JX3Axhml/PyVNJUoTT+ApM/BlabJ5EtheEp6Ny
         TR183OVxclSZ521Nd5Ic4WibOgZ0dpYczinccEGilPVjaB63E61mtQCoOD0/FfmTIBek
         r+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=B1W9OivewMc188vIexfNveoxAww1NG1L7lnLlDX1gTU=;
        b=MhEqEb67CoEJ+BUMmlPOGVl7GVyqdOkhLGgVmqC2WrVsgvBQbzFtc/Jj56IhWp7eh1
         5wD+YEksP75+e5zN6wdQbeIWnXdBeaGTQ98WUT84xRe6cUWjhwTdW8j7TH9/BMlxkDhz
         CuOLbJjLFXL/yVqzWIdAGhvarJzsXwmiQViZpN5e2Vs23RXYPOSP+km9PMiI3mb3MLHJ
         6X09zCoQPI2mmaoTNb6/Ebrr71gHZth7qJG6OwisERyx8jMyO2LluBgyzc1DT5Wo2SSk
         7ddLkFsmk1pVtOuQZJbRD4wGe6tV+hL2P6rEsFXcatRc9fOIBYuuHTDqrbXqHKTQCLr1
         yfyQ==
X-Gm-Message-State: AOPr4FUtIrlTH3MWK80sNpnXt4Yo7o6P642MgYKM6251IIK7TjpdEk9l6H9QU9Ejxe8bSxkhVggF/lhd6p102A==
X-Received: by 10.50.101.200 with SMTP id fi8mr4340329igb.76.1463244809644;
 Sat, 14 May 2016 09:53:29 -0700 (PDT)
Received: by 10.64.64.36 with HTTP; Sat, 14 May 2016 09:53:00 -0700 (PDT)
X-Google-Sender-Auth: pTV6PLk_DU9s_P5pL84XLbhQi38
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294616>

Hello! I was directed to ask here; I hope I am respecting your format.

I have a repo with a subtree. I squashed every merge with the subtree
remote to keep the history manageable. Now down the road after a bunch
of merges, I need to split my repo=E2=80=99s master branch into two new
branches and move the subtree from `/subdir/subdir/` to `/`.
(`/subdir/subdir/user/mycode/` contains code from my repo.)

I ran `git subtree split -P=3Dsubdir/subdir/ -b newbranch` and the
outcome seems to be perfect except that each squash merge has turned
into a full merge, bringing along all history from the other repo. Why
does it do this and how can I preserve my repo history, including only
squashes from the subtree remote repo like it is today?

I initially asked at http://stackoverflow.com/q/36957809

Thank you.
