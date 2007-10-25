From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git apply fails to apply a renamed file in a new directory
Date: Thu, 25 Oct 2007 23:35:23 +0200
Message-ID: <20071025213523.GD11308@steel.home>
References: <20071025180737.GA13829@uranus.ravnborg.org> <20071025213038.GC11308@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 23:35:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlAMd-0004MJ-4i
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 23:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbXJYVf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 17:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbXJYVf0
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 17:35:26 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:30099 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbXJYVfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 17:35:25 -0400
Received: from tigra.home (Fadec.f.strato-dslnet.de [195.4.173.236])
	by post.webmailer.de (mrclete mo47) (RZmta 14.0)
	with ESMTP id K01bffj9PIA3uT ; Thu, 25 Oct 2007 23:35:23 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A5E96277AE;
	Thu, 25 Oct 2007 23:35:23 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 82B3756D22; Thu, 25 Oct 2007 23:35:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071025213038.GC11308@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClJ2mEU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62377>

Alex Riesen, Thu, Oct 25, 2007 23:30:38 +0200:
> Sam Ravnborg, Thu, Oct 25, 2007 20:07:37 +0200:
> > I just stumbled on what looks like a simple bug in git apply.
> > I had following diff:
> > 
> > diff --git a/arch/i386/defconfig b/arch/x86/configs/i386_defconfig
> > similarity index 100%
> > rename from arch/i386/defconfig
> > rename to arch/x86/configs/i386_defconfig
> > diff --git a/arch/x86_64/defconfig b/arch/x86/configs/x86_64_defconfig
> > similarity index 100%
> > rename from arch/x86_64/defconfig
> > rename to arch/x86/configs/x86_64_defconfig
> > -- 
> > 1.5.3.4.1157.g0e74-dirty

.1157...-dirty. Your git looks heavily modified. Could you try with a
something like master of kernel.org?

Mine is based off d90a7fda355c251b8ffdd79617fb083c18245ec2
(builtin-fetch got merged).

> > When trying to apply this diff using:
> > git apply -p1 < .../patch
> 
> works here. Don't use -p1, it is assumed
> 
