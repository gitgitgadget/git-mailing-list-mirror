From: John Medema <john.medema@uniteddrugs.com>
Subject: Re: Bug Report: git gui clones non-master default branch as master
Date: Fri, 18 Sep 2015 12:10:24 -0700
Message-ID: <CALsXy+3gpXJx2=44N_eqcLjc7fYNbPVMKa1rERygzDoVu05iTg@mail.gmail.com>
References: <CALsXy+1p7ekshWNAvA991nWRcUUFv1zW39G2Wm=U0vvQ2O6PuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, SysAdmin <sysadmin@uniteddrugs.com>,
	IT Dev2 <john.kobinski@uniteddrugs.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:10:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd13a-0006Vw-Dg
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 21:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbbIRTKq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Sep 2015 15:10:46 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34946 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbbIRTKp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Sep 2015 15:10:45 -0400
Received: by igbkq10 with SMTP id kq10so24802771igb.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 12:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=zxZq8ZBXCV8AaZb8ekjJpabpSgg3KcJKcfvMXgWO2Ks=;
        b=XBpbp3QRXVbTAQ754DeqEXGiAJVidHxuCG0wlFkcGt7N7Y7EJntD7DFQGiJXlG+1qF
         iAHXf1+N3tOaTCtVgpyoXwc276t6gETEuCVO4UaG94t4He/nmMC2IHmNqkDxy1sarKDR
         5wUV6I/giRdBIEsUPP/XAWNwJcz8G2BMFmIgwASivZdIZCGmTvkXBgCgZbGN6Yi1Ve2z
         vIoM6UHwSxsu3DSgWPoQJGwfrWplre/GnjYAqrWa18py3eYm4Uk1WBHEECWPWVs3gRol
         y2i3DMMj9YsHFcQ2IaUDxqW3iSQWV4KfKfy5sefTj5G+lJBpouW6aaHcC9Nt30xw6aJD
         M1RA==
X-Gm-Message-State: ALoCoQmTxmH0dix45LbD8FNgEYfJt8A7FtEvApV7+2fhctPgA9VMXaTIhM9nQ9H0VrHzN8p/tawoEhlIV5pt+NR+F4vpfne4NvdUQQbxLotJkqhFUABMmtV4XBjhYf9vjjNKOeHHfj4q
X-Received: by 10.50.43.161 with SMTP id x1mr33730866igl.64.1442603444329;
 Fri, 18 Sep 2015 12:10:44 -0700 (PDT)
Received: by 10.107.135.155 with HTTP; Fri, 18 Sep 2015 12:10:24 -0700 (PDT)
In-Reply-To: <CALsXy+1p7ekshWNAvA991nWRcUUFv1zW39G2Wm=U0vvQ2O6PuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278217>

Git devs,

Can I get a confirmation that someone has confirmed this as a bug?
And that it is in a queue somewhere for eventual fixing?

Thanks,

John Medema
Systems Administrator
United Drugs, a Subsidiary of AAP (American Associated Pharmacies)
john.medema@uniteddrugs.com
7243 N 16th Street, Phoenix, AZ 85020
Office:  602-678-1179 x126
=46ax:  602-639-4631


On Thu, Sep 3, 2015 at 10:01 AM, John Medema
<john.medema@uniteddrugs.com> wrote:
> Git gurus, your assistance is needed.
>
> Environment #1:
> git version 2.5.0.windows.1
> git-gui version 0.20.GITGUI
> Windows 7 Pro 64-bit
>
> Environment #2:
> git version 1.7.9.msysgit.0
> git-gui version 0.16.GITGUI
> Windows Server 2003 R2 32-bit
>
> Environment #3:
> Linux (check with dscho, https://github.com/git-for-windows/git/issue=
s/345)
>
> Issue:
> Cloning from Git GUI when the upstream repo has the default branch se=
t
> to something other than master (say "develop") yields a local
> repository with a single branch named "master". This local master
> branch has no pull link, but it has a push link pointing to the
> origin/master, leading to a situation where a commit meant for
> origin/develop is instead pushed to origin/master. Note that this onl=
y
> happens when cloning from the Git GUI - using Git Bash creates a loca=
l
> develop branch pulling & pushing to origin/develop.
>
> To reproduce (example uses fake repo):
> 1) Open Git GUI
> 2) Click "Clone Existing Repository"
> Source Location: git@github.com:PrivateCo/mytestrepo.git
> Target Directory: c:\temp\mytestrepo
> Clone
> 3) Open Git Bash
> 4) $ cd /c/temp/mytestrepo
> 5) $ git remote show origin
> remote origin Fetch URL: git@github.com:PrivateCo/mytestrepo.git
> Push URL: git@github.com:PrivateCo/mytestrepo.git
> HEAD branch: develop
> Remote branches:
> develop tracked
> master tracked
> Local ref configured for 'git push':
> master pushes to master (fast-forwardable)
> 6) $ git branch -avv
> master 846504a 2nd test file, just for develop branch
> remotes/origin/develop 846504a 2nd test file, just for develop branch
> remotes/origin/master c2b577c initial commit with test file
>
> Workaround (creates new develop branch, wipes out bad master, and
> recreates master):
> 1) Open Git Bash
> 2) $ cd /c/temp/mytestrepo
> 3) $ git checkout -b develop --track origin/develop
> 4) $ git branch -d master
> 5) $ git checkout -b master --track origin/master
> 6) $ git remote show origin
> remote origin Fetch URL: git@github.com:PrivateCo/mytestrepo.git
> Push URL: git@github.com:PrivateCo/mytestrepo.git
> HEAD branch: develop
> Remote branches:
> develop tracked
> master tracked
> Local branches configured for 'git pull':
> develop merges with remote develop
> master merges with remote master
> Local refs configured for 'git push': develop pushes to develop (up t=
o date)
> master pushes to master (up to date)
> 7) $ git branch -avv
> develop 846504a [origin/develop] 2nd test file, just for develop bran=
ch
> master c2b577c [origin/master] initial commit with test file
> remotes/origin/develop 846504a 2nd test file, just for develop branch
> remotes/origin/master c2b577c initial commit with test file
>
>
> Let me know if you need any more information.
>
> John Medema
> Systems Administrator
> United Drugs, a Subsidiary of AAP (American Associated Pharmacies)
> john.medema@uniteddrugs.com
> 7243 N 16th Street, Phoenix, AZ 85020
> Office:  602-678-1179 x126
> Fax:  602-639-4631

--=20
HIPAA NOTICE:  It is against United Drugs=E2=80=99 policy to receive or=
 send=20
un-encrypted or non-secured email correspondence containing Protected=20
Health Information (PHI) as defined by HIPAA law.
=20
Please use fax or phone for correspondence containing PHI.

--=20
This email message is for the sole use of the intended recipient(s) and=
 may=20
contain confidential and privileged information. Any unauthorized revie=
w,=20
use, disclosure or distribution is prohibited. If you are not the inten=
ded=20
recipient, contact the sender by reply email, and destroy all copies of=
 the=20
original message.=20
