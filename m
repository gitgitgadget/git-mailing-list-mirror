Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8C7C7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 08:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjC0Iek (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 04:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjC0IeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 04:34:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B287ED3
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 01:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679905725; i=johannes.schindelin@gmx.de;
        bh=ludUiiZhnpuAvRN1IyAzP5dSl1oXpsJ0Ygbb+SFasos=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=pwHL9ze+jzYNG0j/7J79PqrnRZ4jUqo936Kruweac2HpWFdiEBAUzSJC+cJ/M+yp9
         d//VTuka8ypQP3JfLcw4k88DsnCyPDUESm/B8yXod0wO0yR6akdXsDfgqGf4POi8m0
         xkKAG5jGmHlbW+oejAoQRswldkJpmJ/vHeTpjYVhuCZ0StMA/JMH6j9/6vvLWHARKl
         Sar9u3zR+kbrBrXz4o108KWoFo6Nri7Mw7VOnIl8wtG73pYvQKzfAzWt7XjMrkO+9A
         hgfJtHPpYdKb6BDcCuYV4i/GwBo/DPPTBAlVF942Zv+GR9omjO3E1VpvmCUqFeNWpG
         nqI2hVQZvkE6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZkpb-1pvEgU3327-00WpZJ; Mon, 27
 Mar 2023 10:28:45 +0200
Date:   Mon, 27 Mar 2023 10:28:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     "L2750558108@outlook.com" <L2750558108@outlook.com>
cc:     git <git@vger.kernel.org>
Subject: Re: When using git commit in a path with spaces, it prompts Cannot
 read "xxx": No such file or directory
In-Reply-To: <BY5PR14MB35605DDFA6C7F6CD9DF89202B1A09@BY5PR14MB3560.namprd14.prod.outlook.com>
Message-ID: <ca58a4a2-dd73-26f5-9d2f-13a658bbaa9b@gmx.de>
References: <BY5PR14MB35605DDFA6C7F6CD9DF89202B1A09@BY5PR14MB3560.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:B4n63eOmhpW9BcZYns5OgT/Tco16n0ryWFwCNSU1MlmKT3eB7q+
 1Lti59dBqxTfmhXP+7wDnui1imeEyBrfIV9uP7c4ZlBy3s9AjsOvINbPjFM05lWk5OFtSnY
 EHrNR6pTB0vdCihA/i6o518ITdck+j4lmkCs7xbNI7ZDDpBQOFwWo5mcYUpaC2zdVl5/EGj
 OfXjVIbj808WmqEDBOnGg==
UI-OutboundReport: notjunk:1;M01:P0:NBbx275dVVQ=;loOQ7UeoKpIYtNbiyW7XRuim2Vj
 6z1dyCN0mDn3rFKGanTfc9gGAtL/JxCuPwV8sFGDUJnV76Odp40FtCpinskyBqCakm8tu7NfY
 iRbZL3K1GwdTFhHClXNWNzIcNhCRgE544jQ7bfP9X0wRYMMq+VhG17tb0p0Od+Gium/TzboG6
 fmxHUOTWFBAZwjF2+R8dFJJ4UY1Vbe9vTgMFkohQw7UYy2wlBu+6HznC5mA9sIa4QKJuxRyDx
 uYpmBWQ+PTpvf2HGolXLFVeL+J1uqW6RyIvkC7p4egectl2biv/o9XhpkvjkLxDGNYsf0PRs0
 38PurFWJSpQnLKtnOLd4LoTV06ns4xEFlOIAEW79uAVY+TG/vWapsDm9LQyWL7LNmO0zY2nD5
 JNv+fJ8i9KLv0mrCgecz6C4e5FY3DopctXn+W/QzYnUkDI4lSTTeyirZMsHCqwf4WF34kvcRQ
 /SwFCaCw8XiAyY06vxaWljpfDZ6vP8HVwG8d6r+hCio+aBchENug1CqXHttCAkBKt3U0Pq6F1
 8PxCYyN1WcrJo0/qayfH9giHdX+TTTjiOMbXu+SufPznCuAhdgUY3+MzNDKJqv6BRIBIfiGPJ
 g6bjwBZkxNcxmO+Rbp5kZfEyP3FbfiqtdbfRjmhBAHw3lDRbxCOSlezX2ZjjlwxfLTKJcfhIG
 1tWf5rI8R4l7L5ylqzwsi3p7rgChzWGSgDradsanMQ/do2STTMvb9EZWFrV8fybMk/DAhlG08
 4k149Peg5H/Pf6B0XfKhEPKk0lTCevL56QSnppg2B0o8d4FRzNVTyEbW7t9VcT/dbXb8xb/fX
 gd+4sVNuvUQpOUOg78yex/skkGqO9ciYmIXnsw0HI/juX8EXcQ2Fyp9971z8LRsM3Uev6CQBS
 ud4SJX/hqvSFUWUvZa4hSVLNpzXjD3WCy5yx9nOmAslxwxhEKPmyJbsc+s/ZSaqbqreNYhkKY
 EYI2UA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 17 Feb 2023, L2750558108@outlook.com wrote:

> In Windows
> When using git commit in a path with spaces, it prompts Cannot read "xxx=
": No such file or directory
>
> Reduce:
> 1.Init a respository at "C:/te st";
> 2.cd "C:/te st"
> 3.git add .
> 4.git commit
> 5.fatal: could not read 'C:/te': No such file or directory

I suspect that your Git version is basically super old, but I cannot know
for sure because vital information has been omitted from this bug report.

And I cannot reproduce (this was done in a PowerShell window):

	PS C:\> git init "te st"
	Initialized empty Git repository in C:/te st/.git/
	PS C:\> cd "te st"
	PS C:\te st> git add .
	PS C:\te st> git commit
	On branch main

	Initial commit

	nothing to commit (create/copy files and use "git add" to track)
	PS C:\te st> git commit --allow-empty -m "works!"
	[main (root-commit) 0d51f36] works!
	PS C:\te st>

In other words, Git has no problem with the space in the working
directory's path.

Ciao,
Johannes
