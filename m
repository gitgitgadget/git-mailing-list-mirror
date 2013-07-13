From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Sat, 13 Jul 2013 01:28:16 +0100
Message-ID: <CAOpHH-UBRJ08KEnUdGMy6F3eqUkUWSsnuDCCciUOHsg+4TpM2w@mail.gmail.com>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
 <CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
 <loom.20130705T195116-413@post.gmane.org> <CAHCaCkLpobqTOUMeK2TP_=VkjRo4P3-dMwt85_CaasSuRNE1Kg@mail.gmail.com>
 <CAOpHH-WAjjaa3oOXje3u5bBWb=vm-2wG1KYf8oKwH__XLK4R2A@mail.gmail.com>
 <CAHCaCkJDNqhd0UqnZhrA13V=J_yJBr17BuWohjMRADCPYFiQ4Q@mail.gmail.com>
 <CAHCaCkL=ghxktJHDEVPfn73o-6oPQnXQv1NBCwxkwsM==-bQ4A@mail.gmail.com>
 <CAOpHH-WiH8K__Wm_0WmnDpY8OKMWVz5-sOQWZ1vtb0GPJ44USQ@mail.gmail.com>
 <CAHCaCkL6p2ha-8yj4x0G5NodwSdupftCDO4Rst0WTLBRdK2PcA@mail.gmail.com>
 <CAHCaCkJ1rTj3xt4_rHEYTWzRbSDVnULwfkTggevn+qjLj_UC5A@mail.gmail.com>
 <CAOpHH-WxOhfYYOY8z5rc+O1B5QD8g22L9DFrNFEAtp9YwH+V_A@mail.gmail.com> <CAHCaCkJDWTKQk4SrspXVCsCoHStRTaR_PSEgkvqwWHdmiLuY2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pete Wyckoff <pw@padd.com>, Git Mailing List <git@vger.kernel.org>
To: Matthieu Brucher <matthieu.brucher@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 02:28:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxnhj-0004yk-D4
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 02:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946Ab3GMA2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 20:28:47 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:62222 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab3GMA2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 20:28:46 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so21539268iea.4
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qDwbiGqQtWQDk2Xo3hHdrr+eX2+jcoEIEVI3LhAlXdA=;
        b=iPg8crBDaByYwL/JGKjVN4ZBSnNA9Ppr+hTJgMSlJZ26LdBq4CSge80sjlxlO2nNuV
         B+wFFW3k2x2PPelTJbcxjpEbGj9vR4O9Z0EVIslOkWd3xt8bcUgoL3OElv5k0gEYmQj1
         E/eIzqYYmgXSVVNmxl1rqI/8kQFAwZLxyLvzr6Laz72m2FAFUIlxEDRqaIiv1O5FdwHY
         X0NUllFi36d7agqEZKSwiwGoWSGejvyznabDKDhGr4ZlPYjVeIWsAzExhL+zL1hC3eZ5
         xKxZiHFN62fWMGsOzb6FLWcM2wXHcfAcvpKn7c+EZKnBaJ1tbOXcrTlEwjkJvcQVnzef
         d64g==
X-Received: by 10.50.11.102 with SMTP id p6mr1665512igb.49.1373675326348; Fri,
 12 Jul 2013 17:28:46 -0700 (PDT)
Received: by 10.64.21.103 with HTTP; Fri, 12 Jul 2013 17:28:16 -0700 (PDT)
In-Reply-To: <CAHCaCkJDWTKQk4SrspXVCsCoHStRTaR_PSEgkvqwWHdmiLuY2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230268>

On Mon, Jul 8, 2013 at 3:03 PM, Matthieu Brucher
<matthieu.brucher@gmail.com> wrote:
> Hi,
>
> I tried without spec, but then it tried importing everything, even
> though there was a .gitignore and a .git/config/exclude file.
> Then, it crashed during the importation because it could find an old
> branch (I don't have access to everything on the repository), so I
> tried importing just the recent past, but then it failed because it
> identified a branch names Branch/Main/src...
> It is starting to feel as if I will have to compromise between
> something that works but without branches and without the proper names
> (the files are named Project/Branch/Main/...) or having the proper
> names, but with all binaries, bogus branches...
> I know it is not due to git, it is mainly that Perforce and git have
> very different workflows. Or perhaps with any luck, the server is up
> to date, and I can find a way of using Perforce's bridge.

Hi Matthieu,

I created a simple test case where I added a file to one of the branches in
P4 but excluded it in the client spec. During synchronization git p4
correctly ignored it.

Please check which git version you are using. It is possible the issue you
are experiencing was fixed in a more recent version.

Also, if possible, please try creating a simple test case that replicates
your issue (p4 and p4d are free to use when the repo is only used by one
person). If you record the commands you used and share them with me I will
be able to better check this issue on my side.

Cheers,
Vitor
