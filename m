From: Vicent Marti <vicent@github.com>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Sun, 20 Mar 2011 23:01:25 +0200
Message-ID: <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
References: <op.vsm1yszq2m56ex@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Pavel Raiskup <xraisk00@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 22:02:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1PlD-0006fJ-64
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 22:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab1CTVBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 17:01:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52211 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab1CTVBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 17:01:46 -0400
Received: by wya21 with SMTP id 21so5255863wya.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=y3G74Tp2r9fUFvIvhjFxG4J+yeKyjOP+RCOeeC9yD/0=;
        b=JEC7wDyh0ovYgMKTCbnrSyBpNebLMQyrmbYKQPw/uyR950lsXGBe0YOG8PtzMTzWDc
         kj3h1dWtN71EvLzazl2PMKQq0lwu1ExwVqfFG/bYIgOjfhO6755KyP9ll+yyrRjdyCBr
         qBQU9DhIi2Q8H/ea1irobXtXVnmbGzKepIGzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=czk5VLtmtaiUtkrtd4AdKvcp3Zsbc8cBSeiLY7zJw04d8EDJdo9k6l5ukSnrtU3bna
         c82Ee3P55V79LP0WzIsN2waayVLBl837sls8855Dl4G4jwxyQEa/pX9ptZVazniUJLFC
         tzSMt0QiRrBjdffLfcYGO0Lwcciagod2owa5w=
Received: by 10.216.205.13 with SMTP id i13mr3329569weo.36.1300654905193; Sun,
 20 Mar 2011 14:01:45 -0700 (PDT)
Received: by 10.216.243.7 with HTTP; Sun, 20 Mar 2011 14:01:25 -0700 (PDT)
In-Reply-To: <op.vsm1yszq2m56ex@localhost.localdomain>
X-Google-Sender-Auth: Z_ISJlPwCc1PQw70pCfTSkyxOtE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169524>

Yo!

On Sun, Mar 20, 2011 at 12:55 PM, Pavel Raiskup <xraisk00@gmail.com> wrote:
> libgit2:
> I really like the concept of libraries for to be binding-able from dozens of
> languages - this leads to expanding functionality among masses users
> almost everywhere. In this part I like the idea of implementing new features
> inside library (diff, config file parsing) but also maybe the task of
> merging
> libgit2 into git upstream. Basically I don't know much about that.. and
> you wrote that this task is more difficult then others, so I probably need
> to study git's and libgit's architecture very precisely beforehand .. but
> could you tell me some details about that? Is it impossible to do it before
> GSOC deadline and is it worth making a serious big efforts to this task
> (from your point of view onto project objectives)? How big are requirements
> for this task in term of GSOC?

Merging libgit2 into upstream Git is a scary as fuck task. Somebody
put it up on the Wiki ideas page, but that was not me -- I'm
personally doubtful of anybody succeeding on doing that project during
the SoC, so I have very little interest on mentoring the task.

Here's what's going on: The Git code base is hairy and not that well
documented, so you're gonna need to study that quite a bit. I like to
think that the libgit2 code base is not hairy, and is pretty well
documented (I'm an optimistic guy), but you're still going to need
quite a bit of research to understand the whole architecture before
you can actually merge anything into Git.

You could try to port just some selected parts of the library to
libgit2 (i.e. the parts which benchmark to be faster than their Git
counterparts), but the interdependency chain of libgit2 internals is
not going to be pretty, embedding into the Git core is not going to be
easy (libgit2 is reentrant and mostly threadsafe, so there's quite the
architecture mismatch there), and there's no guarantee that the final
implementation is going to be faster once it's in there.

Overall, you'd need balls of steel and a lot of spare time and
interest to accomplish anything significant with this task, so my
personal opinion as very old wise man is to forget about it.

HOWEVER. If you want to do something libgit2-related for the SoC
(which would be awesome), there's still two options:

a) Help us make the library more awesome by implementing new features!
This task is the opposite the previous one; it's like full of unicorns
and rainbows. You can choose one (or more) features we are missing,
and see how to implement them in libgit2 while making them reentrant,
threadsafe AND faster. It's not easy, but it's fucking cool. And you
get to do a lot of micro-optimization if you're into that.

b) Write a minimal Git client using libgit2. Peff keeps bringing this
up and I think it's a bangin' good idea. Write something small and
100% self contained in a C executable that runs everywhere with 0
dependencies -- don't aim for full feature completion, just the basic
stuff to interoperate with a Git repository. Clone, checkout, branch,
commit, push, pull, log. I would totally use that shit on my Windows
boxes. And since it'll be externally compatible with the original Git
client, we can reuse the Git unit tests to test libgit2. HA. Awesome!

So, yeah. That's pretty much my libgit2-related advice for the SoC.

Best of luck with your application process with whatever project you decide,
Vicent
