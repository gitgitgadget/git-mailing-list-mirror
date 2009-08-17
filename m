From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: bbchop & Wikipedia's Bayesian search theory page
Date: Mon, 17 Aug 2009 15:46:26 +0100
Message-ID: <efe2b6d70908170746o36fca4bfy9db81a3a25878e4f@mail.gmail.com>
References: <alpine.DEB.1.00.0908161907580.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 16:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md3U9-0006qM-Gl
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 16:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbZHQOqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 10:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZHQOqs
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 10:46:48 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:56340 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbZHQOqr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 10:46:47 -0400
Received: by ewy10 with SMTP id 10so2998501ewy.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LNUxGAGqaN1r/BLhS2dAEPUgefnPfCxKO0MqS1iWFOE=;
        b=jY0gqoPk3vgLU374yFllLKr4GP5/aU2bliAcyQj3hWREZo1wa5sTrZ778XN7w2ZVit
         ETZ1+/p92DFYKFRKFiHExJ7alDxzjsQrNAXYMA1/7I2pI92E40Uu8tNgieH2g8gSPcyC
         YpuKHdv8cJBLhIFNpcCF2eM7wY4v9bzXQhTi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fljhDENsPYfnM+Np1fTSK/MgPvv10yDExkrvCBB5sQOuIGb4KgZmFclJpcbLeicIJi
         v6e3D9GD14Nko7Pfe5TUAIBMg3zQapnvVJPgWxs09EPC6Z2zmpTi3YjCGFiiVMdiXPcx
         oP/opbpS8uhCcCiSVKyihhCKX3qc6pJY79ipQ=
Received: by 10.216.15.84 with SMTP id e62mr1003044wee.207.1250520406162; Mon, 
	17 Aug 2009 07:46:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908161907580.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126190>

On Sun, Aug 16, 2009 at 6:13 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> I tried to find some documentation for Bayesian search theory, but it
> seems those ridiculous Wikipedia admins struck once again, in their
> mission to reduce the world's intellect to their own.

It looks like it is still there to me:
http://en.wikipedia.org/wiki/Bayesian_search_theory

It looks like github has included a ')' on the end when html-ifying
the link inthe README, making it into a dead link. I'll fix that.

The wikipedia article is still not amazing,though. Unfortunately most
of the online descriptions
of Bayesian Search Theory, such as:
http://www.sarinz.com/index.cfm/3,112,261/landsearchmethodsreview.pdf
seem to go heavily into the minutia of search-and-rescue, which while
interesting, is not
relevant to git.

However, although I got the idea of bbchop from search theory, it is
not necessary to know much
of search theory in order to understand bbchop. The basic algorithm is
very simple:

At each step, test the commit for which the expected gain of information (about
the location of the bug) is greatest.

That is basically all I got from search theory so far - the
calculation of the probability of the
bug existing in each location is standard bayesian probability theory,
which maybe you already
know. If not, a very readable reference is:
http://www.inference.phy.cam.ac.uk/mackay/itila/book.html (free on-line book).

So all the code does is compute N entropies and pick the best. Most of the
complexity is introduced by:
 - calculating the N entropies without calculating N^2 probabilities
 - calculations over a DAG.

Ealdwulf
