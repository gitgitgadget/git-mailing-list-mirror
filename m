From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 27 Oct 2010 22:11:47 -0500
Message-ID: <20101028031147.GA31913@burratino>
References: <AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
 <7v1v9e803a.fsf@alter.siamese.dyndns.org>
 <AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
 <20100902043500.GF29713@burratino>
 <7vvd6o14zz.fsf@alter.siamese.dyndns.org>
 <AANLkTimX2NhXGdK0vVMaw-Fm6fpg4i5pbOZGA8Cc-+ui@mail.gmail.com>
 <20101027151832.GA10614@burratino>
 <AANLkTinxG-=EKeNH3--34Ya4w0E=i_bdmJ7iv2em8C+8@mail.gmail.com>
 <20101027164508.GB11069@burratino>
 <AANLkTinGomS0OS-ZpOQun7E_KVRkL4A-w7MU1AG0bBAH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 05:12:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBIuL-0006Hq-2E
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 05:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871Ab0J1DMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 23:12:00 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48391 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932852Ab0J1DL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 23:11:58 -0400
Received: by qwf7 with SMTP id 7so696701qwf.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 20:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TDiCU855Eu/tVzzZ08UMoQlytWxfg48Ga6yKd58MWUU=;
        b=G7rClLjQDogVduXYXaX5iqOWPXvfDfSnO6KVghyk+XLsVc9Yt0vdGgOJuyjP2sur3A
         4udQBnkbfQnrqPoa4/VL6yTGNCYCy0PQX14sIm8Jf3g6dN6uNwR+BP0oPcs+9XNgqPIx
         0XhzRLQmq1+1uoY5RYwYHw85CiDLGgbyI4zn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hMBXKf1cxEnKQbfE3079JsjbeN9REmoYJ5EabEuTFyuCpcaNgxMcC6SitGf9wWNJMd
         SyryuODrr32LOI6FANJnAx8NG0afovsX3emcGNbXq9GBWOnkfulbnRHtckk5hQ/9Zwms
         FxbJKiCJpMFErwwM5IoJi+XyO0Usic1vy8cnU=
Received: by 10.229.224.142 with SMTP id io14mr729118qcb.19.1288235517536;
        Wed, 27 Oct 2010 20:11:57 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n7sm528562qcu.16.2010.10.27.20.11.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 20:11:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinGomS0OS-ZpOQun7E_KVRkL4A-w7MU1AG0bBAH@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160155>

Thiago Farina wrote:

> Nope, sorry. I don't fully understand his explanation.

Any questions then?

> Also, Junio, thanks for the "I don't like
> churning-for-the-sake-of-churning". This is very incentive.

For the scenario "one person likes this change and another doesn't",
in the Linux kernel world (which I find amusing to take as a model),
there is a well established method to deal with that.  (I'm a big fan
of this method.)  It works like this:

 1. Write a patch.
 2. Send a copy to the list and get feedback.
 3. Use it locally.  Foist it on your friends.  Accept bug reports
    and keep a git tree to handle them.  When conscience or users
    provide the pressure for it, move on to step 4:
 4. Send another report to the list and get more feedback.
    ...
 n. (Ideally) the patch evolves to be more useful.  Eventually, it
    gets applied upstream or, if upstream is out of touch, the
    patched version becomes the new mainstream.

Why am I saying such things?  Isn't it extreme to ask you to take
matters into you own hands, especially for such an unrisky patch?

What I want to get at is that to make your work available, you don't
need Junio.  You can do that yourself.  It can still be very useful
to people!  What Junio offers is help in maintaining code --- once a
patch hits mainline, there is no need to keep forward-porting it, you
are less alone in dealing with bug reports, you will find more people
out there to give advice in changing it for new requirements.

So when someone like Junio says

 I don't like churning for the sake of churning

part of what this means is that in order to take on new code, there
has to be an obvious benefit that outweighs the maintenance burden.
(Keep in mind: "obvious" doesn't mean "big", it just means "clear".)

What maintenance burden?  Here, I thought I had explained that if
it weren't for existing scripts, there would not be more than one
hardlink for builtins in /usr/lib/git-core at all.  Those hardlinks
are technically just bad --- they require munging the PATH and
basing behavior on argv[0], they are confusing, their command-line
syntax is not as flexible as the git <options> foo syntax, and use
of them makes it hard to grep for a real bug that some old programs
have of assuming dashed-form commands are in the user's $PATH.

So your patch is exciting in a way, because it serves as a reminder
of a problem it would be nice to solve (that each new builtin adds
to the builtins in /usr/lib/git-core for no good reason and that
'git help' is relying on that).

Sorry to be vague, hope that helps.
