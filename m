From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] * remote.c (valid_fetch_refspec): remove useless
	if-before-free test
Date: Wed, 20 Aug 2008 21:40:02 +0200
Message-ID: <20080820194002.GC16626@blimp.local>
References: <87k5ecx2pl.fsf@rho.meyering.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <meyering@redhat.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVtYN-0003Di-Eb
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 21:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbYHTTkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 15:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbYHTTkG
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 15:40:06 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:30179 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbYHTTkE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 15:40:04 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (fruni mo18) (RZmta 16.47)
	with ESMTP id 506c7dk7KIlDG8 ; Wed, 20 Aug 2008 21:40:02 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id BE291277AE;
	Wed, 20 Aug 2008 21:40:02 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id A6CF436D18; Wed, 20 Aug 2008 21:40:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87k5ecx2pl.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93018>

Jim Meyering, Tue, Aug 19, 2008 20:46:30 +0200:
> We removed a handful of these useless if-before-free tests
> several months ago.  This change removes a new one that snuck back in.

Something used to crash in free when passed NULL. It's one of the
reasons why some cross-platform projects have xfree which does the
check (sometimes depending on platform). Admittedly, it is a long time
since I saw such a platform (some old SunOS it was, I believe).
