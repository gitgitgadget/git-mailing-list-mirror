From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Wed, 28 Sep 2011 14:35:46 +0000
Message-ID: <CAMOZ1Btw7Bf3_ejZef_SdRojyVeM94knyz9Gw+SEqFtrrpBVsA@mail.gmail.com>
References: <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org> <4E823359.7080602@nextest.com>
 <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley> <20110927214213.GC5176@sigill.intra.peff.net>
 <CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
 <20110927233549.GA10434@sigill.intra.peff.net> <7vpqiltsky.fsf@alter.siamese.dyndns.org>
 <CAMOZ1BvL85xsQpZdez4VJ+dH4NoQ9RkthHY9OsmdnnaZ_tFnFg@mail.gmail.com>
 <vpqty7wok5a.fsf@bauges.imag.fr> <CAMOZ1Bu8UiV+Z0+0CLjxSv5Zic8i4=aGxnzmLc+H7c2T-P4avw@mail.gmail.com>
 <vpq4nzwoj1o.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 28 16:36:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8vFF-0001a0-Qj
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab1I1OgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:36:17 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56047 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab1I1OgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:36:16 -0400
Received: by qyk7 with SMTP id 7so9247730qyk.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=blrqSz8jRCT9tKQ0RXg0SYCHVNEcZ7EIDO+/1IxikPg=;
        b=VLWI5dNhhESB1eDpYbQHrr5LbTEJr3Q2FEXSywcxbRkJH7fQCH/Jyt8sZaATfShm4e
         4hLSJwJ4tlf+Dv8AF/rt0Gx759suI7EFiTgg74Jpf7FbQ7PRIqORsj5NeRX68ljKP0Pn
         rQP7yE4kZA+29rHGOy3WUJowDWZ80m8RAWdpA=
Received: by 10.224.190.10 with SMTP id dg10mr7013018qab.103.1317220576094;
 Wed, 28 Sep 2011 07:36:16 -0700 (PDT)
Received: by 10.229.233.6 with HTTP; Wed, 28 Sep 2011 07:35:46 -0700 (PDT)
In-Reply-To: <vpq4nzwoj1o.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182325>

On Wed, Sep 28, 2011 at 14:09, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:

> Michael Witten <mfwitten@gmail.com> writes:
>
>> Well, as Junio mentioned, "--orphan" could be deprecated in favor of
>> "--no-parent"; the uncommon nature of this task works to our
>> advantage, in that it makes a deprecation of "--orphan" easy.
>
> I agree that _some_ cases would be more natural with commit --no-parent,
> but I disagree that it is a better solution in general.
>
> For example
>
> # I want to create a new root commit with a different tree
> git rm -fr *
> vi file-in-new-project.txt
> git add file-in-new-project.txt
> # continue hacking for a while
> git commit -m "New project" # oops, I forgot the --no-parent
>
> History is not destroyed and you can still "git reset" back to the
> previous commit, but you've at least temporarily damaged your branch
> (and no --force flag could have prevented it). With "git checkout
> --orphan" in the above scenario, you run the command at the time you
> take the decision you want to create a root commit, and then hack
> normally.
>
> Even if you use it normally:
>
> # I want to create a new root commit with a different tree
> git checkout -b new-project
> # hack for a while
> git status
> # ?!? why are files shown as 'deleted', 'moved', 'modified', I said I
> # was creating a new project!
>
> Also, with your proposal, we would need to add two flags to "commit"
> (--no-parent and --force), which is one of the first command beginners
> learn, while in the current state we have just one for "checkout" to do
> the trick, and newbies do not use or read the doc for checkout, so it's
> not scary for them.

Well, those are mildly interesting scenarios. I can only say that I don't
think we should cater to people who either have amnesia or work casually
on a repository for short bursts every few months or so.
