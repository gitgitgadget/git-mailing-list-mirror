From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git subtree: an alternative to git submodule
Date: Fri, 15 May 2009 12:09:20 -0400
Message-ID: <32541b130905150909h7e596f26w7db6887e7f4267ff@mail.gmail.com>
References: <1241822349-27470-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 18:09:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4zyo-0005y5-C3
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 18:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757220AbZEOQJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 12:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbZEOQJl
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 12:09:41 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:33896 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbZEOQJk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 12:09:40 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1150052yxj.1
        for <git@vger.kernel.org>; Fri, 15 May 2009 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kq5C8QmzAtM0WMfRwb0PuVU1fthQ3W4bRI6ygzHoZW8=;
        b=HNrLBBklpe3xqcpIbY5oT/MzQiAQzA/JYL+1l+llYzcld3oiKeTZTXcmJsuZGRYzVg
         JZbOUp+cZ9mICShOTQkK/7XeKFEdQpftV7Y7YEZ4VpTcc2nQbZKsZnFrUOQf2trEgBDW
         CmcaVBzhlHV2uJO59BG6qDM5Xp5cyrENX0Ei8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=isl/5qtMTLd+TePYKBY94KLPQFpQ/S1CkKPvmQEj4CLP7VnK9WsUNb3ozk2I5sjnzu
         rXcPMoVc88zLFwbKl5HzuigPOdjRm6wjrTw44KguX2Y5tfQkChvbwsUAm4hYrqFu1xFf
         zXmDuDva4VVdlqEQ4M3kRAwRO7c3nWGlqgAwY=
Received: by 10.151.150.21 with SMTP id c21mr6257410ybo.322.1242403780707; 
	Fri, 15 May 2009 09:09:40 -0700 (PDT)
In-Reply-To: <1241822349-27470-1-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119261>

On Fri, May 8, 2009 at 6:39 PM, Avery Pennarun <apenwarr@gmail.com> wro=
te:
> I first sent out this patch set a couple of weeks ago
> (http://article.gmane.org/gmane.comp.version-control.git/117612) and =
got a
> couple of positive comments, but no negative ones, so I'm guessing pe=
ople
> haven't reviewed it as closely as I would have hoped :)
>
> git subtree has these subcommands:
>
> =A0- add: connect a given commit to a given subtree, basically using =
the
> =A0 occasionally-documented 'git read-tree --prefix; git commit' tric=
k.
>
> =A0- merge: a user-friendlier form of 'git merge -s subtree'
>
> =A0- pull: likewise, but for git pull
>
> =A0- split: (the magical part!) generate a new commit series from the=
 given
> =A0 prefix, so you can submit subtree changes *back* to the upstream =
project
> =A0 you merged in the first place.
>
> Does anyone have any comments on what it would take to get the git su=
btree
> stuff accepted into git?

Hi all,

Just checking in again.  Since I originally announced git-subtree, it
(or rather the concept) has received a bit of positive feedback out in
the wild.  My original blog post about it:
http://alumnit.ca/~apenwarr/log/?m=3D200904#30

The heroku mailing list:
http://groups.google.com/group/heroku/browse_thread/thread/5e6807fcd257=
2f64

Ycombinator news: http://news.ycombinator.com/item?id=3D604405
And again: http://news.ycombinator.com/item?id=3D604889

Meanwhile, I've been keeping it in a separate git repo here:
http://github.com/apenwarr/git-subtree/commits/master (that's a web
link, not a git link).

The common thread in all these discussions is along the lines of,
"This sounds cool!  I didn't try it though.  Maybe I should!"
Commenters then seem to disappear into a black hole.  The black hole
of my code!  Bwahahaha!  Sigh.

I would love to hear some feedback about this, particularly for the
question of what needs to be done to get it adopted into git's
mainline, or if it's in fact so evil that this is unlikely to ever
happen.  Obviously I would need to write a man page, but I've been
hesitant to do that in case people have suggestions that need the
whole UI to change.  Perhaps that's a chicken-and-egg problem, though,
and I should just get on with writing it.

=46lame away!

Thanks,

Avery

P.S. Dscho is usually really good at flaming me for being stupid, but
he has been strangely silent on this topic so far.  Don't miss this
exciting opportunity!
