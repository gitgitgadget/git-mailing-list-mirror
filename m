From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 17:18:44 -0500
Message-ID: <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904240051.46233.johan@herland.net>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxTkr-0002Cm-VC
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676AbZDXWSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 18:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757829AbZDXWSq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:18:46 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:34017 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756952AbZDXWSq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 18:18:46 -0400
Received: by qyk16 with SMTP id 16so2699308qyk.33
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cSJA+AJP/uCARAIXWHAkD8auyGfr9m/DzoUBK2DgUiw=;
        b=jtn9iCXlowcSKYGeOpEA6bf3R3m1MRu2CZaSutGIocdadhi3L7e4DzdpftFU5c9MTt
         jqC6m/hLJ2F5q7iVdnocZQPzTbsTP74X6Ks/z+F6BJ9eJStI7TRoMfepP2jXqd70OgzC
         pSU2nZ3btyatBx9pWB5KcPwNeL8UfmFNurSBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lqGRg6t4J5aNQz2P8bSjPK/OzH3rMN6yN3FAA+hFOoNvO2OBZQZIhHqpA1k5yy/m6P
         P9tpcdRBAYMEm52/68oo9u8CiDaeixoSxrSKAkJf7Fx5V4yr9xy5Cy8A9utBNxeslUQP
         SB1+PDiYLKACA/7piqqMceh0cNXiGvdsutEVU=
Received: by 10.224.6.136 with SMTP id 8mr3572490qaz.234.1240611524912; Fri, 
	24 Apr 2009 15:18:44 -0700 (PDT)
In-Reply-To: <20090424213848.GA14493@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117500>

On Fri, Apr 24, 2009 at 16:38, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 24, 2009 at 05:34:00PM -0400, Daniel Barkalow wrote:
>
>> I'd say that blobs and trees are an implementation detail of "the fu=
ll
>> content of a version of the project", not something conceptually
>> important. Likewise, the date representation used in commits isn't
> ...
> No, that isn't critical for understanding how _commit_ operations wor=
k,
> but I think that is exactly the sort of conceptual knowledge that let
> people use git more fully.

I think the key conlusion here is that the main concepts are *objects*
and references to those objects. One type of object is not necessarily
more low-level or high-level than another type of object; each type of
object is the most important type of object for a particular task in
or view of the git world.

> I disagree. I think it's important to note that trees and blobs have =
a
> name, and you can refer to them. Once you know that, the fact that yo=
u
> can do:
>
> =A0git show master
> =A0git show master:Documentation
> =A0git show master:Makefile
>
> just makes sense. You are always just specifying an object, but the t=
ype
> is different for each (and show "does the right thing" based on objec=
t
> type).

In fact, I think it's important to note that the notation:

    git show master:Makefile

actually involves a translation from a Unix filesystem address to a
git object address that is then used to find the relevant data.

In fact, I think masking this kind of thing with a catch-all word
'reference' is a bad idea. Rather than being hidden, it should be
exposed: I think it would be beneficial to use the word 'address'
rather than 'reference' when talking about the SHA-1 names. Then HEAD
could be called a pointer variable, etc.

So, a pointer variable's value is an object address that is the
location of an object in git 'memory'. I think using this approach
would make things significantly more transparent.
