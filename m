From: Luben Manolov <luben.manolov@gmail.com>
Subject: Re: Preemptive EOF when pushing (using Msys git and PuTTY)
Date: Wed, 13 May 2009 11:30:33 +0300
Message-ID: <4A0A8529.9010009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: hendeby@isy.liu.se
X-From: git-owner@vger.kernel.org Wed May 13 10:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49rY-0000lv-C7
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 10:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbZEMIao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 04:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbZEMIal
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 04:30:41 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:53074 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbZEMIak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 04:30:40 -0400
Received: by bwz22 with SMTP id 22so484272bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 01:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=K4fB1jsVvKGsJbL9TktxfMhHOGkRxm+XP7UWpjn1kWI=;
        b=vF9xvud/eQdaFpNV/x+4SphzfbMV8f7s/ODPNY8ZeGD/EJjIw4vo6Ik9U33mtIEwA4
         hdkaZXYQIraRrHMKvcGRerHbjY8pUprGFWnKHwdVWDVcsojGHnuCZ2EXnjumsX+YHUJp
         TBGTDXg3NpzM5R9lvwETUrFPLnXvBXMtWcMw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=LIiwhhJjT5/EoJRNjQefged3IXX056KB9DY45jTHVidXQUNyC1E4Wttu/NyfneQ8au
         G9cR7MvQl4/StfrP/fkAjZZYwIpJm4ndSsw+tBpGerMEShbtr0xIlWyXxOyIa8UrBlbd
         uTZ5puJIUl53ml7Sn18waQuWRPojtAzmBoq5o=
Received: by 10.204.8.84 with SMTP id g20mr653668bkg.167.1242203439410;
        Wed, 13 May 2009 01:30:39 -0700 (PDT)
Received: from ?0.0.0.0? (paramount.dreamhost.com [64.111.112.10])
        by mx.google.com with ESMTPS id c28sm1341889fka.2.2009.05.13.01.30.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 01:30:38 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119004>

Hi Gustaf,

I had exactly the same problem, which you have described below. We are 
using MsysGit 1.6.3 and plink on Windows. The solution in our case was 
to start using OpenSSH (the version from msysgit) instead of PuTTY/plink.

Best regards,

Luben

> Hello everyone, and thanks for all your dedicated work with git.
> 
> I have used git for quite some time now, mainly on different Linux
> platforms, without any problems.  Recently we convert the office's pet
> project from svn to git.  Many people at the office use Windows (Msys
> git 1.6.2 and plink), and I have stared to see (only from Windows
> people) problems when pushing similar to the following:
> 
> Counting objects: 422, done.
> Compressing objects: 422, done.
> Writing objects: 100% (379/379), 77.77 KiB, done.
> Total 379 (delta 310), reused 371 (delta 303)
> fatal: early EOF
> error: unpack failed: index-pack abnormal exit
> To jkoehler <at> serv-4100:/git/argos.git
>  ![remote rejected] jk/ellipseFit -> jk/ellipseFit (n/a (unpacker error))
> error: failed to push some refs to
> 'jkoehler <at> serv-4100:/git/argos.git'
> 
> There seems to be no problem with the repo, neither local nor remote,
> but for a specific setup the problem is reproducible on several Windows
> machines, but if I move the whole local repo to a Linux machine instead
> the problem is gone.
> 
> I suspect the problem is that a ^Z EOF gets embedded in the pack to be
> transported, and that somehow interacts poorly with PuTTY, but that is
> just my guessing.  And if so I don't know how to handle it.
> 
> Has anyone experienced anything similar?  If so, is there any simple fix
> to the problem?  How would I go about to try to debug this?
> Unfortunately, this seems to happen on a regular basis and affects the
> git experience in a negative way, so I would be really happy to be able
> to resolve the problem.
> 
> I'm thankful for any help that I can get.
