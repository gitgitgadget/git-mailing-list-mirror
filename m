From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 22:27:26 +0200
Message-ID: <20070829202726.GC11824@steel.home>
References: <1188319608.6106.63.camel@beauty> <200708291005.08795.andyparkins@gmail.com> <20070829095202.GE1219@pasky.or.cz> <200708291356.33126.andyparkins@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Josh England <jjengla@sandia.gov>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 22:27:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQU8V-0008OV-Ja
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 22:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbXH2U13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 16:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbXH2U13
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 16:27:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:64980 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbXH2U12 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 16:27:28 -0400
Received: from tigra.home (Fc9fa.f.strato-dslnet.de [195.4.201.250])
	by post.webmailer.de (klopstock mo33) (RZmta 12.1)
	with ESMTP id c0349cj7TI2U5r ; Wed, 29 Aug 2007 22:27:26 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 84FB8277BD;
	Wed, 29 Aug 2007 22:27:26 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 599A3BE06; Wed, 29 Aug 2007 22:27:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200708291356.33126.andyparkins@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAciAx4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56977>

Andy Parkins, Wed, Aug 29, 2007 14:56:32 +0200:
> On Wednesday 2007 August 29, Petr Baudis wrote:
> 
> > But overally, I'm still not convinced that there is a feasible use-case
> > for the cloned hooks at all. Someone has a particular example?
> 
> Hits me all the time.
> 
> 1) Start a new project
> 2) Install a pre-commit hook that checks that every patch meets some
>    arbitrary coding standard
> 3) Clone to laptop
> 4) Kick self the first time you make a commit that doesn't adhere to coding
>    standards that would have been enforced by the hook script.
> 
> The problem is that my brain thinks that cloning gets me the same 
> configuration as the source, but obviously it doesn't and I forget that I 
> need to clone _then_ scp .git/config and .git/hooks/*.
> 
> I understand that these things are a security risk to do automatically, and I 
> don't think I'd advocate that.  However, it would be useful to be able to 
> grab those files as well.

It is just a case for "git clone --clone-templates" (which does not
exist yet), not for a clone hook.

Sometimes, I miss the cloning of .git/description, it probably should
be something like: "git clone --clone=templates,config,description".
Where config could include a predefined set of harmless config options
(like colors or i18n).
