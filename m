From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: What are branches?
Date: Tue, 21 Apr 2009 15:41:55 +0400
Message-ID: <20090421114155.GK25059@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net> <20090420132414.GD25059@dpotapov.dyndns.org> <49EC7E3B.9050909@drmicha.warpmail.net> <20090420184048.GF25059@dpotapov.dyndns.org> <7viqkzdoua.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 13:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwEOT-0006di-IV
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 13:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbZDULm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 07:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753598AbZDULm1
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 07:42:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:47097 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbZDULm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 07:42:27 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2388519rvb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 04:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=t8am2Bt3OFt6p3xrtk0SPefq3XELmHaWshyk0Pu/jTk=;
        b=o/jFDMk1dXiRry0QoFCiozWk4ZMydqrQJOB4CzcKTeliMXe/BHkqi7g1s8KN8VlPNv
         iHo20mCMqGYbiSnZf+lQllqjb5E+G8/VyAeHzKLDWgnaooRTxAOrVVkTNrhd5AGiQ0F0
         MPWDl1tIoaJGJu1zX40P6znBegdnLOOxKpZEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RBJPdwwuhzkx3QF55yivq4LmX7ACKQ9hbDfR6NHU/a1YM85RRaJ+U+jOTXwDuQ13ll
         BGBgADyGhNKp8HEjqUYsZUcmPxQbSQzlE2GNRtnApnV1LfiTcg+UtxkMYi2TPV1OEErf
         TpBKA0RwXN5IqYIQnFOh9a8x18f2g1NBkhG28=
Received: by 10.115.48.12 with SMTP id a12mr3913401wak.167.1240314145912;
        Tue, 21 Apr 2009 04:42:25 -0700 (PDT)
Received: from localhost (ppp91-78-51-18.pppoe.mtu-net.ru [91.78.51.18])
        by mx.google.com with ESMTPS id t1sm26489980poh.4.2009.04.21.04.42.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Apr 2009 04:42:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7viqkzdoua.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117122>

On Mon, Apr 20, 2009 at 01:58:37PM -0700, Junio C Hamano wrote:
> 
> However, especially after I fast-forward my branch tip to M and continue
> building on it, it is more useful to treat Dscho's topic as the side
> branch that was merged to my mainline that had your patches, for the
> purpose of most people.  Your "first parent" rule does not match that
> expectation.

Yes, it does not work here. However, fast-forward merge is not a real
merge (though it is often very useful, because it avoids useless commits,
yet, it is clearly Git specific thing). Still, what you describe is not
very like to happen in practice, because it usually takes some time for
any branch to "graduate" to master, and in meanwhile some other branches
get merged, so it is not very likely to be fast-forward (and some people
always prefer to merge anything to master with --no-ff).

> 
> If we made it easy for Dscho to create the merge M to record my tree as
> the first parent, you _could_ make the "first parent" rule to be more
> meaningful than it currently is, but without it, it still is merely one of
> the heuristics as people suggested in this discussion.

Agreed. It is merely a heuristic unless it is not reinforced (like using
--no-ff merges to master), but still it is a very good heuristic for most
practical purposes, and it even can be improved based on merge messages.


Dmitry
