From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git apply fails to apply a renamed file in a new directory
Date: Thu, 25 Oct 2007 23:41:19 +0200
Message-ID: <20071025214119.GC15292@uranus.ravnborg.org>
References: <20071025180737.GA13829@uranus.ravnborg.org> <20071025213038.GC11308@steel.home> <20071025213523.GD11308@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 23:39:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlAQo-0005NR-He
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 23:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbXJYVjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 17:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbXJYVjp
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 17:39:45 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:56948 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650AbXJYVjo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 17:39:44 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 926A88013B8;
	Thu, 25 Oct 2007 23:39:43 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 03AB6580D2; Thu, 25 Oct 2007 23:41:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071025213523.GD11308@steel.home>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62379>

On Thu, Oct 25, 2007 at 11:35:23PM +0200, Alex Riesen wrote:
> Alex Riesen, Thu, Oct 25, 2007 23:30:38 +0200:
> > Sam Ravnborg, Thu, Oct 25, 2007 20:07:37 +0200:
> > > I just stumbled on what looks like a simple bug in git apply.
> > > I had following diff:
> > > 
> > > diff --git a/arch/i386/defconfig b/arch/x86/configs/i386_defconfig
> > > similarity index 100%
> > > rename from arch/i386/defconfig
> > > rename to arch/x86/configs/i386_defconfig
> > > diff --git a/arch/x86_64/defconfig b/arch/x86/configs/x86_64_defconfig
> > > similarity index 100%
> > > rename from arch/x86_64/defconfig
> > > rename to arch/x86/configs/x86_64_defconfig
> > > -- 
> > > 1.5.3.4.1157.g0e74-dirty
> 
> .1157...-dirty. Your git looks heavily modified. Could you try with a
> something like master of kernel.org?
I guess I still have Linus' rename stuff added - will update.

> 
> Mine is based off d90a7fda355c251b8ffdd79617fb083c18245ec2
> (builtin-fetch got merged).
> 
> > > When trying to apply this diff using:
> > > git apply -p1 < .../patch
> > 
> > works here. Don't use -p1, it is assumed
> > 

It seems to be a picnic[*] bug - at least I cannot reproduce it.
Sorry for the noise but thanks for testing.

[*] Problem In Chair Not In Computer


	Sam
