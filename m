From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Wed, 23 Apr 2014 22:26:20 -0500
Message-ID: <5358845caeba7_59ed83d3087d@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <xmqqmwfd2fa5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 05:37:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdATQ-00051n-EN
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 05:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbaDXDgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 23:36:48 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:48728 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbaDXDgr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 23:36:47 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so2043901oac.30
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 20:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=oTDRMQkOwy99gC4Hjh2XqmihVHPsLXB9LL51/rX0j/w=;
        b=GPYEI7oJeXYEAS+7mX5dDA9i/h3Gkjq94RtBCGx3604KVURTcgAKRxnTjQjlvE5gq5
         pHeu7H45qGKKyzYNqtXBpaCrDE+nPijlBLicZQDQ/c5cy61qgNiCfYDQMwCFP0UUL+Cx
         437bL7A1i2I9mHU95b5cqUSos8qL0sdI4CfF0duEvnq57sPgMiVvuKYUTcErsL4M8D3a
         6+9NRDHEy7vAqU6nygoDbT4ys2/ErVjGBavAqrFRnrNEjacxZp0b2zuRyAPE9MdhREgu
         4veeKKp4nwnvOommFkHPQs5C/jSYzg+WvW+ulEWt8xdXrGXeLSIB/qMHDLwwN8R5OVUg
         GzWQ==
X-Received: by 10.182.22.227 with SMTP id h3mr41624047obf.36.1398310607171;
        Wed, 23 Apr 2014 20:36:47 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id or12sm5950006obc.0.2014.04.23.20.36.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 20:36:46 -0700 (PDT)
In-Reply-To: <xmqqmwfd2fa5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246929>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I am not fundamentally opposed.  I just do not think it would add
> > much value to new people at this point, and it will actively hurt
> > if we shoved barely cooked one in 2.0.
> >
> > A few thinking points that are necessary to be worked out, even
> > before we start imagining a plan to introduce them, off the top of
> > my head, are these:
> >
> >  * Should we add many random aliases, or should we limit ourselves
> >    only to a narrow set that everybody can agree on?
> >
> >  * What is the additional cognitive load do we feel comfortable
> >    burdening with the new users?
> >
> >  * What is the exact mechanism to give these built-in aliases?
> >
> > Imagine that somebody says "[alias] ci = commit" and a handful of
> > vocal people on this list agree that it is a good idea.  Many random
> > websites start mentioning "git ci -a" in their beginner examples.
> >
> > Users are led to think "ci" is a command just like "commit" and does
> > the same thing.... and need to learn that only the
> > first kind and not the second kind cannot be used to define their
> > own alias (and the users need to learn "commit" at that time as
> > well).
> 
> A bit further on this point, looking into the future.
> 
> It might help if we added some "introduction" phase to the first
> invocation of "git init", "git clone", etc. that is interactively
> run on a machine where there is no $HOME/.gitconfig detected, and
> help the user populate it with a few selected and uncontroversial
> ones.  Such a session might go like this:
> 
> 	$ git init
>         ... We do not see $HOME/.gitconfig; using Git for the first time?

We shouldn't say $HOME/.gitconfig, that's not user friendly, and it might not
be accurate.

Plus, we might prefer $XDG_CONFIG_HOME/.config/git/config.

"There doesn't seem to be a Git user configuration." is enough.

>         >> Do you want us to add a few sample aliases to your configuration file?
>         Y

I don't see the point in asking this, just put them, the user can remove them
if he doesn't want.

>         ... Done.  You can further tweak $HOME/.gitconfig to suit
>         ... Git to your taste.

Aagain not friendly. `git config --global --edit`.

> And it would end up with something like this:
> 
> 	$ cat $HOME/.gitconfig
>         [user]
> 		name = <<interactively ask and record the result>>
>                 email = <<ditto>>
> 	[alias]
>         	co = checkout
> 		lg = log --oneline
> 
> which can serve as an example the user can then tweak, without
> giving any false impression that "co" is any more special than
> whatever the user adds as a custom alias.

You are assuming the user wanted to "further tweak", most likely he didn't, in
which case he wouldn't have seen those aliases.

It would be more friendly if the aliases are always there, then we can mention
them in the documentation of the relevant commands.

-- 
Felipe Contreras
