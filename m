From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Wed, 24 May 2006 08:32:16 +1200
Message-ID: <46a038f90605231332l7ba7a596k2916e6e8c7456e48@mail.gmail.com>
References: <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	 <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
	 <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	 <20060522214128.GE16677@kiste.smurf.noris.de>
	 <7v8xotadm3.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com>
	 <20060523065232.GA6180@coredump.intra.peff.net>
	 <20060523070007.GC6180@coredump.intra.peff.net>
	 <46a038f90605230113x2f6b0e4bq5a2ea97308b495e0@mail.gmail.com>
	 <7vpsi55et5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 22:32:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FidYC-00047o-Fr
	for gcvg-git@gmane.org; Tue, 23 May 2006 22:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWEWUcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 16:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWEWUcS
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 16:32:18 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:9739 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932121AbWEWUcR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 16:32:17 -0400
Received: by wr-out-0506.google.com with SMTP id i3so1338981wra
        for <git@vger.kernel.org>; Tue, 23 May 2006 13:32:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WAaIM3ep5ohZZR7aC7CWGvlr4vvOU/K+cWgsyLupduvqfT47AIygDQjm4RyEqnv1tjT9xuraTqg1Kf1weK/nc4meYWMG4oqxEVHdlIpujArWiLuU4sppIWR+RnUK0yrI81wDIOcCIpsKvd78bTZrZ3LjOFZOL4k1pROV8KMP/BE=
Received: by 10.54.76.1 with SMTP id y1mr6305227wra;
        Tue, 23 May 2006 13:32:15 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Tue, 23 May 2006 13:32:16 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vpsi55et5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20633>

On 5/23/06, Junio C Hamano <junkio@cox.net> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
> > Jeff,
> >
> > good stuff -- aiming at exactly the things that had been nagging me.
> > Some minor notes on top of what junio's mentioned...
> >
> >> +    die "unable to open $f: $!" unless $! == POSIX::ENOENT;
> >> +    return undef;
> >
> > Heh. Is that the return of the living dead?
>
> Note the trailing "unless" there.

Of course. I had actually missed the closing quotes, and thought the
error msg wanted to talk about POSIX. 'twas late in the day, seems
like most of my comments in this email were rather stoopid.

> >> +sub update_index (\@\@) {
> >> +       my $old = shift;
> >> +       my $new = shift;
> >
> > Would it not make more sense to just pass them as plain parameters?
>
> Meaning...?  Perl5 can pass only one flat array, so the above is
> a standard way to pass two arrays.

Meaning I am stupid :(

> >> +       print "Committed patch $patchset ($branch $commit_date)\n" if
> >
> > Given that we have that -- should we remember it and avoid re-reading
> > the headref from disk? A %seenheads cache would save us 99.9% of the
> > hassle.
> >
> > In related news, I've dealt with file reads from the socket being
> > memorybound. Should merge ok.
>
> Merged OK, and I think your last suggestion makes sense.  I'll
> go to bed after pushing out Jeff's two patches and yours.

I'll look into caching headrefs tonight if noone beats me to it.




martin
