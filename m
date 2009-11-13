From: Eric Raible <raible@gmail.com>
Subject: Re: Git in next is broken
Date: Fri, 13 Nov 2009 20:20:47 +0000 (UTC)
Message-ID: <loom.20091113T211800-4@post.gmane.org>
References: <alpine.LFD.2.00.0911121513470.16711@xanadu.home> <4AFC8960.9090808@lsrfire.ath.cx> <alpine.LNX.2.00.0911122239150.6967@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0911122345450.16711@xanadu.home> <alpine.LNX.2.00.0911130910150.17726@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0911131152120.16711@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 21:21:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N92dy-0002TM-6E
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 21:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356AbZKMUVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 15:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbZKMUVG
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 15:21:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:45971 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757320AbZKMUVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 15:21:04 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N92dq-0002Q7-0L
	for git@vger.kernel.org; Fri, 13 Nov 2009 21:21:10 +0100
Received: from adsl-63-197-71-184.dsl.snfc21.pacbell.net ([63.197.71.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 21:21:09 +0100
Received: from raible by adsl-63-197-71-184.dsl.snfc21.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 21:21:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 63.197.71.184 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132842>

Nicolas Pitre <nico <at> fluxnic.net> writes:

 > diff --git a/remote.c b/remote.c
> > index 4f9f0cc..6195a58 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -754,6 +754,8 @@ void ref_remove_duplicates(struct ref *ref_map)
> >                         prev->next = ref_map->next;
> >                         free(ref_map->peer_ref);
> >                         free(ref_map);
> > +                       ref_map = prev; // Keep the same prev.
> > +                       continue;
> >                 }
> > 

This is one of those example where the comment is essentially useless.
Wouldn't something like "// Skip the freed item" be more useful?

- Eric
