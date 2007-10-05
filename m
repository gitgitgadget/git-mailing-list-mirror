From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: A few usability question about git diff --cached
Date: Fri, 5 Oct 2007 06:22:18 +0100
Message-ID: <e1dab3980710042222u3e1fc21dtf4b90056fb36eaf0@mail.gmail.com>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
	 <20071004125641.GE15339@genesis.frugalware.org>
	 <7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
	 <Pine.LNX.4.64.0710041534000.4174@racer.site>
	 <vpqtzp7ndn3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Oct 05 07:29:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdfkO-0000tP-JO
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 07:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbXJEFWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 01:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXJEFWV
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 01:22:21 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:21076 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbXJEFWU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 01:22:20 -0400
Received: by py-out-1112.google.com with SMTP id u77so774456pyb
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 22:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=G+TM4JWqFMMtPdbJnio0kU7BM3VuQdmk8CW+5+RbEn4=;
        b=ENfG/+U/m7r4oh4xQPQ68zF3T/3pPE+KJMa+aL+qAne2wXaRUJbytmTdkWW/Dgussp79gaYAo1Y2Gj+pJ+N4E0yr7whM2QoO40i0IFe9weHCgHYBfcmSYWpltod/2vr9sZ7gYGnMG766Tsll5CRojW/tUPXkdc9HLgun5qge4H8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rr16phusyPumML2tEET4JyMRhQVuYncvlI2EHwALhtHcWrljnjtET0w2SJvfKLo4fl1MEX1RmWi25ktwndY3KHEUD6Cz5xkJquSg+njRJiXd2PNpLi0ey9XGvNHQuYTUoyXhdYk3rNKVTxVDgTDVM1ZUzeLFtfjViYNt6Xk7PdE=
Received: by 10.65.96.6 with SMTP id y6mr12927052qbl.1191561738424;
        Thu, 04 Oct 2007 22:22:18 -0700 (PDT)
Received: by 10.64.181.10 with HTTP; Thu, 4 Oct 2007 22:22:18 -0700 (PDT)
In-Reply-To: <vpqtzp7ndn3.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60035>

On 10/4/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> It makes more sense to me.
>
> For me, a "cache" is a fast-access copy of something, that I can
> rebuild at any time. Cache should be only a matter of performance, if
> the "cache" for an application changes its functionality, it means the
> cache has been too optimistic. Git's index is not that, "git add"
> means "add this to the index", which itself means "put that in the
> list of things to commit", and not "get a copy of that to work faster
> with it".

Just to say this interpretation is also the natural interpretation I
have for the term "cached", and it confused me no end when I was first
learning about git that the index was referred to as a cache. To be
fair, git the documentation was in flux at that time and it's now
referred too as a cache in very few places now.

An example of the kind of thing I have to think carefully about even
now, Junio said in a different mail:

"--cached means work only on the "cached information in index."

If I understand correctly, the term "cached information in index" is
more correctly "stored information in index" (or perhaps more
technically "staged information in index") since there may be
information in there which isn't a cache because it's no longer
present anywhere else (ie, not in a commit yet but also changed in the
working tree).

It's not a big thing, but the usage of cached in git still quite confuses me.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
