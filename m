From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: Val Henson's critique of hash-based content storage systems
Date: Fri, 29 Apr 2005 16:47:17 -0400
Message-ID: <118833cc0504291347ea1a3fa@mail.gmail.com>
References: <loom.20050429T015434-928@post.gmane.org>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:43:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcKC-0000bY-GE
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVD2Urm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVD2Urm
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:47:42 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:14256 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262929AbVD2UrW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:47:22 -0400
Received: by rproxy.gmail.com with SMTP id a41so620909rng
        for <git@vger.kernel.org>; Fri, 29 Apr 2005 13:47:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QHiR9vrrA6VW+ajYnytCSpKWQNDXQ6xq5GWGi/TdZzHCn+WCJliPsxGYJlYa2x0zJRyC41+j0CyvD7pX4Eor2+OanRFeVkx/KFiwiq9iFB9cnWL9pk/C7XGDDI9wb1PAN9RIVJ86IwZr3/zq3Lnoh2/d3DEF7PV/+EJzd7e/5WE=
Received: by 10.38.72.40 with SMTP id u40mr3339905rna;
        Fri, 29 Apr 2005 13:47:17 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Fri, 29 Apr 2005 13:47:17 -0700 (PDT)
To: Rob Jellinghaus <robj@unrealities.com>
In-Reply-To: <loom.20050429T015434-928@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/28/05, Rob Jellinghaus <robj@unrealities.com> wrote:
> I assume most people here have read this, but just in case:
> 
> http://www.usenix.org/events/hotos03/tech/full_papers/henson/henson.pdf

The math in section 3 is bogus.  1-(1-2^-b)^n  isn't hard to compute and
even if it was, it is the wrong formula.  (Set n==2^b; you obviously should
get probability 1 for collision.)

The right formula is 1-B!/B^n/(B-n)! where B=2^n.  For n=2^80 and b=160
you get about 39%.

Morten
