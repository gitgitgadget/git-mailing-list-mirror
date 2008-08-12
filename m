From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Help reverting a particular file
Date: Tue, 12 Aug 2008 08:15:38 +0200
Message-ID: <20080812061538.GA3824@blimp.local>
References: <3f81a4240808111600u78c5eeefu588a6b1250a0dd02@mail.gmail.com> <loom.20080811T232642-623@post.gmane.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 08:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSnBU-00013y-Lu
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 08:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbYHLGPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 02:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbYHLGPm
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 02:15:42 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:46027 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbYHLGPl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 02:15:41 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20pf4EfeSQ==
Received: from tigra.home (Fac9e.f.strato-dslnet.de [195.4.172.158])
	by post.webmailer.de (fruni mo1) (RZmta 16.47)
	with ESMTP id e017dck7C3FDEu ; Tue, 12 Aug 2008 08:15:39 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 0ACBE277BD;
	Tue, 12 Aug 2008 08:15:39 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id D01E936D1A; Tue, 12 Aug 2008 08:15:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20080811T232642-623@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92070>

Eric Raible, Tue, Aug 12, 2008 01:33:17 +0200:
> Bryan Richardson <btricha <at> gmail.com> writes:
> > 
> > Can anyone tell me how to revert a particular file using git?  I
> > executed a commit, then froze my Rails application to the latest Rails
> > version.  This caused my custom config/boot.rb file to be overwritten
> > and I would like to restore it without rolling back to the previous
> > commit (which would roll back the rails freeze).  In general I need to
> > know how to do this anyway. :)
> > 
> 
> See corresponding man page for full details, but briefly:
> 
> # Updates index as well
> git checkout HEAD^ -- config/boot.rb
> 

That'd revert it to the _previous_ commit, not the current, while he
seems to need the recently committed state in his working tree:

  git checkout HEAD -- config/boot.rb
