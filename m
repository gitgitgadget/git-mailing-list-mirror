From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Managing submodules on large multi-user projects
Date: Fri, 29 May 2009 16:18:21 -0400
Message-ID: <32541b130905291318j2fb5188fk889a6dc9bfca37b3@mail.gmail.com>
References: <20090529184125.GE11222@starfruit.corp.slide.com> 
	<32541b130905291253k3fa1d675yde1dddb5e8090ef9@mail.gmail.com> 
	<20090529200928.GH11222@starfruit.corp.slide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Fri May 29 22:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA8XR-00046M-8M
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 22:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbZE2USl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 16:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbZE2USk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 16:18:40 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:3139 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbZE2USj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 16:18:39 -0400
Received: by yw-out-2324.google.com with SMTP id 5so3573672ywb.1
        for <git@vger.kernel.org>; Fri, 29 May 2009 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=f7hylvdaYEYjvXOD+43eGHRW9lVkkse4+kNN3X3goSg=;
        b=jmGJwHtPiuHQwIxHU1Ci7GxRhCw1dC3b+FDJyxbVXN97CXNH+LlbtZbgwqPwlY4cYP
         sD7kkXvFftzvbv4Gr0DgE/R7m+zUINwAQkFXNJ6hlGYT617dtlpWKl+twZRsk0nBE7Ta
         ohRhGItrznp4227zluYBBk/bJoHYlKdBQCtKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=V6oH5k5vIEqYPE4XOiug+AlWzjGlcaU54wbz2wL3zlp+V20qhMvfmd3UWWktP9B0Pj
         YOOTq8+/ag5gw2xCPQ72adJeNJ5MMZP2NqrQoG8pkr8ubBZ8LesGZNOuGDipwO1NvYBX
         DgnTaEILXmnTHUchrUvpXW1rSByaHlVIj324Y=
Received: by 10.151.131.3 with SMTP id i3mr5828777ybn.206.1243628321121; Fri, 
	29 May 2009 13:18:41 -0700 (PDT)
In-Reply-To: <20090529200928.GH11222@starfruit.corp.slide.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120310>

On Fri, May 29, 2009 at 4:09 PM, R. Tyler Ballance <tyler@slide.com> wr=
ote:
> On Fri, May 29, 2009 at 03:53:26PM -0400, Avery Pennarun wrote:
>> Just so I understand, is the reason you're splitting into submodules
>> *just* to avoid memory usage / repository size issues? =A0I can sort=
 of
>> understand the memory usage issues - sort of - but how does it reduc=
e
>> repository size if you need to need to check out all the submodule
>> repositories along with the main project anyway?
>
> I've got an eye on submodules as a way of avoiding the need to requir=
e a
> whole tree clone to just work on parts of it, but that's not really
> relevant to my query, just explaining our environment and setting the=
 stage ;)
>
> We're using submodules right now similar to how we used svn externals=
 in
> the past (except better, clearly), to incorporate outside components
> (like open source projects) that our stack depends on.

That makes sense.

>> Just looking to clarify for myself. =A0(I'm continuing my work on
>> git-subtree, which is getting more and more positive feedback. =A0It
>> solves all the *other* problems that you listed vs. submodules, but =
it
>> certainly doesn't resolve any repository size issues.)
>
> Good to know, we're still on Git 1.6.1, are there any benefits or
> additional features in more recent releases of Git that help alleviat=
e
> the submodules issues I outlined at the top of the thread?

git-subtree is my own little project that hasn't been accepted into
git proper yet.  It does work with git 1.6.1 (and also git 1.5.4, at
least) just by dropping the script into your PATH.  Google "git
subtree" for more.

AFAIK, the particular issues you outlined with submodules continue to
exist in latest git.  They are certainly fixable (they aren't
*fundamental* problems), but nobody has fixed them yet.  I looked at
the issues for a long time and failed miserably to find a good general
solution, but that's just me.

Have fun,

Avery
