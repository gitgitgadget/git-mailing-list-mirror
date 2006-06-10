From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 15:41:39 +1200
Message-ID: <46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
	 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
	 <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
	 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 05:41:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FouM5-0007br-B0
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 05:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWFJDlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 23:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWFJDlm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 23:41:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:45186 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932283AbWFJDll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 23:41:41 -0400
Received: by wr-out-0506.google.com with SMTP id i22so776913wra
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 20:41:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=URvYn9grg00DhdzedXI/9Sdcdx6CNNCCC1M6r05T8gC/KP8+lI7t1wjES1Tat59NJmX9GDIiatS//r0dLpr4oLrnjoo4CPWWgvJxYP1sy6GMzeCvqR/ITmH+VQd0uDjW2Fx9iyYRZTX+68o1o1wWEr+JAn9GF2L3rVriW7TC3/Y=
Received: by 10.54.86.19 with SMTP id j19mr1039112wrb;
        Fri, 09 Jun 2006 20:41:40 -0700 (PDT)
Received: by 10.54.71.4 with HTTP; Fri, 9 Jun 2006 20:41:39 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21590>

On 6/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Fri, 9 Jun 2006, Jon Smirl wrote:
> > >
> > > Btw, does anybody know roughly how much data a initial "cvs co" takes on
> > > the mozilla repo? Git will obviously get the whole history, and that will
> > > inevitably be bigger than getting a single check-out, but it's not
> > > necessarily orders of magnitude bigger.
> >
> > 339MB for initial checkout
>
> And I think people run :pserver: with compression by default, so we're
> likely talking about half that in actual download overhead, no?

Yes, most people have -z3, and I agree with you, on paper it sounds
like the cost is 1/4 of a git clone.

However.

The CVS protocol is very chatty because the client _acts_ extremely
stupid. It says, ok, I got here an empty directory, and the server
walks the client through every little step. And all that chatter is
uncompressed cleartext under pserver.

So the per-file and per-directory overhead are significant. I can do a
cvs checkout via pserver:localhost but I don't know off-the-cuff how
to measure the traffic. Hints?

cheers,


martin
