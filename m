From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Question on git-filter-branch
Date: Thu, 1 Nov 2007 15:20:51 +0100
Message-ID: <20071101142051.GB14475@steel.home>
References: <18217.52425.655322.52338@lisa.zopyra.com> <20071101125845.GA27567@glandium.org> <18217.53833.710503.667761@lisa.zopyra.com> <20071101133440.GA17239@glandium.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 15:21:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inav0-0008If-DL
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 15:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbXKAOU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 10:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbXKAOU4
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 10:20:56 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:62017 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbXKAOUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 10:20:55 -0400
Received: from tigra.home (Fc985.f.strato-dslnet.de [195.4.201.133])
	by post.webmailer.de (mrclete mo12) (RZmta 14.0)
	with ESMTP id N01b27jA1AkNpf ; Thu, 1 Nov 2007 15:20:51 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A293E277AE;
	Thu,  1 Nov 2007 15:20:51 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 379E756D22; Thu,  1 Nov 2007 15:20:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071101133440.GA17239@glandium.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzATv+k0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62963>

Mike Hommey, Thu, Nov 01, 2007 14:34:41 +0100:
> On Thu, Nov 01, 2007 at 07:19:05AM -0600, Bill Lear wrote:
> > >Just remove .git/refs/original/
> > 
> > Ok, thanks.  But, how do I remove the subdirectory?
> > 
> > % rm -rf .git/refs/original
> > % git filter-branch --index-filter 'git update-index --remove sensitive_stuff' HEAD
> > Rewrite 6711f6a50605918326f67ca0c3402eab9a4c8571 (8/8)
> > WARNING: Ref 'refs/heads/master' is unchanged
> 
> git-update-index --remove will remove files, not trees, so you need to
> use something like
> git-ls-files ensitive_stuff | xargs -d "\n" git-update-index --remove
> instead.

git ls-files -z sensitive_stuff | git update-index --remove -z --stdin
