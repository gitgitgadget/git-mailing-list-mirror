Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A53C433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F218B64EAE
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 21:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCNVRa convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 14 Mar 2021 17:17:30 -0400
Received: from elephants.elehost.com ([216.66.27.132]:50363 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNVR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 17:17:29 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 12ELHOEr079690
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Mar 2021 17:17:25 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Christian Strasser'" <christian@avr-fun.de>,
        <git@vger.kernel.org>
References: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
In-Reply-To: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
Subject: RE: Git install crashed nearly whole System
Date:   Sun, 14 Mar 2021 17:17:18 -0400
Message-ID: <00a701d71917$6d624d20$4826e760$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJAx1mv459/G8WhnKv5Co6S+gnuLamwnT2A
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 14, 2021 2:24 PM, Christian Strasser wrote:
> Subject: Git install crashed nearly whole System
> I installed Git yesterday on my system. For that I used “sudo apt-get install
> git-all”.  During the installation a lot of very important packages got removed!
> It was horrible, and I couldn’t use my gnome desktop environment at all! A
> lot off dependencies got lost!
> Fortunately, I could save my system through read out the information about
> removed packages from the apt history.
> 
> Today I totally removed git and tried to install everything again with the same
> instruction. The same misbehavior did happen!
> 
> For more information I added the history as an attachment to this email.
> 
> Information about my system:
> 
> Kernel          : Linux 4.19.0-14-amd64 (x86_64)
> Version         : #1 SMP Debian 4.19.171-2 (2021-01-30)
> C Library       : GNU C Library / (Debian GLIBC 2.28-10) 2.28
> Distribution    : Debian GNU/Linux 10 (buster)
> 
> Gnome           : Version: 3.30.2-11~deb10u2 (apt-cache show gnome-
> shell  grep Version) -> 3.30.2

I think it might be appropriate to report this to the apt team. The links can be found here: https://help.ubuntu.com/community/PackageManagerTroubleshootingProcedureshould

I just (2021 Mar 03 2115Z) ran apt-get update and apt-get upgrade git. Yes, it did upgrade a whole lot of packages, including ansible, git, syslog, openssh, and many others. The apt manager for ubuntu only appears to know about git 2.7.4. You might have to add the git-core repository using: add-apt-repository ppa:git-core/ppa -y

After I added that, then ran apt-get upgrade git, I am now on git 2.29.0. Granted this is Ubuntu, not Debian, but apt should be ok. I'm not sure about the "git-all" package. I have never used that one (not is it certified at my place - just "git" is).

Regards,
Randall

