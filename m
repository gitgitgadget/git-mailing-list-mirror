From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@swipnet.se>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Thu, 26 Mar 2009 22:39:07 +0100
Message-ID: <20090326213907.GC27249@jeeves.jpl.local>
References: <20090321154738.GA27249@jeeves.jpl.local> <200903212055.15026.j6t@kdbg.org> <20090324215416.GB27249@jeeves.jpl.local> <49CB2BA5.1070100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 22:40:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmxJe-00017T-BY
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756520AbZCZVjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbZCZVjO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:39:14 -0400
Received: from proxy2.bredband.net ([195.54.101.72]:35272 "EHLO
	proxy2.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbZCZVjN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 17:39:13 -0400
Received: from ironport.bredband.com (195.54.101.120) by proxy2.bredband.net (7.3.139)
        id 49CB85570002EAE4 for git@vger.kernel.org; Thu, 26 Mar 2009 22:39:10 +0100
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvQsAEuTy0lT4/BMPGdsb2JhbACBUJQnAQEBAR4XC74wg3cG
X-IronPort-AV: E=Sophos;i="4.38,428,1233529200"; 
   d="scan'208";a="500868077"
Received: from ua-83-227-240-76.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.240.76])
  by ironport1.bredband.com with ESMTP; 26 Mar 2009 22:39:09 +0100
Received: from jeeves.jpl.local (jeeves.jpl.local [192.168.7.3])
	by elwood.jpl.local (Postfix) with ESMTP id EFE2F4229F
	for <git@vger.kernel.org>; Thu, 26 Mar 2009 22:39:08 +0100 (CET)
Received: by jeeves.jpl.local (Postfix, from userid 100)
	id A067D3C2D; Thu, 26 Mar 2009 22:39:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49CB2BA5.1070100@viscovery.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114830>

On Thursday, March 26, 2009 at 08:15 CET,
     Johannes Sixt <j.sixt@viscovery.net> wrote:

> Magnus B=E4ck schrieb:
>
> > From what I gather the problematic conversion takes place in
> > the Win32 layer, in which case we might be able to call the
> > ZwQueryDirectoryFile() kernel routine directly via ntdll.dll
> > to obtain the file times straight from the file system. Has
> > anyone explored that path, and would it be acceptable to make
> > such a change?
>
> It depends.
>
> The disadvantages are that this function is only available on
> Windows XP and later and that it is not present in the header
> files of MinGW gcc.

I'd be very surprised if ZwQueryDirectoryFile() hasn't always
been around (I just verified ntdll.dll from NT 4.0), so that's
not a worry. Don't know why MSDN reports it as introduced in XP.

> It's on you to prove that there are advantages that clearly
> outweigh these disadvantages.

All right, I'll see if I can find time to take a look at this.
I just wanted to check that it wasn't a project policy or whatever
to bypass Win32.

--=20
Magnus B=E4ck
baeck@swipnet.se
