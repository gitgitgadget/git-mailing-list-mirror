From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Thu, 31 Jul 2008 01:45:22 +0400
Message-ID: <20080730214521.GC7008@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no> <20080729134619.GB7008@dpotapov.dyndns.org> <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Wed Jul 30 23:57:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOJg4-0000hs-KZ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 23:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759140AbYG3V41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759643AbYG3V40
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 17:56:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:7984 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188AbYG3V4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 17:56:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so132729fgg.17
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ACCF1iHRhoFSXFEDgeVxyGGNgN5Xq71P6ognMfNypao=;
        b=K7BY+VSmIc2wCEjybzEE+larDQfRd19xrSfs4RREUE+w19aKTy4Iyfku8d5vbU6phW
         Wgms5qCd7nTiKSMiA8vWuHQErgDcIRUouHbebvzbZMdieONaCD+feRbrHN1tPcIULyGe
         9hMISyj/5dKb4yzDDWCn5Rh5nSVQKkeY1juZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=td/fPv8aZHsJdnWtWZW7K7Fb7GDdLK3ixdG/NQasvQrEkVKOaU3hYoPLAYdYK4EZYX
         Yc6lWPS2NI2yT2mm/1RLnQNaOKYwpClNyIVfyh16a/Agg7z26/H5Gsl9vxPFVIxfCXpN
         gdQBmFAVvoRT8rByGTFzF78KGU9OTc0oYu6a8=
Received: by 10.86.4.2 with SMTP id 2mr5329688fgd.67.1217454326116;
        Wed, 30 Jul 2008 14:45:26 -0700 (PDT)
Received: from localhost ( [85.141.148.53])
        by mx.google.com with ESMTPS id l12sm1671256fgb.6.2008.07.30.14.45.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jul 2008 14:45:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90863>

On Tue, Jul 29, 2008 at 11:17:23PM +0200, Eyvind Bernhardsen wrote:
> 
> My point was that autocrlf penalises Windows users just as much as it  
> does Linux users, so why should it be turned on by default on  
> Windows? 

Because it does make sense on Windows (I mentioned some reasons for that
in my previous email), and it does NOT make any sense on Linux unless
you copy files from Windows.

> >
> >And the main argument for having that in this way is that people  
> >with LF
> >text files should be unnecessary penalized for Windows being  
> >different.
> 
> I know, but my point is that I don't like to be unnecessarily  
> penalised any more when I am using Windows than when I'm using Linux  
> or OS X.

It seems you still have not realized that from the very day when you
started to use Windows, you are penalized for that day-in, day-out.
Let's take something simple. For instance, the hello-world program:
cat <<=== > hello.c
#include <stdio.h>
int main() {
	printf ("Hello world!\n");
	return 0;
}
===

You can compile it on Linux and Windows (using Microsoft Visual C).
Now, if you run it on Linux, it will print 13 symbols (exactly
as many as there are symbols in the printf string) while on Windows
you will get 14 bytes. It means that printf and as many other C
function on Windows does conversion and penalize you already!

> I would like the default to be "no conversion", and for  
> conversion to be enabled not based on platform, but as a policy  
> decision on the repositories where it actually matters.

If Microsoft C library did not do any conversion, I suspect we would
have this CRLF conversion at all!

> You can have anything you like in _your_ repository, of course, but if  
> you're not publishing it anywhere, who cares what your line endings  
> are?  Your line endings only matter when you publish. 

You can publish only what you have. So, it must decided before.

> That's why I  
> want a setting that is propagated: so that when you clone a repository  
> with a LF-only policy, Git knows what to do.

LF-only policy is the only sane policy for any text files. It has nothing
to do with clone.

> 
> I think the real penalty is that with autocrlf enabled, Git no longer  
> stores exactly what I committed.

And what is wrong with that? In any case, Git deltifies and compress
your files. Why does it not bother you? So, what matters here is
whether you are able to get back exactly what you put or not. That's
why Git has this safecrlf option! Of course, it is guarantee to get
exactly the same back only if you have the same autocrlf setting,
but if you have different autocrlf settings, it means that you want
*different* representation of text files!

> >Files that do not need conversion (such as *.bat) should be marked as
> >"-crlf" in .gitattributes.
> 
> Yes, and I see you checked that "crlf=input" does actually work when  
> you want LF-only, sorry about that.  The syntax is _horrible_, though.
> 
> >Of course, those who are very careful and have good editors can set
> >autocrlf=false even on Windows...
> 
> Right, or who know that the repository they're using will only be  
> shared with other Windows users.

WRONG! Using storing CRLF in text files is a completely idiotic idea.
Those who do so asked for troubles, so they should not complain!

> 
> Internally, Git doesn't really care, does it?

It DOES!!! Such things like merges and diffs and many other every day
commands do care about end-of-lines and the ONLY end-of-line they
recognize is '\n'. In fact, there are more than 400 places in Git where
'\n' is used. Of course, not all of them may be qualified as internals
but many of them do.

So, as long as Git internally consider only LF as the end-of-line.

> 
> Heh.  Where I work, we hacked CVS for Windows to get away from that  
> behaviour :)

Maybe, you used Cygwin version of CVS, which had LF, but those Windows
versions of CVS I used produced CRLF on Windows.

> >
> >The problem is how to determine when it is necessary and when it is
> >not. If I never commit with wrong EOLs, I don't think it is necessary
> >for me to have this conversion... On the other hand, I don't mind  
> >having
> >this check as default.  It does not really bother me much, and if I  
> >can
> >turn it off, it is fine with me. But I suppose other people may feel
> >differently about this issue.
> 
> Well, what I want is to be able to say "it is necessary to do eol  
> conversion in this repository",

You always can do that in _your_ repository:
git config core.autocrlf ...

> allowing the default to be "don't do  
> eol conversion" on Windows, too.  For a setting like that to be  
> useful, it has to be propagated when the repository is cloned.

Why? Other people may have other preferences.

> I want it to be versioned because you might want to change it without  
> messing with the content that's already in the repository.  This is  
> actually my main motivation, since I have lots of CRLF-infused CVS  
> history to deal with.

Well, you can try to use .gitattributes, but I believe it would be far
more reasonable to clean this mess with line-ending than finding a
way to continue insanity with different ending in different text files.

> 
> It should apply on Linux as well as Windows because there is always  
> the chance that a user will manage to commit a CRLF on Linux (a  
> colleague of mine once complained that CVS on Linux doesn't do eol  
> conversion; he edited files on Windows, but checked them in on  
> Linux).

For those who need it, Git provides autocrlf=input. But the question
here is what should be default. I don't think that those who copies
files directly from Windows to Linux are majority. OTOH, I don't
mind autocrlf=input as default. If it can be turned off, it is fine
with me :)

> It would probably be okay to have a setting that turns all  
> conversion off, but wouldn't that be kind of rude?

How so?


Dmitry
