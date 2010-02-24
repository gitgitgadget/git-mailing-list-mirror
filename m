From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] git checkout -b: unparent the new branch with -o
Date: Wed, 24 Feb 2010 19:27:06 -0300
Message-ID: <55bacdd31002241427w2b160614vd1a5977d1820984b@mail.gmail.com>
References: <1266960007-16127-1-git-send-email-erick.mattos@gmail.com> 
	<7viq9nfwg8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:27:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkPhh-0003LM-F4
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 23:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758370Ab0BXW1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 17:27:32 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44100 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758242Ab0BXW1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 17:27:31 -0500
Received: by gwj16 with SMTP id 16so1371543gwj.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=O4/lfa94lFLtjCT6G75PJKlWXajuq7K64bNumL7Opcs=;
        b=e05FRGcsYHGbjkTqFYfgZB2d5ScfHHrfdL/XDL+wwT3TvVZpPiVkffZPRC3IS5AGJD
         anVjnWZP8ivy95pax5+J+j5SjVsgSBkmI5XTKunU/XfDq+jczAgNfRofyqERbb7/bkVV
         koIR9kxY7Tk1Tlqu9ucyeVCcFPHM2WoYvR+Io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=PsCbf3GMOoJzAGxdf2HFYVyDzkyG8xdyeOEZRvm0vUVEcQTvxzIIpCJIDqaOQ1fKCd
         m6/6WjP/sMT1exIjJC7bzwyXoyj00C0iZ5mL1dGNE8asz0uiC8w78QkqHAQKgbPyJUue
         cf+VvsU+vKvcilQhZBd2kKogyrO9IoHeYn02I=
Received: by 10.150.169.5 with SMTP id r5mr276796ybe.307.1267050447384; Wed, 
	24 Feb 2010 14:27:27 -0800 (PST)
In-Reply-To: <7viq9nfwg8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140996>

Thanks for the fast response.  Your level of commitment to this
project is awesome!

2010/2/23 Junio C Hamano <gitster@pobox.com>
>
> >       git checkout -ob debian
> >       git clean -df
> >       mkdir Debian
> >       add all control files
> >       ...hack it enough...
> >       git add Debian
> >       git commit
>
> I do not think that is a good example.

Well it is just an example. Its intention is to show some practical
data about this proposition.

> If you have an extract of an upstream tarball, say frotz-1.42.tar.gz, and
> you are not porting anything older than that version, why not have two
> branches, frotz and master, and do things this way?
>
>  - frotz (or "vanilla" or "upstream") that keeps track of the "vendor
>   drop" without debian/ directory;
>
>  - master that forks from frotz and adds "debian/" and nothing else; and
>
>  - any other topic branches that either fork from frotz if you are fixing
>   upstream bug (or enhancing the vanilla version), or fork from master if
>   you are fixing or enhancing the debianization.
>
> When you receive frotz-1.43.tar.gz, you will advance 'frotz' branch with
> it, and probably fork maint-1.42 branch from master so that you can keep
> supporting older debianized frotz, while merging frotz into master so that
> you can prepare a debianized version of newer package.

The main point here is not the way one prefers to work.  It is to let
one works the way one wants.  In other words: give more versatility to
what is already working fine.

> Your debianization will _never_ be totally independent of the vendor
> version, so there is no good reason to have it as a rootless branch.

In matter of fact, mine, personally, is.  Please follow:
I normally hack software I want to add features I feel is lacking.  As
a Debian user when I compile it at last to install my version I always
do Debian packages so to let APT do its works.  As I like not to
reinvent the wheel I normally extract the Debian folder from the
normal repository packages.

So after a while I just have in a separate Debian branch the commit
1.5, 1.6, ....  In case I have to change the Debian files then I will
have my commits spread in the middle of this branch.

But as what I had pictured before was a general approach then or you
could be right on your example work flow or separating it could be
better or whatever!  It was just an example.

All commits I post are stuff I use which, following free software
ideology, I just want to share so other people could use it too.  I
know how limited my efforts are to a project like git.  A project like
that needs people really involved and pro-active like you.  But even
being a small contributor I really like to contribute because I think
the approach of free software community is the best for all and it
should be supported by everyone who cares.

I hope some day we could find a way to spread this ideology to
everything else in our society.  Working just to make things better
for no other direct reason; communitarian development; freedom and
demo/meritocracy; ...  :-)

Sorry for writing too much.

Regards.
