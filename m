From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [RFC PATCH 0/4] Teach git fetch to verify signed tags
	automatically
Date: Thu, 27 Nov 2008 19:18:25 -0500
Message-ID: <20081128001825.GA29662@euler>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu> <alpine.DEB.1.00.0811241140280.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 28 01:20:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5r5L-00020k-Sy
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 01:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbYK1ASf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 19:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbYK1ASf
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 19:18:35 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:37532 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbYK1ASe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 19:18:34 -0500
Received: by yw-out-2324.google.com with SMTP id 9so505709ywe.1
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 16:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=icpoy51Ql5qz130IixaZhHhFbghgOQWJdHYAk2oaz/0=;
        b=j2aYLVS9xyRCMyaVBI3hoRA5Qd5OPIj8pFURZY+TChEtnu+EOn95VEUdZuVhYISgm1
         7wHoNxm0QTEB1TLEkSJeLZOHFSb0m4VfBwC11uzreMMHowrgrNhJtWr6zKsq94RYE0WH
         xwF88DgePrEfOQO+jHGiea0jKau2N2RKlRSRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=a9W6hqamxNn28tac7MfJQBC3Q/tqDcLN/5SDi5/tn2QOmFJD38FiIP/rWhkBM8B8gw
         GFVnCwe5puJnshtLh8uLyOOTW9t+zC9X4zr6YPvwHbK/OY8FU06gCfAaAOhhQK+V6Vlb
         qvcwLc/qclwkMO7pMI6psNp57ocYEH0HE0nwE=
Received: by 10.65.84.15 with SMTP id m15mr8019688qbl.54.1227831512806;
        Thu, 27 Nov 2008 16:18:32 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id p6sm810304qbp.17.2008.11.27.16.18.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 16:18:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811241140280.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101847>

On Mon, Nov 24, 2008 at 11:41:27AM +0100, Johannes Schindelin wrote:
> On Sun, 23 Nov 2008, Deskin Miller wrote:
> 
> > -What to do if a tag is found to have a bad signature?
> 
> Or even worse: if the public key was not found?  In dubio pro reo, they 
> say, but OTOH you asked to verify the signatures...

I don't see how not finding the public key is `worse' than a bad
signature.  Compared to what the user learns currently when they run git
fetch and receive new signed tags, the case of not having the required
public key leaves them in exactly the same state: the user does not know
whether the signature is valid or not.

The user didn't ask to verify, as I see it; rather, they asked git to
*try* to verify.  If that fails in a way they don't expect, they're free
to investigate further with git tag -v for situations like not having
the right public key.

Deskin Miller 
