From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] git integrated bugtracking
Date: Mon, 11 Jun 2007 22:00:48 +1200
Message-ID: <46a038f90706110300r20dd992excfcb6fbd9d2b8d6c@mail.gmail.com>
References: <20070610140204.GA6730@artemis.madism.org>
	 <46a038f90706101614h48112deel70d848f4312c88d7@mail.gmail.com>
	 <20070611084533.GA24327@artemis.intersec.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Martin Langhoff" <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 12:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxghn-0004Vb-CX
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 12:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212AbXFKKAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 06:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759493AbXFKKAu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 06:00:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:28339 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759392AbXFKKAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 06:00:49 -0400
Received: by wr-out-0506.google.com with SMTP id 76so944990wra
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 03:00:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ek8pAcCUI2MTQiLx+qbO2ICq43O4OU8g20gxT6cnFj5IrN3lLZrDVFs6f2d9koPWvSSVLjFalnAeHR9twmEPOm5fWPaF+xXFYeL3sR/vXUnlDdAg8XBnmSc8zEGQHZB3YsEJsgihpXvJTILHqt2B6hoBvmC5jF86RTWx6IvSH/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ehjNWn22B76N5itGeqIEdRnUwwt3FaVBbvrCwnnCaslTWuCelERlsSa42UuQLkqtUmShMgWwP49Ji97i+PpQozlYh/80QpBW3WGTgEW/QhPoB6lXukWjgRJYPbyNDLCVWOinw0qqnDP15vCB/M+czxDs3HhzffbnJlAhIa6C1JQ=
Received: by 10.90.106.11 with SMTP id e11mr4891069agc.1181556048952;
        Mon, 11 Jun 2007 03:00:48 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Mon, 11 Jun 2007 03:00:48 -0700 (PDT)
In-Reply-To: <20070611084533.GA24327@artemis.intersec.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49840>

On 6/11/07, Pierre Habouzit <madcoder@debian.org> wrote:
>   That one is easy. Indeed, the big politics in bugtrackers are ...
> severity-ping-pong, or close-wars. Good example of that is btw:
> http://sourceware.org/bugzilla/show_bug.cgi?id=4509.
>
>   Okay, what would we gain in a DBTS: developer would still be (sorry)
> a perfect asshole with the user. That is a thing we cannot fix. Though,
> the release manager will probably disagree with him. So this bug that
> _he_ considers non existant will be closed in his repository, but still
> remain open in the main one. Meaning that if another developer steps up,
> he'll see this issue is not fixed. Else nobody will have any chance to
> step up, ever.

I've seen all those bugtracker-wars. But they never block a developer
or fellow user from saying --hey, here's a patch. And with a DSCM,
that clears things up quite quickly.

I don't understand how  "Else nobody will have any chance to step up, ever."

> > >  Honestly ? No, because that would be horribly slow (but I'd love to be
> > >proven wrong).
> >
> > What part would be slow?
>
>   The perl scripts. It would perceptibly slow down commits. And I don't
> want that now that I finally have a fast SCM. I just don't want to turn
> git into bzr.

The model I was thinking of was of _not_ slowing down your commits ;-) but

 * Stick to a mostly centralised BTS that tracks a limited set of repos
 * When you push to the public repo, the BTS updates its bug status
 * on git-pull, update a (fast!) local cache of BTS data
 * on gitk use a similar technique to the "follows" line shown for
each commit to display bug info "inline"

cheers,


martin
