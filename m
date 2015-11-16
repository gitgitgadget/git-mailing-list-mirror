From: "Ryabov, Vasily V" <vasily.v.ryabov@intel.com>
Subject: RE: [bug] git 2.6.2 (64-bit) blocks keyboard input (running in RDP,
 Win7 x64)
Date: Mon, 16 Nov 2015 12:21:22 +0000
Message-ID: <D28D2D5A78DB8B49BB75DB10E72239683ABA2037@IRSMSX102.ger.corp.intel.com>
References: <D28D2D5A78DB8B49BB75DB10E72239683ABA1700@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.1.00.1511161308510.1686@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 16 13:21:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyIn0-0000bE-V1
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 13:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbbKPMVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 07:21:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:64480 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbbKPMVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2015 07:21:38 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP; 16 Nov 2015 04:21:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,302,1444719600"; 
   d="scan'208";a="821208174"
Received: from irsmsx109.ger.corp.intel.com ([163.33.3.23])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2015 04:21:23 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.251]) by
 IRSMSX109.ger.corp.intel.com ([169.254.13.96]) with mapi id 14.03.0248.002;
 Mon, 16 Nov 2015 12:21:22 +0000
Thread-Topic: [bug] git 2.6.2 (64-bit) blocks keyboard input (running in
 RDP, Win7 x64)
Thread-Index: AdEbwFFCHwseOB+ZR1e7k4rymJ8q8QEp3bAAAAAwYNA=
In-Reply-To: <alpine.DEB.1.00.1511161308510.1686@s15462909.onlinehome-server.info>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.180]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281336>

     Hi Johannes,

Thanks for your response.
I've already workarounded the issue by using OpenSSH.

It seems there is no simple way to configure Jenkins Git plugin to call Putty first under LOCAL_SYSTEM account, so using OpenSSH is much simpler in this case.

Best regards,
-Vasily.

-----Original Message-----
From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
Sent: Monday, November 16, 2015 3:10 PM
To: Ryabov, Vasily V
Cc: git@vger.kernel.org
Subject: Re: [bug] git 2.6.2 (64-bit) blocks keyboard input (running in RDP, Win7 x64)

Hi Vasily,

On Tue, 10 Nov 2015, Ryabov, Vasily V wrote:

> I'm trying to run something like this (on the remote machine (Win7 x64 with git 2.6.2 64-bit) through RDP):
> ```
> git pull --tags --progress 
> ssh://<username>@<repo_URL>:<tcp_port>/<repo_name> 
> +refs/heads/*:refs/remotes/origin/*
> ```
> It worked on local machine with git 1.9.5.
> 
> Git asks to confirm an action:
> ```
> The server's host key is not cached in the registry. You have no 
> guarantee that the server is the computer you think it is.
> The server's dss key fingerprint is:
> ssh-dss 1024 <...>
> If you trust this host, enter "y" to add the key to PuTTY's cache and 
> carry on connecting.
> If you want to carry on connecting just once, without adding the key 
> to the cache, enter "n".
> If you do not trust this host, press Return to abandon the connection.
> Store key in cache? (y/n)
> ```
> I'm typing `y`, but there is no reaction at all. No symbols appears in the console. But...
> When I'm pressing `Ctrl+C`, it's killed. And I can see `yyyyy` keys in the bash console for the next command.

This is a known issue, mentioned in the release notes
(https://github.com/git-for-windows/build-extra/blob/master/installer/ReleaseNotes.md#known-issues):

> * If configured to use Plink, you will have to connect with putty first
>   and accept the host key.

Ciao,
Johannes

--------------------------------------------------------------------
Joint Stock Company Intel A/O
Registered legal address: Krylatsky Hills Business Park,
17 Krylatskaya Str., Bldg 4, Moscow 121614,
Russian Federation

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
