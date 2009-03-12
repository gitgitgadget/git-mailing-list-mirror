From: John Tapsell <johnflux@gmail.com>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 16:45:21 +0000
Message-ID: <43d8ce650903120945h7063e7baraa3911d2cf63d1d8@mail.gmail.com>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
	 <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>
	 <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com>
	 <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>
	 <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com>
	 <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com>
	 <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl>
	 <20090312153738.GA24690@coredump.intra.peff.net>
	 <43d8ce650903120916yb91113fy5485813c512c8108@mail.gmail.com>
	 <20090312163533.GA28205@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 17:53:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lho3a-0000ds-Is
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 17:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbZCLQpZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 12:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754331AbZCLQpZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 12:45:25 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:52254 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbZCLQpY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 12:45:24 -0400
Received: by yx-out-2324.google.com with SMTP id 8so764543yxm.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cN+lqgyv/DFs7EXECkcdaEMYRpKwTG0/YTNcsqyMdxk=;
        b=ANGLZoJxnt17hKlCkcHQAOIZlr/mjQasALPXgDiosFq6JALi/6PFbkyBjp05mzp5VF
         PykZMiNz+4AMK1kGsRwdcij9t1XIwhq7B6imwhpHCQNBO6J+6r+cl1DcefZ0Ijo/x4Bh
         8HKqJBeKTEvOceL9Yqbt7KAzUNcZfcNXecGk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OP4vuQIfnx941N2EFjCBRVEK4W24EEVWe5ISKEoV5i/6Ey1x6Zb2mM5PxTdUcKSTjd
         EUiQIdX6osotdM9Fk0sEjTCGxwolnKWxXbp/hdFfv31K5A07acUHV1EpN2RZ1bEI3wcS
         Hhxsf4DZc5o5+ly69D/AM201IEgaIkPG6irOI=
Received: by 10.142.174.8 with SMTP id w8mr25133wfe.15.1236876321875; Thu, 12 
	Mar 2009 09:45:21 -0700 (PDT)
In-Reply-To: <20090312163533.GA28205@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113086>

2009/3/12 Jeff King <peff@peff.net>:
> On Thu, Mar 12, 2009 at 04:16:09PM +0000, John Tapsell wrote:
>
>> I was thinking more along the lines of checking if it begins with
>> remotes/, origin/, tags/, stash/, bisect/ =C2=A0 =C2=A0and blacklist=
ing these.
>>
>> Can anyone suggest a reason that you really might want to create a
>> branch called =C2=A0origin/something ?
>
> The name "origin" is simply convention. So if you are thinking about
> blacklisting "origin/*", then it is certainly possible to have a fals=
e
> positive (although as you note, it is unlikely). But what is worse is
> that it is very likely for you to have a false negative if you use a
> different remote name (and people often do if they have multiple
> remotes).
>
> For example, in one of my projects where I do integration, "origin" i=
s
> my own public repo, and I have a remote pointing to the public repo o=
f a
> number of other developers from whom I pull. So I would encounter the
> same error by doing:
>
> =C2=A0git checkout -b mike/master mike/master
>
> but it would not be caught by your rule.
>
> One area where your rule _is_ nicer than mine is that mine only looks=
 at
> what exists _now_ and doesn't future-proof you at all. So I could say
>
> =C2=A0git checkout -b origin/newtopic
>
> which might not be ambiguous. But if the remote adds a "newtopic"
> branch, then the next time I fetch it will _become_ ambiguous.
>
> Potentially you could blacklist "X/*" for every remote.X.* that
> exists in your config. Even that, of course, isn't future-proof again=
st
> you creating a new remote. :)
>
> I think the future-proofing is probably not worth the effort. Catchin=
g
> things that are ambiguous _now_ will cover the "oops, I typed the wro=
ng
> thing" case, which I think is really the issue.

Yep, makes sense.

I suppose you could do both.  Blacklist and check if it already
exists, but I think just checking if it exists is "good enough".

John
