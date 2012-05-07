From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: planned view wildcard support
Date: Mon, 7 May 2012 08:28:33 -0700
Message-ID: <20120507152833.GA30191@padd.com>
References: <CAF0RQx-0M4iUHgGdH=RE_UFmLLZH8uy4kkMW=XspNzGm-vsyEg@mail.gmail.com>
 <20120507104443.GA20372@padd.com>
 <CAF0RQx_0EYGiTd36WMtjeBwJL1cxsGTe44=P+btEfWn+5Hq5yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthew Mendell <matthew.mendell@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 17:36:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRPzQ-00036O-Bf
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 17:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770Ab2EGPgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 11:36:39 -0400
Received: from honk.padd.com ([74.3.171.149]:43027 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756623Ab2EGPgi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 11:36:38 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 May 2012 11:36:38 EDT
Received: by honk.padd.com (Postfix, from userid 7770)
	id 503653309; Mon,  7 May 2012 08:28:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF0RQx_0EYGiTd36WMtjeBwJL1cxsGTe44=P+btEfWn+5Hq5yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197279>

matthew.mendell@gmail.com wrote on Mon, 07 May 2012 08:19 -0700:
> On Mon, May 7, 2012 at 3:44 AM, Pete Wyckoff <pw@padd.com> wrote:
> > matthew.mendell@gmail.com wrote on Sun, 06 May 2012 16:46 -0700:
> >> Is there any plan for the git-p4.py script to support the "*" wild=
card
> >> in a p4 client?
> >>
> >> The specific test that exposes this unsupported feature:
> >> ./t9809-git-p4-client-view.sh
> >> ...
> >> ok 4 - unsupported view wildcard *
> >
> > It hasn't been on anybody's priority list so far that I know, but
> > this would be not too hard to implement in theory.
> >
> > The code changes would need to alter just one class. =A0In
> > View.Path, functions Path.find_wildcards, match_wildcards and
> > fill_in_wildcards, if you're interested in giving it a try.
> >
> > Can you constrain your use of "*" a bit? =A0What makes these
> > wildcards difficult is all the edge cases. =A0For instance, is
> > there ever more than one "*"? =A0Is it combined with "..."? =A0Are
> > there multiple lines in the client spec with wildcards? =A0Some
> > abstracted examples would be interesting.
>=20
> Yeah, I have been perusing the code and would like to give it a shot.
> Is it ok to initially add partial support for the easy cases?
> My usage of "*" is straight forward:
>=20
> //depot/project/* //my_clientspec/depot/project/*

That one does seem like it wouldn't be too hard.  Similar to
trailing "...", but matching only one path component.

As long as git-p4 can reliably detect when it can deal
with a *, I think partial support would be just fine.

I'll help think about test cases and such once you have
some code that's ready to look at.  Thanks!

		-- Pete
