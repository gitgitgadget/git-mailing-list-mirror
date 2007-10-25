From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git apply fails to apply a renamed file in a new directory
Date: Thu, 25 Oct 2007 23:30:38 +0200
Message-ID: <20071025213038.GC11308@steel.home>
References: <20071025180737.GA13829@uranus.ravnborg.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 23:31:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlAIR-0003Pn-Vu
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 23:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbXJYVam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972AbXJYVam
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 17:30:42 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:27452 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbXJYVal (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 17:30:41 -0400
Received: from tigra.home (Fadec.f.strato-dslnet.de [195.4.173.236])
	by post.webmailer.de (mrclete mo61) (RZmta 14.0)
	with ESMTP id o01c41j9PL4Z6E ; Thu, 25 Oct 2007 23:30:39 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 06080277AE;
	Thu, 25 Oct 2007 23:30:39 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BBD7056D22; Thu, 25 Oct 2007 23:30:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071025180737.GA13829@uranus.ravnborg.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClJ2mEU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62376>

Sam Ravnborg, Thu, Oct 25, 2007 20:07:37 +0200:
> I just stumbled on what looks like a simple bug in git apply.
> I had following diff:
> 
> diff --git a/arch/i386/defconfig b/arch/x86/configs/i386_defconfig
> similarity index 100%
> rename from arch/i386/defconfig
> rename to arch/x86/configs/i386_defconfig
> diff --git a/arch/x86_64/defconfig b/arch/x86/configs/x86_64_defconfig
> similarity index 100%
> rename from arch/x86_64/defconfig
> rename to arch/x86/configs/x86_64_defconfig
> -- 
> 1.5.3.4.1157.g0e74-dirty
> 
> When trying to apply this diff using:
> git apply -p1 < .../patch

works here. Don't use -p1, it is assumed
