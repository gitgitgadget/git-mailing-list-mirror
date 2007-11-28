From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 11:37:38 -0500
Message-ID: <9e4733910711280837o43003e93p470bb403e6bdd3bb@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	 <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
	 <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com>
	 <alpine.LFD.0.99999.0711280951150.9605@xanadu.home>
	 <9e4733910711280758x38ca3cdau4e62bfe8776e5c0d@mail.gmail.com>
	 <alpine.LFD.0.99999.0711281125320.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:38:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPvI-0006hZ-UP
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759788AbXK1Qhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 11:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759519AbXK1Qhk
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:37:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:45760 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759494AbXK1Qhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:37:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1804775wah
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 08:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wMzJTnU/jCtyjDNeGzlYLiXRy8hs0ZLy/cpwYXkMTro=;
        b=KFQ+9eWdpkP5i2esWjlkoQrXbd01wcDx2gVpnPYBa7kvygAjMzynApBhwR95UFmW48iO0lMS0zqI/BtGoTYbqZkuI1XQOZWIV7GfilbgpJTFg3eIydKL0JmXv8uROyG0dVeIlFb9MqXIhybsD+4RxMO++nVhxgqnztWYO0eSve4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f6JByeET1sg+gMgaYImhTguTA4FYfRnQumNS9Pb7rOIdiIi7neJ2c+EQ50jivcEVcn+8fnhK5x/dtxcXkecHvUIVhANRizpcIP/oN1wDgBTz2Rq5gAqKkz1rRpdRTDMQHC2u/jPRuRaT0ZKSKZ7dVTP4MWAnQIHJqdRtoFdKMcU=
Received: by 10.115.54.1 with SMTP id g1mr680849wak.1196267858787;
        Wed, 28 Nov 2007 08:37:38 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Wed, 28 Nov 2007 08:37:38 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0711281125320.9605@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66376>

On 11/28/07, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 28 Nov 2007, Jon Smirl wrote:
>
> > On 11/28/07, Nicolas Pitre <nico@cam.org> wrote:
> > > On Tue, 27 Nov 2007, Jon Smirl wrote:
> > >
> > > > Of course you've never screwed up a repository using git commands,
> > > > right? I've messed up plenty. A good way to mess up a repo is to get
> > > > the data in .git/* out of sync with what is in the repo. I'm getting
> > > > good enough with git that I can fix most mess up with a few edits, but
> > > > it took me two years to get to that point. Rolling back to a check
> > > > point is way easier. User error and a command failing are both equally
> > > > valid ways to mess up a repo.
> > >
> > > The reflog contains all your check points, for every modifications you
> > > make, even the stupid ones.  You should look at it.
> >
> > The state contained in the other config files in .git/* is not getting
> > check pointed. I can use reflog to move my branch heads around. But
> > doing that does not undo the changes to the state recorded in .git/*.
> > After the error I encountered  I moved my branch head back, but the
> > state stgit had stored in .git/* was out of sync with where the branch
> > had been moved to.
>
> It's up to stgit to version control its state then.  It may even use a
> reflog for it.  All the machinery is there already.

Git has state in .git/* too, shouldn't it be version controlling it
too? If git was version controlling the state in .git/* you'd have
checkpoints with the ability to roll back.


>
>
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
