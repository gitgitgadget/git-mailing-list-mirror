From: Wayne Scott <wsc9tt@gmail.com>
Subject: Re: The criss-cross merge case
Date: Fri, 29 Apr 2005 07:19:18 -0500
Message-ID: <59a6e58305042905191f4eca98@mail.gmail.com>
References: <200504281425.j3SEP1H00534@freya.yggdrasil.com>
Reply-To: Wayne Scott <wsc9tt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ry102@rz.uni-karlsruhe.de, barkalow@iabervon.org,
	bram@bitconjurer.org, droundry@abridgegame.org,
	git@vger.kernel.org, tupshin@tupshin.com
X-From: git-owner@vger.kernel.org Fri Apr 29 14:14:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRUNZ-0002yF-PP
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 14:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVD2MT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 08:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVD2MTZ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 08:19:25 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:62621 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262516AbVD2MTT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 08:19:19 -0400
Received: by wproxy.gmail.com with SMTP id 68so956081wri
        for <git@vger.kernel.org>; Fri, 29 Apr 2005 05:19:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RokNFiH8OfpU6dfh5K4OIyStu1s6LGmiDwJPnr1NAjuHpZH4mvvjoElFXLsI3HMiiQevyD1z8eMnr7ZkBaruf8ZvfKdnT/WvMEkEqVy0TG3tm1oU9e5+lO1dYckrM6JQPDogzd/zchKD6UiIWZWPMG9hxNKPPItg9v5P/U8JoKI=
Received: by 10.54.121.14 with SMTP id t14mr1315812wrc;
        Fri, 29 Apr 2005 05:19:18 -0700 (PDT)
Received: by 10.54.36.54 with HTTP; Fri, 29 Apr 2005 05:19:18 -0700 (PDT)
To: "Adam J. Richter" <adam@yggdrasil.com>
In-Reply-To: <200504281425.j3SEP1H00534@freya.yggdrasil.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/28/05, Adam J. Richter <adam@yggdrasil.com> wrote:
> On 2005-04-28, Benedikt Schmidt wrote:
> >AFAIK the paper mentioned in the GNU diff sources [1] is an improvement
> >to an earlier paper by the same author titled
> >"A File Comparison Program" - Miller, Myers - 1985.
> [...]
> >[1] http://citeseer.ist.psu.edu/myers86ond.html
> 
>         Monotone apparently uses a futher acceleration of that algorithm
> from the 1989 paper, also co-authored by the Myers, "An O(NP) Sequence
> Comparison Algorithm" by Sun Wu, Udi Manber, and Gene Myers.
> http://www.eecs.berkeley.edu/~gene/Papers/np_diff.pdf .  The Monotone
> implementation was apparently a port of an implementation originally
> written in Scheme by Aubrey Jaffer.
> 
>         I don't fully understand the 1989 paper, but I get the
> general impression that is a small change to the previous algorithm
> (the one in GNU diff) that might be a 30 line patch if someone
> got around to submitting it, and seems to make the code run more
> than twice as fast in practice.  One of these days, I will probably get
> around to coding up a patch to GNU diff if nobody beats me to it.
> 
>         Making diff run faster may have at least one potentially useful
> benefit for merging.  A faster diff makes it more practical run diff
> on smaller units of comparison.  I posted a note here before about
> converting the input files to diff3 to have just one character per
> line, and then undoing that transformation of the result to produce
> a character based merge that seemed to work pretty well in the
> couple of tests that I tried.

I just read that paper and unless I am mistaken, it already describes
the basis for how GNU diff works.  I don't think anything in that
paper would make it faster.

I also don't find anything to suggest the Monotone guys have rewritten
diff.  Just some notes from graydon that notes python's difflib uses a
non-optimal diff that is faster in some cases.

-Wayne
