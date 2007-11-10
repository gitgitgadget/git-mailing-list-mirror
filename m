From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: gitweb, updating 'last changed' column on the project page
Date: Sat, 10 Nov 2007 01:10:57 -0500
Message-ID: <9e4733910711092210o65759276sd6970af5d29f2f32@mail.gmail.com>
References: <9e4733910711091709k173bf23flf2824673f82de9bb@mail.gmail.com>
	 <fh337a$ggp$1@ger.gmane.org>
	 <9e4733910711092201n5aaeeb7cvfd0e76e43170d481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 07:11:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqjYt-0006Ug-Fk
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 07:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbXKJGLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 01:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbXKJGLC
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 01:11:02 -0500
Received: from ro-out-1112.google.com ([72.14.202.180]:25167 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbXKJGLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 01:11:00 -0500
Received: by ro-out-1112.google.com with SMTP id p4so464346roc
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 22:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cbTCuFSR3Os3psjsDd1WBtwf/lNt2NmeGHPFOmNAtFA=;
        b=aLIn9LGaj/l/mvjubTKgtoCN5EctQ2/OL4zpyOxI/7ZGDttm1Y4WWe7fE6yKYFymvfFPtIKzMvWl5flJFRTfk1N8h3Ges3tAvkwfwvTnlQMI4AzB4si3LVci7AgFxCleEWywp9ud53ZppgTwXcxU8ifIr/qZyt48VzE0jF+lKD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kcn0jpDjiOuZy89Az7oAlUZtp6M1/1kMuJCKK706lSmlxG6NNqSENUvKfHvoDjWa1O9uemjFQdAXwBQ/4cYXqprvBpUPXe+4nCRzcuc3KviYgwu62VNEcS2qax8E2wje3tzsIp2ypzd64aHyT5kra5x+LNqWtGuIHL0BlZJ5yjg=
Received: by 10.114.195.19 with SMTP id s19mr281090waf.1194675057387;
        Fri, 09 Nov 2007 22:10:57 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 22:10:57 -0800 (PST)
In-Reply-To: <9e4733910711092201n5aaeeb7cvfd0e76e43170d481@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64309>

On 11/10/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 11/9/07, Jakub Narebski <jnareb@gmail.com> wrote:
> > Jon Smirl wrote:
> >
> > > At http://git.digispeaker.com/ the 'last change' column is not getting updated.
> > >
> > > mpc5200b.git
> > >       DigiSpeaker for Freescale MPC5200B.
> > >       Jon Smirl
> > >       5 weeks ago
> > >       summary | shortlog | log | tree
> > >
> > > It still says 5 weeks ago, but if I click on the project last change is today.
> > >
> > > What controls this? I tried running update-server-info
> >
> > What does
> >
> >   git for-each-ref --format="%(refname):%09%(committer)" --sort=-committerdate
> >       refs/heads
>
> [daedalus]$ git for-each-ref --format="%(refname):%09%(committer)"
> --sort=-committerdate refs/heads
> refs/heads/m24: Jon Smirl <jonsmirl@gmail.com> 1191362799 -0400
> refs/heads/m25: Jon Smirl <jonsmirl@gmail.com> 1191472422 -0400
> refs/heads/m26: Jon Smirl <jonsmirl@gmail.com> 1194382038 -0500
> refs/heads/m28: Jon Smirl <jonsmirl@gmail.com> 1194385071 -0500
> refs/heads/m29: Jon Smirl <jonsmirl@gmail.com> 1194585780 -0500


It appears to be using the first head instead of the most recent date.


>
> >
> > return? Does adding --count select proper branch, with proper update
> > date?
>
> Is it looking for master, and just picking the first branch instead?
>
> >
> > Which gitweb version is this?
>
> <!-- git web interface version 1.5.3.5.605.g79fa-dirty, (C) 2005-2006,
> Kay Sievers <kay.sievers@vrfy.org>, Christian Gierke -->
> <!-- git core binaries version 1.5.3.5.605.g79fa-dirty -->
>
> >
> > --
> > Jakub Narebski
> > Warsaw, Poland
> > ShadeHawk on #git
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
