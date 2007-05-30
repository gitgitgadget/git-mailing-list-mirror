From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Make git-k an alias to gitk
Date: Wed, 30 May 2007 09:06:26 +0200
Organization: eudaptics software gmbh
Message-ID: <465D2272.3383501C@eudaptics.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500>  <f3a2ke$9s7$1@sea.gmane.org>
	 <465C064F.B9CE9379@eudaptics.com>  <465C1252.9020801@trolltech.com> 
	 <Pine.LNX.4.64.0705291305540.4648@racer.site>  <465C2516.7040607@trolltech.com>
	  <Pine.LNX.4.64.0705291446170.4648@racer.site>  <465C3502.BE134BC9@eudaptics.com>
	  <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com> 
	 <465C4B0E.C34795B@eudaptics.com> <fcaeb9bf0705291145q6a0d276o6a94ded3c3e0b6d1@mail.gmail.com> <Pine.LNX.4.64.0705300402050.4011@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 30 09:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtIFX-0000WV-HQ
	for gcvg-git@gmane.org; Wed, 30 May 2007 09:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbXE3HFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 03:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbXE3HFd
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 03:05:33 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:9300 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbXE3HFc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 03:05:32 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HtIFP-0000wK-9I; Wed, 30 May 2007 09:05:31 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 175754E9; Wed, 30 May 2007 09:05:31 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.044
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48749>

Johannes Schindelin wrote:
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> On Tue, 29 May 2007, Nguyen Thai Ngoc Duy wrote:
> 
>         > On 5/29/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
>         > > pointy..clicky..pointy..clicky  (aka: cp gitk git-k)
>         > >
>         > > $ git k
>         > >
>         > > :)
>         >
>         > Maybe we should teach git.c to try gitk if git-k is not found ;)
> 
>         Something like this?
> 
> +static int cmd_gitk(int argc, const char **argv, const char *prefix)
> +{
> +       return execv("gitk", (char *const *)argv);
> +}
> +

This does not work. Windows's execv() does not know how to invoke shell
(or tcl) scripts. Only execve() does, because we have our own
implementation.

I'd prefer to install gitk under both names gitk and git-k (as hard
links; which would amount to copies on Windows, but we don't care).

-- Hannes
