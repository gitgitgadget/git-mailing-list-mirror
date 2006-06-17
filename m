From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: parsecvs and unnamed branches
Date: Sat, 17 Jun 2006 01:51:59 -0400
Message-ID: <9e4733910606162251i65021336m4388d4da715befc9@mail.gmail.com>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
	 <9e4733910606162002x508ec6ccjbc36e4220ca44fd6@mail.gmail.com>
	 <1150513943.29738.15.camel@dv>
	 <9e4733910606162031o69df27fdje50c88949ed990b5@mail.gmail.com>
	 <1150517336.9144.8.camel@dv>
	 <9e4733910606162115g2165212bgf32a2e328cce751a@mail.gmail.com>
	 <1150522246.6983.52.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 07:52:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrTj1-0008VH-Po
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 07:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWFQFwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 01:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWFQFwA
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 01:52:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:37350 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751248AbWFQFv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 01:51:59 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1298261nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 22:51:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dug1nYk1xt5jBue8+Cw+gBK570aqr75ZYH+AJpAHCCh9JiPvg8ZA+WjZ2RqYGKx6IjCuNAt3sI5y2LXYkShybC5WRtg96K2q7kL7UyUkh5DfjA+f8wAZrhtDzFZ0qUYFcHcd8Ya/GqOy8yyvcAvA13zpnnz5EugT214lY6E0thY=
Received: by 10.36.227.51 with SMTP id z51mr4708012nzg;
        Fri, 16 Jun 2006 22:51:59 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 22:51:59 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1150522246.6983.52.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22004>

On 6/17/06, Keith Packard <keithp@keithp.com> wrote:
> On Sat, 2006-06-17 at 00:15 -0400, Jon Smirl wrote:
>
> > >>But the real problem is why does it think the branches are in a loop?
>
> I haven't figured it out yet either; mine didn't detect the loop though,
> it just ended up spinning in the tsort code, unable to compute a valid
> order to execute branches in. Something funky must be up with the
> mozilla branches.

Have you checked parsecvs on the 38 test repositories in the cvs2svn source?


> What this code does is find an order that will 'work' when computing
> branch contents. The requirement is that the 'parent' branch be computed
> before any 'child' branches.
>
> It does this with a nice quadratic algorithm, building a list of 'ready'
> branches who have no 'unready' dependencies in any of the incoming file
> objects. If there are conflicts where one incoming file shows branch 'B'
> as the parent of branch 'A' while another shows branch 'A' as the parent
> of branch 'B', the sorting cannot succeed.
>
> Ideally, I'd figure out a way to eliminate the parent/child relationship
> and just treat the branches as peers with a common ancestor. I haven't
> figure out how to manage that yet; attempting to find the precise
> divergence point where the child forks from the parent remains
> complicated, it seems like trying to do that without a strong
> parent/child relationship would be even more error prone.
>
> Better error messsages here would clearly help discover which branches
> were in conflict, and show the files causing problems.
>
> --
> keith.packard@intel.com
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.3 (GNU/Linux)
>
> iD8DBQBEk5OGQp8BWwlsTdMRAuyZAKC3URBHR/SWgG7azMqKe3efGNxNZwCdFAVA
> GEIKF8z/MtdbBnKRMDneSH8=
> =ShEA
> -----END PGP SIGNATURE-----
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
